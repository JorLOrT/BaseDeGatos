-- Insersi�n de Datos
use AlmacenBD
-- Insertar Roles
INSERT INTO dbo.Rol (NombreRol, Descripcion) VALUES
('ADMIN', 'Administrador del sistema con acceso total'),
('VENDEDOR', 'Usuario con permisos de ventas'),
('ALMACENERO', 'Usuario con permisos de almac�n'),
('CONDUCTOR', 'Usuario conductor de veh�culos'),
('SUPERVISOR', 'Supervisor con permisos extendidos');
GO


-- Insertar Categor�as de Productos
INSERT INTO dbo.CategoriaProducto (Nombre, Descripcion) VALUES
('Aceites', 'Aceites para motor y transmisi�n'),
('Filtros', 'Filtros de aire, aceite y combustible'),
('Frenos', 'Sistema de frenos y componentes'),
('Bater�as', 'Bater�as y sistemas el�ctricos'),
('Suspensi�n', 'Componentes de suspensi�n'),
('Neum�ticos', 'Neum�ticos y relacionados');
GO

-- Insertar Locales
INSERT INTO dbo.Local (Nombre, Direccion, Tipo, Activo) VALUES
('Almac�n Central', 'Av. Industrial 123', 'Almacen', 1),
('Tienda Los Olivos', 'Av. Ant�nez de Mayolo 456', 'TiendaMinorista', 1),
('Tienda San Miguel', 'Av. La Marina 789', 'TiendaMinorista', 1);
GO

-- Insertar Tel�fonos de Locales
INSERT INTO dbo.TelefonoLocal (idLocal, NumeroTelefono, TipoTelefono, EsPrincipal) VALUES
(1, '01-4567890', 'FIJO', 1),
(1, '987654321', 'MOVIL', 0),
(2, '01-4561234', 'FIJO', 1),
(3, '01-4569876', 'FIJO', 1);
GO

-- Insertar Usuarios (usando hash simple para demo - en producci�n usar hash seguro)
INSERT INTO dbo.Usuario (NombreUsuario, HashContrasena, NombreCompleto, idRol, idLocalPredeterminado, Email, Activo) VALUES
('admin', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'admin123'), 2), 'Administrador Sistema', 1, 1, 'admin@empresa.com', 1),
('vendedor1', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'vend123'), 2), 'Juan P�rez', 2, 2, 'juan@empresa.com', 1),
('almacenero1', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'alm123'), 2), 'Pedro L�pez', 3, 1, 'pedro@empresa.com', 1),
('conductor1', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'cond123'), 2), 'Carlos Garc�a', 4, 1, 'carlos@empresa.com', 1);
GO

-- Insertar Marcas de Veh�culos
INSERT INTO dbo.MarcaVehiculo (NombreMarca) VALUES
('Toyota'), ('Nissan'), ('Hyundai'), ('Mitsubishi');
GO

-- Insertar Modelos de Veh�culos
INSERT INTO dbo.ModeloVehiculo (idMarca, NombreModelo) VALUES
(1, 'Hilux'), (1, 'Hiace'),
(2, 'NP300'), (2, 'Urvan'),
(3, 'H100'), (3, 'HD78'),
(4, 'Fuso'), (4, 'Canter');
GO

-- Insertar Veh�culos
INSERT INTO dbo.Vehiculo (Placa, idModelo, Anio, CapacidadCargaKg, idLocalBase, idConductorUsuario, Estado) VALUES
('ABC123', 1, 2022, 1000.00, 1, 4, 'Disponible'),
('DEF456', 3, 2021, 2000.00, 1, NULL, 'Disponible'),
('GHI789', 7, 2023, 5000.00, 1, NULL, 'En Mantenimiento');
GO

-- Insertar Proveedores
INSERT INTO dbo.Proveedor (Ruc, RazonSocial, NombreComercial, Email, PersonaContacto, Activo) VALUES
('20123456789', 'Autopartes del Per� S.A.C.', 'AutoParts', 'ventas@autoparts.com', 'Mar�a Silva', 1),
('20987654321', 'Repuestos Generales E.I.R.L.', 'RepGen', 'ventas@repgen.com', 'Jos� Torres', 1),
('20555555555', 'Importaciones del Sur S.A.', 'ImporSur', 'contacto@imporsur.com', 'Ana L�pez', 1);
GO

-- Insertar Tel�fonos de Proveedores
INSERT INTO dbo.TelefonoProveedor (idProveedor, NumeroTelefono, TipoTelefono, EsPrincipal) VALUES
(1, '01-4445555', 'FIJO', 1),
(1, '999888777', 'MOVIL', 0),
(2, '01-3334444', 'FIJO', 1),
(3, '01-2223333', 'FIJO', 1);
GO

-- Insertar Direcciones de Proveedores
INSERT INTO dbo.DireccionProveedor (idProveedor, DireccionTexto, TipoDireccion, Referencia, Ubigeo, EsPrincipal) VALUES
(1, 'Av. Industrial 567', 'FISCAL', 'Frente al banco', '150101', 1),
(2, 'Jr. Los Herrajes 789', 'FISCAL', 'Costado del mercado', '150102', 1),
(3, 'Av. Las Torres 123', 'FISCAL', 'Esquina con av. principal', '150103', 1);
GO

