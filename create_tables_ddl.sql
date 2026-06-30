-- create_tables_ddl.sql
-- Generado a partir de estructura_bd.md
-- DB2 compatible

-- 1. ARCHIVOS COMUNES

CREATE TABLE CNOFT (
  codigo_tabla VARCHAR(20) NOT NULL,
  idioma VARCHAR(20) NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_tabla, idioma)
);

CREATE INDEX idx_cnoft_created_at ON CNOFT(created_at);

CREATE TABLE CNOFC (
  codigo_tabla VARCHAR(20) NOT NULL,
  codigo_registro VARCHAR(20) NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_tabla, codigo_registro)
);

CREATE INDEX idx_cnofc_created_at ON CNOFC(created_at);

CREATE TABLE MLNCT (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_de_notificacion VARCHAR(20) NOT NULL,
  nivel INTEGER NOT NULL,
  idioma VARCHAR(20) NOT NULL,
  secuencia INTEGER NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_de_notificacion, nivel, idioma, secuencia)
);

CREATE INDEX idx_mlnct_created_at ON MLNCT(created_at);

CREATE TABLE MLNOT (
  codigo_banco VARCHAR(20) NOT NULL,
  fecha_proceso DATE NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  codigo_de_notificacion VARCHAR(20) NOT NULL,
  nivel INTEGER NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, fecha_proceso, numero_cuenta, codigo_de_notificacion, nivel)
);

CREATE INDEX idx_mlnot_fecha ON MLNOT(fecha_proceso);
CREATE INDEX idx_mlnot_created_at ON MLNOT(created_at);

CREATE TABLE HSNOT (
  codigo_banco VARCHAR(20) NOT NULL,
  fecha_proceso DATE NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  codigo_de_notificacion VARCHAR(20) NOT NULL,
  nivel INTEGER NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, fecha_proceso, numero_cuenta, codigo_de_notificacion, nivel)
);

CREATE INDEX idx_hsnot_fecha ON HSNOT(fecha_proceso);
CREATE INDEX idx_hsnot_created_at ON HSNOT(created_at);

CREATE TABLE HEAD (
  nombre_printer_file VARCHAR(50) NOT NULL,
  secuencia INTEGER NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (nombre_printer_file, secuencia)
);

CREATE INDEX idx_head_created_at ON HEAD(created_at);

CREATE TABLE MSSGS (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_mssgs_created_at ON MSSGS(created_at);

CREATE TABLE HOLYD (
  codigo_moneda VARCHAR(20) NOT NULL,
  fecha DATE NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_moneda, fecha)
);

CREATE INDEX idx_holyd_fecha ON HOLYD(fecha);
CREATE INDEX idx_holyd_created_at ON HOLYD(created_at);

CREATE TABLE APCLS (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_de_producto VARCHAR(20) NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_de_producto)
);

CREATE INDEX idx_apcls_created_at ON APCLS(created_at);

CREATE TABLE RATES (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_moneda)
);

CREATE INDEX idx_rates_created_at ON RATES(created_at);

CREATE TABLE RTRNS (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  fecha DATE NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_moneda, fecha)
);

CREATE INDEX idx_rtrns_fecha ON RTRNS(fecha);
CREATE INDEX idx_rtrns_created_at ON RTRNS(created_at);

CREATE TABLE HLHIS (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_hlhis_created_at ON HLHIS(created_at);

CREATE TABLE PRENA (
  nombre_programa VARCHAR(50) NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (nombre_programa)
);

CREATE INDEX idx_prena_created_at ON PRENA(created_at);

CREATE TABLE PRENS (
  nombre_programa VARCHAR(50) NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (nombre_programa)
);

CREATE INDEX idx_prens_created_at ON PRENS(created_at);

CREATE TABLE UT500 (
  codigo_usuario VARCHAR(20) NOT NULL,
  fecha DATE NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_usuario, fecha)
);

CREATE INDEX idx_ut500_fecha ON UT500(fecha);
CREATE INDEX idx_ut500_created_at ON UT500(created_at);

CREATE TABLE UT510 (
  codigo_usuario VARCHAR(20) NOT NULL,
  fecha DATE NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_usuario, fecha)
);

CREATE INDEX idx_ut510_fecha ON UT510(fecha);
CREATE INDEX idx_ut510_created_at ON UT510(created_at);

CREATE TABLE MICRF (
  tipo_formulario VARCHAR(50) NOT NULL,
  nombre_reporte VARCHAR(50) NOT NULL,
  secuencia INTEGER NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (tipo_formulario, nombre_reporte, secuencia)
);

CREATE INDEX idx_micrf_created_at ON MICRF(created_at);

CREATE TABLE IBSDD (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_ibsdd_created_at ON IBSDD(created_at);

CREATE TABLE IBTBL (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_ibtbl_created_at ON IBTBL(created_at);

CREATE TABLE TRANS (
  id_transaccion BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  numero_registro_relativo VARCHAR(30),
  codigo_banco VARCHAR(20),
  codigo_sucursal VARCHAR(20),
  codigo_moneda VARCHAR(20),
  cuenta_contable VARCHAR(24),
  numero_cuenta VARCHAR(24),
  id_cliente VARCHAR(30),
  fecha_operacion DATE,
  fecha_valor DATE,
  hora_operacion TIME,
  tipo_movimiento VARCHAR(20),
  debito_credito CHAR(1),
  monto DECIMAL(18,2),
  saldo_anterior DECIMAL(18,2),
  saldo_posterior DECIMAL(18,2),
  canal_origen VARCHAR(20),
  terminal_origen VARCHAR(30),
  referencia_externa VARCHAR(40),
  estado_transaccion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_transaccion)
);

CREATE INDEX idx_trans_reg_rel ON TRANS(numero_registro_relativo);
CREATE INDEX idx_trans_cuenta_fecha ON TRANS(numero_cuenta, fecha_operacion);
CREATE INDEX idx_trans_contable_fecha ON TRANS(cuenta_contable, fecha_operacion);
CREATE INDEX idx_trans_cliente_fecha ON TRANS(id_cliente, fecha_operacion);
CREATE INDEX idx_trans_created_at ON TRANS(created_at);

CREATE TABLE TRDSC (
  numero_registro_relativo VARCHAR(30) NOT NULL,
  secuencia INTEGER NOT NULL,
  tipo_descripcion VARCHAR(20),
  texto_descripcion VARCHAR(200),
  codigo_idioma VARCHAR(5),
  formato_salida VARCHAR(20),
  obligatorio BOOLEAN,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_registro_relativo, secuencia)
);

