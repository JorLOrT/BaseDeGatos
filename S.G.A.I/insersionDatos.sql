-- Insersión de Datos
use AlmacenBD
-- Insertar Roles
INSERT INTO dbo.Rol (NombreRol, Descripcion) VALUES
('ADMIN', 'Administrador del sistema con acceso total'),
('VENDEDOR', 'Usuario con permisos de ventas'),
('ALMACENERO', 'Usuario con permisos de almacén'),
('CONDUCTOR', 'Usuario conductor de vehículos'),
('SUPERVISOR', 'Supervisor con permisos extendidos');
GO


-- Insertar Categorías de Productos
INSERT INTO dbo.CategoriaProducto (Nombre, Descripcion) VALUES
('Aceites', 'Aceites para motor y transmisión'),
('Filtros', 'Filtros de aire, aceite y combustible'),
('Frenos', 'Sistema de frenos y componentes'),
('Baterías', 'Baterías y sistemas eléctricos'),
('Suspensión', 'Componentes de suspensión'),
('Neumáticos', 'Neumáticos y relacionados');
GO

-- Insertar Locales
INSERT INTO dbo.Local (Nombre, Direccion, Tipo, Activo) VALUES
('Almacén Central', 'Av. Industrial 123', 'Almacen', 1),
('Tienda Los Olivos', 'Av. Antúnez de Mayolo 456', 'TiendaMinorista', 1),
('Tienda San Miguel', 'Av. La Marina 789', 'TiendaMinorista', 1);
GO

-- Insertar Teléfonos de Locales
INSERT INTO dbo.TelefonoLocal (idLocal, NumeroTelefono, TipoTelefono, EsPrincipal) VALUES
(1, '01-4567890', 'FIJO', 1),
(1, '987654321', 'MOVIL', 0),
(2, '01-4561234', 'FIJO', 1),
(3, '01-4569876', 'FIJO', 1);
GO

-- Insertar Usuarios (usando hash simple para demo - en producción usar hash seguro)
INSERT INTO dbo.Usuario (NombreUsuario, HashContrasena, NombreCompleto, idRol, idLocalPredeterminado, Email, Activo) VALUES
('admin', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'admin123'), 2), 'Administrador Sistema', 1, 1, 'admin@empresa.com', 1),
('vendedor1', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'vend123'), 2), 'Juan Pérez', 2, 2, 'juan@empresa.com', 1),
('almacenero1', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'alm123'), 2), 'Pedro López', 3, 1, 'pedro@empresa.com', 1),
('conductor1', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'cond123'), 2), 'Carlos García', 4, 1, 'carlos@empresa.com', 1);
GO

-- Insertar Marcas de Vehículos
INSERT INTO dbo.MarcaVehiculo (NombreMarca) VALUES
('Toyota'), ('Nissan'), ('Hyundai'), ('Mitsubishi');
GO

-- Insertar Modelos de Vehículos
INSERT INTO dbo.ModeloVehiculo (idMarca, NombreModelo) VALUES
(1, 'Hilux'), (1, 'Hiace'),
(2, 'NP300'), (2, 'Urvan'),
(3, 'H100'), (3, 'HD78'),
(4, 'Fuso'), (4, 'Canter');
GO

-- Insertar Vehículos
INSERT INTO dbo.Vehiculo (Placa, idModelo, Anio, CapacidadCargaKg, idLocalBase, idConductorUsuario, Estado) VALUES
('ABC123', 1, 2022, 1000.00, 1, 4, 'Disponible'),
('DEF456', 3, 2021, 2000.00, 1, NULL, 'Disponible'),
('GHI789', 7, 2023, 5000.00, 1, NULL, 'En Mantenimiento');
GO

-- Insertar Proveedores
INSERT INTO dbo.Proveedor (Ruc, RazonSocial, NombreComercial, Email, PersonaContacto, Activo) VALUES
('20123456789', 'Autopartes del Perú S.A.C.', 'AutoParts', 'ventas@autoparts.com', 'María Silva', 1),
('20987654321', 'Repuestos Generales E.I.R.L.', 'RepGen', 'ventas@repgen.com', 'José Torres', 1),
('20555555555', 'Importaciones del Sur S.A.', 'ImporSur', 'contacto@imporsur.com', 'Ana López', 1);
GO

