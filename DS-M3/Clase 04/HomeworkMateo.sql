select * from gasto;
select * from tipo_gasto;
-- La sucursal que mas gasto es San Isidro
select sum(g.Monto) as gastos, g.IdSucursal, s.Sucursal
from gasto g join Sucursal s
				on (g.IdSucursal = s.IdSucursal)
                group by Sucursal
                order by gastos desc;
-- Execution time 0.00.0085

-- Suma de gastos por mes de la sucursal San Isidro
select sum(g.Monto), date_format(g.Fecha, '%M'), s.Sucursal
from gasto g join sucursal s
				on (g.IdSucursal = S.IdSucursal)
where s.Sucursal = 'San Isidro' and year(Fecha) =2019
group by date_format(g.Fecha, '%M')
order by sum(g.Monto) desc;
-- Execution times 0.00.0047 

select year(g.Fecha) as año, avg(g.Monto) as Montopromedio, s.Sucursal
from gasto g join sucursal s
				on (g.IdSucursal = s.IdSucursal)
where s.Sucursal = 'San Isidro'
group by year(g.Fecha)
order by Montopromedio;
-- Execution time 0.00.0031

-- Asignar Primary Key 
select count(*), IdVenta 
from aux_venta
group by IdVenta
having count(*) > 1;

ALTER TABLE `empresa`.`canal_venta` 
CHANGE COLUMN `IdCanal` `IdCanal` INT NOT NULL,
ADD PRIMARY KEY (`IdCanal`);

ALTER TABLE `empresa`.`cargo` 
CHANGE COLUMN `IdCargo` `IdCargo` INT NOT NULL,
ADD PRIMARY KEY (`IdCargo`);

alter table cliente
change column IdCliente IdCliente int not null,
add primary key (IdCliente);

alter table compra
change column IdCompra IdCompra int not null,
add primary key (IdCompra);

alter table empleado 
change column IdEmpleado IdEmpleado int not null,
add primary key (IdEmpleado);

alter table gasto
change column IdGasto IdGasto int not null,
add primary key (IdGasto);

alter table producto 
change column IdProducto IdProducto int not null,
add primary key (IdProducto);

alter table proveedor
change column IdProveedor IdProveedor int not null,
add primary key (idProveedor);

alter table tipo_gasto
change column IdTipoGasto IdTipoGasto int not null,
add primary key (IdTipoGasto); -- Ya tien primary key

alter table venta
change column IdVenta IdVenta int not null,
add primary key (IdVenta);

alter table sucursal
change column IdSucursal IdSucursal int not null,
add primary key (IdSucursal);

-- indexacion
alter table calendario add index (IdFecha);
alter table calendario add index (anio);
alter table calendario add index (mes);
alter table calendario add index (dia);
alter table calendario add index (trimestre);
alter table calendario add index (semana);

alter table venta add index (Fecha);
alter table venta add index (Fecha_Entrega);
alter table venta add index (IdCanal); 
alter table venta add index (IdCliente);
alter table venta add index (IdEmpleado);
alter table venta add index (IdProducto);
alter table venta add index (Precio);
alter table venta add index (Cantidad);
alter table venta add index (IdSucursal);

alter table producto add index (Precio);
alter table producto add index (IdTipoProducto);

alter table sucursal add index (IdLocalidad);
alter table sucursal add index (latitud);
alter table sucursal add index (longitud);

alter table empleado add index (CodigoEmpleado);
alter table empleado add index (IdSucursal);
alter table empleado add index (IdSector);
alter table empleado add index (IdCargo);
alter table empleado add index (Salario);

alter table localidad add index (IdProvincia);
alter table localidad add index (Latitud);
alter table localidad add index (Longitud);

alter table proveedor add index (IdLocalidad);

alter table gasto add index (IdSucursal);
alter table gasto add index (IdTipoGasto);
alter table gasto add index (Fecha);
alter table gasto add index (Monto);

alter table cliente add index (Telefono);
alter table cliente add index (Edad);
alter table cliente add index (Rango_Etario);
alter table cliente add index (IdLocalidad);
alter table cliente add index (Latitud);
alter table cliente add index (Longitud);

alter table compra add index (Fecha);
alter table compra add index (IdProducto);
alter table compra add index (Cantidad);
alter table compra add index (Precio);
alter table compra add index (IdProveedor);


