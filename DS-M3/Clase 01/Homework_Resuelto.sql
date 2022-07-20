CREATE DATABASE Empresa;

USE Empresa;



CREATE TABLE `CanalVenta` (
`idCanal` int NOT NULL,
`Canal` varchar (20),
PRIMARY KEY (`idCanal`)
);

CREATE TABLE `Sucursal` (
`idSucursal` int NOT NULL,
`Sucursal` varchar (100),
`Direccion` varchar (150),
`Localidad` varchar (150),
`Provincia` varchar (150),
`Latitud` varchar(100),
`Longitud` varchar (100),
PRIMARY KEY (`idSucursal`)
);

CREATE TABLE `Productos` (
`idProducto` int NOT NULL,
`Nombre` varchar (100),
`Tipo` varchar (100),
`Precio` decimal(10, 2),
PRIMARY KEY (`idProducto`)
);

CREATE TABLE `Clientes` (
`idCliente` int NOT NULL, 
`Provincia` varchar (20) DEFAULT NULL,
`NombreCompleto` varchar (50),
`Domicilio` varchar (150),
`telefono` varchar (20),
`Edad` int,
`Localidad` varchar (100),
`Latitud` varchar (20),
`Longitud` varchar (20),
PRIMARY KEY (`idCliente`)
);

CREATE TABLE `Empleados` (
`idEmpleado` int NOT NULL,
`Apellido` varchar (20),
`Nombre` varchar (20),
`idSucursal` int DEFAULT NULL,
`Sector` varchar (25),
`Cargo` varchar (25),
`Salario` decimal(20,2),
PRIMARY KEY (`idEmpleado`),
FOREIGN KEY (`idSucursal`) REFERENCES `Sucursal` (`idSucursal`)
);

CREATE TABLE `Ventas` (
`idVenta` int NOT NULL,
`Fecha` date NOT NULL,
`Fecha_Entrega` date NOT NULL,
`idCanal` int DEFAULT NULL,
`idCliente` int DEFAULT NULL,
`idSucursal` int default null,
`idEmpleado` int DEFAULT NULL,
`idProducto` int DEFAULT NULL,
`Precio` decimal(20,2),
`Cantidad` int,
PRIMARY KEY (`idVenta`),
CONSTRAINT `venta_canal` FOREIGN KEY (`idCanal`) REFERENCES `canalventa` (`idCanal`) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT `venta_cliente` FOREIGN KEY (`idCliente`) REFERENCES `Clientes` (`idCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT `venta_sucursal` FOREIGN KEY (`idSucursal`) REFERENCES `Sucursal` (`idSucursal`) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT `venta_empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `Empleados` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT `venta_producto` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`)ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE `TipoGasto` (
`idTipoGasto` int NOT NULL, 
`Descripcion` varchar (20),
`MontoAprox` decimal(20,2),
PRIMARY KEY (`idTipoGasto`)
);

CREATE TABLE `Gastos` (
`idGasto` int NOT NULL,
`idSucursal` int DEFAULT NULL,
`idTipoGasto` int DEFAULT NULL,
`Fecha` date DEFAULT NULL,
`Monto` decimal (20,2),
PRIMARY KEY (`idGasto`),
FOREIGN KEY (`idSucursal`) REFERENCES `Sucursal` (`idSucursal`),
FOREIGN KEY (`idTipoGasto`) REFERENCES  `TipoGasto` (`idTipoGasto`)
);

CREATE TABLE `Proveedores` (
`idProveedores` INT NOT NULL,
`Nombre` varchar (20) DEFAULT NULL,
`Direccion` varchar (50),
`Ciudad` varchar (30),
`Provincia` varchar (30),
`Pais` varchar (15),
PRIMARY KEY (`idProveedores`)
);

CREATE TABLE `Compras` (
`idCompra` int not null, 
`Fecha` date DEFAULT NULL,
`idProducto` int DEFAULT NULL,
`Cantidad` int,
`Precio` decimal (20,2),
`idProveedores` int DEFAULT NULL,
PRIMARY KEY (`idCompra`),
FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`),
FOREIGN KEY (`idProveedores`) references `Proveedores` ( `idProveedores`)
);