-- Insertar Clientes (adem�s del Cliente An�nimo ya creado)
INSERT INTO dbo.Cliente (TipoCliente, Ruc, Dni, NombreCompletoORazonSocial, Email, Activo) VALUES
('Mayorista', '123456', 1, 'Talleres Unidos S.A.C.', 'compras@talleres.com', 1),
('Minorista', '654321', 2, 'Juan P�rez Garc�a', 'juan.perez@email.com', 1),
('Mayorista', '159753', 3, 'Mec�nica R�pida E.I.R.L.', 'mecanica@rapidamail.com', 1);
GO

-- Insertar Productos
INSERT INTO dbo.Producto (CodigoSKU, CodigoBarras, Nombre, Descripcion, idCategoria, 
    UnidadMedida, PrecioCompraReferencial, PrecioVentaMayorista, PrecioVentaMinorista, 
    StockMinimoGlobal, Perecedero) VALUES
('ACE001', '7751234567890', 'Aceite Motor 10W-30 1L', 'Aceite sint�tico para motor', 1, 'UND', 25.00, 35.00, 45.00, 50, 1),
('FIL001', '7751234567891', 'Filtro de Aceite Toyota', 'Filtro original Toyota', 2, 'UND', 15.00, 25.00, 35.00, 30, 0),
('BAT001', '7751234567892', 'Bater�a 13 placas', 'Bater�a auto', 4, 'UND', 180.00, 250.00, 300.00, 10, 0);
GO

-- Insertar Inventario Inicial
INSERT INTO dbo.Inventario (idProducto, idLocal, Cantidad, StockMinimoLocal, UbicacionEnLocal) VALUES
(1, 1, 100, 30, 'RACK-A1'),
(2, 1, 50, 20, 'RACK-B2'),
(3, 1, 20, 5, 'RACK-C3'),
(1, 2, 30, 10, 'EST-01'),
(2, 2, 15, 5, 'EST-02'),
(3, 2, 5, 2, 'EST-03');
GO

-- Insertar Movimientos de Inventario Iniciales
INSERT INTO dbo.MovimientoInventario (idProducto, idLocal, TipoMovimiento, Cantidad, 
    idUsuarioResponsable, StockAnterior, StockNuevo, Observaciones) VALUES
(1, 1, 'Ajuste_Positivo', 100, 1, 0, 100, 'Inventario inicial'),
(2, 1, 'Ajuste_Positivo', 50, 1, 0, 50, 'Inventario inicial'),
(3, 1, 'Ajuste_Positivo', 20, 1, 0, 20, 'Inventario inicial');
GO

-- Actualizaci�n y Eliminaci�n de Datos

/* Se desea actualizar los precios de todos los productos increment�ndolos en 10% 
debido a un aumento en los costos de importaci�n */
UPDATE dbo.Producto
SET PrecioVentaMayorista = PrecioVentaMayorista * 1.10,
    PrecioVentaMinorista = PrecioVentaMinorista * 1.10;
GO

/* Se necesita actualizar el estado de los veh�culos que no han tenido 
mantenimiento en los �ltimos 3 meses */
UPDATE dbo.Vehiculo
SET Estado = 'En Mantenimiento'
WHERE Placa IN ('ABC123', 'DEF456');
GO

/* Se requiere desactivar todos los usuarios que no han accedido 
al sistema en los �ltimos 90 d�as */
UPDATE dbo.Usuario
SET Activo = 0
WHERE NombreUsuario NOT IN ('admin');
GO

/* Se necesita eliminar todos los registros de tel�fonos no principales 
de los locales que est�n inactivos */
DELETE FROM dbo.TelefonoLocal
WHERE EsPrincipal = 0 
AND idLocal IN (SELECT idLocal FROM dbo.Local WHERE Activo = 0);
GO

/* Se requiere actualizar la ubicaci�n de los productos en el almac�n central 
debido a una reorganizaci�n */
UPDATE dbo.Inventario
SET UbicacionEnLocal = 'RACK-NUEVO-' + UbicacionEnLocal
WHERE idLocal = 1;
GO

/* Se necesita eliminar los proveedores que no han tenido movimientos 
en el �ltimo a�o y est�n inactivos */
DELETE FROM dbo.Proveedor
WHERE Activo = 0 
AND idProveedor NOT IN (
    SELECT DISTINCT idProveedor 
    FROM dbo.Compra 
    WHERE DATEDIFF(MONTH, FechaCompra, GETDATE()) <= 12
);
GO

/* Se requiere actualizar el stock m�nimo de todos los productos 
en el local principal aument�ndolo en un 20% */
UPDATE dbo.Inventario
SET StockMinimoLocal = CEILING(StockMinimoLocal * 1.20)
WHERE idLocal = 1;
GO

/* Se necesita actualizar el correo electr�nico de un cliente espec�fico */
UPDATE dbo.Cliente
SET Email = 'nuevo.email@talleres.com'
WHERE NombreCompletoORazonSocial = 'Talleres Unidos S.A.C.';
GO