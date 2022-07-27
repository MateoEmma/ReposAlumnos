use empresa;

-- Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto 
-- junto al id del producto y su respectivo precio.
select distinct c.Nombre_Y_Apellido, v.IdProducto, v.Precio, v.IdVenta
from venta v join cliente c
				on (c.IdCliente = v.IdCliente)
                order by v.IdVenta;

select distinct c.Nombre_Y_Apellido, v.IdProducto, v.Precio
from venta v join cliente c
				on (c.IdCliente = v.IdCliente);


-- Obteber un listado de clientes con la cantidad de productos adquiridos, 
-- incluyendo aquellos que nunca compraron algún producto.
select c.*, sum(v.Cantidad) as ProductosComprados
from cliente c left join venta v
				on (c.IdCliente = v.IdCliente)
group by c.IdCliente
order by c.IdCliente asc;

-- Obtener un listado de cual fue el volumen de compra (cantidad) por año de cada cliente.
select c.Nombre_y_Apellido, sum(v.Cantidad) as ProductosComprados, year(v.Fecha) as año
from venta v join cliente c 
				on (v.IdCliente = c.IdCliente)
group by año, c.Nombre_y_Apellido;

-- Obtener un listado del nombre y apellido de cada cliente 
-- que haya adquirido algun producto junto al id del producto, 
-- la cantidad de productos adquiridos y el precio promedio.
select c.Nombre_Y_Apellido, v.IdProducto, sum(v.Cantidad) as CantidadProductos, avg(v.Precio) as PrecioPromedio
from venta v right join cliente c 
				on v.IdCliente = c.IdCliente
where v.IdProducto is not null
group by c.Nombre_y_Apellido, v.IdProducto;

-- Cacular la cantidad de productos vendidos y 
-- la suma total de ventas para cada localidad, 
-- presentar el análisis en un listado con el nombre de cada localidad.
select l.Localidad, sum(v.Cantidad) as CantidadProductos, sum(v.Precio * v.Cantidad) as VentasTotales
from venta v left join sucursal s 
			on v.IdSucursal = s.IdSucursal
			join Localidad l 
            on s.IdLocalidad = l.IdLocalidad
group by s.IdLocalidad;

-- Cacular la cantidad de productos vendidos 
-- y la suma total de ventas para cada provincia, 
-- presentar el análisis en un listado con el nombre de cada provincia, 
-- pero solo en aquellas donde la suma total de las ventas fue superior a $100.000.
select p.Provincia, sum(v.Cantidad) as CantidadProductos, sum(v.Precio * v.Cantidad) as VentasTotales
from venta v join sucursal s 
				on v.IdSucursal = s.IdSucursal
                join Localidad L 
                on s.IdLocalidad = l.IdLocalidad
                join provincia p 
                on l.IdProvincia = p.IdProvincia
group by p.Provincia;

-- Obtener un listado de dos campos en donde por un lado se obtenga la cantidad de productos vendidos 
-- por rango etario y las ventas totales en base a esta misma dimensión. 
-- El resultado debe obtenerse en un solo listado.
select c.Rango_Etario, sum(v.Cantidad) as ProductosComprados, sum(v.Precio*v.Cantidad) as VentasTotales
from venta v join cliente c 
				on v.IdCliente = c.IdCliente
group by c.Rango_Etario;

-- Obtener la cantidad de clientes por provincia.
select count(c.IdCliente) as CantidadClientes, p.Provincia
from provincia p left join localidad l 
					on p.IdProvincia = l.IdProvincia
				left join  cliente c
					on l.IdLocalidad = c.IdLocalidad
group by p.Provincia;
				
                
				