ALTER TABLE venta ADD CONSTRAINT `venta_fk_fecha` FOREIGN KEY (fecha) REFERENCES calendario (fecha) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_cliente` FOREIGN KEY (IdCliente) REFERENCES cliente (IdCliente) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_sucursal` FOREIGN KEY (IdSucursal) REFERENCES sucursal (IdSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_producto` FOREIGN KEY (IdProducto) REFERENCES producto (IdProducto) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_empleado` FOREIGN KEY (IdEmpleado) REFERENCES empleado (IdEmpleado) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_canal` FOREIGN KEY (IdCanal) REFERENCES canal_venta (IdCanal) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE producto ADD CONSTRAINT `producto_fk_tipoproducto` FOREIGN KEY (IdTipoProducto) REFERENCES tipo_producto (IdTipoProducto) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE empleado ADD CONSTRAINT `empleado_fk_sector` FOREIGN KEY (IdSector) REFERENCES sector (IdSector) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE empleado ADD CONSTRAINT `empleado_fk_cargo` FOREIGN KEY (IdCargo) REFERENCES cargo (IdCargo) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE empleado ADD CONSTRAINT `empleado_fk_sucursal` FOREIGN KEY (IdSucursal) REFERENCES sucursal (IdSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE cliente ADD CONSTRAINT `cliente_fk_localidad` FOREIGN KEY (IdLocalidad) REFERENCES localidad (IdLocalidad) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE proveedor ADD CONSTRAINT `proveedor_fk_localidad` FOREIGN KEY (IdLocalidad) REFERENCES localidad (IdLocalidad) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE sucursal ADD CONSTRAINT `sucursal_fk_localidad` FOREIGN KEY (IdLocalidad) REFERENCES localidad (IdLocalidad) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE localidad ADD CONSTRAINT `localidad_fk_provincia` FOREIGN KEY (IdProvincia) REFERENCES provincia (IdProvincia) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE compra ADD CONSTRAINT `compra_fk_fecha` FOREIGN KEY (Fecha) REFERENCES calendario (fecha) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE compra ADD CONSTRAINT `compra_fk_producto` FOREIGN KEY (IdProducto) REFERENCES producto (IdProducto) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE compra ADD CONSTRAINT `compra_fk_proveedor` FOREIGN KEY (IdProveedor) REFERENCES proveedor (IdProveedor) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE gasto ADD CONSTRAINT `gasto_fk_fecha` FOREIGN KEY (Fecha) REFERENCES calendario (fecha) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE gasto ADD CONSTRAINT `gasto_fk_sucursal` FOREIGN KEY (IdSucursal) REFERENCES sucursal (IdSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE gasto ADD CONSTRAINT `gasto_fk_tipogasto` FOREIGN KEY (IdTipoGasto) REFERENCES tipo_gasto (IdTipoGasto) ON DELETE RESTRICT ON UPDATE RESTRICT;

DROP TABLE IF EXISTS `fact_venta`;
CREATE TABLE IF NOT EXISTS `fact_venta` (
  `IdVenta`				INTEGER,
  `Fecha` 				DATE NOT NULL,
  `Fecha_Entrega` 		DATE NOT NULL,
  `IdCanal`				INTEGER, 
  `IdCliente`			INTEGER, 
  `IdEmpleado`			INTEGER,
  `IdProducto`			INTEGER,
  `Precio`				DECIMAL(15,2),
  `Cantidad`			INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO fact_venta
SELECT IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
FROM venta
WHERE YEAR(Fecha) = 2020;

ALTER TABLE `fact_venta` ADD PRIMARY KEY(`IdVenta`);
ALTER TABLE `fact_venta` ADD INDEX(`IdProducto`);
ALTER TABLE `fact_venta` ADD INDEX(`IdEmpleado`);
ALTER TABLE `fact_venta` ADD INDEX(`Fecha`);
ALTER TABLE `fact_venta` ADD INDEX(`Fecha_Entrega`);
ALTER TABLE `fact_venta` ADD INDEX(`IdCliente`);
ALTER TABLE `fact_venta` ADD INDEX(`IdCanal`);

DROP TABLE IF EXISTS dim_cliente;
CREATE TABLE IF NOT EXISTS dim_cliente (
	IdCliente			INTEGER,
	Nombre_y_Apellido	VARCHAR(80),
	Domicilio			VARCHAR(150),
	Telefono			VARCHAR(30),
	Rango_Etario		VARCHAR(20),
	IdLocalidad			INTEGER,
	Latitud				DECIMAL(13,10),
	Longitud			DECIMAL(13,10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO dim_cliente
SELECT IdCliente, Nombre_y_Apellido, Domicilio, Telefono, Rango_Etario, IdLocalidad, Latitud, Longitud
FROM cliente
WHERE IdCliente IN (SELECT distinct IdCliente FROM fact_venta);

DROP TABLE IF EXISTS dim_producto;
CREATE TABLE IF NOT EXISTS dim_producto (
	IdProducto					INTEGER,
	Producto					VARCHAR(100),
	IdTipoProducto				VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO dim_producto
SELECT IdProducto, Producto, IdTipoProducto
FROM producto
WHERE IdProducto IN (SELECT distinct IdProducto FROM fact_venta);


select * from venta;
select * from empleado;

