**FREE
ctl-opt dftactgrp(*no) option(*srcstmt: *nodebugio) commit(*none) dbgview(*source);

exec sql include sqlca;
exec sql set option commit = *none, datfmt = *iso, timfmt = *iso;

dcl-ds ResultadoPrueba qualified;
  NumeroPrueba int(10);
  Descripcion  varchar(100);
  Resultado    char(4);
  Codigo       int(10);
  Mensaje      varchar(256);
end-ds;

dcl-pr DA_LoadGLBLN int(10) extproc('DA_LoadGLBLN');
  pBanco          varchar(20) const;
  pSucursal       varchar(20) const;
  pMoneda         varchar(20) const;
  pCuentaDesde    varchar(24) const;
  pCuentaHasta    varchar(24) const;
  pFechaProceso   date const;
  pAccountsJson   varchar(32767);
  pTotalCuentas   int(10);
  pIncidentsJson  varchar(4096);
  pErrorMsg       varchar(512);
end-pr;

dcl-pr BR_EvaluateExecution int(10) extproc('BR_EvaluateExecution');
  pTotalCuentas      int(10) const;
  pTotalIncidentes   int(10) const;
  pHasCritical       ind const;
  pEstadoEjecucion   varchar(12);
  pResumen           varchar(512);
end-pr;

dcl-pr OUT_BuildPayload int(10) extproc('OUT_BuildPayload');
  pIdEjecucion         varchar(40) const;
  pFechaProceso        date const;
  pFechaHoraInicio     timestamp const;
  pFechaHoraFin        timestamp const;
  pUsuario             varchar(30) const;
  pPrograma            varchar(20) const;
  pLibreria            varchar(20) const;
  pEstadoEjecucion     varchar(12) const;
  pBanco               varchar(20) const;
  pSucursal            varchar(20) const;
  pMoneda              varchar(20) const;
  pCuentaDesde         varchar(24) const;
  pCuentaHasta         varchar(24) const;
  pAccountsJson        varchar(32767) const;
  pControlTotalesJson  varchar(2048) const;
  pIncidentesJson      varchar(4096) const;
  pPayload             varchar(32767);
end-pr;

dcl-s totalPruebas int(10) inz(0);
dcl-s pruebasOk    int(10) inz(0);
dcl-s estado       varchar(12) inz('');
dcl-s resumen      varchar(512) inz('');
dcl-s rc           int(10) inz(0);
dcl-s cuentasJson  varchar(32767) inz('[]');
dcl-s incidents    varchar(4096) inz('[]');
dcl-s err          varchar(512) inz('');
dcl-s payload      varchar(32767) inz('');
dcl-s totCuentas   int(10) inz(0);
dcl-s tIni         timestamp;
dcl-s tFin         timestamp;

tIni = %timestamp();
tFin = %timestamp();

TestEvalFinalizado();
TestEvalError();
TestEvalCritico();
TestBuildPayload();
TestDataAccess();
TestDataAccessFiltrosOpcionales();

dsply ('TOTAL PRUEBAS: ' + %char(totalPruebas));
dsply ('PRUEBAS OK   : ' + %char(pruebasOk));

*inlr = *on;
return;

dcl-proc TestEvalFinalizado;
  dcl-s r ResultadoPrueba;

  totalPruebas += 1;
  r.NumeroPrueba = totalPruebas;
  r.Descripcion = 'BR_EvaluateExecution FINALIZADO';

  rc = BR_EvaluateExecution(2: 0: *off: estado: resumen);

  if rc = 0 and %trim(estado) = 'FINALIZADO';
    r.Resultado = 'PASS';
    pruebasOk += 1;
  else;
    r.Resultado = 'FAIL';
  endif;

  r.Codigo = rc;
  r.Mensaje = %trim(resumen);
  MostrarResultado(r);
end-proc;

dcl-proc TestEvalError;
  dcl-s r ResultadoPrueba;

  totalPruebas += 1;
  r.NumeroPrueba = totalPruebas;
  r.Descripcion = 'BR_EvaluateExecution ERROR';

  rc = BR_EvaluateExecution(0: 1: *on: estado: resumen);

  if rc = -1 and %trim(estado) = 'ERROR';
    r.Resultado = 'PASS';
    pruebasOk += 1;
  else;
    r.Resultado = 'FAIL';
  endif;

  r.Codigo = rc;
  r.Mensaje = %trim(resumen);
  MostrarResultado(r);