CREATE INDEX idx_trdsc_tipo ON TRDSC(tipo_descripcion);
CREATE INDEX idx_trdsc_created_at ON TRDSC(created_at);

CREATE TABLE TTRAN (
  id_transaccion_dia BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  numero_registro_relativo VARCHAR(30),
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  cuenta_contable VARCHAR(24) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  id_cliente VARCHAR(30),
  fecha DATE NOT NULL,
  fecha_valor DATE,
  hora_operacion TIME,
  tipo_movimiento VARCHAR(20),
  debito_credito CHAR(1),
  monto DECIMAL(18,2),
  saldo_anterior DECIMAL(18,2),
  saldo_posterior DECIMAL(18,2),
  canal_origen VARCHAR(20),
  terminal_origen VARCHAR(30),
  referencia_externa VARCHAR(40),
  estado_transaccion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_transaccion_dia, codigo_banco, codigo_sucursal, codigo_moneda, cuenta_contable, numero_cuenta, fecha)
);

CREATE INDEX idx_ttran_reg_rel ON TTRAN(numero_registro_relativo);
CREATE INDEX idx_ttran_cuenta_fecha ON TTRAN(numero_cuenta, fecha);
CREATE INDEX idx_ttran_contable_fecha ON TTRAN(cuenta_contable, fecha);
CREATE INDEX idx_ttran_cliente_fecha ON TTRAN(id_cliente, fecha);
CREATE INDEX idx_ttran_fecha ON TTRAN(fecha);
CREATE INDEX idx_ttran_created_at ON TTRAN(created_at);

CREATE TABLE CIFXF (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_cifxf_created_at ON CIFXF(created_at);

CREATE TABLE CNTRLCNT (
  codigo_banco VARCHAR(20) NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco)
);

CREATE INDEX idx_cntrlcnt_created_at ON CNTRLCNT(created_at);

CREATE TABLE CNTRLBRN (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal)
);

CREATE INDEX idx_cntrlbrn_created_at ON CNTRLBRN(created_at);

CREATE TABLE CNTRLNUM (
  codigo_aplicacion VARCHAR(20) NOT NULL,
  tipo_cuenta VARCHAR(20) NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_aplicacion, tipo_cuenta)
);

CREATE INDEX idx_cntrlnum_created_at ON CNTRLNUM(created_at);

CREATE TABLE CNTRLTAX (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_impuesto VARCHAR(20) NOT NULL,
  descripcion VARCHAR(120),
  valor_texto VARCHAR(50),
  valor_numerico DECIMAL(18,2),
  vigencia_desde DATE,
  vigencia_hasta DATE,
  orden_visualizacion INTEGER,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_impuesto)
);

CREATE INDEX idx_cntrltax_created_at ON CNTRLTAX(created_at);

-- 2. CLIENTES

CREATE TABLE CUMST (
  id_cliente VARCHAR(30) NOT NULL,
  tipo_persona VARCHAR(20),
  tipo_identificacion VARCHAR(20),
  numero_identificacion VARCHAR(30),
  nombres VARCHAR(80),
  apellidos VARCHAR(80),
  razon_social VARCHAR(80),
  fecha_nacimiento DATE,
  direccion VARCHAR(120),
  email VARCHAR(80),
  telefono VARCHAR(80),
  pais_residencia VARCHAR(50),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_cliente)
);

CREATE INDEX idx_cumst_created_at ON CUMST(created_at);

CREATE TABLE CUMAD (
  id_cliente_operacion VARCHAR(30) NOT NULL,
  tipo_registro VARCHAR(20) NOT NULL,
  secuencia INTEGER NOT NULL,
  tipo_persona VARCHAR(20),
  tipo_identificacion VARCHAR(20),
  numero_identificacion VARCHAR(30),
  nombres VARCHAR(80),
  apellidos VARCHAR(80),
  razon_social VARCHAR(80),
  fecha_nacimiento DATE,
  direccion VARCHAR(120),
  email VARCHAR(80),
  telefono VARCHAR(80),
  pais_residencia VARCHAR(50),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_cliente_operacion, tipo_registro, secuencia)
);

CREATE INDEX idx_cumad_created_at ON CUMAD(created_at);

CREATE TABLE CUMPR (
  palabra VARCHAR(50) NOT NULL,
  tipo_persona VARCHAR(20),
  tipo_identificacion VARCHAR(20),
  numero_identificacion VARCHAR(30),
  nombres VARCHAR(80),
  apellidos VARCHAR(80),
  razon_social VARCHAR(80),
  fecha_nacimiento DATE,
  direccion VARCHAR(120),
  email VARCHAR(80),
  telefono VARCHAR(80),
  pais_residencia VARCHAR(50),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (palabra)
);

CREATE INDEX idx_cumpr_created_at ON CUMPR(created_at);

CREATE TABLE CUMSD (
  id_cliente VARCHAR(30) NOT NULL,
  tipo_persona VARCHAR(20),
  tipo_identificacion VARCHAR(20),
  numero_identificacion VARCHAR(30),
  nombres VARCHAR(80),
  apellidos VARCHAR(80),
  razon_social VARCHAR(80),
  fecha_nacimiento DATE,
  direccion VARCHAR(120),
  email VARCHAR(80),
  telefono VARCHAR(80),
  pais_residencia VARCHAR(50),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_cliente)
);

CREATE INDEX idx_cumsd_created_at ON CUMSD(created_at);

CREATE TABLE SPINS (
  tipo_informacion VARCHAR(50) NOT NULL,
  cuenta_o_cliente VARCHAR(50) NOT NULL,
  secuencia INTEGER NOT NULL,
  tipo_persona VARCHAR(20),
  tipo_identificacion VARCHAR(20),
  numero_identificacion VARCHAR(30),
  nombres VARCHAR(80),
  apellidos VARCHAR(80),
  razon_social VARCHAR(80),
  fecha_nacimiento DATE,
  direccion VARCHAR(120),
  email VARCHAR(80),
  telefono VARCHAR(80),
  pais_residencia VARCHAR(50),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (tipo_informacion, cuenta_o_cliente, secuencia)
);

