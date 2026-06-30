**FREE
ctl-opt dftactgrp(*no) option(*srcstmt: *nodebugio) commit(*none) dbgview(*source);

exec sql include sqlca;
exec sql set option commit = *none;

dcl-proc OUT_BuildPayload export;
  dcl-pi *n int(10);
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
  end-pi;

  pPayload = '{'
          + '"metadata":{'
          + '"versionEstructura":"1.0.0",'
          + '"sistemaOrigen":"IBS-IBM-i",'
          + '"proceso":"CONCILIACION_GLBLN",'
          + '"ambiente":"QA",'
          + '"charset":"UTF-8"'
          + '},'
          + '"ejecucion":{'
          + '"idEjecucion":"' + %trim(pIdEjecucion) + '",'
          + '"fechaProceso":"' + %char(pFechaProceso:*iso) + '",'
          + '"fechaHoraInicio":"' + %char(pFechaHoraInicio) + '",'
          + '"fechaHoraFin":"' + %char(pFechaHoraFin) + '",'
          + '"usuario":"' + %trim(pUsuario) + '",'
          + '"programa":"' + %trim(pPrograma) + '",'
          + '"libreria":"' + %trim(pLibreria) + '",'
          + '"estadoEjecucion":"' + %trim(pEstadoEjecucion) + '"'
          + '},'
          + '"contexto":{'
          + '"banco":"' + %trim(pBanco) + '",'
          + '"sucursal":"' + %trim(pSucursal) + '",'
          + '"moneda":"' + %trim(pMoneda) + '",'
          + '"rangoCuentas":{'
          + '"desde":"' + %trim(pCuentaDesde) + '",'
          + '"hasta":"' + %trim(pCuentaHasta) + '"'
          + '}'
          + '},'
          + '"consolidado":{'
          + '"metadataEjecucion":{'
          + '"idEjecucion":"' + %trim(pIdEjecucion) + '",'
          + '"fechaProceso":"' + %char(pFechaProceso:*iso) + '",'
          + '"fechaHoraInicio":"' + %char(pFechaHoraInicio) + '",'
          + '"fechaHoraFin":"' + %char(pFechaHoraFin) + '",'
          + '"usuario":"' + %trim(pUsuario) + '",'
          + '"programa":"' + %trim(pPrograma) + '",'
          + '"libreria":"' + %trim(pLibreria) + '",'
          + '"estadoEjecucion":"' + %trim(pEstadoEjecucion) + '"'
          + '},'
          + '"identificacionCuenta":' + pAccountsJson + ','
          + '"resumenResultados":' + pControlTotalesJson + ','
          + '"incidentes":' + pIncidentesJson
          + '},'
          + '"cuentas":' + pAccountsJson + ','
          + '"controlTotales":' + pControlTotalesJson + ','
          + '"incidentes":' + pIncidentesJson
          + '}';

  return 0;
end-proc;

dcl-proc OUT_WriteToIFS export;
  dcl-pi *n int(10);
    pPath      varchar(512) const;
    pContent   varchar(32767) const;
    pErrorMsg  varchar(512);
  end-pi;

  dcl-s vCmd     varchar(32767);
  dcl-s vLen     packed(15:5);
  dcl-s vEsc     varchar(32767);

  pErrorMsg = '';

  vEsc = %replace('''':'''''' : pContent);

  vCmd = 'QSH CMD('''
      + 'cat <<"EOF" | iconv -f IBM037 -t UTF-8 > ' + %trim(pPath) + x'25'
       + vEsc + x'25'
       + 'EOF' + ''')';

  vLen = %len(%trim(vCmd));

  exec sql
    call QSYS2.QCMDEXC(:vCmd, :vLen);

  if sqlca.sqlcode < 0;
    pErrorMsg = 'Error escribiendo IFS. SQLCODE=' + %char(sqlca.sqlcode);
    return -1;
  endif;

  return 0;
end-proc;

dcl-proc OUT_AppendLog export;
  dcl-pi *n int(10);
    pPath      varchar(512) const;
    pLevel     varchar(10) const;
    pMessage   varchar(1024) const;
    pErrorMsg  varchar(512);
  end-pi;

  dcl-s vCmd     varchar(32767);
  dcl-s vLen     packed(15:5);
  dcl-s vEsc     varchar(32767);
  dcl-s vLine    varchar(1400);

  pErrorMsg = '';

  vLine = %char(%timestamp()) + ' [' + %trim(pLevel) + '] ' + %trim(pMessage);
  vEsc = %replace('''':'''''' : vLine);

  vCmd = 'QSH CMD('''
      + 'cat <<"EOF" | iconv -f IBM037 -t UTF-8 >> ' + %trim(pPath) + x'25'
       + vEsc + x'25'
       + 'EOF' + ''')';

  vLen = %len(%trim(vCmd));

  exec sql
    call QSYS2.QCMDEXC(:vCmd, :vLen);

  if sqlca.sqlcode < 0;
    pErrorMsg = 'Error escribiendo log IFS. SQLCODE=' + %char(sqlca.sqlcode);
    return -1;
  endif;

  return 0;
end-proc;
