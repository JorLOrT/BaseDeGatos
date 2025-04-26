USE master;
GO 

IF DB_ID('AlmacenBD') IS NULL
BEGIN
    CREATE DATABASE AlmacenBD
    ON PRIMARY
    (
        NAME = AlmacenBD_Data,
        FILENAME = 'D:\AlmacenBD_Data.mdf',
        SIZE = 10MB,
        MAXSIZE = 200MB,
        FILEGROWTH = 10MB
    )
    LOG ON
    (
        NAME = AlmacenBD_Log,
        FILENAME = 'D:\AlmacenBD_Log.ldf',
        SIZE = 5MB,
        MAXSIZE = 50MB,
        FILEGROWTH = 5MB
    );
    PRINT 'Base de datos AlmacenBD creada con archivos específicos.';
END
ELSE
BEGIN
    PRINT 'La base de datos AlmacenBD ya existe.';
END
GO

-- Usar la base de datos recién creada o existente
USE AlmacenBD;
GO

-- Eliminar tablas existentes en orden inverso de dependencia
IF OBJECT_ID('dbo.MovimientoInventario', 'U') IS NOT NULL DROP TABLE dbo.MovimientoInventario;
IF OBJECT_ID('dbo.DetalleVenta', 'U') IS NOT NULL DROP TABLE dbo.DetalleVenta;
IF OBJECT_ID('dbo.DetalleCompra', 'U') IS NOT NULL DROP TABLE dbo.DetalleCompra;
IF OBJECT_ID('dbo.Venta', 'U') IS NOT NULL DROP TABLE dbo.Venta;
IF OBJECT_ID('dbo.Compra', 'U') IS NOT NULL DROP TABLE dbo.Compra;
IF OBJECT_ID('dbo.Inventario', 'U') IS NOT NULL DROP TABLE dbo.Inventario;
IF OBJECT_ID('dbo.Vehiculo', 'U') IS NOT NULL DROP TABLE dbo.Vehiculo;
IF OBJECT_ID('dbo.Usuario', 'U') IS NOT NULL DROP TABLE dbo.Usuario;
IF OBJECT_ID('dbo.TelefonoLocal', 'U') IS NOT NULL DROP TABLE dbo.TelefonoLocal;
IF OBJECT_ID('dbo.Local', 'U') IS NOT NULL DROP TABLE dbo.Local;
IF OBJECT_ID('dbo.TelefonoProveedor', 'U') IS NOT NULL DROP TABLE dbo.TelefonoProveedor;
IF OBJECT_ID('dbo.DireccionProveedor', 'U') IS NOT NULL DROP TABLE dbo.DireccionProveedor;
IF OBJECT_ID('dbo.Proveedor', 'U') IS NOT NULL DROP TABLE dbo.Proveedor;
IF OBJECT_ID('dbo.TelefonoCliente', 'U') IS NOT NULL DROP TABLE dbo.TelefonoCliente;
IF OBJECT_ID('dbo.DireccionCliente', 'U') IS NOT NULL DROP TABLE dbo.DireccionCliente;
IF OBJECT_ID('dbo.Cliente', 'U') IS NOT NULL DROP TABLE dbo.Cliente;
IF OBJECT_ID('dbo.Producto', 'U') IS NOT NULL DROP TABLE dbo.Producto;
IF OBJECT_ID('dbo.CategoriaProducto', 'U') IS NOT NULL DROP TABLE dbo.CategoriaProducto;
IF OBJECT_ID('dbo.ModeloVehiculo', 'U') IS NOT NULL DROP TABLE dbo.ModeloVehiculo;
IF OBJECT_ID('dbo.MarcaVehiculo', 'U') IS NOT NULL DROP TABLE dbo.MarcaVehiculo;
IF OBJECT_ID('dbo.Rol', 'U') IS NOT NULL DROP TABLE dbo.Rol;
PRINT 'Tablas existentes eliminadas (si aplicable).';
GO