CREATE INDEX idx_spins_created_at ON SPINS(created_at);

-- 3. CUENTAS DE DETALLE/CHEQUERAS

CREATE TABLE ACMST (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_acmst_created_at ON ACMST(created_at);

CREATE TABLE STPMT (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  cuenta_contable VARCHAR(24) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  secuencia INTEGER NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, codigo_moneda, cuenta_contable, numero_cuenta, secuencia)
);

CREATE INDEX idx_stpmt_created_at ON STPMT(created_at);

CREATE TABLE UNCOL (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, numero_cuenta)
);

CREATE INDEX idx_uncol_created_at ON UNCOL(created_at);

CREATE TABLE PBTRN (
  numero_cuenta VARCHAR(24) NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_cuenta, fecha, hora)
);

CREATE INDEX idx_pbtrn_fecha ON PBTRN(fecha);
CREATE INDEX idx_pbtrn_created_at ON PBTRN(created_at);

CREATE TABLE OFMST (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  numero_cheque VARCHAR(30) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, numero_cheque)
);

CREATE INDEX idx_ofmst_created_at ON OFMST(created_at);

CREATE TABLE RCLNB (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  cuenta_contable VARCHAR(24) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  fecha DATE NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, codigo_moneda, cuenta_contable, numero_cuenta, fecha)
);

CREATE INDEX idx_rclnb_fecha ON RCLNB(fecha);
CREATE INDEX idx_rclnb_created_at ON RCLNB(created_at);

CREATE TABLE TLMST (
  codigo_de_cajero VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_de_cajero, codigo_moneda)
);

CREATE INDEX idx_tlmst_created_at ON TLMST(created_at);

CREATE TABLE TDRCR (
  codigo_de_transaccion VARCHAR(20) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_de_transaccion)
);

CREATE INDEX idx_tdrcr_created_at ON TDRCR(created_at);

CREATE TABLE AUDIT (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  codigo_cajero VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  referencia VARCHAR(50) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, codigo_cajero, codigo_moneda, referencia)
);

CREATE INDEX idx_audit_created_at ON AUDIT(created_at);

CREATE TABLE CHMST (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  cheque_inicial VARCHAR(50) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, codigo_moneda, numero_cuenta, cheque_inicial)
);

CREATE INDEX idx_chmst_created_at ON CHMST(created_at);

CREATE TABLE CHPER (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, numero_cuenta)
);

CREATE INDEX idx_chper_created_at ON CHPER(created_at);

CREATE TABLE CHSTS (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  cuenta_contable VARCHAR(24) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, codigo_moneda, cuenta_contable, numero_cuenta)
);

CREATE INDEX idx_chsts_created_at ON CHSTS(created_at);

CREATE TABLE DEVOL (
  numero_cuenta VARCHAR(24) NOT NULL,
  numero_cheque VARCHAR(30) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_cuenta, numero_cheque)
);

CREATE INDEX idx_devol_created_at ON DEVOL(created_at);

CREATE TABLE CMRIN (
  codigo_banco VARCHAR(20) NOT NULL,
  sucursal_moneda VARCHAR(50) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  monto DECIMAL(18,2) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, sucursal_moneda)
);

CREATE INDEX idx_cmrin_created_at ON CMRIN(created_at);

CREATE TABLE OVDRF (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_ovdrf_created_at ON OVDRF(created_at);

CREATE TABLE CNTRLMSG (
  codigo_banco VARCHAR(20) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco)
);

CREATE INDEX idx_cntrlmsg_created_at ON CNTRLMSG(created_at);

CREATE TABLE CNTRLRTE (
  codigo_banco VARCHAR(20) NOT NULL,
  tipo_producto VARCHAR(20) NOT NULL,
  codigo_tabla VARCHAR(20) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, tipo_producto, codigo_tabla)
);

CREATE INDEX idx_cntrlrte_created_at ON CNTRLRTE(created_at);

CREATE TABLE CNTRLDEV (
  codigo_causal VARCHAR(20) NOT NULL,
  fecha_apertura DATE,
  fecha_ultima_transaccion DATE,
  saldo_actual DECIMAL(18,2),
  saldo_disponible DECIMAL(18,2),
  limite_sobregiro DECIMAL(18,2),
  estado_cuenta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_causal)
);

CREATE INDEX idx_cntrldev_created_at ON CNTRLDEV(created_at);

-- 4. CONTRATOS/CERTIFICADOS/GIROS/VALORES AL COBRO

CREATE TABLE DEALS (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  fecha_desembolso DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  tasa_interes DECIMAL(18,2),
  plazo_meses INTEGER,
  dias_mora INTEGER,
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_deals_created_at ON DEALS(created_at);

CREATE TABLE DLPMT (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  numero_prestamo VARCHAR(30) NOT NULL,
  fecha DATE NOT NULL,
  tipo_registro VARCHAR(20) NOT NULL,
  fecha_desembolso DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  tasa_interes DECIMAL(18,2),
  plazo_meses INTEGER,
  dias_mora INTEGER,
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, codigo_moneda, numero_prestamo, fecha, tipo_registro)
);

CREATE INDEX idx_dlpmt_fecha ON DLPMT(fecha);
CREATE INDEX idx_dlpmt_created_at ON DLPMT(created_at);

CREATE TABLE DLDRF (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  numero_prestamo VARCHAR(30) NOT NULL,
  identificacion VARCHAR(50) NOT NULL,
  numero_documento VARCHAR(30) NOT NULL,
  fecha_desembolso DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  tasa_interes DECIMAL(18,2),
  plazo_meses INTEGER,
  dias_mora INTEGER,
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, codigo_moneda, numero_prestamo, identificacion, numero_documento)
);

CREATE INDEX idx_dldrf_created_at ON DLDRF(created_at);

CREATE TABLE DLSDE (
  numero_prestamo VARCHAR(30) NOT NULL,
  fecha DATE NOT NULL,
  tipo_registro VARCHAR(20) NOT NULL,
  secuencia INTEGER NOT NULL,
  codigo_deduccion VARCHAR(20) NOT NULL,
  fecha_desembolso DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  tasa_interes DECIMAL(18,2),
  plazo_meses INTEGER,
  dias_mora INTEGER,
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_prestamo, fecha, tipo_registro, secuencia, codigo_deduccion)
);

