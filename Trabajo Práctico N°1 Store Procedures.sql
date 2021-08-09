use negocioWebRopa;

/*
#######################################################################################################
STORE PROCEDURES TABLA CLIENTES
#######################################################################################################
*/

drop procedure if exists SP_Clientes_Insert_Min;
delimiter //
create procedure SP_Clientes_Insert_Min (in Pnombre varchar(20), Papellido varchar(20))
begin
	insert into clientes (nombre,apellido) values (Pnombre,Papellido);
end
// delimiter ;


drop procedure if exists SP_Clientes_Insert_Full;
delimiter //
create procedure SP_Clientes_Insert_Full (in Pnombre varchar(20), Papellido varchar(20),
		Pfenaci date, Pdireccion varchar(50), Pemail varchar(30), 
        Ptelefono  varchar(25), PtipoDocumento varchar(20), PnumeroDocumento char(8))
begin
	insert into clientes 
		(nombre,apellido,fenaci,direccion,email,telefono,tipoDocumento,numeroDocumento) 
        values 
        (Pnombre,Papellido,Pfenaci,Pdireccion,Pemail,Ptelefono,PtipoDocumento,PnumeroDocumento);
end
// delimiter ;


drop procedure if exists SP_Clientes_Delete;
delimiter //
create procedure SP_Clientes_Delete (in Pid int)
begin
	delete from clientes where id=Pid;
end
// delimiter ;


drop procedure if exists SP_Clientes_Update;
delimiter //
create procedure SP_Clientes_Update (in Pid int, Pnombre varchar(20), Papellido varchar(20),
		Pfenaci date, Pdireccion varchar(50), Pemail varchar(30), 
        Ptelefono  varchar(25), PtipoDocumento varchar(20), PnumeroDocumento char(8))
begin
	update clientes set nombre=Pnombre, apellido=Papellido, fenaci=Pfenaci, direccion=Pdireccion,
					email=Pemail, telefono=Ptelefono, tipoDocumento=PtipoDocumento,
					numeroDocumento=PnumeroDocumento where id=Pid;
end
// delimiter ;


drop procedure if exists SP_Clientes_All;
delimiter //
create procedure SP_Clientes_All ()
begin
	select id idCliente ,concat(apellido,' ',nombre) nombre, fenaci fecha_nacimiento, 
    TIMESTAMPDIFF(YEAR,fenaci,CURDATE()) edad, direccion, email, telefono,
    tipoDocumento, numeroDocumento from clientes;
end
// delimiter ;


-- Llamada a los SP de la tabla clientes
call SP_Clientes_Insert_Min('Andrea','Moretti');
call SP_Clientes_Insert_Full('Marcelo','Gallardo','1976/12/12','Libertador 202','muñeco@gmail.com','1234565','DNI','86086001');
call SP_Clientes_Delete(3);
call SP_Clientes_Update(7,'Andrea','Moretti','1978/5/25','Laprida 2121','andy@gmail.com','12345678','DNI','03034560');
call SP_Clientes_All();


/*
#######################################################################################################
STORE PROCEDURES TABLA ARTICULOS
#######################################################################################################
*/

drop procedure if exists SP_Articulos_Insert_Min;
delimiter //
create procedure SP_Articulos_Insert_Min (in Pdescripcion varchar(25), Pcolor varchar(20))
begin
	insert into articulos (descripcion, color) values (Pdescripcion, Pcolor);
end
// delimiter ;


drop procedure if exists SP_Articulos_Insert_Full;
delimiter //
create procedure SP_Articulos_Insert_Full (in Pdescripcion varchar(25), Ptipo enum('CALZADO','ROPA'), Pcolor varchar(20),
											Ptalle_num varchar(20), Pstock int, PstockMin int, PstockMax int, Pcosto double,
                                            Pprecio double, Ptemporada enum('VERANO','OTOÑO','INVIERNO'))
begin
	insert into articulos 
		(descripcion, tipo, color, talle_num, stock, stockMin, stockMax, costo, precio, temporada) 
        values 
        (Pdescripcion, Ptipo, Pcolor, Ptalle_num, Pstock, PstockMin, PstockMax, Pcosto, Pprecio, Ptemporada);
end
// delimiter ;


drop procedure if exists SP_Articulos_Delete;
delimiter //
create procedure SP_Articulos_Delete (in Pid int)
begin
	delete from articulos where id=Pid;
end
// delimiter ;


