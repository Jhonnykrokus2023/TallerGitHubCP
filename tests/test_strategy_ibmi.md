# Estrategia de Pruebas IBM i para GLRPT001

## Objetivo
Validar pruebas unitarias e integración del flujo GLBLN -> JSON -> IFS.

## Artefactos de prueba
1. Runner unitario SQLRPGLE:
- src/ibmi/tests/glrpt001_test_runner.rpgle

2. Datos de prueba SQL:
- tests/sql/test_setup_glbln.sql

3. Ejecucion de integración:
- tests/sql/test_run_glrpt001.sql

## Cobertura unitaria
1. BR_EvaluateExecution estado FINALIZADO.
2. BR_EvaluateExecution estado ERROR.
3. OUT_BuildPayload estructura JSON minima.
4. DA_LoadGLBLN consulta filtrada y formato de salida.

## Cobertura de integración
1. Preparar dataset de prueba (GLMST/GLBLN).
2. Ejecutar GLRPT001 en modo TEST.
3. Ejecutar GLRPT001 en modo PROD (opcional) para validar salida IFS.
4. Revisar log de ejecucion generado en ruta IFS.

## Orden recomendada
1. Ejecutar tests/sql/test_setup_glbln.sql.
2. Compilar y ejecutar src/ibmi/tests/glrpt001_test_runner.rpgle.
3. Ejecutar tests/sql/test_run_glrpt001.sql.
4. Revisar resultados funcionales y logs.

## Criterios de aceptación
1. Runner unitario termina con todas las pruebas en PASS.
2. GLRPT001 no genera error crítico con dataset válido.
3. En modo PROD, existe JSON en IFS y log asociado.
4. El JSON contiene metadata, ejecucion, contexto, cuentas, controlTotales e incidentes.