CREATE INDEX idx_dlsde_fecha ON DLSDE(fecha);
CREATE INDEX idx_dlsde_created_at ON DLSDE(created_at);

CREATE TABLE DLCLP (
  id_cliente VARCHAR(30) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  referencia VARCHAR(50) NOT NULL,
  fecha_desembolso DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  tasa_interes DECIMAL(18,2),
  plazo_meses INTEGER,
  dias_mora INTEGER,
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_cliente, numero_cuenta, referencia)
);

CREATE INDEX idx_dlclp_created_at ON DLCLP(created_at);

CREATE TABLE DDCPN (
  numero_prestamo VARCHAR(30) NOT NULL,
  fecha_desembolso DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  tasa_interes DECIMAL(18,2),
  plazo_meses INTEGER,
  dias_mora INTEGER,
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_prestamo)
);

CREATE INDEX idx_ddcpn_created_at ON DDCPN(created_at);

CREATE TABLE DLITP (
  numero_prestamo VARCHAR(30) NOT NULL,
  codigo_deduccion VARCHAR(20) NOT NULL,
  fecha_desembolso DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  tasa_interes DECIMAL(18,2),
  plazo_meses INTEGER,
  dias_mora INTEGER,
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_prestamo, codigo_deduccion)
);

CREATE INDEX idx_dlitp_created_at ON DLITP(created_at);

CREATE TABLE CDRTE (
  numero_tabla VARCHAR(30) NOT NULL,
  fecha DATE NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  fecha_desembolso DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  tasa_interes DECIMAL(18,2),
  plazo_meses INTEGER,
  dias_mora INTEGER,
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_tabla, fecha, codigo_moneda)
);

CREATE INDEX idx_cdrte_fecha ON CDRTE(fecha);
CREATE INDEX idx_cdrte_created_at ON CDRTE(created_at);

CREATE TABLE CNTRLDLS (
  codigo_banco VARCHAR(20) NOT NULL,
  numero_tabla VARCHAR(30) NOT NULL,
  tipo_producto VARCHAR(20) NOT NULL,
  fecha_desembolso DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  tasa_interes DECIMAL(18,2),
  plazo_meses INTEGER,
  dias_mora INTEGER,
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, numero_tabla, tipo_producto)
);

CREATE INDEX idx_cntrldls_created_at ON CNTRLDLS(created_at);

-- 5. CARTAS DE CRÉDITO

CREATE TABLE LCMST (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  fecha_emision DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  banco_corresponsal VARCHAR(80),
  pais_destino VARCHAR(80),
  estado_carta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_lcmst_created_at ON LCMST(created_at);

CREATE TABLE LCDOC (
  numero_carta_credito VARCHAR(30) NOT NULL,
  tipo_registro VARCHAR(20) NOT NULL,
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_documento VARCHAR(20) NOT NULL,
  numero_linea VARCHAR(30) NOT NULL,
  fecha_emision DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  banco_corresponsal VARCHAR(80),
  pais_destino VARCHAR(80),
  estado_carta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_carta_credito, tipo_registro, codigo_banco, codigo_documento, numero_linea)
);

CREATE INDEX idx_lcdoc_created_at ON LCDOC(created_at);

CREATE TABLE LCFIN (
  nivel INTEGER NOT NULL,
  codigo_documento VARCHAR(20) NOT NULL,
  secuencia_de_texto VARCHAR(50) NOT NULL,
  fecha_emision DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  banco_corresponsal VARCHAR(80),
  pais_destino VARCHAR(80),
  estado_carta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (nivel, codigo_documento, secuencia_de_texto)
);

CREATE INDEX idx_lcfin_created_at ON LCFIN(created_at);

CREATE TABLE LCFMT (
  codigo_documento VARCHAR(20) NOT NULL,
  secuencia_de_texto VARCHAR(50) NOT NULL,
  numero_linea VARCHAR(30) NOT NULL,
  fecha_emision DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  banco_corresponsal VARCHAR(80),
  pais_destino VARCHAR(80),
  estado_carta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_documento, secuencia_de_texto, numero_linea)
);

CREATE INDEX idx_lcfmt_created_at ON LCFMT(created_at);

CREATE TABLE LCADM (
  numero_carta_credito VARCHAR(30) NOT NULL,
  numero_enmienda VARCHAR(30) NOT NULL,
  fecha_emision DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  banco_corresponsal VARCHAR(80),
  pais_destino VARCHAR(80),
  estado_carta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_carta_credito, numero_enmienda)
);

CREATE INDEX idx_lcadm_created_at ON LCADM(created_at);

CREATE TABLE LCCOV (
  numero_carta_credito VARCHAR(30) NOT NULL,
  secuencia INTEGER NOT NULL,
  fecha_emision DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  banco_corresponsal VARCHAR(80),
  pais_destino VARCHAR(80),
  estado_carta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_carta_credito, secuencia)
);

CREATE INDEX idx_lccov_created_at ON LCCOV(created_at);

CREATE TABLE LCDIN (
  numero_carta_credito VARCHAR(30) NOT NULL,
  secuencia INTEGER NOT NULL,
  fecha_emision DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  banco_corresponsal VARCHAR(80),
  pais_destino VARCHAR(80),
  estado_carta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_carta_credito, secuencia)
);

CREATE INDEX idx_lcdin_created_at ON LCDIN(created_at);

CREATE TABLE LCSTA (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  fecha_emision DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  banco_corresponsal VARCHAR(80),
  pais_destino VARCHAR(80),
  estado_carta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_lcsta_created_at ON LCSTA(created_at);

CREATE TABLE CNTRLLCP (
  codigo_banco VARCHAR(20) NOT NULL,
  lcrparm VARCHAR(20) NOT NULL,
  fecha_emision DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  banco_corresponsal VARCHAR(80),
  pais_destino VARCHAR(80),
  estado_carta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, lcrparm)
);

CREATE INDEX idx_cntrllcp_created_at ON CNTRLLCP(created_at);

