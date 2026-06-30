-- ddl_incremental_fk_idx.sql
-- Ajustes incrementales derivados de la revision de indices y PK/FK.
-- Objetivo:
-- 1) Completar indice temporal faltante de TTRAN (created_at).
-- 2) Definir FK prioritarias para reforzar integridad referencial.
--
-- Nota:
-- Antes de aplicar FK, ejecutar consultas de prevalidacion para detectar
-- datos huerfanos que bloquearian los ALTER TABLE.

-- =========================================================
-- 1) INDICE FALTANTE EN TTRAN
-- =========================================================

-- Si tu entorno aun no tiene este indice, descomenta la sentencia.
-- CREATE INDEX idx_ttran_created_at ON TTRAN(created_at);

-- =========================================================
-- 2) PREVALIDACION DE DATOS PARA FK
-- =========================================================

-- 2.1 TTRAN.id_cliente -> CUMST.id_cliente
SELECT COUNT(*) AS orphans_ttran_cumst
  FROM TTRAN t
 WHERE t.id_cliente IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
         FROM CUMST c
        WHERE c.id_cliente = t.id_cliente
   );

-- 2.2 TRANS.id_cliente -> CUMST.id_cliente
SELECT COUNT(*) AS orphans_trans_cumst
  FROM TRANS t
 WHERE t.id_cliente IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
         FROM CUMST c
        WHERE c.id_cliente = t.id_cliente
   );

-- 2.3 GLBLN(banco, moneda, cuenta) -> GLMST(banco, moneda, cuenta)
SELECT COUNT(*) AS orphans_glbln_glmst
  FROM GLBLN b
 WHERE NOT EXISTS (
       SELECT 1
         FROM GLMST m
        WHERE m.codigo_banco = b.codigo_banco
          AND m.codigo_moneda = b.codigo_moneda
          AND m.cuenta_contable = b.cuenta_contable
   );

-- 2.4 TTRAN(banco, moneda, cuenta) -> GLMST(banco, moneda, cuenta)
SELECT COUNT(*) AS orphans_ttran_glmst
  FROM TTRAN t
 WHERE NOT EXISTS (
       SELECT 1
         FROM GLMST m
        WHERE m.codigo_banco = t.codigo_banco
          AND m.codigo_moneda = t.codigo_moneda
          AND m.cuenta_contable = t.cuenta_contable
   );

-- 2.5 TRANS(banco, moneda, cuenta) -> GLMST(banco, moneda, cuenta)
SELECT COUNT(*) AS orphans_trans_glmst
  FROM TRANS t
 WHERE t.codigo_banco IS NOT NULL
   AND t.codigo_moneda IS NOT NULL
   AND t.cuenta_contable IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
         FROM GLMST m
        WHERE m.codigo_banco = t.codigo_banco
          AND m.codigo_moneda = t.codigo_moneda
          AND m.cuenta_contable = t.cuenta_contable
   );

-- =========================================================
-- 3) FK PRIORITARIAS
-- =========================================================

-- Clientes
ALTER TABLE TTRAN
  ADD CONSTRAINT fk_ttran_cumst
  FOREIGN KEY (id_cliente)
  REFERENCES CUMST (id_cliente);

ALTER TABLE TRANS
  ADD CONSTRAINT fk_trans_cumst
  FOREIGN KEY (id_cliente)
  REFERENCES CUMST (id_cliente);

-- Catalogo contable base
ALTER TABLE GLBLN
  ADD CONSTRAINT fk_glbln_glmst
  FOREIGN KEY (codigo_banco, codigo_moneda, cuenta_contable)
  REFERENCES GLMST (codigo_banco, codigo_moneda, cuenta_contable);

ALTER TABLE TTRAN
  ADD CONSTRAINT fk_ttran_glmst
  FOREIGN KEY (codigo_banco, codigo_moneda, cuenta_contable)
  REFERENCES GLMST (codigo_banco, codigo_moneda, cuenta_contable);

ALTER TABLE TRANS
  ADD CONSTRAINT fk_trans_glmst
  FOREIGN KEY (codigo_banco, codigo_moneda, cuenta_contable)
  REFERENCES GLMST (codigo_banco, codigo_moneda, cuenta_contable);
