-- test_setup_glbln.sql
-- Prepara datos de prueba para GLRPT001 / DA_LoadGLBLN.

-- 1) Limpieza del dataset de prueba
DELETE FROM GLBLN
 WHERE codigo_banco = 'TST01'
   AND codigo_sucursal = '0001'
   AND codigo_moneda = 'USD';

DELETE FROM GLMST
 WHERE codigo_banco = 'TST01'
   AND codigo_moneda = 'USD'
   AND cuenta_contable BETWEEN '11000000' AND '11999999';

-- 2) Datos base de catalogo mayor
INSERT INTO GLMST (
  codigo_banco, codigo_moneda, cuenta_contable, descripcion_cuenta,
  naturaleza_cuenta, nivel_cuenta, saldo_actual, fecha_proceso_sistema,
  estado_registro, created_at, updated_at
) VALUES
('TST01', 'USD', '11010101', 'CAJA GENERAL', 'DEUDORA', '4', 120000.00,
 TIMESTAMP('2026-06-29-10.00.00'), 'A', CURRENT TIMESTAMP, CURRENT TIMESTAMP),
('TST01', 'USD', '11020202', 'BANCOS NACIONALES', 'DEUDORA', '4', 48000.00,
 TIMESTAMP('2026-06-29-10.00.00'), 'A', CURRENT TIMESTAMP, CURRENT TIMESTAMP);

-- 3) Datos GLBLN para proceso
INSERT INTO GLBLN (
  codigo_banco, codigo_sucursal, codigo_moneda, cuenta_contable,
  descripcion_cuenta, naturaleza_cuenta, nivel_cuenta, saldo_actual,
  fecha_proceso_sistema, estado_registro, created_at, updated_at
) VALUES
('TST01', '0001', 'USD', '11010101', 'CAJA GENERAL', 'DEUDORA', '4', 120000.00,
 TIMESTAMP('2026-06-29-11.00.00'), 'A', CURRENT TIMESTAMP, CURRENT TIMESTAMP),
('TST01', '0001', 'USD', '11020202', 'BANCOS NACIONALES', 'DEUDORA', '4', 48000.00,
 TIMESTAMP('2026-06-29-11.00.00'), 'A', CURRENT TIMESTAMP, CURRENT TIMESTAMP);

COMMIT;
