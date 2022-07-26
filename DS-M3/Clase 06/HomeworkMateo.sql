use empresa;

-- procedimiento que recibe ua fecha y devuelve las ventas echas en esa fecha.
drop procedure ventasenfecha;
delimiter $$
create procedure ventasenfecha(fecha date)
begin
	select v.Fecha, v.IdVenta, p.Producto
    from venta v join producto p 
    on v.IdProducto = p.IdProducto
    where v.Fecha = fecha;
end $$
 delimiter ;
call ventasenfecha("2015-06-06");


-- funcion que determina el margren bruto sobre un producto 
select (5-4)/2;
drop function margembruto;
delimiter $$
create function margembruto(valor decimal(50,2), costo decimal(50,2)) returns float
begin
	declare margen decimal(50,2);
    set margen = (select (valor - costo)/valor);
    return margen;
end$$

delimiter ;
select margembruto(100.00,80.00);

-- Productos de impresion agregarle un 20% de margen bruto
drop procedure valornominal;
delimiter $$
create procedure valornominal()
begin 
	select p.Producto, t.TipoProducto, p.Precio + (p.Precio * 0.20) as valornominal
    from producto p join tipo_producto t
    on (t.IdTipoProducto = p.IdTipoProducto)
    having t.TipoProducto = 'Impresion';
end$$
delimiter ;
call valornominal();
	
-- Obtener ventas totales x rango etario


delimiter $$
create procedure ventasXRangoetario(rango varchar (20))
begin 
	
end$$

delimiter ;
call ventasXRangoetario("3_De 41 a 50 años")

    