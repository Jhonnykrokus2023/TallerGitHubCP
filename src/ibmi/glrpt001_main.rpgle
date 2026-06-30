**FREE
ctl-opt dftactgrp(*no) option(*srcstmt: *nodebugio) commit(*none) dbgview(*source);

exec sql include sqlca;
exec sql set option commit = *none, datfmt = *iso, timfmt = *iso;

dcl-c PROGRAMA_NOMBRE const('GLRPT001');

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

dcl-pr BR_BuildControlTotales int(10) extproc('BR_BuildControlTotales');
  pTotalCuentas         int(10) const;
  pTotalIncidentes      int(10) const;
  pControlTotalesJson   varchar(2048);
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

dcl-pr OUT_WriteToIFS int(10) extproc('OUT_WriteToIFS');
  pPath      varchar(512) const;
  pContent   varchar(32767) const;
  pErrorMsg  varchar(512);
end-pr;

dcl-pr OUT_AppendLog int(10) extproc('OUT_AppendLog');
  pPath      varchar(512) const;
  pLevel     varchar(10) const;
  pMessage   varchar(1024) const;
  pErrorMsg  varchar(512);
end-pr;

dcl-pi *n;
  pBanco        varchar(20) const;
  pSucursal     varchar(20) const;
  pMoneda       varchar(20) const;
  pCuentaDesde  varchar(24) const;
  pCuentaHasta  varchar(24) const;
  pFechaProceso date const;
  pRutaIFS      varchar(512) const;
  pModo         varchar(10) const;
end-pi;

dcl-s vAccountsJson       varchar(32767) inz('[]');
dcl-s vIncidentsJson      varchar(4096) inz('[]');
dcl-s vControlTotalesJson varchar(2048) inz('{}');
dcl-s vPayload            varchar(32767) inz('');
dcl-s vError              varchar(512) inz('');
dcl-s vResumen            varchar(512) inz('');
dcl-s vEstadoEjec         varchar(12) inz('ERROR');
dcl-s vIdEjecucion        varchar(40) inz('');
dcl-s vUsuario            varchar(30) inz('');
dcl-s vLibreria           varchar(20) inz('*CURRENT');
dcl-s vFileSalida         varchar(512) inz('');
dcl-s vLogFile            varchar(512) inz('');
dcl-s vRutaIFSBase        varchar(512) inz('');

dcl-s vTotalCuentas       int(10) inz(0);
dcl-s vTotalIncidentes    int(10) inz(0);
dcl-s vHasCritical        ind inz(*off);
dcl-s vSkipWrite           ind inz(*off);
dcl-s vAbortProcess        ind inz(*off);

dcl-s rc int(10) inz(0);
dcl-s rcLog int(10) inz(0);
dcl-s tsInicio timestamp;
dcl-s tsFin timestamp;

tsInicio = %timestamp();
vUsuario = %user();

vRutaIFSBase = %trim(pRutaIFS);
if %len(%trim(vRutaIFSBase)) > 0 and %subst(vRutaIFSBase: %len(%trim(vRutaIFSBase)): 1) = '/';
  vRutaIFSBase = %subst(vRutaIFSBase: 1: %len(%trim(vRutaIFSBase)) - 1);
endif;

vIdEjecucion = %char(%date():*iso0) + '_' + %char(%time():*hms0);
vFileSalida = vRutaIFSBase + '/glbln_' + vIdEjecucion + '.json';
vLogFile = vRutaIFSBase + '/glbln_' + vIdEjecucion + '.log';

rcLog = OUT_AppendLog(vLogFile: 'INFO': 'Inicio de ejecucion programa GLRPT001': vError);

rc = DA_LoadGLBLN(
        pBanco: pSucursal: pMoneda: pCuentaDesde: pCuentaHasta: pFechaProceso:
        vAccountsJson: vTotalCuentas: vIncidentsJson: vError);

if rc <> 0;
  vTotalIncidentes = 1;
  vHasCritical = *on;
  vAbortProcess = *on;
  AddIncident(vIncidentsJson: 'ERR-DA-001': 'DATOS': vError: 'CRITICA');
  rcLog = OUT_AppendLog(vLogFile: 'ERROR': 'Fallo DA_LoadGLBLN: ' + %trim(vError): vError);
endif;