end-proc;

dcl-proc TestEvalCritico;
  dcl-s r ResultadoPrueba;

  totalPruebas += 1;
  r.NumeroPrueba = totalPruebas;
  r.Descripcion = 'BR_EvaluateExecution CRITICO';

  rc = BR_EvaluateExecution(5: 1: *on: estado: resumen);

  if rc = 1 and %trim(estado) = 'ERROR';
    r.Resultado = 'PASS';
    pruebasOk += 1;
  else;
    r.Resultado = 'FAIL';
  endif;

  r.Codigo = rc;
  r.Mensaje = %trim(resumen);
  MostrarResultado(r);
end-proc;

dcl-proc TestBuildPayload;
  dcl-s r ResultadoPrueba;

  totalPruebas += 1;
  r.NumeroPrueba = totalPruebas;
  r.Descripcion = 'OUT_BuildPayload JSON base';

  rc = OUT_BuildPayload(
         '20260629_120000': %date('2026-06-29'): tIni: tFin: 'TESTUSR': 'GLRPT001': 'TALLERLIB':
         'FINALIZADO': 'TST01': '0001': 'USD': '11000000': '11999999':
         '[]': '{"totalCuentasProcesadas":0}': '[]': payload);

  if rc = 0 and %scan('"metadata"': payload) > 0 and %scan('"ejecucion"': payload) > 0 and %scan('"consolidado"': payload) > 0;
    r.Resultado = 'PASS';
    pruebasOk += 1;
  else;
    r.Resultado = 'FAIL';
  endif;

  r.Codigo = rc;
  r.Mensaje = 'Tamano payload=' + %char(%len(%trim(payload)));
  MostrarResultado(r);
end-proc;

dcl-proc TestDataAccess;
  dcl-s r ResultadoPrueba;

  totalPruebas += 1;
  r.NumeroPrueba = totalPruebas;
  r.Descripcion = 'DA_LoadGLBLN consulta filtrada';

  rc = DA_LoadGLBLN('TST01': '0001': 'USD': '11000000': '11999999': %date('2026-06-29'):
                    cuentasJson: totCuentas: incidents: err);

  if rc = 0 and %subst(cuentasJson:1:1) = '[';
    if %scan('"balanceCalculado"': cuentasJson) > 0 and %scan('"estadoFinanciero"': cuentasJson) > 0;
      r.Resultado = 'PASS';
      pruebasOk += 1;
    else;
      r.Resultado = 'FAIL';
    endif;
  else;
    r.Resultado = 'FAIL';
  endif;

  r.Codigo = rc;
  if %trim(err) <> '';
    r.Mensaje = %trim(err);
  else;
    r.Mensaje = 'Cuentas=' + %char(totCuentas);
  endif;
  MostrarResultado(r);
end-proc;

dcl-proc TestDataAccessFiltrosOpcionales;
  dcl-s r ResultadoPrueba;

  totalPruebas += 1;
  r.NumeroPrueba = totalPruebas;
  r.Descripcion = 'DA_LoadGLBLN filtros opcionales';

  rc = DA_LoadGLBLN('': '': 'USD': '11000000': '11999999': %date('2026-06-29'):
                    cuentasJson: totCuentas: incidents: err);

  if rc = 0 and %subst(cuentasJson:1:1) = '[';
    if %scan('"balanceCalculado"': cuentasJson) > 0 and %scan('"estadoFinanciero"': cuentasJson) > 0;
      r.Resultado = 'PASS';
      pruebasOk += 1;
    else;
      r.Resultado = 'FAIL';
    endif;
  else;
    r.Resultado = 'FAIL';
  endif;

  r.Codigo = rc;
  if %trim(err) <> '';
    r.Mensaje = %trim(err);
  else;
    r.Mensaje = 'Cuentas=' + %char(totCuentas);
  endif;
  MostrarResultado(r);
end-proc;

dcl-proc MostrarResultado;
  dcl-pi *n;
    pRes likeds(ResultadoPrueba) const;
  end-pi;

  dsply ('PRUEBA ' + %char(pRes.NumeroPrueba)
      + ' - ' + %trim(pRes.Descripcion)
      + ' = ' + %trim(pRes.Resultado)
      + ' (RC=' + %char(pRes.Codigo) + ') ' + %trim(pRes.Mensaje));
end-proc;
