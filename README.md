**Especificación de Requerimientos de Software (SRS)**

**Sistema de Gestión de Almacén e Inventario - Transportes Banda**

**Versión:** 1.0
**Fecha:** 2 de Abril, 2025
**Preparado por:** Karen Banda, en representación de Transportes Banda y La Nave del Código

**Historial de Revisiones:**

| Versión | Fecha       | Autor(es)         | Descripción de Cambios       |
| :------ | :---------- | :---------------- | :--------------------------- |
| 1.0     | 2025-04-02  | Transportes Banda | Versión Inicial del documento |

---

**Índice:**

1. **Introducción**
   1.1. Propósito  
   1.2. Alcance del Producto  
   1.3. Definiciones, Acrónimos y Abreviaturas  
   1.4. Referencias  
   1.5. Vista General del Documento  

2. **Descripción General**
   2.1. Perspectiva del Producto  
   2.2. Funciones del Producto  
   2.3. Características de los Usuarios  
   2.4. Restricciones Generales  
   2.5. Suposiciones y Dependencias  

3. **Requerimientos Específicos**
   3.1. Requerimientos Funcionales  
      3.1.1. Gestión de Entidades Base (Locales, Proveedores, Clientes)  
      3.1.2. Gestión de Contactos (Teléfonos, Direcciones)  
      3.1.3. Gestión de Productos y Categorías  
      3.1.4. Gestión de Compras a Proveedores  
      3.1.5. Gestión de Inventario y Stock  
      3.1.6. Gestión de Ventas a Clientes  
      3.1.7. Gestión de Vehículos y Logística  
      3.1.8. Administración de Usuarios y Roles  
      3.1.9. Reportes  
   3.2. Requerimientos No Funcionales  
      3.2.1. Rendimiento  
      3.2.2. Usabilidad  
      3.2.3. Seguridad  
      3.2.4. Fiabilidad  
      3.2.5. Mantenibilidad  
   3.3. Requerimientos de Interfaz Externa  
      3.3.1. Interfaz de Usuario  
      3.3.2. Interfaces de Hardware  
      3.3.3. Interfaces de Software  

4. **Apéndices**

---

**1. Introducción**

**1.1. Propósito**
El propósito de este documento es describir de manera completa y detallada los requerimientos funcionales y no funcionales para el nuevo "Sistema de Gestión de Almacén e Inventario" (en adelante, SGAI) para Transportes Banda. Este sistema centralizará y automatizará los procesos clave relacionados con la compra de productos a proveedores, la gestión de inventario en nuestros diferentes locales, la venta de productos tanto al por mayor como al por menor, y la gestión de la información de clientes y proveedores en nuestra operación en Arequipa, Perú. El SGAI busca mejorar la eficiencia operativa, reducir errores manuales, proporcionar información actualizada del stock y facilitar la toma de decisiones.

**1.2. Alcance del Producto**
El SGAI será una aplicación interna, utilizada por el personal autorizado de Transportes Banda en sus distintos roles. El sistema cubrirá las siguientes funcionalidades principales:

*   **Gestión de Catálogos:** Administración de Productos, Categorías de Productos, Proveedores, Clientes, Locales (Almacén Central y Tiendas Minoristas), Vehículos (Marcas, Modelos).
*   **Gestión de Contactos:** Registro y mantenimiento de múltiples números de teléfono y direcciones para Clientes y Proveedores.
*   **Gestión de Compras:** Creación y seguimiento de órdenes de compra a proveedores, registro de detalles de productos comprados, actualización de estados de compra (Pedido, Recibido Parcial/Completo).
*   **Gestión de Inventario:** Seguimiento del stock de productos por local, visualización de cantidades, registro de ubicaciones, gestión de stock mínimo, ajustes manuales de inventario (mermas, ingresos), y registro histórico de todos los movimientos de inventario.
*   **Gestión de Ventas:** Registro de ventas a clientes mayoristas (con RUC) y minoristas (con DNI o anónimos), aplicación de precios diferenciados, generación de documentos de venta (Factura, Boleta, Nota de Venta, Ticket) con numeración correlativa, gestión de descuentos.
*   **Gestión de Envíos:** Marcado de ventas que requieren envío, asignación de vehículos y conductores (usuarios), registro de dirección de envío y seguimiento básico de estados (Pendiente, En Reparto, Entregada).
*   **Administración y Seguridad:** Gestión de usuarios del sistema, asignación de roles con permisos diferenciados, autenticación segura.
*   **Reportes Básicos:** Generación de reportes esenciales sobre ventas, compras, stock actual, movimientos de inventario y listados de entidades.

