-- test_run_glrpt001.sql
-- Ejecucion de integracion del programa principal.
-- Requiere objeto programa GLRPT001 compilado en la libreria activa.

-- Modo TEST: valida flujo sin publicar JSON final
CALL GLRPT001(
  'TST01',
  '0001',
  'USD',
  '11000000',
  '11999999',
  DATE('2026-06-29'),
  '/home/APPPWRCE/',
  'TEST'
);

-- Modo PROD: publica JSON y log en IFS (/home/APPPWRCE/)
-- Descomentar para pruebas de publicacion real.
-- CALL GLRPT001(
--   'TST01',
--   '0001',
--   'USD',
--   '11000000',
--   '11999999',
--   DATE('2026-06-29'),
--   '/home/APPPWRCE/',
--   'PROD'
-- );
