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
create index indice on calendario(IdFecha);
create index indicecanal on canal_venta(IdCanal);
create index indiceventa on venta(IdVenta,Fecha,Fecha_Entrega,IdCanal,IdCliente,IdSucursal,IdEmpleado,IdProducto,Precio,Cantidad);
create index indiceproduc on producto(IdProducto,Precio,IdTipoProducto);
create index indicetipoproduc on tipo_producto(IdTipoProducto);
create index indicesucur on sucursal(IdSucursal,IdLocalidad,Latitud,Longitud);
create index indiceemple on empleado(IdEmpleado,CodigoEmpleado,IdSucursal,IdSector,IdCargo,Salario);
create index indiceloc on localidad(IdLocalidad, IdProvincia,Latitud,Longitud);
create index indiceprov on proveedor(IdProveedor,IdLocalidad);
create index indicegasto on gasto(IdGasto, IdSucursal,IdTipoGasto,Fecha,Monto);
create index indicecliente on cliente(IdCliente,Telefono,Edad,Rango_Etario,IdLocalidad,Latitud,Longitud);
create index indicecompra on compra(IdCompra,Fecha,IdProducto,Cantidad,Precio,IdProveedor);