**Fuera del Alcance:**
*   Integración contable avanzada (solo registro transaccional).
*   Módulo de facturación electrónica directa con SUNAT (se asume generación de datos para otro sistema o proceso manual).
*   Gestión avanzada de Recursos Humanos (solo gestión de usuarios del SGAI).
*   Portal web para clientes o proveedores (aplicación interna).
*   Funcionalidades complejas de CRM o marketing.

**1.3. Definiciones, Acrónimos y Abreviaturas**
*   **SGAI:** Sistema de Gestión de Almacén e Inventario.
*   **TB:** Transportes Banda.
*   **RUC:** Registro Único de Contribuyentes (Identificador fiscal para empresas en Perú).
*   **DNI:** Documento Nacional de Identidad (Identificador para personas naturales en Perú).
*   **SKU:** Stock Keeping Unit (Código único interno para un producto).
*   **Almacén Central:** Principal punto de almacenamiento y despacho mayorista de TB.
*   **Tienda Minorista:** Local secundario de TB orientado a la venta directa al público.
*   **UDT:** User-Defined Type (Tipo de Dato Definido por el Usuario en la BD).
*   **FK:** Foreign Key (Clave Foránea en la BD).
*   **PK:** Primary Key (Clave Primaria en la BD).
*   **GUI:** Graphical User Interface (Interfaz Gráfica de Usuario).
*   **RBAC:** Role-Based Access Control (Control de Acceso Basado en Roles).
*   **SUNAT:** Superintendencia Nacional de Aduanas y de Administración Tributaria (Perú).

**1.4. Referencias**
*   Este documento (SRS - SGAI Transportes Banda v1.0).
*   Script de Creación de Base de Datos `AlmacenBD` (Versión con UDTs y Filegroups).

**1.5. Vista General del Documento**
Este documento se organiza de la siguiente manera: La Sección 1 introduce el sistema. La Sección 2 proporciona una descripción general del producto, sus funciones, usuarios y restricciones. La Sección 3 detalla los requerimientos funcionales y no funcionales específicos, así como las interfaces.

---

**2. Descripción General**

**2.1. Perspectiva del Producto**
El SGAI es un nuevo sistema de información desarrollado a medida para Transportes Banda. Reemplazará los posibles métodos actuales (manuales, hojas de cálculo, sistemas obsoletos) para la gestión de inventario y transacciones. Operará de forma independiente, utilizando su propia base de datos (SQL Server) alojada en un servidor de TB. No se prevén interfaces directas con otros sistemas de software externos en esta primera versión.

**2.2. Funciones del Producto**
Las principales funciones que el SGAI ofrecerá son:
*   Registro y mantenimiento centralizado de productos, categorías, proveedores, clientes y locales.
*   Gestión eficiente de múltiples datos de contacto (teléfonos, direcciones).
*   Proceso estructurado para registrar compras a proveedores y sus detalles.
*   Control preciso del inventario en tiempo real por cada local.
*   Registro histórico detallado de todos los movimientos de stock.
*   Proceso ágil para registrar ventas mayoristas y minoristas, aplicando precios correctos.
*   Gestión básica de la logística de envíos.
*   Administración de usuarios y seguridad basada en roles definidos.
*   Generación de reportes operativos clave.

**2.3. Características de los Usuarios**
El sistema será utilizado por diferentes empleados de Transportes Banda, cada uno con un rol específico:

| Rol             | Descripción de Usuario                                       | Nivel Técnico Esperado | Funciones Principales en SGAI                                                                         |
| :-------------- | :----------------------------------------------------------- | :------------------- | :---------------------------------------------------------------------------------------------------- |
| Administrador   | Gerente de operaciones, administrador de TI.                  | Medio/Alto           | Configuración inicial, gestión de usuarios/roles, supervisión general, reportes avanzados.             |
| Almacenero      | Personal encargado del almacén central.                      | Básico/Medio         | Registrar compras, recepcionar mercancía, gestionar inventario físico, realizar ajustes, ver stock. |
| Vendedor        | Personal de ventas (mayorista o tienda).                     | Básico               | Registrar ventas, buscar clientes/productos, consultar precios/stock.                                  |
| Cajero          | Personal de caja en tiendas minoristas.                      | Básico               | Registrar ventas rápidas (tipo ticket/boleta), manejar cliente anónimo.                               |
| Repartidor      | Personal encargado de las entregas.                          | Básico               | Consultar ventas asignadas para envío, actualizar estado de entrega (posiblemente desde móvil/tablet). |