if vAbortProcess = *off;
  if BR_BuildControlTotales(vTotalCuentas: vTotalIncidentes: vControlTotalesJson) <> 0;
    vTotalIncidentes += 1;
    AddIncident(vIncidentsJson: 'ERR-BR-001': 'NEGOCIO': 'Error construyendo controlTotales': 'ALTA');
    rcLog = OUT_AppendLog(vLogFile: 'ERROR': 'Error en BR_BuildControlTotales': vError);
  endif;

  rc = BR_EvaluateExecution(vTotalCuentas: vTotalIncidentes: vHasCritical: vEstadoEjec: vResumen);

  if %trim(vResumen) <> '';
    AddIncident(vIncidentsJson: 'INF-EXEC-001': 'EJECUCION': vResumen: 'BAJA');
  endif;

  tsFin = %timestamp();

  rc = OUT_BuildPayload(
         vIdEjecucion: pFechaProceso: tsInicio: tsFin: vUsuario: PROGRAMA_NOMBRE: vLibreria:
         vEstadoEjec: pBanco: pSucursal: pMoneda: pCuentaDesde: pCuentaHasta:
         vAccountsJson: vControlTotalesJson: vIncidentsJson: vPayload);

  if rc <> 0;
    AddIncident(vIncidentsJson: 'ERR-OUT-001': 'JSON': 'Error construyendo payload JSON': 'CRITICA');
    vTotalIncidentes += 1;
    vHasCritical = *on;
    vEstadoEjec = 'ERROR';
    vSkipWrite = *on;
    vAbortProcess = *on;
    rcLog = OUT_AppendLog(vLogFile: 'ERROR': 'Error en OUT_BuildPayload': vError);
  endif;
endif;

if vAbortProcess = *off and vSkipWrite = *off and %trim(%upper(pModo)) <> 'TEST';
  rc = OUT_WriteToIFS(vFileSalida: vPayload: vError);
  if rc <> 0;
    AddIncident(vIncidentsJson: 'ERR-IFS-001': 'IFS': vError: 'CRITICA');
    vTotalIncidentes += 1;
    vHasCritical = *on;
    vEstadoEjec = 'ERROR';
    vAbortProcess = *on;
    rcLog = OUT_AppendLog(vLogFile: 'ERROR': 'Fallo escritura JSON: ' + %trim(vError): vError);
  else;
    rcLog = OUT_AppendLog(vLogFile: 'INFO': 'JSON publicado en ' + %trim(vFileSalida): vError);
  endif;
else;
  if vAbortProcess = *on;
    rcLog = OUT_AppendLog(vLogFile: 'ERROR': 'Ejecucion abortada por error critico; no se publica JSON': vError);
  else;
  rcLog = OUT_AppendLog(vLogFile: 'INFO': 'Modo TEST: no se publica JSON en IFS': vError);
  endif;
endif;

rcLog = OUT_AppendLog(
          vLogFile:
          'INFO':
          'Fin ejecucion estado=' + %trim(vEstadoEjec)
          + ' cuentas=' + %char(vTotalCuentas)
          + ' incidentes=' + %char(vTotalIncidentes):
          vError);

*inlr = *on;
return;

dcl-proc AddIncident;
  dcl-pi *n;
    pIncidents  varchar(4096);
    pCodigo     varchar(20) const;
    pTipo       varchar(20) const;
    pMensaje    varchar(512) const;
    pSeveridad  varchar(10) const;
  end-pi;

  dcl-s vItem varchar(1200);

  vItem = '{"codigo":"' + %trim(pCodigo)
       + '","tipo":"' + %trim(pTipo)
       + '","mensaje":"' + EscapeJson(%trim(pMensaje))
       + '","severidad":"' + %trim(pSeveridad) + '"}';

  if %trim(pIncidents) = '[]';
    pIncidents = '[' + vItem + ']';
  else;
    pIncidents = %subst(pIncidents: 1: %len(pIncidents) - 1) + ',' + vItem + ']';
  endif;
end-proc;

dcl-proc EscapeJson;
  dcl-pi *n varchar(512);
    pValue varchar(512) const;
  end-pi;

  dcl-s vOut varchar(512);

  vOut = %replace('\\' : '\\' : pValue);
  vOut = %replace('"' : '\"' : vOut);
  return vOut;
end-proc;