drop procedure if exists SP_Articulos_Update;
delimiter //
create procedure SP_Articulos_Update (in Pid int, Pdescripcion varchar(25), Ptipo enum('CALZADO','ROPA'), Pcolor varchar(20),
										Ptalle_num varchar(20), Pstock int, PstockMin int, PstockMax int, Pcosto double,
										Pprecio double, Ptemporada enum('VERANO','OTOÑO','INVIERNO'))
begin
	update articulos set descripcion=Pdescripcion, tipo=Ptipo, color=Pcolor, talle_num=Ptalle_num, 
						stock=Pstock, stockMin=PstockMin, stockMax=PstockMax, costo=Pcosto, 
                        precio=Pprecio, temporada=Ptemporada where id=Pid;
end
// delimiter ;


drop procedure if exists SP_Articulos_All;
delimiter //
create procedure SP_Articulos_All ()
begin
	select * from articulos;
end
// delimiter ;


drop procedure if exists SP_Articulos_Reponer;
delimiter //
create procedure SP_Articulos_Reponer ()
begin
	select * from articulos where stock < stockMin;
end
// delimiter ;


-- Llamada a los SP de la tabla articulos
call SP_Articulos_Insert_Min("Bufanda", "Violeta");
call SP_Articulos_Insert_Full("Ojotas", 'CALZADO', "Rojo", "39", 25, 7, 30, 125.50, 250, 'VERANO');
call SP_Articulos_Delete(9);
call SP_Articulos_Update(10, "Ojotas", 'CALZADO', "Rojo", "39", 25, 7, 30, 125.50, 250, 'VERANO');
call SP_Articulos_All();
call SP_Articulos_Reponer();


/*
#######################################################################################################
STORE PROCEDURES TABLA FACTURAS
#######################################################################################################
*/

drop procedure if exists SP_Facturas_Insert;
delimiter //
create procedure SP_Facturas_Insert (in Pletra enum('A','B','C'), Pnumero int, Pfecha date,
									PmedioDePago enum('EFECTIVO','DEBITO','TARJETA'), PidCliente int)
begin
	insert into facturas (letra, numero, fecha, medioDePago, idCliente) 
    values (Pletra, Pnumero, Pfecha, PmedioDePago, PidCliente);
end
// delimiter ;


drop procedure if exists SP_Facturas_Delete;
delimiter //
create procedure SP_Facturas_Delete (in Pid int)
begin
	delete from facturas where id=Pid;
end
// delimiter ;


drop procedure if exists SP_Facturas_Update;
delimiter //
create procedure SP_Facturas_Update (in Pid int, Pletra enum('A','B','C'), Pnumero int, Pfecha date,
									PmedioDePago enum('EFECTIVO','DEBITO','TARJETA'), PidCliente int)
begin
	update facturas set letra=Pletra, numero=Pnumero, fecha=Pfecha, 
			medioDePago=PmedioDePago, idCliente=PidCliente where id=Pid;
end
// delimiter ;


drop procedure if exists SP_Facturas_All;
delimiter //
create procedure SP_Facturas_All ()
begin
	select * from facturas;
end
// delimiter ;


drop procedure if exists SP_Facturas_AgregarDetalle;
delimiter //
create procedure SP_Facturas_AgregarDetalle (in PidArticulo int, PidFactura int, Pprecio double, Pcantidad int)
begin
	insert into detalles (idArticulo, idFactura, precio, cantidad) 
    values(PidArticulo, PidFactura, Pprecio, Pcantidad);
end
// delimiter ;


-- Llamada a los SP de la tabla facturas
call SP_Facturas_Insert('A', 5, '2021-08-05', 'EFECTIVO',5);
call SP_Facturas_Delete(2);
call SP_Facturas_Update(1, 'A', 1, curdate(), 'TARJETA',1);
call SP_Facturas_All();
call SP_Facturas_AgregarDetalle(4, 1, 250, 1);


/*
#######################################################################################################
STORE PROCEDURES TABLA DETALLES
#######################################################################################################
*/

drop procedure if exists SP_Detalles_Delete;
delimiter //
create procedure SP_Detalles_Delete (in Pid int)
begin
	delete from detalles where id=Pid;
end
// delimiter ;


drop procedure if exists SP_Detalles_All;
delimiter //
create procedure SP_Detalles_All ()
begin
	select 	concat(f.letra,f.numero) Factura,
			a.descripcion "Artículo",
            a.color Color,
            a.talle_num "Talle/Número",            
            d.cantidad Monto    
    from 	detalles d
    join	articulos a
    on		d.idArticulo=a.id
    join	facturas f
    on		d.idFactura=f.id;
end
// delimiter ;


-- Llamada a los SP de la tabla detalles
call SP_Detalles_Delete(3);
call SP_Detalles_All();