**2.4. Restricciones Generales**
*   **Tecnología:** El sistema deberá desarrollarse utilizando tecnologías compatibles con un backend sobre SQL Server. La interfaz de usuario será una aplicación de escritorio Windows o una aplicación web interna.
*   **Base de Datos:** Se utilizará obligatoriamente la estructura de base de datos definida en el script `AlmacenBD` (versión con UDTs y Filegroups).
*   **Idioma:** La interfaz de usuario y toda la documentación estarán en Español (Perú).
*   **Seguridad:** La autenticación será mediante usuario y contraseña. Las contraseñas se almacenarán de forma segura (hashed). El acceso a funcionalidades estará restringido por roles.
*   **Regulatorio:** El sistema debe permitir registrar información necesaria para la documentación fiscal peruana (RUC, DNI, tipos de comprobante), aunque no realizará la facturación electrónica directa.
*   **Hardware:** Deberá funcionar en los equipos de cómputo estándar disponibles en TB (especificaciones mínimas se detallarán en RINT-HW).

**2.5. Suposiciones y Dependencias**
*   Se asume que TB proporcionará el hardware necesario (servidor, estaciones de trabajo, red).
*   Se asume que existirá una conexión de red estable entre las estaciones de trabajo y el servidor de base de datos.
*   Se asume que la información inicial (productos, clientes, proveedores, stock inicial) será migrada o cargada al sistema como parte de la implementación.
*   Se asume que los usuarios recibirán la capacitación adecuada antes de usar el sistema productivamente.
*   El correcto funcionamiento del sistema depende de la integridad y disponibilidad de la base de datos `AlmacenBD` en SQL Server.

---

**3. Requerimientos Específicos**

**3.1. Requerimientos Funcionales**

**3.1.1. Gestión de Entidades Base (Locales, Proveedores, Clientes)**
*   **RF-ENT-001:** El sistema permitirá crear, editar, listar y buscar `Local`es. Se deberá poder marcar un local como Activo/Inactivo. Los campos requeridos son Nombre, Dirección (principal), Tipo (Almacén/TiendaMinorista).
*   **RF-ENT-002:** El sistema permitirá crear, editar, listar y buscar `Proveedor`es. Los campos requeridos son RUC y Razón Social. Se podrán registrar Nombre Comercial, Email, Persona de Contacto y marcar como Activo/Inactivo.
*   **RF-ENT-003:** El sistema permitirá crear, editar, listar y buscar `Cliente`s. Se deberá seleccionar el `TipoCliente` (Mayorista, Minorista, Anónimo).
    *   Si es Mayorista, el RUC será obligatorio.
    *   Si es Minorista, se podrá registrar DNI (opcional).
    *   NombreCompletoORazonSocial es obligatorio.
    *   Se podrá registrar Email y marcar como Activo/Inactivo.
*   **RF-ENT-004:** El sistema deberá tener pre-registrado un cliente `TipoCliente`='Anónimo' con nombre "Cliente Varios" (ID=1) para ser usado en ventas sin identificación.

**3.1.2. Gestión de Contactos (Teléfonos, Direcciones)**
*   **RF-CON-001:** Para cada `Local`, el sistema permitirá registrar múltiples números de teléfono (`TelefonoLocal`), especificando el número y opcionalmente un `TipoTelefono` (Fijo, Móvil, etc.) y si es el `EsPrincipal`.
*   **RF-CON-002:** Para cada `Proveedor`, el sistema permitirá registrar múltiples números de teléfono (`TelefonoProveedor`), especificando el número y opcionalmente un `TipoTelefono` y si es el `EsPrincipal`.
*   **RF-CON-003:** Para cada `Proveedor`, el sistema permitirá registrar múltiples direcciones (`DireccionProveedor`), especificando `DireccionTexto`, y opcionalmente `TipoDireccion` (Fiscal, Almacén, etc.), `Referencia`, `Ubigeo`, y si es la `EsPrincipal`.
*   **RF-CON-004:** Para cada `Cliente` (excepto el Anónimo), el sistema permitirá registrar múltiples números de teléfono (`TelefonoCliente`), especificando número, `TipoTelefono` opcional y si es `EsPrincipal`.
*   **RF-CON-05:** Para cada `Cliente` (excepto el Anónimo), el sistema permitirá registrar múltiples direcciones (`DireccionCliente`), especificando `DireccionTexto`, y opcionalmente `TipoDireccion`, `Referencia`, `Ubigeo` y si es `EsPrincipal`.