-- Eliminar Tipos de Datos Definidos por el Usuario (UDTs) si existen
IF TYPE_ID('dbo.TipoId') IS NOT NULL DROP TYPE dbo.TipoId;
IF TYPE_ID('dbo.TipoIdGrande') IS NOT NULL DROP TYPE dbo.TipoIdGrande;
IF TYPE_ID('dbo.TipoCodigo') IS NOT NULL DROP TYPE dbo.TipoCodigo;
IF TYPE_ID('dbo.TipoCodigoLargo') IS NOT NULL DROP TYPE dbo.TipoCodigoLargo;
IF TYPE_ID('dbo.TipoNombre') IS NOT NULL DROP TYPE dbo.TipoNombre;
IF TYPE_ID('dbo.TipoNombreLargo') IS NOT NULL DROP TYPE dbo.TipoNombreLargo;
IF TYPE_ID('dbo.TipoDescripcion') IS NOT NULL DROP TYPE dbo.TipoDescripcion;
IF TYPE_ID('dbo.TipoTextoLargo') IS NOT NULL DROP TYPE dbo.TipoTextoLargo;
IF TYPE_ID('dbo.TipoEmail') IS NOT NULL DROP TYPE dbo.TipoEmail;
IF TYPE_ID('dbo.TipoTelefono') IS NOT NULL DROP TYPE dbo.TipoTelefono;
IF TYPE_ID('dbo.TipoEstado') IS NOT NULL DROP TYPE dbo.TipoEstado;
IF TYPE_ID('dbo.TipoFlag') IS NOT NULL DROP TYPE dbo.TipoFlag;
IF TYPE_ID('dbo.TipoMoneda') IS NOT NULL DROP TYPE dbo.TipoMoneda;
IF TYPE_ID('dbo.TipoMonedaTotal') IS NOT NULL DROP TYPE dbo.TipoMonedaTotal;
IF TYPE_ID('dbo.TipoCantidad') IS NOT NULL DROP TYPE dbo.TipoCantidad;
IF TYPE_ID('dbo.TipoFecha') IS NOT NULL DROP TYPE dbo.TipoFecha;
IF TYPE_ID('dbo.TipoFechaHora') IS NOT NULL DROP TYPE dbo.TipoFechaHora;
PRINT 'UDTs existentes eliminados (si aplicable).';
GO

CREATE TYPE dbo.TipoId FROM INT NOT NULL;
CREATE TYPE dbo.TipoIdGrande FROM BIGINT NOT NULL;
CREATE TYPE dbo.TipoCodigo FROM NVARCHAR(50) NULL; -- Para códigos como SKU, comprobantes, etc.
CREATE TYPE dbo.TipoCodigoLargo FROM NVARCHAR(100) NULL; -- Para códigos de barras, etc.
CREATE TYPE dbo.TipoNombre FROM NVARCHAR(100) NOT NULL; -- Para nombres de Categoría, Marca, Modelo, Contacto
CREATE TYPE dbo.TipoNombreLargo FROM NVARCHAR(255) NOT NULL; -- Para RazonSocial, NombreCliente, NombreProducto
CREATE TYPE dbo.TipoDescripcion FROM NVARCHAR(150) NULL; -- Para descripciones cortas, observaciones
CREATE TYPE dbo.TipoTextoLargo FROM NVARCHAR(300) NULL; -- Para direcciones de texto
CREATE TYPE dbo.TipoEmail FROM NVARCHAR(100) NULL;
CREATE TYPE dbo.TipoTelefono FROM NVARCHAR(50) NOT NULL;
CREATE TYPE dbo.TipoEstado FROM NVARCHAR(30) NOT NULL; -- Aumentado ligeramente para Tipos de Movimiento
CREATE TYPE dbo.TipoFlag FROM BIT NOT NULL;
CREATE TYPE dbo.TipoMoneda FROM DECIMAL(10, 2) NULL;
CREATE TYPE dbo.TipoMonedaTotal FROM DECIMAL(12, 2) NULL;
CREATE TYPE dbo.TipoCantidad FROM INT NOT NULL;
CREATE TYPE dbo.TipoFecha FROM DATE NULL;
CREATE TYPE dbo.TipoFechaHora FROM DATETIME NULL;
PRINT 'UDTs creados.';
GO