CREATE TABLE CNTRLRLC (
  codigo_banco VARCHAR(20) NOT NULL,
  tipo_producto VARCHAR(20) NOT NULL,
  numero_tabla VARCHAR(30) NOT NULL,
  fecha_emision DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_actual DECIMAL(18,2),
  banco_corresponsal VARCHAR(80),
  pais_destino VARCHAR(80),
  estado_carta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, tipo_producto, numero_tabla)
);

CREATE INDEX idx_cntrlrlc_created_at ON CNTRLRLC(created_at);

-- 6. COBRANZAS

CREATE TABLE DCMST (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  fecha_recepcion DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_pendiente DECIMAL(18,2),
  tipo_documento VARCHAR(20),
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_dcmst_created_at ON DCMST(created_at);

CREATE TABLE APPRV (
  numero_carta_credito VARCHAR(30) NOT NULL,
  tipo_registro VARCHAR(20) NOT NULL,
  fecha_recepcion DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_pendiente DECIMAL(18,2),
  tipo_documento VARCHAR(20),
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_carta_credito, tipo_registro)
);

CREATE INDEX idx_apprv_created_at ON APPRV(created_at);

CREATE TABLE LCFEE (
  numero_carta_credito VARCHAR(30) NOT NULL,
  codigo_de_comision VARCHAR(20) NOT NULL,
  fecha_recepcion DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_pendiente DECIMAL(18,2),
  tipo_documento VARCHAR(20),
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_carta_credito, codigo_de_comision)
);

CREATE INDEX idx_lcfee_created_at ON LCFEE(created_at);

CREATE TABLE CNTRLRCO (
  codigo_banco VARCHAR(20) NOT NULL,
  tipo_producto VARCHAR(20) NOT NULL,
  numero_tabla VARCHAR(30) NOT NULL,
  fecha_recepcion DATE,
  fecha_vencimiento DATE,
  monto_original DECIMAL(18,2),
  saldo_pendiente DECIMAL(18,2),
  tipo_documento VARCHAR(20),
  estado_operacion VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, tipo_producto, numero_tabla)
);

CREATE INDEX idx_cntrlrco_created_at ON CNTRLRCO(created_at);

-- 7. CONTABILIDAD

CREATE TABLE GLMST (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  cuenta_contable VARCHAR(24) NOT NULL,
  descripcion_cuenta VARCHAR(120),
  naturaleza_cuenta VARCHAR(20),
  nivel_cuenta VARCHAR(50),
  saldo_actual DECIMAL(18,2),
  fecha_proceso_sistema TIMESTAMP,
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_moneda, cuenta_contable)
);

CREATE INDEX idx_glmst_created_at ON GLMST(created_at);

CREATE TABLE INPUT (
  numero_del_lote VARCHAR(30) NOT NULL,
  secuencia_dentro_del_lote VARCHAR(50) NOT NULL,
  descripcion_cuenta VARCHAR(120),
  naturaleza_cuenta VARCHAR(20),
  nivel_cuenta VARCHAR(50),
  saldo_actual DECIMAL(18,2),
  fecha_proceso_sistema TIMESTAMP,
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_del_lote, secuencia_dentro_del_lote)
);

CREATE INDEX idx_input_created_at ON INPUT(created_at);

CREATE TABLE GLBLN (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  cuenta_contable VARCHAR(24) NOT NULL,
  descripcion_cuenta VARCHAR(120),
  naturaleza_cuenta VARCHAR(20),
  nivel_cuenta VARCHAR(50),
  saldo_actual DECIMAL(18,2),
  fecha_proceso_sistema TIMESTAMP,
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, codigo_moneda, cuenta_contable)
);

CREATE INDEX idx_glbln_created_at ON GLBLN(created_at);

CREATE TABLE GLBSE (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  descripcion_cuenta VARCHAR(120),
  naturaleza_cuenta VARCHAR(20),
  nivel_cuenta VARCHAR(50),
  saldo_actual DECIMAL(18,2),
  fecha_proceso_sistema TIMESTAMP,
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_glbse_created_at ON GLBSE(created_at);

CREATE TABLE GLFIN (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  descripcion_cuenta VARCHAR(120),
  naturaleza_cuenta VARCHAR(20),
  nivel_cuenta VARCHAR(50),
  saldo_actual DECIMAL(18,2),
  fecha_proceso_sistema TIMESTAMP,
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_glfin_created_at ON GLFIN(created_at);

CREATE TABLE CCDSC (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  descripcion_cuenta VARCHAR(120),
  naturaleza_cuenta VARCHAR(20),
  nivel_cuenta VARCHAR(50),
  saldo_actual DECIMAL(18,2),
  fecha_proceso_sistema TIMESTAMP,
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_ccdsc_created_at ON CCDSC(created_at);

CREATE TABLE INPT2 (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  descripcion_cuenta VARCHAR(120),
  naturaleza_cuenta VARCHAR(20),
  nivel_cuenta VARCHAR(50),
  saldo_actual DECIMAL(18,2),
  fecha_proceso_sistema TIMESTAMP,
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_inpt2_created_at ON INPT2(created_at);

CREATE TABLE NXINP (
  numero_batch VARCHAR(30) NOT NULL,
  secuencia INTEGER NOT NULL,
  descripcion_cuenta VARCHAR(120),
  naturaleza_cuenta VARCHAR(20),
  nivel_cuenta VARCHAR(50),
  saldo_actual DECIMAL(18,2),
  fecha_proceso_sistema TIMESTAMP,
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_batch, secuencia)
);

CREATE INDEX idx_nxinp_created_at ON NXINP(created_at);

CREATE TABLE BUMST (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  numero_presupuesto VARCHAR(30) NOT NULL,
  centro_costo VARCHAR(50) NOT NULL,
  descripcion_cuenta VARCHAR(120),
  naturaleza_cuenta VARCHAR(20),
  nivel_cuenta VARCHAR(50),
  saldo_actual DECIMAL(18,2),
  fecha_proceso_sistema TIMESTAMP,
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, codigo_moneda, numero_presupuesto, centro_costo)
);

CREATE INDEX idx_bumst_created_at ON BUMST(created_at);

-- 8. GARANTÍAS

CREATE TABLE ROCOL (
  codigo_banco VARCHAR(20) NOT NULL,
  id_cliente VARCHAR(30) NOT NULL,
  numero_garantia VARCHAR(30) NOT NULL,
  tipo_garantia VARCHAR(20),
  valor_garantia DECIMAL(18,2),
  fecha_avaluo DATE,
  fecha_vencimiento DATE,
  estado_garantia VARCHAR(20),
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, id_cliente, numero_garantia)
);

CREATE INDEX idx_rocol_created_at ON ROCOL(created_at);

CREATE TABLE RCOLL (
  codigo_banco VARCHAR(20) NOT NULL,
  cuenta_a_garantizar VARCHAR(50) NOT NULL,
  cuenta_que_garantiza VARCHAR(50) NOT NULL,
  tipo_garantia VARCHAR(20),
  valor_garantia DECIMAL(18,2),
  fecha_avaluo DATE,
  fecha_vencimiento DATE,
  estado_garantia VARCHAR(20),
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, cuenta_a_garantizar, cuenta_que_garantiza)
);