**3.1.3. Gestión de Productos y Categorías**
*   **RF-PRO-001:** El sistema permitirá crear, editar, listar y buscar `CategoriaProducto`. Campos: Nombre (único), Descripción.
*   **RF-PRO-002:** El sistema permitirá crear, editar, listar, buscar y marcar como Activo/Inactivo `Producto`s.
*   **RF-PRO-003:** Al crear/editar un `Producto`, se registrarán: `CodigoSKU` (único), `Nombre`, `Descripcion`, `UnidadMedida`, `PrecioVentaMayorista`, `PrecioVentaMinorista`, `StockMinimoGlobal`, `Perecedero` (Sí/No). Opcionalmente se registrará `CodigoBarras` (único si se ingresa), `idCategoria`, `PrecioCompraReferencial`, `FechaCaducidadLote` (informativa).
*   **RF-PRO-004:** El sistema debe permitir asociar un `Producto` a una `CategoriaProducto` existente.
*   **RF-PRO-005:** El sistema debe validar la unicidad de `CodigoSKU` y `CodigoBarras`.

**3.1.4. Gestión de Compras a Proveedores**
*   **RF-COM-001:** El sistema permitirá crear un nuevo registro de `Compra`, asociándolo a un `Proveedor`, `Usuario` (quien registra) y `Local` (destino). Se registrará `FechaCompra`.
*   **RF-COM-002:** El sistema permitirá añadir `DetalleCompra` a una compra existente, seleccionando un `Producto` e ingresando `Cantidad` y `PrecioUnitarioCompra`. El sistema calculará y mostrará el `Subtotal` por línea.
*   **RF-COM-003:** El sistema calculará y almacenará (o mostrará) el `MontoTotal` de la `Compra` basado en la suma de los subtotales de sus detalles.
*   **RF-COM-004:** El sistema permitirá editar compras mientras estén en estado 'Pedido'.
*   **RF-COM-005:** El sistema permitirá registrar `FechaRecepcion`, `TipoComprobante` y `NumeroComprobante` del proveedor.
*   **RF-COM-006:** El sistema permitirá cambiar el `Estado` de la `Compra` ('Pedido', 'Recibido Parcial', 'Recibido Completo', 'Cancelado').
*   **RF-COM-007:** Al marcar una compra como 'Recibido Completo' o 'Recibido Parcial', el sistema deberá (mediante lógica interna o sugerencia al usuario) generar los correspondientes ingresos en `Inventario` y los registros en `MovimientoInventario` con `TipoMovimiento`='Compra'.
*   **RF-COM-008:** El sistema permitirá listar y buscar `Compra`s por proveedor, fecha, estado, etc.

**3.1.5. Gestión de Inventario y Stock**
*   **RF-INV-001:** El sistema permitirá consultar el stock (`Cantidad`) actual de un `Producto` en un `Local` específico a través de la tabla `Inventario`.
*   **RF-INV-002:** El sistema permitirá visualizar la `UbicacionEnLocal` y el `StockMinimoLocal` si están definidos.
*   **RF-INV-003:** El sistema permitirá realizar Ajustes de Inventario manuales. El usuario seleccionará `Producto`, `Local`, indicará la `Cantidad` del ajuste (positiva para ingresos, negativa para salidas), y un motivo (`Observaciones`). Esto debe generar un registro en `MovimientoInventario` con `TipoMovimiento` 'Ajuste_Positivo' o 'Ajuste_Negativo', actualizando también la tabla `Inventario`.
*   **RF-INV-004:** El sistema permitirá consultar el historial de `MovimientoInventario` de un producto en un local, mostrando fecha, tipo de movimiento, cantidad, usuario responsable, stock resultante y referencia (si aplica).
*   **RF-INV-005:** El sistema deberá generar alertas (visuales o en un reporte) para productos cuyo stock en `Inventario` esté por debajo del `StockMinimoLocal` o cuyo stock total (suma de locales) esté por debajo del `StockMinimoGlobal` definido en `Producto`.
*   **RF-INV-006:** El sistema reflejará automáticamente las actualizaciones de stock derivadas de Compras recibidas y Ventas completadas.

