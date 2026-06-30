**FREE
ctl-opt dftactgrp(*no) option(*srcstmt: *nodebugio) commit(*none) dbgview(*source);

exec sql include sqlca;
exec sql set option commit = *none, datfmt = *iso, timfmt = *iso;

dcl-proc DA_LoadGLBLN export;
  dcl-pi *n int(10);
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
  end-pi;

  dcl-pr BR_AssignFinancialState int(10) extproc('BR_AssignFinancialState');
    pNaturaleza         varchar(20) const;
    pSaldoCalculado     packed(18:2) const;
    pEstadoCodigo       varchar(20);
    pEstadoDescripcion  varchar(100);
    pRequiereRevision   ind;
  end-pr;

  dcl-s vBanco        varchar(20);
  dcl-s vSucursal     varchar(20);
  dcl-s vMoneda       varchar(20);
  dcl-s vCuenta       varchar(24);
  dcl-s vDescripcion  varchar(120);
  dcl-s vNaturaleza   varchar(20);
  dcl-s vNivel        varchar(50);
  dcl-s vSaldoFuente  packed(18:2);
  dcl-s vSaldoInicial packed(18:2);
  dcl-s vDebitos      packed(18:2);
  dcl-s vCreditos     packed(18:2);
  dcl-s vSaldoCalc    packed(18:2);
  dcl-s vEstadoFin    varchar(20);
  dcl-s vEstadoFinDesc varchar(100);
  dcl-s vRequiereRev  ind;
  dcl-s rc            int(10);
  dcl-s vBancoFiltro      varchar(20);
  dcl-s vSucursalFiltro   varchar(20);
  dcl-s vMonedaFiltro     varchar(20);
  dcl-s vCuentaDesdeFiltro varchar(24);
  dcl-s vCuentaHastaFiltro varchar(24);

  dcl-s vRowJson      varchar(2048) inz('');

  vBancoFiltro      = %trim(pBanco);
  vSucursalFiltro   = %trim(pSucursal);
  vMonedaFiltro     = %trim(pMoneda);
  vCuentaDesdeFiltro = %trim(pCuentaDesde);
  vCuentaHastaFiltro = %trim(pCuentaHasta);

  pAccountsJson  = '[';
  pIncidentsJson = '[]';
  pErrorMsg      = '';
  pTotalCuentas  = 0;

  exec sql
    declare c_glbln cursor for
      select g.codigo_banco,
             g.codigo_sucursal,
             g.codigo_moneda,
             g.cuenta_contable,
             coalesce(g.descripcion_cuenta, ''),
             coalesce(g.naturaleza_cuenta, ''),
             coalesce(g.nivel_cuenta, ''),
               coalesce(g.saldo_actual, 0),
               coalesce((select sum(case when debito_credito = 'D' then monto else 0 end)
                          from TRANS
                         where cuenta_contable = g.cuenta_contable
                           and codigo_banco = g.codigo_banco
                           and codigo_sucursal = g.codigo_sucursal
                           and codigo_moneda = g.codigo_moneda
                           and fecha_operacion <= :pFechaProceso), 0)
             + coalesce((select sum(case when debito_credito = 'D' then monto else 0 end)
                          from TTRAN
                         where cuenta_contable = g.cuenta_contable
                           and codigo_banco = g.codigo_banco
                           and codigo_sucursal = g.codigo_sucursal
                           and codigo_moneda = g.codigo_moneda
                           and fecha <= :pFechaProceso), 0),
               coalesce((select sum(case when debito_credito = 'C' then monto else 0 end)
                          from TRANS
                         where cuenta_contable = g.cuenta_contable
                           and codigo_banco = g.codigo_banco
                           and codigo_sucursal = g.codigo_sucursal
                           and codigo_moneda = g.codigo_moneda
                           and fecha_operacion <= :pFechaProceso), 0)
             + coalesce((select sum(case when debito_credito = 'C' then monto else 0 end)
                          from TTRAN
                         where cuenta_contable = g.cuenta_contable
                           and codigo_banco = g.codigo_banco
                           and codigo_sucursal = g.codigo_sucursal
                           and codigo_moneda = g.codigo_moneda
                           and fecha <= :pFechaProceso), 0)
        from GLBLN g
       where (:vBancoFiltro = '' or g.codigo_banco = :vBancoFiltro)
         and (:vSucursalFiltro = '' or g.codigo_sucursal = :vSucursalFiltro)
         and (:vMonedaFiltro = '' or g.codigo_moneda = :vMonedaFiltro)
         and (:vCuentaDesdeFiltro = '' or g.cuenta_contable >= :vCuentaDesdeFiltro)
         and (:vCuentaHastaFiltro = '' or g.cuenta_contable <= :vCuentaHastaFiltro)
         and date(g.fecha_proceso_sistema) <= :pFechaProceso
      order by cuenta_contable;

  exec sql open c_glbln;
  if sqlca.sqlcode < 0;
    pErrorMsg = 'Error abriendo cursor GLBLN. SQLCODE=' + %char(sqlca.sqlcode);
    return -1;
  endif;

  dow *on;
    exec sql
      fetch c_glbln
       into :vBanco, :vSucursal, :vMoneda, :vCuenta,
            :vDescripcion, :vNaturaleza, :vNivel, :vSaldoFuente,
            :vDebitos, :vCreditos;

    if sqlca.sqlcode = 100;
      leave;
    endif;

    if sqlca.sqlcode < 0;
      pErrorMsg = 'Error leyendo GLBLN. SQLCODE=' + %char(sqlca.sqlcode);
      exec sql close c_glbln;
      return -2;
    endif;

        vSaldoInicial = vSaldoFuente;
        vSaldoCalc = vSaldoInicial + vDebitos - vCreditos;

        rc = BR_AssignFinancialState(vNaturaleza: vSaldoCalc: vEstadoFin: vEstadoFinDesc: vRequiereRev);
        if rc <> 0;
          vEstadoFin = 'SIN_REGLA';
          vEstadoFinDesc = 'No fue posible clasificar el estado financiero';
          vRequiereRev = *on;
        endif;

        vRowJson = '{'
            + '"cuentaMayor":{'
            + '"codigoBanco":"' + %trim(vBanco) + '",'
            + '"codigoSucursal":"' + %trim(vSucursal) + '",'
            + '"codigoMoneda":"' + %trim(vMoneda) + '",'
            + '"cuentaContable":"' + %trim(vCuenta) + '",'
            + '"descripcionCuenta":"' + escapeJson(%trim(vDescripcion)) + '",'
            + '"naturaleza":"' + escapeJson(%trim(vNaturaleza)) + '",'
            + '"nivelCuenta":"' + escapeJson(%trim(vNivel)) + '"'
            + '},'
            + '"saldos":{'
          + '"saldoInicial":' + %trim(%char(vSaldoInicial)) + ','
          + '"debitosPeriodo":' + %trim(%char(vDebitos)) + ','
          + '"creditosPeriodo":' + %trim(%char(vCreditos)) + ','
          + '"balanceCalculado":' + %trim(%char(vSaldoCalc)) + ','
          + '"saldoFinalCalculado":' + %trim(%char(vSaldoCalc)) + ','
          + '"saldoFinalFuente":' + %trim(%char(vSaldoFuente)) + ','
          + '"saldoFinalConciliado":' + %trim(%char(vSaldoCalc))
            + '},'
          + '"estadoFinanciero":{'
          + '"codigo":"' + %trim(vEstadoFin) + '",'
          + '"descripcion":"' + escapeJson(%trim(vEstadoFinDesc)) + '",'
          + '"requiereRevision":' + %subst(%char(vRequiereRev):1:1)
          + '},'
            + '"diferencias":{'
          + '"diferenciaNeta":' + %trim(%char(vSaldoFuente - vSaldoCalc)) + ','
          + '"diferenciaAbsoluta":' + %trim(%char(%abs(vSaldoFuente - vSaldoCalc))) + ','
            + '"toleranciaPermitida":1,'
          + '"excedeTolerancia":' + %subst(%char(%abs(vSaldoFuente - vSaldoCalc) > 1):1:1) + ','
          + '"motivoPrincipal":"' + %trim(vEstadoFin) + '"'
            + '},'
            + '"estadoConciliacion":{'
          + '"codigo":"' + %cond(%abs(vSaldoFuente - vSaldoCalc) > 1: 'NO_CONCILIADA': 'CONCILIADA') + '",'
          + '"descripcion":"' + %cond(%abs(vSaldoFuente - vSaldoCalc) > 1: 'Excede tolerancia': 'Sin diferencias') + '",'
          + '"severidad":"' + %cond(%abs(vSaldoFuente - vSaldoCalc) > 1: 'ALTA': 'BAJA') + '",'
          + '"requiereRevision":' + %subst(%char(%abs(vSaldoFuente - vSaldoCalc) > 1):1:1)
            + '},'
            + '"trazabilidad":{'
            + '"registrosFuente":{'
            + '"glbln":1,'
            + '"trans":0,'
            + '"trdsc":0,'
            + '"ttran":0'
            + '}'
            + '}'
            + '}';

    pAccountsJson += vRowJson + ',';
    pTotalCuentas += 1;
  enddo;

  exec sql close c_glbln;

  if pTotalCuentas > 0;
    pAccountsJson = %subst(pAccountsJson: 1: %len(pAccountsJson) - 1) + ']';
  else;
    pAccountsJson = '[]';
  endif;

  return 0;
end-proc;

dcl-proc escapeJson;
  dcl-pi *n varchar(1024);
    pValue varchar(1024) const;
  end-pi;

  dcl-s vOut varchar(1024);

  vOut = %replace('\\' : '\\' : pValue);
  vOut = %replace('"' : '\"' : vOut);
  return vOut;
end-proc;
