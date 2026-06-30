-- Configuracion recomendada de esquema
SET CURRENT SCHEMA APPPWRCE1;

-- Prueba de integracion en modo TEST
CALL GLRPT001(
  'TST01',
  '0001',
  'USD',
  '11000000',
  '11999999',
  DATE('2026-06-29'),
  '/tmp',
  'TEST'
);

-- Prueba de integracion en modo PROD
-- CALL GLRPT001(
--   'TST01',
--   '0001',
--   'USD',
--   '11000000',
--   '11999999',
--   DATE('2026-06-29'),
--   '/tmp',
--   'PROD'
-- );

-- Ejecucion runner unitario desde SQL (si aplica via CALL)
-- CALL GLRPTTST();