-- Insertar Teléfonos de Proveedores
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

-- Insertar Clientes (además del Cliente Anónimo ya creado)
INSERT INTO dbo.Cliente (TipoCliente, Ruc, Dni, NombreCompletoORazonSocial, Email, Activo) VALUES
('Mayorista', '123456', 1, 'Talleres Unidos S.A.C.', 'compras@talleres.com', 1),
('Minorista', '654321', 2, 'Juan Pérez García', 'juan.perez@email.com', 1),
('Mayorista', '159753', 3, 'Mecánica Rápida E.I.R.L.', 'mecanica@rapidamail.com', 1);
GO

-- Insertar Productos
INSERT INTO dbo.Producto (CodigoSKU, CodigoBarras, Nombre, Descripcion, idCategoria, 
    UnidadMedida, PrecioCompraReferencial, PrecioVentaMayorista, PrecioVentaMinorista, 
    StockMinimoGlobal, Perecedero) VALUES
('ACE001', '7751234567890', 'Aceite Motor 10W-30 1L', 'Aceite sintético para motor', 1, 'UND', 25.00, 35.00, 45.00, 50, 1),
('FIL001', '7751234567891', 'Filtro de Aceite Toyota', 'Filtro original Toyota', 2, 'UND', 15.00, 25.00, 35.00, 30, 0),
('BAT001', '7751234567892', 'Batería 13 placas', 'Batería auto', 4, 'UND', 180.00, 250.00, 300.00, 10, 0);
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

-- Actualización y Eliminación de Datos

/* Se desea actualizar los precios de todos los productos incrementándolos en 10% 
debido a un aumento en los costos de importación */
UPDATE dbo.Producto
SET PrecioVentaMayorista = PrecioVentaMayorista * 1.10,
    PrecioVentaMinorista = PrecioVentaMinorista * 1.10;
GO

/* Se necesita actualizar el estado de los vehículos que no han tenido 
mantenimiento en los últimos 3 meses */
UPDATE dbo.Vehiculo
SET Estado = 'En Mantenimiento'
WHERE Placa IN ('ABC123', 'DEF456');
GO

/* Se requiere desactivar todos los usuarios que no han accedido 
al sistema en los últimos 90 días */
UPDATE dbo.Usuario
SET Activo = 0
WHERE NombreUsuario NOT IN ('admin');
GO

/* Se necesita eliminar todos los registros de teléfonos no principales 
de los locales que están inactivos */
DELETE FROM dbo.TelefonoLocal
WHERE EsPrincipal = 0 
AND idLocal IN (SELECT idLocal FROM dbo.Local WHERE Activo = 0);
GO

/* Se requiere actualizar la ubicación de los productos en el almacén central 
debido a una reorganización */
UPDATE dbo.Inventario
SET UbicacionEnLocal = 'RACK-NUEVO-' + UbicacionEnLocal
WHERE idLocal = 1;
GO

/* Se necesita eliminar los proveedores que no han tenido movimientos 
en el último año y están inactivos */
DELETE FROM dbo.Proveedor
WHERE Activo = 0 
AND idProveedor NOT IN (
    SELECT DISTINCT idProveedor 
    FROM dbo.Compra 
    WHERE DATEDIFF(MONTH, FechaCompra, GETDATE()) <= 12
);
GO

/* Se requiere actualizar el stock mínimo de todos los productos 
en el local principal aumentándolo en un 20% */
UPDATE dbo.Inventario
SET StockMinimoLocal = CEILING(StockMinimoLocal * 1.20)
WHERE idLocal = 1;
GO

/* Se necesita actualizar el correo electrónico de un cliente específico */
UPDATE dbo.Cliente
SET Email = 'nuevo.email@talleres.com'
WHERE NombreCompletoORazonSocial = 'Talleres Unidos S.A.C.';
GO