CREATE INDEX idx_rcoll_created_at ON RCOLL(created_at);

-- 9. LINEAS DE CRÉDITO

CREATE TABLE LNECR (
  id_cliente VARCHAR(30) NOT NULL,
  numero_linea VARCHAR(30) NOT NULL,
  fecha_aprobacion DATE,
  fecha_vencimiento DATE,
  monto_aprobado DECIMAL(18,2),
  monto_utilizado DECIMAL(18,2),
  monto_disponible DECIMAL(18,2),
  estado_linea VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_cliente, numero_linea)
);

CREATE INDEX idx_lnecr_created_at ON LNECR(created_at);

-- 10. ACTIVOS FIJOS

CREATE TABLE FIXMS (
  numero_activo VARCHAR(30) NOT NULL,
  descripcion VARCHAR(120),
  fecha_adquisicion DATE,
  valor_adquisicion DECIMAL(18,2),
  vida_util_meses INTEGER,
  depreciacion_acumulada DECIMAL(18,2),
  estado_activo VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_activo)
);

CREATE INDEX idx_fixms_created_at ON FIXMS(created_at);

CREATE TABLE CLSMS (
  codigo_clase VARCHAR(20) NOT NULL,
  descripcion VARCHAR(120),
  fecha_adquisicion DATE,
  valor_adquisicion DECIMAL(18,2),
  vida_util_meses INTEGER,
  depreciacion_acumulada DECIMAL(18,2),
  estado_activo VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_clase)
);

CREATE INDEX idx_clsms_created_at ON CLSMS(created_at);

CREATE TABLE LOCMS (
  numero_localizacion VARCHAR(30) NOT NULL,
  descripcion VARCHAR(120),
  fecha_adquisicion DATE,
  valor_adquisicion DECIMAL(18,2),
  vida_util_meses INTEGER,
  depreciacion_acumulada DECIMAL(18,2),
  estado_activo VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_localizacion)
);

CREATE INDEX idx_locms_created_at ON LOCMS(created_at);

CREATE TABLE CNTRLFIX (
  codigo_banco VARCHAR(20) NOT NULL,
  descripcion VARCHAR(120),
  fecha_adquisicion DATE,
  valor_adquisicion DECIMAL(18,2),
  vida_util_meses INTEGER,
  depreciacion_acumulada DECIMAL(18,2),
  estado_activo VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco)
);

CREATE INDEX idx_cntrlfix_created_at ON CNTRLFIX(created_at);

-- 11. PROVEEDORES Y CUENTAS POR PAGAR

CREATE TABLE BAVEN (
  id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  numero_proveedor VARCHAR(30),
  numero_identificacion VARCHAR(30),
  razon_social VARCHAR(80),
  email VARCHAR(80),
  telefono VARCHAR(80),
  monto_original DECIMAL(18,2),
  saldo_pendiente DECIMAL(18,2),
  fecha_emision DATE,
  fecha_vencimiento DATE,
  estado_cxp VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE INDEX idx_baven_created_at ON BAVEN(created_at);

CREATE TABLE BAPRC (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  origen_cuenta VARCHAR(20) NOT NULL,
  tipo_cuenta VARCHAR(20) NOT NULL,
  id_cliente VARCHAR(30) NOT NULL,
  numero_referencia VARCHAR(30) NOT NULL,
  tipo_registro VARCHAR(20) NOT NULL,
  numero_identificacion VARCHAR(30),
  razon_social VARCHAR(80),
  email VARCHAR(80),
  telefono VARCHAR(80),
  monto_original DECIMAL(18,2),
  saldo_pendiente DECIMAL(18,2),
  fecha_emision DATE,
  fecha_vencimiento DATE,
  estado_cxp VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, origen_cuenta, tipo_cuenta, id_cliente, numero_referencia, tipo_registro)
);

CREATE INDEX idx_baprc_created_at ON BAPRC(created_at);

CREATE TABLE BAMOR (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_sucursal VARCHAR(20) NOT NULL,
  origen_cuenta VARCHAR(20) NOT NULL,
  tipo_cuenta VARCHAR(20) NOT NULL,
  id_cliente VARCHAR(30) NOT NULL,
  numero_referencia VARCHAR(30) NOT NULL,
  tipo_registro VARCHAR(20) NOT NULL,
  numero_identificacion VARCHAR(30),
  razon_social VARCHAR(80),
  email VARCHAR(80),
  telefono VARCHAR(80),
  monto_original DECIMAL(18,2),
  saldo_pendiente DECIMAL(18,2),
  fecha_emision DATE,
  fecha_vencimiento DATE,
  estado_cxp VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_sucursal, origen_cuenta, tipo_cuenta, id_cliente, numero_referencia, tipo_registro)
);

CREATE INDEX idx_bamor_created_at ON BAMOR(created_at);

CREATE TABLE BAINP (
  numero_batch VARCHAR(30) NOT NULL,
  secuencia INTEGER NOT NULL,
  numero_identificacion VARCHAR(30),
  razon_social VARCHAR(80),
  email VARCHAR(80),
  telefono VARCHAR(80),
  monto_original DECIMAL(18,2),
  saldo_pendiente DECIMAL(18,2),
  fecha_emision DATE,
  fecha_vencimiento DATE,
  estado_cxp VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_batch, secuencia)
);

