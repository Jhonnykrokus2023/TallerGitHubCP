# Despliegue y Ejecucion en IBM i

Esta guía cubre compilacion, despliegue y ejecución de la aplicación GLRPT001 usando las fuentes del proyecto.

## 1. Objetos a construir

Fuentes:
1. src/ibmi/glbln_data_access.rpgle
2. src/ibmi/glbln_business_rules.rpgle
3. src/ibmi/glbln_json_ifs.rpgle
4. src/ibmi/glrpt001_main.rpgle
5. src/ibmi/tests/glrpt001_test_runner.rpgle

Objetos sugeridos en librería APPPWRCE1:
1. Modulo GLBLNDA (data access)
2. Modulo GLBLNBR (business rules)
3. Modulo GLBLNOUT (json/ifs)
4. Modulo GLRPT001 (main)
5. Programa GLRPT001 (resultado final)
6. Programa GLRPTTST (runner de pruebas)

## 2. Compilacion por comandos

Ejecutar en QCMD (ajustar rutas IFS al entorno real):

```cl
CRTLIB LIB(APPPWRCE1)

CRTSQLRPGI OBJ(APPPWRCE1/GLBLNDA) OBJTYPE(*MODULE) +
           SRCSTMF('/home/APPPWRCE/src/ibmi/glbln_data_access.rpgle') +
           COMMIT(*NONE) DBGVIEW(*SOURCE)

CRTSQLRPGI OBJ(APPPWRCE1/GLBLNBR) OBJTYPE(*MODULE) +
           SRCSTMF('/home/APPPWRCE/src/ibmi/glbln_business_rules.rpgle') +
           COMMIT(*NONE) DBGVIEW(*SOURCE)

CRTSQLRPGI OBJ(APPPWRCE1/GLBLNOUT) OBJTYPE(*MODULE) +
           SRCSTMF('/home/APPPWRCE/src/ibmi/glbln_json_ifs.rpgle') +
           COMMIT(*NONE) DBGVIEW(*SOURCE)

CRTSQLRPGI OBJ(APPPWRCE1/GLRPT001) OBJTYPE(*MODULE) +
           SRCSTMF('/home/APPPWRCE/src/ibmi/glrpt001_main.rpgle') +
           COMMIT(*NONE) DBGVIEW(*SOURCE)

CRTPGM PGM(APPPWRCE1/GLRPT001) +
  MODULE(APPPWRCE1/GLRPT001 APPPWRCE1/GLBLNDA APPPWRCE1/GLBLNBR APPPWRCE1/GLBLNOUT) +
       ACTGRP(*CALLER)

CRTSQLRPGI OBJ(APPPWRCE1/GLRPTTST) OBJTYPE(*PGM) +
           SRCSTMF('/home/APPPWRCE/src/ibmi/tests/glrpt001_test_runner.rpgle') +
           COMMIT(*NONE) DBGVIEW(*SOURCE)
```

## 3. Carga de esquema y datos de prueba

1. Ejecutar create_tables_ddl.sql.
2. Ejecutar ddl_incremental_fk_idx.sql.
3. Ejecutar tests/sql/test_setup_glbln.sql.

Recomendado: correr en ACS Run SQL Scripts con SET CURRENT SCHEMA APPPWRCE1.

## 4. Ejecucion de pruebas

### 4.1 Runner unitario

```cl
CALL PGM(APPPWRCE1/GLRPTTST)
```

### 4.2 Integracion por SQL

Ejecutar tests/sql/test_run_glrpt001.sql.

## 5. Ejecucion operativa del programa

Modo TEST:

```sql
CALL GLRPT001(
  'TST01', '0001', 'USD', '11000000', '11999999',
  DATE('2026-06-29'), '/home/APPPWRCE/', 'TEST'
)
```

Modo PROD:

```sql
CALL GLRPT001(
  'TST01', '0001', 'USD', '11000000', '11999999',
  DATE('2026-06-29'), '/home/APPPWRCE/', 'PROD'
)
```

## 6. Verificacion post-ejecucion

En IFS (/home/APPPWRCE/):
1. Archivo glbln_YYYYMMDD_HHMMSS.json
2. Archivo glbln_YYYYMMDD_HHMMSS.log

Validar:
1. JSON con metadata, ejecucion, contexto, cuentas, controlTotales e incidentes.
2. Log con inicio, errores (si existen) y cierre con resumen.

## 7. Troubleshooting rapido

1. Error en CRTSQLRPGI por ruta:
- Verificar SRCSTMF y permisos IFS.

2. Error SQL0204 (objeto no encontrado):
- Confirmar esquema actual y tablas GLBLN/GLMST.

3. Error de escritura IFS:
- Verificar permisos RW sobre ruta de salida.

4. Error de link en CRTPGM:
- Confirmar nombres de modulo y librería.
