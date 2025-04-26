-- Consultas
use AlmacenBD
/* Obtener todos los productos que pertenecen a las categor�as 'Aceites' o 'Filtros' 
y tienen un precio de venta mayorista mayor a 30 */
SELECT 
	p.Nombre, 
	p.PrecioVentaMayorista, 
	c.Nombre as Categoria
FROM 
	dbo.Producto p
INNER JOIN 
	dbo.CategoriaProducto c 
ON 
	p.idCategoria = c.idCategoria
WHERE 
	c.Nombre IN ('Aceites', 'Filtros')
	AND p.PrecioVentaMayorista > 30 
	AND p.Activo=1
	AND c.Activo=1;
GO

/* Buscar todos los clientes que son mayoristas o tienen RUC, 
ordenados por raz�n social */
SELECT 
	NombreCompletoORazonSocial, 
	TipoCliente, 
	Ruc
FROM 
	dbo.Cliente
WHERE 
	TipoCliente = 'Mayorista' OR Ruc IS NOT NULL
	AND	Activo=1
ORDER BY 
	NombreCompletoORazonSocial;
GO

/* Obtener inventario de productos con stock entre 10 y 50 unidades, 
incluyendo productos sin stock */
SELECT 
	p.Nombre, 
	i.Cantidad, 
	l.Nombre as Local
FROM 
	dbo.Producto p
LEFT JOIN 
	dbo.Inventario i 
ON 
	p.idProducto = i.idProducto
LEFT JOIN 
	dbo.Local l 
ON 
	i.idLocal = l.idLocal
WHERE 
	i.Cantidad BETWEEN 10 AND 50 
	AND	p.Activo=1 
	AND	l.Activo=1
ORDER BY 
	i.Cantidad DESC;
GO

/* Buscar todos los proveedores que empiezan con 'Auto' o terminan en 'S.A.' */
SELECT 
	RazonSocial, 
	NombreComercial
FROM 
	dbo.Proveedor
WHERE 
	RazonSocial LIKE 'Auto%' 
	OR RazonSocial LIKE '%S.A.' 
	AND Activo=1 ;
GO

/* Encontrar veh�culos sin conductor asignado y su modelo correspondiente */
SELECT 
	v.Placa, 
	mv.NombreModelo, 
	ma.NombreMarca
FROM 
	dbo.Vehiculo v
INNER JOIN 
	dbo.ModeloVehiculo mv 
ON 
	v.idModelo = mv.idModelo
INNER JOIN 
	dbo.MarcaVehiculo ma 
ON 
	mv.idMarca = ma.idMarca
WHERE 
	v.idConductorUsuario IS NULL
	AND v.Activo=1
	AND mv.Activo=1
	AND ma.Activo=1;
GO

/* Obtener todos los usuarios con sus roles, incluso si no tienen rol asignado */
SELECT 
	u.NombreUsuario, 
	u.NombreCompleto, 
	r.NombreRol
FROM 
	dbo.Usuario u
LEFT JOIN 
	dbo.Rol r 
ON 
	u.idRol = r.idRol
WHERE 
	u.Activo = 1
ORDER BY 
	r.NombreRol, u.NombreUsuario;
GO

/* Listar todos los locales con sus tel�fonos, incluso si no tienen tel�fonos registrados */
SELECT 
	l.Nombre as Local, 
	tl.NumeroTelefono, 
	tl.TipoTelefono
FROM 
	dbo.Local l
LEFT JOIN 
	dbo.TelefonoLocal tl 
ON 
	l.idLocal = tl.idLocal
WHERE 
	l.Activo = 1;
GO

/* Obtener todos los proveedores con sus direcciones y tel�fonos, 
incluso si les falta alg�n dato */
SELECT 
	p.RazonSocial, 
    dp.DireccionTexto,
    tp.NumeroTelefono
FROM 
	dbo.Proveedor p
LEFT JOIN 
	dbo.DireccionProveedor dp 
ON 
	p.idProveedor = dp.idProveedor
LEFT JOIN 
	dbo.TelefonoProveedor tp 
ON 
	p.idProveedor = tp.idProveedor
WHERE 
	p.Activo = 1
ORDER BY 
	p.RazonSocial;
GO

/* Encontrar productos cuyo precio de venta minorista es diferente del 
precio mayorista m�s un 30% */
SELECT 
	Nombre, 
	PrecioVentaMayorista, 
	PrecioVentaMinorista
FROM 
	dbo.Producto
WHERE 
	PrecioVentaMinorista <> (PrecioVentaMayorista * 1.30)
	AND Activo=1
ORDER BY 
	Nombre;
GO