CREATE INDEX idx_bainp_created_at ON BAINP(created_at);

CREATE TABLE BAHIS (
  codigo_banco VARCHAR(20) NOT NULL,
  origen_cuenta VARCHAR(20) NOT NULL,
  tipo_cuenta VARCHAR(20) NOT NULL,
  id_cliente VARCHAR(30) NOT NULL,
  numero_referencia VARCHAR(30) NOT NULL,
  fecha DATE NOT NULL,
  numero_identificacion VARCHAR(30),
  razon_social VARCHAR(80),
  email VARCHAR(80),
  telefono VARCHAR(80),
  monto_original DECIMAL(18,2),
  saldo_pendiente DECIMAL(18,2),
  fecha_emision DATE,
  fecha_vencimiento DATE,
  estado_cxp VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, origen_cuenta, tipo_cuenta, id_cliente, numero_referencia, fecha)
);

CREATE INDEX idx_bahis_fecha ON BAHIS(fecha);
CREATE INDEX idx_bahis_created_at ON BAHIS(created_at);

CREATE TABLE CNTRLBAF (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  numero_identificacion VARCHAR(30),
  razon_social VARCHAR(80),
  email VARCHAR(80),
  telefono VARCHAR(80),
  monto_original DECIMAL(18,2),
  saldo_pendiente DECIMAL(18,2),
  fecha_emision DATE,
  fecha_vencimiento DATE,
  estado_cxp VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_moneda)
);

CREATE INDEX idx_cntrlbaf_created_at ON CNTRLBAF(created_at);

CREATE TABLE CNTRLBAP (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  numero_identificacion VARCHAR(30),
  razon_social VARCHAR(80),
  email VARCHAR(80),
  telefono VARCHAR(80),
  monto_original DECIMAL(18,2),
  saldo_pendiente DECIMAL(18,2),
  fecha_emision DATE,
  fecha_vencimiento DATE,
  estado_cxp VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_moneda)
);

CREATE INDEX idx_cntrlbap_created_at ON CNTRLBAP(created_at);

-- 12. PAGOS Y TRANSFERENCIAS

CREATE TABLE FIWRT (
  codigo_banco VARCHAR(20) NOT NULL,
  numero_transferencia VARCHAR(30) NOT NULL,
  fecha_operacion DATE,
  monto DECIMAL(18,2),
  beneficiario VARCHAR(80),
  banco_destino VARCHAR(80),
  canal_pago VARCHAR(20),
  estado_pago VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, numero_transferencia)
);

CREATE INDEX idx_fiwrt_created_at ON FIWRT(created_at);

CREATE TABLE POFED (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  id_cliente VARCHAR(30) NOT NULL,
  tipo_registro VARCHAR(20) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  numero_referencia VARCHAR(30) NOT NULL,
  fecha_operacion DATE,
  monto DECIMAL(18,2),
  beneficiario VARCHAR(80),
  banco_destino VARCHAR(80),
  canal_pago VARCHAR(20),
  estado_pago VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_moneda, id_cliente, tipo_registro, numero_cuenta, numero_referencia)
);

CREATE INDEX idx_pofed_created_at ON POFED(created_at);

CREATE TABLE POSWF (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  id_cliente VARCHAR(30) NOT NULL,
  tipo_registro VARCHAR(20) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  numero_referencia VARCHAR(30) NOT NULL,
  monto DECIMAL(18,2) NOT NULL,
  fecha_operacion DATE,
  beneficiario VARCHAR(80),
  banco_destino VARCHAR(80),
  canal_pago VARCHAR(20),
  estado_pago VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_moneda, id_cliente, tipo_registro, numero_cuenta, numero_referencia)
);

CREATE INDEX idx_poswf_created_at ON POSWF(created_at);

CREATE TABLE POTLX (
  codigo_banco VARCHAR(20) NOT NULL,
  codigo_moneda VARCHAR(20) NOT NULL,
  id_cliente VARCHAR(30) NOT NULL,
  tipo_registro VARCHAR(20) NOT NULL,
  numero_cuenta VARCHAR(24) NOT NULL,
  numero_referencia VARCHAR(30) NOT NULL,
  fecha_operacion DATE,
  monto DECIMAL(18,2),
  beneficiario VARCHAR(80),
  banco_destino VARCHAR(80),
  canal_pago VARCHAR(20),
  estado_pago VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, codigo_moneda, id_cliente, tipo_registro, numero_cuenta, numero_referencia)
);

CREATE INDEX idx_potlx_created_at ON POTLX(created_at);

CREATE TABLE SWITF (
  codigo_banco VARCHAR(20) NOT NULL,
  numero_referencia VARCHAR(30) NOT NULL,
  formato_swift VARCHAR(50) NOT NULL,
  fecha_operacion DATE,
  monto DECIMAL(18,2),
  beneficiario VARCHAR(80),
  banco_destino VARCHAR(80),
  canal_pago VARCHAR(20),
  estado_pago VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, numero_referencia, formato_swift)
);

CREATE INDEX idx_switf_created_at ON SWITF(created_at);

CREATE TABLE CNTRLPRF (
  codigo_banco VARCHAR(20) NOT NULL,
  parametro VARCHAR(20) NOT NULL,
  codigo_tabla VARCHAR(20) NOT NULL,
  fecha_operacion DATE,
  monto DECIMAL(18,2),
  beneficiario VARCHAR(80),
  banco_destino VARCHAR(80),
  canal_pago VARCHAR(20),
  estado_pago VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_banco, parametro, codigo_tabla)
);

CREATE INDEX idx_cntrlprf_created_at ON CNTRLPRF(created_at);

-- 13. PROPUESTA DE CRÉDITO

CREATE TABLE PLPCR (
  numero_propuesta VARCHAR(30) NOT NULL,
  fecha_propuesta DATE,
  monto_solicitado DECIMAL(18,2),
  plazo_meses INTEGER,
  tasa_propuesta DECIMAL(18,2),
  dictamen_credito VARCHAR(120),
  estado_propuesta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_propuesta)
);

CREATE INDEX idx_plpcr_created_at ON PLPCR(created_at);

