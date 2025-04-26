-- Vistas para Inventario
-----------------------
use AlmacenBD
/* Vista para ver el stock actual con información detallada de productos */
CREATE OR ALTER VIEW dbo.vw_StockActual
AS
SELECT 
    p.idProducto,
    p.CodigoSKU,
    p.Nombre AS NombreProducto,
    cp.Nombre AS Categoria,
    l.Nombre AS Local,
    i.Cantidad AS StockActual,
    i.StockMinimoLocal,
    p.StockMinimoGlobal,
    i.UbicacionEnLocal,
    p.PrecioVentaMayorista,
    p.PrecioVentaMinorista
FROM dbo.Producto p
INNER JOIN dbo.Inventario i ON p.idProducto = i.idProducto
INNER JOIN dbo.Local l ON i.idLocal = l.idLocal
LEFT JOIN dbo.CategoriaProducto cp ON p.idCategoria = cp.idCategoria
WHERE 
	p.Activo = 1
	AND l.Activo=1;
GO

-- Vistas para Clientes
---------------------

/* Vista para información completa de clientes */
CREATE OR ALTER VIEW dbo.vw_ClientesCompleto
AS
SELECT 
    c.idCliente,
    c.NombreCompletoORazonSocial,
    c.TipoCliente,
    c.Ruc,
    c.Dni,
    c.Email,
    dc.DireccionTexto AS DireccionPrincipal,
    tc.NumeroTelefono AS TelefonoPrincipal,
    COUNT(v.idVenta) AS TotalCompras,
    SUM(v.MontoTotal) AS MontoTotalCompras,
    MAX(v.FechaVenta) AS UltimaCompra
FROM dbo.Cliente c
LEFT JOIN dbo.DireccionCliente dc ON c.idCliente = dc.idCliente AND dc.EsPrincipal = 1
LEFT JOIN dbo.TelefonoCliente tc ON c.idCliente = tc.idCliente AND tc.EsPrincipal = 1
LEFT JOIN dbo.Venta v ON c.idCliente = v.idCliente
WHERE 
	c.Activo = 1 
	AND c.TipoCliente != 'Anonimo'
	AND dc.Activo=1 AND tc.Activo=1
GROUP BY c.idCliente, c.NombreCompletoORazonSocial, c.TipoCliente, 
         c.Ruc, c.Dni, c.Email, dc.DireccionTexto, tc.NumeroTelefono;
GO
-- Vistas para Logística
----------------------
/* Vista para seguimiento de vehículos y entregas */
CREATE OR ALTER VIEW dbo.vw_VehiculosEstado
AS
SELECT 
    v.Placa,
    mv.NombreMarca + ' ' + mdv.NombreModelo AS Vehiculo,
    v.CapacidadCargaKg,
    v.Estado,
    l.Nombre AS LocalBase,
    u.NombreCompleto AS Conductor,
    COUNT(vt.idVenta) AS EntregasPendientes
FROM dbo.Vehiculo v
INNER JOIN dbo.ModeloVehiculo mdv ON v.idModelo = mdv.idModelo
INNER JOIN dbo.MarcaVehiculo mv ON mdv.idMarca = mv.idMarca
INNER JOIN dbo.Local l ON v.idLocalBase = l.idLocal
LEFT JOIN dbo.Usuario u ON v.idConductorUsuario = u.idUsuario
LEFT JOIN dbo.Venta vt ON v.idVehiculo = vt.idVehiculoAsignado 
    AND vt.EstadoVenta = 'En Reparto'
WHERE v.Activo = 1
GROUP BY v.Placa, mv.NombreMarca, mdv.NombreModelo, v.CapacidadCargaKg, 
         v.Estado, l.Nombre, u.NombreCompleto;
GO

/* Vista para movimientos de inventario */
CREATE OR ALTER VIEW dbo.vw_MovimientosInventario
AS
SELECT 
    mi.FechaHora,
    l.Nombre AS Local,
    p.CodigoSKU,
    p.Nombre AS Producto,
    mi.TipoMovimiento,
    mi.Cantidad,
    mi.StockAnterior,
    mi.StockNuevo,
    u.NombreUsuario AS UsuarioResponsable,
    mi.Observaciones
FROM dbo.MovimientoInventario mi
INNER JOIN dbo.Producto p ON mi.idProducto = p.idProducto
INNER JOIN dbo.Local l ON mi.idLocal = l.idLocal
INNER JOIN dbo.Usuario u ON mi.idUsuarioResponsable = u.idUsuario;
GO

-- Listar todas las vistas
SELECT 
    name AS NombreVista,
    create_date AS FechaCreacion,
    modify_date AS FechaModificacion
FROM sys.views
WHERE schema_id = SCHEMA_ID('dbo')
ORDER BY name;

-- Ver el stock actual con detalles de productos
SELECT * FROM dbo.vw_StockActual;

-- Ver información completa de clientes
SELECT * FROM dbo.vw_ClientesCompleto;

-- Ver estado actual de vehículos y entregas
SELECT * FROM dbo.vw_VehiculosEstado;

-- Ver registro de movimientos de inventario
SELECT * FROM dbo.vw_MovimientosInventario;