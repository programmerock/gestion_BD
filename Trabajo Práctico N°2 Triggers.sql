use negocioWebRopa;
SET SQL_SAFE_UPDATES = 0;

/*
#######################################################################################################
TRIGGERS CLIENTES
#######################################################################################################
*/

drop trigger if exists TR_Clientes_Insert;
delimiter //
create trigger TR_Clientes_Insert
	after insert on clientes
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('clientes', 'insert', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;


drop trigger if exists TR_Clientes_Delete;
delimiter //
create trigger TR_Clientes_Delete
	after delete on clientes
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('clientes', 'delete', curdate(), curtime(), current_user(), old.id);
    end;
// delimiter ;


drop trigger if exists TR_Clientes_Update;
delimiter //
create trigger TR_Clientes_Update
	after update on clientes
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('clientes', 'update', curdate(), curtime(), current_user(), new.id);
    end;
// delimiter ;


/*
#######################################################################################################
TRIGGERS ARTICULOS
#######################################################################################################
*/

drop trigger if exists TR_Articulos_Insert;
delimiter //
create trigger TR_Articulos_Insert
	after insert on articulos
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('articulos', 'insert', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;


drop trigger if exists TR_Articulos_Delete;
delimiter //
create trigger TR_Articulos_Delete
	after delete on articulos
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('articulos', 'delete', curdate(), curtime(), current_user(), old.id);
    end;
// delimiter ;


drop trigger if exists TR_Articulos_Update;
delimiter //
create trigger TR_Articulos_Update
	after update on articulos
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('articulos', 'update', curdate(), curtime(), current_user(), new.id);
    end;
// delimiter ;

/*
#######################################################################################################
TRIGGERS FACTURAS
#######################################################################################################
*/

drop trigger if exists TR_Facturas_Insert;
delimiter //
create trigger TR_Facturas_Insert
	after insert on facturas
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('facturas', 'insert', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;


drop trigger if exists TR_Facturas_Delete;
delimiter //
create trigger TR_Facturas_Delete
	after delete on facturas
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('facturas', 'delete', curdate(), curtime(), current_user(), old.id);
    end;
// delimiter ;


drop trigger if exists TR_Facturas_Update;
delimiter //
create trigger TR_Facturas_Update
	after update on facturas
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('facturas', 'update', curdate(), curtime(), current_user(), new.id);
    end;
// delimiter ;

/*
#######################################################################################################
TRIGGERS DETALLES
#######################################################################################################
*/

drop trigger if exists TR_Detalles_Insert;
delimiter //
create trigger TR_Detalles_Insert
	after insert on detalles
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('detalles', 'insert', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;


drop trigger if exists TR_Detalles_Delete;
delimiter //
create trigger TR_Detalles_Delete
	after delete on detalles
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('detalles', 'delete', curdate(), curtime(), current_user(), old.id);
    end;
// delimiter ;


drop trigger if exists TR_Detalle_Update;
delimiter //
create trigger TR_Detalle_Update
	after update on detalles
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
        values ('detalles', 'update', curdate(), curtime(), current_user(), new.id);
    end;
// delimiter ;



call SP_Clientes_Insert_Min("Mateo", "Burella");
call SP_Clientes_Insert_Min("Juan", "Mendoza");
call SP_Clientes_Delete(8);
call SP_Clientes_Delete(8);
update clientes set telefono="64647777" where id=1;
call SP_Articulos_Insert_Min("Campera", "Negra");
call SP_Articulos_Insert_Min("Campera", "Verde");
call SP_Articulos_Delete(12);
update articulos set precio=12000 where descripcion="Campera" and color="Negra";
call SP_Facturas_Insert('C', 4, curdate(), 'TARJETA', 4);
call SP_Facturas_Insert('C', 5, curdate(), 'TARJETA', 5);
call SP_Facturas_Delete(3);
update facturas set medioDePago='EFECTIVO' where letra='C' and numero=5;
call SP_Facturas_AgregarDetalle(3, 1, 190, 3);
call SP_Facturas_AgregarDetalle(3, 4, 385, 3);
call SP_Detalles_Delete(3);

select * from control;