CREATE TABLE PLPRD (
  numero_propuesta VARCHAR(30) NOT NULL,
  codigo_producto VARCHAR(20) NOT NULL,
  tipo_producto VARCHAR(20) NOT NULL,
  fecha_propuesta DATE,
  monto_solicitado DECIMAL(18,2),
  plazo_meses INTEGER,
  tasa_propuesta DECIMAL(18,2),
  dictamen_credito VARCHAR(120),
  estado_propuesta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_propuesta, codigo_producto)
);

CREATE INDEX idx_plprd_created_at ON PLPRD(created_at);

CREATE TABLE PLGRT (
  numero_propuesta VARCHAR(30) NOT NULL,
  secuencia INTEGER NOT NULL,
  fecha_propuesta DATE,
  monto_solicitado DECIMAL(18,2),
  plazo_meses INTEGER,
  tasa_propuesta DECIMAL(18,2),
  dictamen_credito VARCHAR(120),
  estado_propuesta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_propuesta, secuencia)
);

CREATE INDEX idx_plgrt_created_at ON PLGRT(created_at);

CREATE TABLE DPMST (
  id_cliente VARCHAR(30) NOT NULL,
  secuencia INTEGER NOT NULL,
  fecha_propuesta DATE,
  monto_solicitado DECIMAL(18,2),
  plazo_meses INTEGER,
  tasa_propuesta DECIMAL(18,2),
  dictamen_credito VARCHAR(120),
  estado_propuesta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_cliente, secuencia)
);

CREATE INDEX idx_dpmst_created_at ON DPMST(created_at);

CREATE TABLE DPDTL (
  id_cliente VARCHAR(30) NOT NULL,
  secuencia INTEGER NOT NULL,
  tipo_registro VARCHAR(20) NOT NULL,
  fecha_propuesta DATE,
  monto_solicitado DECIMAL(18,2),
  plazo_meses INTEGER,
  tasa_propuesta DECIMAL(18,2),
  dictamen_credito VARCHAR(120),
  estado_propuesta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_cliente, secuencia, tipo_registro)
);

CREATE INDEX idx_dpdtl_created_at ON DPDTL(created_at);

CREATE TABLE IFMST (
  id_cliente VARCHAR(30) NOT NULL,
  anio INTEGER NOT NULL,
  mes INTEGER NOT NULL,
  formato_balance VARCHAR(50) NOT NULL,
  fecha_propuesta DATE,
  monto_solicitado DECIMAL(18,2),
  plazo_meses INTEGER,
  tasa_propuesta DECIMAL(18,2),
  dictamen_credito VARCHAR(120),
  estado_propuesta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_cliente, anio, mes, formato_balance)
);

CREATE INDEX idx_ifmst_created_at ON IFMST(created_at);

CREATE TABLE IFDTL (
  id_cliente VARCHAR(30) NOT NULL,
  anio INTEGER NOT NULL,
  mes INTEGER NOT NULL,
  formato_balance VARCHAR(50) NOT NULL,
  codigo_linea VARCHAR(20) NOT NULL,
  codigo_cuenta VARCHAR(20) NOT NULL,
  fecha_propuesta DATE,
  monto_solicitado DECIMAL(18,2),
  plazo_meses INTEGER,
  tasa_propuesta DECIMAL(18,2),
  dictamen_credito VARCHAR(120),
  estado_propuesta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_cliente, anio, mes, formato_balance, codigo_linea, codigo_cuenta)
);

CREATE INDEX idx_ifdtl_created_at ON IFDTL(created_at);

CREATE TABLE DPGLN (
  tipo_balance VARCHAR(20) NOT NULL,
  codigo_cuenta VARCHAR(20) NOT NULL,
  fecha_propuesta DATE,
  monto_solicitado DECIMAL(18,2),
  plazo_meses INTEGER,
  tasa_propuesta DECIMAL(18,2),
  dictamen_credito VARCHAR(120),
  estado_propuesta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (tipo_balance, codigo_cuenta)
);

CREATE INDEX idx_dpgln_created_at ON DPGLN(created_at);

CREATE TABLE LIMST (
  id_cliente VARCHAR(30) NOT NULL,
  fecha_propuesta DATE,
  monto_solicitado DECIMAL(18,2),
  plazo_meses INTEGER,
  tasa_propuesta DECIMAL(18,2),
  dictamen_credito VARCHAR(120),
  estado_propuesta VARCHAR(20),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (id_cliente)
);

CREATE INDEX idx_limst_created_at ON LIMST(created_at);

-- 14. MANEJO DE DOCUMENTOS

CREATE TABLE DIMST (
  tipo_cuenta VARCHAR(20) NOT NULL,
  numero_tabla VARCHAR(30) NOT NULL,
  secuencia INTEGER NOT NULL,
  tipo_documento VARCHAR(20),
  descripcion_documento VARCHAR(120),
  obligatorio BOOLEAN,
  fecha_recepcion DATE,
  fecha_vencimiento DATE,
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (tipo_cuenta, numero_tabla, secuencia)
);

CREATE INDEX idx_dimst_created_at ON DIMST(created_at);

CREATE TABLE DITBL (
  numero_tabla VARCHAR(30) NOT NULL,
  secuencia INTEGER NOT NULL,
  tipo_documento VARCHAR(20),
  descripcion_documento VARCHAR(120),
  obligatorio BOOLEAN,
  fecha_recepcion DATE,
  fecha_vencimiento DATE,
  observaciones VARCHAR(120),
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (numero_tabla, secuencia)
);

CREATE INDEX idx_ditbl_created_at ON DITBL(created_at);

-- 15. SEGURIDAD

CREATE TABLE USERS (
  codigo_usuario VARCHAR(20) NOT NULL,
  menu VARCHAR(20) NOT NULL,
  opcion VARCHAR(20) NOT NULL,
  rol VARCHAR(20),
  nivel_autorizacion INTEGER,
  permite_consulta BOOLEAN,
  permite_creacion BOOLEAN,
  permite_actualizacion BOOLEAN,
  permite_aprobacion BOOLEAN,
  usuario_creacion VARCHAR(30),
  usuario_actualizacion VARCHAR(30),
  version_registro INTEGER,
  observaciones VARCHAR(120),
  estado_registro CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (codigo_usuario, menu, opcion)
);

CREATE INDEX idx_users_created_at ON USERS(created_at);

-- FIN del script de creación de tablas
