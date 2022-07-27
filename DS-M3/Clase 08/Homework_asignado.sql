
-- Instrucción SQL N° 1

INSERT INTO fact_venta (IdFecha, Fecha, IdSucursal, IdProducto, IdProductoFecha, IdSucursalFecha, IdProductoSucursalFecha)
SELECT	c.IdFecha, 
		g.Fecha,
		g.IdSucursal, 
        NULL AS IdProducto, 
        NULL AS IdProductoFecha, 
        g.IdSucursal * 100000000 + c.IdFecha IdSucursalFecha,
        NULL AS IdProductoSucursalFecha
FROM 	gasto g JOIN calendario c
	ON (g.Fecha = c.fecha)
WHERE g.IdSucursal * 100000000 + c.IdFecha NOT IN (	SELECT	v.IdSucursal * 100000000 + c.IdFecha 
													FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
													WHERE v.Outlier = 1);
-- Instrucción SQL N° 2

INSERT INTO fact_inicial (IdFecha, Fecha, IdSucursal, IdProducto, IdProductoFecha, IdSucursalFecha, IdProductoSucursalFecha)
SELECT	c.IdFecha, 
		co.Fecha,
		NULL AS IdSucursal, 
        co.IdProducto, 
        co.IdProducto * 100000000 + c.IdFecha AS  IdProductoFecha, 
        NULL IdSucursalFecha,
        NULL AS IdProductoSucursalFecha
FROM 	compra co JOIN calendario c
	ON (co.Fecha = c.fecha)
WHERE co.IdProducto * 100000000 + c.IdFecha NOT IN (SELECT	v.IdProducto * 100000000 + c.IdFecha 
													FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
													WHERE v.Outlier = 1);

-- Instrucción SQL N° 3

-- Hace una consulta de la union de dos consultas.
create view Analisis_TipoProducto as
SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers
FROM
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) co
JOIN
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) so
ON co.TipoProducto = so.TipoProducto;

-- Ventas totales del primer y ultimo dia que se tenta registro
select Fecha, sum(Precio * Cantidad) as Ventas
from venta
where Fecha = (select min(Fecha) from venta)
union
select Fecha, sum(Precio * Cantidad) as Ventas
from venta
where Fecha = (select max(Fecha) from venta);

-- Obtenga un listado de los productos vendidos y del total de ventas de cada uno, 
-- según los requisitos del punto anterior.

select p.Producto, v.Fecha, sum(v.Precio * v.Cantidad) as VentasTotales
from venta v join producto p 
on v.IdProducto = p.IdProducto
where Fecha = (select min(Fecha) from venta)
group by p.Producto
union
select p.Producto, v.Fecha, sum(v.Precio * v.Cantidad) as VentasTotales
from venta v join producto p 
on v.IdProducto = p.IdProducto
where Fecha = (select max(Fecha) from venta)
group by p.Producto, v.Fecha;

-- Obtenga el importe total de ventas por fecha y a partir de este último listado, 
-- en que fecha se obtuvo el récord de ventas.
drop view VentasXFecha;
create view VentasXFecha as
select Fecha, sum(Precio * Cantidad) as VentasTotales
from venta
where Outlier = 1
group by Fecha;

select * from VentasXFecha;

select Fecha, max(VentasTotales)
from VentasXFecha;