**3.1.6. Gestión de Ventas a Clientes**
*   **RF-VEN-001:** El sistema permitirá crear un nuevo registro de `Venta`, asociándolo a un `Cliente` (permitiendo buscar existentes o usar "Cliente Varios"), `Usuario` (vendedor logueado), y `Local` (desde donde se vende).
*   **RF-VEN-002:** El sistema permitirá seleccionar el `TipoComprobante` (Factura, Boleta, NotaVenta, Ticket).
*   **RF-VEN-003:** El sistema asignará automáticamente (o permitirá ingresar) `SerieComprobante` y generará el `NumeroComprobante` correlativo único para la combinación Tipo/Serie.
*   **RF-VEN-004:** El sistema permitirá añadir `DetalleVenta` a una venta, seleccionando un `Producto`. El sistema deberá sugerir el `PrecioUnitarioVenta` correspondiente (`PrecioVentaMayorista` o `PrecioVentaMinorista` según el `TipoCliente`), pero permitirá al usuario modificarlo (con permisos adecuados).
*   **RF-VEN-005:** El sistema permitirá ingresar un `DescuentoUnitario` por línea de detalle. El sistema calculará y mostrará el `Subtotal` por línea.
*   **RF-VEN-006:** El sistema calculará y almacenará (o mostrará) el `MontoTotal` de la `Venta`.
*   **RF-VEN-007:** Si la venta `RequiereEnvio` (marcado por el usuario):
    *   Se podrá asignar un `Vehiculo` disponible.
    *   Se podrá ingresar una `DireccionEnvio` específica (o tomar una principal del cliente).
    *   Se podrá actualizar el `EstadoVenta` ('Pendiente Envio', 'En Reparto', 'Entregada').
*   **RF-VEN-008:** Al marcar una venta como 'Completada' (o 'Entregada' si requiere envío), el sistema deberá (mediante lógica interna o sugerencia al usuario) generar las correspondientes salidas en `Inventario` y los registros en `MovimientoInventario` con `TipoMovimiento`='Venta'.
*   **RF-VEN-009:** El sistema permitirá listar y buscar `Venta`s por cliente, fecha, vendedor, estado, etc.

**3.1.7. Gestión de Vehículos y Logística**
*   **RF-VEH-001:** El sistema permitirá crear, editar y listar `MarcaVehiculo`.
*   **RF-VEH-002:** El sistema permitirá crear, editar y listar `ModeloVehiculo`, asociándolo a una `MarcaVehiculo`.
*   **RF-VEH-003:** El sistema permitirá crear, editar, listar, buscar y marcar como Activo/Inactivo `Vehiculo`s. Se registrará `Placa` (única), `idModelo`, `Año`, `CapacidadCargaKg`, `idLocalBase` (obligatorio).
*   **RF-VEH-004:** Se podrá asignar un `Usuario` como conductor (`idConductorUsuario`) a un vehículo.
*   **RF-VEH-005:** Se podrá actualizar el `Estado` del vehículo ('Disponible', 'En Mantenimiento', 'En Reparto').

**3.1.8. Administración de Usuarios y Roles**
*   **RF-ADM-001:** El sistema requerirá autenticación mediante `NombreUsuario` y contraseña para todos los accesos.
*   **RF-ADM-002:** El sistema validará las contraseñas contra el `HashContrasena` almacenado en la tabla `Usuario`.
*   **RF-ADM-003:** (Admin) El sistema permitirá crear, editar, listar y marcar como Activo/Inactivo `Usuario`s. Al crear/editar, se debe poder asignar un `Rol` y opcionalmente un `idLocalPredeterminado`. Se gestionará la contraseña (generación inicial/reseteo).
*   **RF-ADM-004:** (Admin) El sistema permitirá crear y editar `Rol`es, definiendo su `NombreRol` y `Descripcion`. (La asignación detallada de permisos por rol se define implícitamente por cómo el código de la aplicación usa el `idRol` del usuario logueado para habilitar/deshabilitar funciones).
*   **RF-ADM-005:** El sistema restringirá el acceso a las diferentes funciones y módulos basado en el `Rol` del usuario autenticado.

