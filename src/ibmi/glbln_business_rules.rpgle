**FREE
ctl-opt dftactgrp(*no) option(*srcstmt: *nodebugio) commit(*none) dbgview(*source);

dcl-c ST_FINALIZADO const('FINALIZADO');
dcl-c ST_PARCIAL   const('PARCIAL');
dcl-c ST_ERROR     const('ERROR');
dcl-c ST_SIN_MOV   const('SIN_MOVIMIENTO');
dcl-c ST_DEUDOR    const('SALDO_DEUDOR');
dcl-c ST_ACREEDOR  const('SALDO_ACREEDOR');

dcl-proc BR_AssignFinancialState export;
  dcl-pi *n int(10);
    pNaturaleza         varchar(20) const;
    pSaldoCalculado     packed(18:2) const;
    pEstadoCodigo       varchar(20);
    pEstadoDescripcion  varchar(100);
    pRequiereRevision   ind;
  end-pi;

  if pSaldoCalculado = 0;
    pEstadoCodigo = ST_SIN_MOV;
    pEstadoDescripcion = 'Saldo neto en cero';
    pRequiereRevision = *off;
    return 0;
  endif;

  if %upper(%trim(pNaturaleza)) = 'DEUDORA';
    if pSaldoCalculado > 0;
      pEstadoCodigo = ST_DEUDOR;
      pEstadoDescripcion = 'Saldo coherente con naturaleza deudora';
      pRequiereRevision = *off;
    else;
      pEstadoCodigo = ST_ACREEDOR;
      pEstadoDescripcion = 'Saldo inverso a naturaleza deudora';
      pRequiereRevision = *on;
    endif;
    return 0;
  endif;

  if %upper(%trim(pNaturaleza)) = 'ACREEDORA';
    if pSaldoCalculado < 0;
      pEstadoCodigo = ST_ACREEDOR;
      pEstadoDescripcion = 'Saldo coherente con naturaleza acreedora';
      pRequiereRevision = *off;
    else;
      pEstadoCodigo = ST_DEUDOR;
      pEstadoDescripcion = 'Saldo inverso a naturaleza acreedora';
      pRequiereRevision = *on;
    endif;
    return 0;
  endif;

  if pSaldoCalculado > 0;
    pEstadoCodigo = ST_DEUDOR;
    pEstadoDescripcion = 'Saldo positivo';
  else;
    pEstadoCodigo = ST_ACREEDOR;
    pEstadoDescripcion = 'Saldo negativo';
  endif;
  pRequiereRevision = *on;
  return 0;
end-proc;

dcl-proc BR_EvaluateExecution export;
  dcl-pi *n int(10);
    pTotalCuentas      int(10) const;
    pTotalIncidentes   int(10) const;
    pHasCritical       ind const;
    pEstadoEjecucion   varchar(12);
    pResumen           varchar(512);
  end-pi;

  if pTotalCuentas <= 0;
    pEstadoEjecucion = ST_ERROR;
    pResumen = 'Sin cuentas procesadas.';
    return -1;
  endif;

  if pHasCritical = *on;
    pEstadoEjecucion = ST_ERROR;
    pResumen = 'Ejecucion con incidentes criticos.';
    return 1;
  endif;

  if pTotalIncidentes > 0;
    pEstadoEjecucion = ST_PARCIAL;
    pResumen = 'Ejecucion parcial con incidentes no criticos.';
    return 0;
  endif;

  pEstadoEjecucion = ST_FINALIZADO;
  pResumen = 'Ejecucion finalizada sin incidentes.';
  return 0;
end-proc;

dcl-proc BR_BuildControlTotales export;
  dcl-pi *n int(10);
    pTotalCuentas         int(10) const;
    pTotalIncidentes      int(10) const;
    pControlTotalesJson   varchar(2048);
  end-pi;

  pControlTotalesJson = '{'
                     + '"totalCuentasProcesadas":' + %char(pTotalCuentas) + ','
                     + '"totalCuentasConciliadas":' + %char(pTotalCuentas - pTotalIncidentes) + ','
                     + '"totalCuentasConDiferencia":' + %char(pTotalIncidentes) + ','
                     + '"sumatoriaSaldoFinalFuente":0,'
                     + '"sumatoriaSaldoFinalConciliado":0,'
                     + '"sumatoriaDiferenciaNeta":0'
                     + '}';

  return 0;
end-proc;