-- Crear tabla Rol
IF OBJECT_ID('dbo.Rol', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Rol (
        idRol dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        NombreRol dbo.TipoCodigo NOT NULL UNIQUE,
        Descripcion dbo.TipoDescripcion NULL
    );
    PRINT 'Tabla Rol creada.';
END
GO

-- Crear tabla CategoriaProducto
IF OBJECT_ID('dbo.CategoriaProducto', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CategoriaProducto (
        idCategoria dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        Nombre dbo.TipoNombre NOT NULL UNIQUE,
        Descripcion dbo.TipoDescripcion NULL
    );
    PRINT 'Tabla CategoriaProducto creada.';
END
GO

-- Crear tabla Local
IF OBJECT_ID('dbo.Local', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Local (
        idLocal dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        Nombre dbo.TipoNombre NOT NULL,
        Direccion dbo.TipoNombreLargo NULL,
        Tipo dbo.TipoEstado NOT NULL CHECK (Tipo IN ('Almacen', 'TiendaMinorista')),
        Activo dbo.TipoFlag DEFAULT 1
    );
    PRINT 'Tabla Local creada.';
END
GO

-- Crear tabla TelefonoLocal
IF OBJECT_ID('dbo.TelefonoLocal', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.TelefonoLocal (
        idTelefonoLocal dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        idLocal dbo.TipoId NOT NULL,
        NumeroTelefono dbo.TipoTelefono NOT NULL,
        TipoTelefono dbo.TipoCodigo NULL,
        EsPrincipal dbo.TipoFlag DEFAULT 0,
        CONSTRAINT FK_TelefonoLocal_Local FOREIGN KEY (idLocal) REFERENCES dbo.Local(idLocal)
            ON DELETE CASCADE ON UPDATE CASCADE
    );
    PRINT 'Tabla TelefonoLocal creada.';
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_TelefonoLocal_idLocal' AND object_id = OBJECT_ID('dbo.TelefonoLocal'))
BEGIN
    CREATE INDEX IX_TelefonoLocal_idLocal ON dbo.TelefonoLocal(idLocal);
    PRINT 'Índice IX_TelefonoLocal_idLocal creado.';
END
GO

-- Crear tabla Proveedor
IF OBJECT_ID('dbo.Proveedor', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Proveedor (
        idProveedor dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        Ruc dbo.TipoCodigo NOT NULL UNIQUE,
        RazonSocial dbo.TipoNombreLargo NOT NULL,
        NombreComercial dbo.TipoNombreLargo NULL,
        Email dbo.TipoEmail NULL UNIQUE,
        PersonaContacto dbo.TipoNombre NULL,
        FechaRegistro dbo.TipoFechaHora DEFAULT GETDATE(),
        Activo dbo.TipoFlag DEFAULT 1
    );
    PRINT 'Tabla Proveedor creada.';
END
GO

-- Crear tabla TelefonoProveedor
IF OBJECT_ID('dbo.TelefonoProveedor', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.TelefonoProveedor (
        idTelefonoProveedor dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        idProveedor dbo.TipoId NOT NULL,
        NumeroTelefono dbo.TipoTelefono NOT NULL,
        TipoTelefono dbo.TipoCodigo NULL,
        EsPrincipal dbo.TipoFlag DEFAULT 0,
        CONSTRAINT FK_TelefonoProveedor_Proveedor FOREIGN KEY (idProveedor) REFERENCES dbo.Proveedor(idProveedor)
            ON DELETE CASCADE ON UPDATE CASCADE
    );
    PRINT 'Tabla TelefonoProveedor creada.';
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_TelefonoProveedor_idProveedor' AND object_id = OBJECT_ID('dbo.TelefonoProveedor'))
BEGIN
    CREATE INDEX IX_TelefonoProveedor_idProveedor ON dbo.TelefonoProveedor(idProveedor);
    PRINT 'Índice IX_TelefonoProveedor_idProveedor creado.';
END
GO

-- Crear tabla DireccionProveedor
IF OBJECT_ID('dbo.DireccionProveedor', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.DireccionProveedor (
        idDireccionProveedor dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        idProveedor dbo.TipoId NOT NULL,
        DireccionTexto dbo.TipoTextoLargo NOT NULL,
        TipoDireccion dbo.TipoCodigo NULL,
        Referencia dbo.TipoDescripcion NULL,
        Ubigeo dbo.TipoCodigo NULL,
        EsPrincipal dbo.TipoFlag DEFAULT 0,
        CONSTRAINT FK_DireccionProveedor_Proveedor FOREIGN KEY (idProveedor) REFERENCES dbo.Proveedor(idProveedor)
            ON DELETE CASCADE ON UPDATE CASCADE
    );
    PRINT 'Tabla DireccionProveedor creada.';
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_DireccionProveedor_idProveedor' AND object_id = OBJECT_ID('dbo.DireccionProveedor'))
BEGIN
    CREATE INDEX IX_DireccionProveedor_idProveedor ON dbo.DireccionProveedor(idProveedor);
    PRINT 'Índice IX_DireccionProveedor_idProveedor creado.';
END
GO

-- Crear tabla Cliente
IF OBJECT_ID('dbo.Cliente', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Cliente (
        idCliente dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        TipoCliente dbo.TipoEstado NOT NULL CHECK (TipoCliente IN ('Mayorista', 'Minorista', 'Anonimo')),
        Ruc dbo.TipoCodigo NULL UNIQUE,
        Dni dbo.TipoCodigo NULL UNIQUE,
        NombreCompletoORazonSocial dbo.TipoNombreLargo NOT NULL,
        Email dbo.TipoEmail NULL UNIQUE,
        FechaRegistro dbo.TipoFechaHora DEFAULT GETDATE(),
        Activo dbo.TipoFlag DEFAULT 1
    );
    PRINT 'Tabla Cliente creada.';
    IF NOT EXISTS (SELECT 1 FROM dbo.Cliente WHERE TipoCliente = 'Anonimo')
    BEGIN
        INSERT INTO dbo.Cliente (TipoCliente, NombreCompletoORazonSocial, Activo)
        VALUES ('Anonimo', 'Cliente Varios', 1);
        PRINT 'Cliente Anónimo insertado.';
    END
END
GO

-- Crear tabla TelefonoCliente
IF OBJECT_ID('dbo.TelefonoCliente', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.TelefonoCliente (
        idTelefonoCliente dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        idCliente dbo.TipoId NOT NULL,
        NumeroTelefono dbo.TipoTelefono NOT NULL,
        TipoTelefono dbo.TipoCodigo NULL,
        EsPrincipal dbo.TipoFlag DEFAULT 0,
        CONSTRAINT FK_TelefonoCliente_Cliente FOREIGN KEY (idCliente) REFERENCES dbo.Cliente(idCliente)
            ON DELETE CASCADE ON UPDATE CASCADE
    );
    PRINT 'Tabla TelefonoCliente creada.';
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_TelefonoCliente_idCliente' AND object_id = OBJECT_ID('dbo.TelefonoCliente'))
BEGIN
    CREATE INDEX IX_TelefonoCliente_idCliente ON dbo.TelefonoCliente(idCliente);
    PRINT 'Índice IX_TelefonoCliente_idCliente creado.';
END
GO

-- Crear tabla DireccionCliente
IF OBJECT_ID('dbo.DireccionCliente', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.DireccionCliente (
        idDireccionCliente dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        idCliente dbo.TipoId NOT NULL,
        DireccionTexto dbo.TipoTextoLargo NOT NULL,
        TipoDireccion dbo.TipoCodigo NULL,
        Referencia dbo.TipoDescripcion NULL,
        Ubigeo dbo.TipoCodigo NULL,
        EsPrincipal dbo.TipoFlag DEFAULT 0,
        CONSTRAINT FK_DireccionCliente_Cliente FOREIGN KEY (idCliente) REFERENCES dbo.Cliente(idCliente)
            ON DELETE CASCADE ON UPDATE CASCADE
    );
    PRINT 'Tabla DireccionCliente creada.';
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_DireccionCliente_idCliente' AND object_id = OBJECT_ID('dbo.DireccionCliente'))
BEGIN
    CREATE INDEX IX_DireccionCliente_idCliente ON dbo.DireccionCliente(idCliente);
    PRINT 'Índice IX_DireccionCliente_idCliente creado.';
END
GO

-- Crear tabla Usuario
IF OBJECT_ID('dbo.Usuario', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Usuario (
        idUsuario dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        NombreUsuario dbo.TipoCodigo NOT NULL UNIQUE,
        HashContrasena NVARCHAR(255) NOT NULL, -- Se mantiene NVARCHAR por longitud variable de hashes
        NombreCompleto dbo.TipoDescripcion NOT NULL,
        idRol dbo.TipoId NOT NULL,
        idLocalPredeterminado dbo.TipoId NULL,
        Email dbo.TipoEmail NULL UNIQUE,
        Activo dbo.TipoFlag DEFAULT 1,
        CONSTRAINT FK_Usuario_Rol FOREIGN KEY (idRol) REFERENCES dbo.Rol(idRol) ON DELETE NO ACTION ON UPDATE CASCADE,
        CONSTRAINT FK_Usuario_Local FOREIGN KEY (idLocalPredeterminado) REFERENCES dbo.Local(idLocal) ON DELETE SET NULL ON UPDATE CASCADE
    );
    PRINT 'Tabla Usuario creada.';
END
GO

-- Crear tabla MarcaVehiculo
IF OBJECT_ID('dbo.MarcaVehiculo', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.MarcaVehiculo (
        idMarca dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        NombreMarca dbo.TipoCodigo NOT NULL UNIQUE
    );
    PRINT 'Tabla MarcaVehiculo creada.';
END
GO

-- Crear tabla ModeloVehiculo
IF OBJECT_ID('dbo.ModeloVehiculo', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ModeloVehiculo (
        idModelo dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        idMarca dbo.TipoId NOT NULL,
        NombreModelo dbo.TipoCodigo NOT NULL,
        CONSTRAINT FK_ModeloVehiculo_Marca FOREIGN KEY (idMarca) REFERENCES dbo.MarcaVehiculo(idMarca) ON DELETE NO ACTION ON UPDATE CASCADE,
        CONSTRAINT UQ_ModeloVehiculo_Marca_Nombre UNIQUE (idMarca, NombreModelo)
    );
    PRINT 'Tabla ModeloVehiculo creada.';
END
GO

-- Crear tabla Vehiculo
IF OBJECT_ID('dbo.Vehiculo', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Vehiculo (
        idVehiculo dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        Placa dbo.TipoCodigo NOT NULL UNIQUE,
        idModelo dbo.TipoId NULL,
        Anio dbo.TipoCantidad NULL,
        CapacidadCargaKg dbo.TipoMoneda NULL,
        idLocalBase dbo.TipoId NOT NULL,
        idConductorUsuario dbo.TipoId NULL,
        Estado dbo.TipoEstado DEFAULT 'Disponible' CHECK (Estado IN ('Disponible', 'En Mantenimiento', 'En Reparto')),
        Activo dbo.TipoFlag DEFAULT 1,
        CONSTRAINT FK_Vehiculo_Modelo FOREIGN KEY (idModelo) REFERENCES dbo.ModeloVehiculo(idModelo) ON DELETE SET NULL ON UPDATE CASCADE,
        CONSTRAINT FK_Vehiculo_LocalBase FOREIGN KEY (idLocalBase) REFERENCES dbo.Local(idLocal) ON DELETE NO ACTION ON UPDATE CASCADE,
        CONSTRAINT FK_Vehiculo_Conductor FOREIGN KEY (idConductorUsuario) REFERENCES dbo.Usuario(idUsuario) ON DELETE SET NULL ON UPDATE NO ACTION
    );
    PRINT 'Tabla Vehiculo creada.';
END
GO

-- Crear tabla Producto
IF OBJECT_ID('dbo.Producto', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Producto (
        idProducto dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        CodigoSKU dbo.TipoCodigo NOT NULL UNIQUE,
        CodigoBarras dbo.TipoCodigoLargo NULL UNIQUE,
        Nombre dbo.TipoNombreLargo NOT NULL,
        Descripcion dbo.TipoDescripcion NULL,
        idCategoria dbo.TipoId NULL,
        UnidadMedida dbo.TipoCodigo NOT NULL,
        PrecioCompraReferencial dbo.TipoMoneda DEFAULT 0.00,
        PrecioVentaMayorista dbo.TipoMoneda NOT NULL,
        PrecioVentaMinorista dbo.TipoMoneda NOT NULL,
        StockMinimoGlobal dbo.TipoCantidad DEFAULT 0,
        Perecedero dbo.TipoFlag DEFAULT 0,
        FechaCaducidadLote dbo.TipoFecha NULL,
        Activo dbo.TipoFlag DEFAULT 1,
        CONSTRAINT FK_Producto_Categoria FOREIGN KEY (idCategoria) REFERENCES dbo.CategoriaProducto(idCategoria) ON DELETE SET NULL ON UPDATE CASCADE
    );
    PRINT 'Tabla Producto creada.';
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Producto_Nombre' AND object_id = OBJECT_ID('dbo.Producto'))
BEGIN
    CREATE INDEX IX_Producto_Nombre ON dbo.Producto(Nombre);
    PRINT 'Índice IX_Producto_Nombre creado.';
END
GO

-- Crear tabla Inventario
IF OBJECT_ID('dbo.Inventario', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Inventario (
        idInventario dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        idProducto dbo.TipoId NOT NULL,
        idLocal dbo.TipoId NOT NULL,
        Cantidad dbo.TipoCantidad NOT NULL DEFAULT 0,
        StockMinimoLocal dbo.TipoCantidad DEFAULT 0,
        UbicacionEnLocal dbo.TipoCodigoLargo NULL,
        FechaUltimaActualizacion dbo.TipoFechaHora DEFAULT GETDATE(),
        CONSTRAINT FK_Inventario_Producto FOREIGN KEY (idProducto) REFERENCES dbo.Producto(idProducto) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_Inventario_Local FOREIGN KEY (idLocal) REFERENCES dbo.Local(idLocal) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT UQ_Inventario_Producto_Local UNIQUE (idProducto, idLocal)
    );
    PRINT 'Tabla Inventario creada.';
END
GO

-- Crear tabla Compra
IF OBJECT_ID('dbo.Compra', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Compra (
        idCompra dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        idProveedor dbo.TipoId NOT NULL,
        idUsuarioRegistro dbo.TipoId NOT NULL,
        idLocalDestino dbo.TipoId NOT NULL,
        FechaCompra dbo.TipoFecha NOT NULL,
        FechaRecepcion dbo.TipoFecha NULL,
        TipoComprobante dbo.TipoCodigo NULL,
        NumeroComprobante dbo.TipoCodigo NULL,
        MontoTotal dbo.TipoMonedaTotal DEFAULT 0.00,
        Estado dbo.TipoEstado NOT NULL DEFAULT 'Pedido' CHECK (Estado IN ('Pedido', 'Recibido Parcial', 'Recibido Completo', 'Cancelado')),
        Observaciones dbo.TipoDescripcion NULL,
        CONSTRAINT FK_Compra_Proveedor FOREIGN KEY (idProveedor) REFERENCES dbo.Proveedor(idProveedor) ON DELETE NO ACTION ON UPDATE CASCADE,
        CONSTRAINT FK_Compra_Usuario FOREIGN KEY (idUsuarioRegistro) REFERENCES dbo.Usuario(idUsuario) ON DELETE NO ACTION ON UPDATE CASCADE,
        CONSTRAINT FK_Compra_Local FOREIGN KEY (idLocalDestino) REFERENCES dbo.Local(idLocal) ON DELETE NO ACTION ON UPDATE NO ACTION
    );
    PRINT 'Tabla Compra creada.';
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Compra_Fecha' AND object_id = OBJECT_ID('dbo.Compra'))
BEGIN
    CREATE INDEX IX_Compra_Fecha ON dbo.Compra(FechaCompra);
    PRINT 'Índice IX_Compra_Fecha creado.';
END
GO

-- Crear tabla DetalleCompra
IF OBJECT_ID('dbo.DetalleCompra', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.DetalleCompra (
        idDetalleCompra dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        idCompra dbo.TipoId NOT NULL,
        idProducto dbo.TipoId NOT NULL,
        Cantidad dbo.TipoCantidad NOT NULL CHECK (Cantidad > 0),
        PrecioUnitarioCompra dbo.TipoMoneda NOT NULL CHECK (PrecioUnitarioCompra >= 0),
        Subtotal AS (CONVERT(DECIMAL(12,2), Cantidad * PrecioUnitarioCompra)) PERSISTED, -- Se mantiene DECIMAL para cálculo preciso
        CONSTRAINT FK_DetalleCompra_Compra FOREIGN KEY (idCompra) REFERENCES dbo.Compra(idCompra) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_DetalleCompra_Producto FOREIGN KEY (idProducto) REFERENCES dbo.Producto(idProducto) ON DELETE NO ACTION ON UPDATE CASCADE
    );
    PRINT 'Tabla DetalleCompra creada.';
END
GO

-- Crear tabla Venta
IF OBJECT_ID('dbo.Venta', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Venta (
        idVenta dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        idCliente dbo.TipoId NOT NULL,
        idUsuarioVendedor dbo.TipoId NOT NULL,
        idLocal dbo.TipoId NOT NULL,
        FechaVenta dbo.TipoFechaHora DEFAULT GETDATE(),
        TipoComprobante dbo.TipoEstado NOT NULL CHECK (TipoComprobante IN ('Factura', 'Boleta', 'NotaVenta', 'Ticket')),
        SerieComprobante dbo.TipoCodigo NULL,
        NumeroComprobante dbo.TipoCantidad NOT NULL,
        MontoTotal dbo.TipoMonedaTotal DEFAULT 0.00,
        EstadoVenta dbo.TipoEstado NOT NULL DEFAULT 'Completada' CHECK (EstadoVenta IN ('Completada', 'Pendiente Envio', 'En Reparto', 'Entregada', 'Cancelada')),
        RequiereEnvio dbo.TipoFlag DEFAULT 0,
        idVehiculoAsignado dbo.TipoId NULL,
        DireccionEnvio dbo.TipoNombreLargo NULL,
        Observaciones dbo.TipoDescripcion NULL,
        CONSTRAINT FK_Venta_Cliente FOREIGN KEY (idCliente) REFERENCES dbo.Cliente(idCliente) ON DELETE NO ACTION ON UPDATE CASCADE,
        CONSTRAINT FK_Venta_Usuario FOREIGN KEY (idUsuarioVendedor) REFERENCES dbo.Usuario(idUsuario) ON DELETE NO ACTION ON UPDATE CASCADE,
        CONSTRAINT FK_Venta_Local FOREIGN KEY (idLocal) REFERENCES dbo.Local(idLocal) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT FK_Venta_Vehiculo FOREIGN KEY (idVehiculoAsignado) REFERENCES dbo.Vehiculo(idVehiculo) ON DELETE SET NULL ON UPDATE NO ACTION,
        CONSTRAINT UQ_Venta_Comprobante UNIQUE (TipoComprobante, SerieComprobante, NumeroComprobante)
    );
    PRINT 'Tabla Venta creada.';
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Venta_Fecha' AND object_id = OBJECT_ID('dbo.Venta'))
BEGIN
    CREATE INDEX IX_Venta_Fecha ON dbo.Venta(FechaVenta);
    PRINT 'Índice IX_Venta_Fecha creado.';
END
GO

-- Crear tabla DetalleVenta
IF OBJECT_ID('dbo.DetalleVenta', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.DetalleVenta (
        idDetalleVenta dbo.TipoId IDENTITY(1,1) PRIMARY KEY,
        idVenta dbo.TipoId NOT NULL,
        idProducto dbo.TipoId NOT NULL,
        Cantidad dbo.TipoCantidad NOT NULL CHECK (Cantidad > 0),
        PrecioUnitarioVenta dbo.TipoMoneda NOT NULL CHECK (PrecioUnitarioVenta >= 0),
        DescuentoUnitario dbo.TipoMoneda DEFAULT 0.00 CHECK (DescuentoUnitario >= 0),
        CONSTRAINT CK_DescuentoVenta CHECK (DescuentoUnitario <= PrecioUnitarioVenta),
        Subtotal AS (CONVERT(DECIMAL(12,2), Cantidad * (PrecioUnitarioVenta - DescuentoUnitario))) PERSISTED, -- Se mantiene DECIMAL
        CONSTRAINT FK_DetalleVenta_Venta FOREIGN KEY (idVenta) REFERENCES dbo.Venta(idVenta) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_DetalleVenta_Producto FOREIGN KEY (idProducto) REFERENCES dbo.Producto(idProducto) ON DELETE NO ACTION ON UPDATE CASCADE
    );
    PRINT 'Tabla DetalleVenta creada.';
END
GO

-- Crear tabla MovimientoInventario
IF OBJECT_ID('dbo.MovimientoInventario', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.MovimientoInventario (
        idMovimiento dbo.TipoIdGrande IDENTITY(1,1) PRIMARY KEY,
        idProducto dbo.TipoId NOT NULL,
        idLocal dbo.TipoId NOT NULL,
        FechaHora dbo.TipoFechaHora DEFAULT GETDATE(),
        TipoMovimiento dbo.TipoEstado NOT NULL CHECK (TipoMovimiento IN ('Compra', 'Venta', 'Transferencia_Salida', 'Transferencia_Entrada', 'Ajuste_Positivo', 'Ajuste_Negativo', 'Devolucion_Cliente', 'Devolucion_Proveedor')),
        Cantidad dbo.TipoCantidad NOT NULL,
        idUsuarioResponsable dbo.TipoId NOT NULL,
        idReferencia dbo.TipoId NULL,
        MotivoReferencia dbo.TipoCodigo NULL,
        StockAnterior dbo.TipoCantidad NULL,
        StockNuevo dbo.TipoCantidad NOT NULL,
        Observaciones dbo.TipoDescripcion NULL,
        CONSTRAINT FK_MovimientoInv_Producto FOREIGN KEY (idProducto) REFERENCES dbo.Producto(idProducto) ON DELETE NO ACTION ON UPDATE CASCADE,
        CONSTRAINT FK_MovimientoInv_Local FOREIGN KEY (idLocal) REFERENCES dbo.Local(idLocal) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT FK_MovimientoInv_Usuario FOREIGN KEY (idUsuarioResponsable) REFERENCES dbo.Usuario(idUsuario) ON DELETE NO ACTION ON UPDATE CASCADE
    );
    PRINT 'Tabla MovimientoInventario creada.';
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_MovimientoInv_Prod_Local_Fecha' AND object_id = OBJECT_ID('dbo.MovimientoInventario'))
BEGIN
    CREATE INDEX IX_MovimientoInv_Prod_Local_Fecha ON dbo.MovimientoInventario(idProducto, idLocal, FechaHora);
    PRINT 'Índice IX_MovimientoInv_Prod_Local_Fecha creado.';
END
GO