**3.1.9. Reportes**
*   **RF-REP-001:** Reporte de Ventas: Filtrable por rango de fechas, Cliente, Vendedor, Local. Debe mostrar como mínimo: Fecha, Tipo/Serie/Número Comprobante, Cliente, Vendedor, Local, Monto Total. Opcional: Ver detalle de productos.
*   **RF-REP-002:** Reporte de Compras: Filtrable por rango de fechas, Proveedor, Local Destino, Estado. Mostrar: Fecha Compra, Proveedor, Tipo/Número Comprobante Proveedor, Estado, Monto Total. Opcional: Ver detalle.
*   **RF-REP-003:** Reporte de Stock Actual: Mostrar `Producto` (Nombre, SKU), `Local`, `Cantidad` actual en `Inventario`. Filtrable por Local, Categoría, Producto.
*   **RF-REP-004:** Reporte de Movimientos de Inventario: Historial detallado filtrable por Producto, Local, rango de fechas, Tipo de Movimiento. Mostrar columnas de `MovimientoInventario`.
*   **RF-REP-005:** Listado de Clientes: Con opción de ver teléfonos y direcciones principales. Filtrable por TipoCliente.
*   **RF-REP-006:** Listado de Proveedores: Con opción de ver teléfonos y direcciones principales.
*   **RF-REP-007:** Reporte de Productos Bajo Stock: Listar productos donde `Inventario.Cantidad` <= `Inventario.StockMinimoLocal` o suma global <= `Producto.StockMinimoGlobal`.

**3.2. Requerimientos No Funcionales**

*   **RNF-PER-001:** Las operaciones transaccionales comunes (registro de venta/compra simple, consulta de stock) deben completarse en menos de 3 segundos bajo condiciones normales de carga.
*   **RNF-PER-002:** La generación de reportes básicos no debe exceder los 10-15 segundos para rangos de fechas razonables (ej. 1 mes).
*   **RNF-USA-001:** La interfaz de usuario debe ser intuitiva y fácil de aprender para usuarios con conocimientos básicos de informática.
*   **RNF-USA-002:** El sistema utilizará terminología clara y consistente en Español (Perú).
*   **RNF-USA-003:** El sistema debe proporcionar mensajes de error claros y útiles para el usuario.
*   **RNF-SEG-001:** Las contraseñas de usuario deben almacenarse hasheadas utilizando un algoritmo moderno y seguro (ej. bcrypt, Argon2).
*   **RNF-SEG-002:** El acceso a las funciones del sistema estará estrictamente controlado por el rol asignado al usuario (RBAC).
*   **RNF-FIA-001:** El sistema debe ser estable y minimizar cierres inesperados.
*   **RNF-FIA-002:** El sistema debe garantizar la consistencia de los datos mediante el uso adecuado de transacciones y las restricciones de la base de datos.
*   **RNF-MAN-001:** (Para el equipo de desarrollo) El código fuente debe seguir buenas prácticas de programación para facilitar futuras modificaciones y correcciones.

**3.3. Requerimientos de Interfaz Externa**

*   **RINT-USR-001:** El sistema presentará una Interfaz Gráfica de Usuario (GUI). Será una aplicación de escritorio Windows o una aplicación web interna accesible mediante navegador estándar.
*   **RINT-USR-002:** La interfaz debe ser organizada, con menús claros y formularios bien estructurados para la entrada de datos.
*   **RINT-HW-001:** Estación de Trabajo Cliente Mínima: Procesador Core i3 o equivalente, 4 GB RAM, 1 GB espacio libre en disco, Resolución de pantalla 1366x768, Teclado, Mouse.
*   **RINT-HW-002:** Servidor de Base de Datos: Capacidad adecuada para SQL Server y el tamaño esperado de la base de datos (según configuración de filegroups), RAM suficiente para SQL Server (mínimo 8GB recomendado). Conexión de red estable.
*   **RINT-SW-001:** Estación de Trabajo Cliente: Sistema Operativo Windows 10 o superior. Si es web, navegador moderno (Chrome, Firefox, Edge).
*   **RINT-SW-002:** Servidor: Windows Server (versión compatible con SQL Server), SQL Server (versión a definir, ej. 2019 o superior).

---

**4. Apéndices** (Opcional)

*   Diagrama Entidad-Relación de la base de datos (si se desea adjuntar).
*   Diagramas de flujo de procesos clave (Compra, Venta, Ajuste).

---

Este documento establece las bases para el desarrollo del SGAI. Cualquier cambio o adición deberá seguir un proceso formal de gestión de cambios.
