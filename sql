SELECT NOMBREARTÍCULO, SECCIÓN, PRECIO FROM PRODUCTOS WHERE SECCIÓN="CERÁMICA"

SELECT *FROM PRODUCTOS WHERE FECHA BETWEEN '2000-03-01' AND '2000-03-30'

select * from productos where sección='deportes' or sección='cerámica'

select * from productos where sección='deportes' or sección='cerámica' order by sección

select * from productos where sección='deportes' or sección='cerámica' order by sección desc

select * from productos where sección='deportes' or sección='cerámica' order by precio

select * from productos where sección='deportes' or sección='cerámica' order by sección,precio

select * from productos where sección='deportes' or sección='cerámica' order by sección,precio desc

select * from productos where sección='deportes' or sección='cerámica' order by sección,paísorigen,precio

select sección,SUM(precio) from productos group by sección

select sección,SUM(precio) as sumaarticulos from productos group by sección order by sumaarticulos

select sección,nombreartículo,SUM(precio) as sumaarticulos from productos group by sección order by sumaarticulos

select sección,AVG(precio) as mediaarticulos from productos group by sección having sección='deportes' or sección='confección'

select sección,AVG(precio) as mediaarticulos from productos group by sección order by mediaarticulos

select sección,AVG(precio) as mediaarticulos from productos group by sección having sección='deportes' or sección='confección' order by mediaarticulos

select población, count(códigocliente) as numerocliente from clientes group by población

select sección,max(precio) as preciomasalto from productos where sección='confección' group by sección 

select sección,nombreartículo,max(precio) as preciomasalto from productos where sección='confección' group by sección 

select nombreartículo,sección,precio,precio*1.21 as precio_con_iva from productos

select nombreartículo,sección,precio,round(precio*1.21,2) as precio_con_iva from productos

select nombreartículo,sección,precio,precio-3 as preciodescuento from productos

select nombreartículo,sección,precio,fecha from productos where sección='deportes'

select nombreartículo,sección,precio,fecha,now() as diahoy from productos where sección='deportes'

select nombreartículo,sección,precio,fecha,now() as diahoy,datediff(now(),fecha) as diferencia from productos where sección='deportes'

select nombreartículo,sección,precio,fecha,date_format(now(),'%D-%M') as diahoy,datediff(now(),fecha) from productos where sección='deportes'

consultas multi tablas o de union de tablas, union externas
con el mismo numero de campos y tipos de datos compatibles

select * from productos where sección='deportes' union select * from productosnuevos where sección='deportes de riesgo'

select * from productos where precio>500 union select * from productosnuevos where sección='alta costura'

SELECT * FROM PRODUCTOS WHERE SECCIÓN='DEPORTES' UNION SELECT * FROM PRODUCTOSNUEVOS

SELECT * FROM PRODUCTOS WHERE SECCIÓN='DEPORTES' UNION ALL SELECT * FROM PRODUCTOSNUEVOS

union internas, composiciones externas
devuelve registros comunes innerjoin
devuelve la parte izquierda registros left join right join lo contrario

select * from clientes inner join pedidos on clientes.códigocliente=pedidos.códigocliente where población='madrid'

select * from clientes left join pedidos on clientes.códigocliente=pedidos.códigocliente where población='madrid'

select * from clientes right join pedidos on clientes.códigocliente=pedidos.códigocliente where población='madrid'

select clientes.códigocliente,población,dirección, númerodepedido,pedidos.códigocliente,formadepago from clientes inner join pedidos on clientes.códigocliente=pedidos.códigocliente where población='madrid'

select clientes.códigocliente,población,dirección, númerodepedido,pedidos.códigocliente,formadepago from clientes left join pedidos on clientes.códigocliente=pedidos.códigocliente where población='madrid'

select clientes.códigocliente,población,dirección, númerodepedido,pedidos.códigocliente,formadepago from clientes inner join pedidos on clientes.códigocliente=pedidos.códigocliente where población='madrid' and pedidos.códigocliente is null

subconsultas=consulta dentro de otra
escalonadas,listas,correlacionadas

select avg(precio) from productos =escalonada
select nombreartículo,sección from productos where precio > (select avg(precio) from productos) 

select * from productos where precio > all (select precio from productos where seccion='cerámica')

select * from productos where precio > any (select precio from productos where sección='cerámica')

select * from productos where precio > all (select precio from productos where sección='juquetería')

select nombreartículo,precio from productos where códigoartículo in (select códigoartículo from productospedidos where unidades>20)

select nombrearticulo,precio from productos inner join productospedidos on productos.codigoarticulo=productospedidos.codigoarticulo where unidades > 20

select empresa,poblacion from clientes where codigocliente not in(select codigocliente from pedidos where formadepago='tarjeta')

consultas de accion
-actualiza,crea tablas,eliminar,anexar registros

comandos dml y ddl
create,update,delete,inset into,select into

update productos set precio=precio+10 where seccion ='deporte'

update productos set seccion ='deportivos' where seccion='deportes'

create table clientes_madrid select * from clientes where poblacio='madrid'

delete from clientes where poblacion='madrid'

delete from productos where seccion='deportivos' and precio between 50 and 100

select distinct empresa from clientes inner join pedidos on clientes.codigoclientes=pedido.codigoclientes

select distinctrow * from productos where seccio='ferreteria'

delete distinctrow clientes.*,pedidos.codigocliente from clientes left join pedidos on clientes.codigocliente=pedidos.codigocliente where pedido.codigocliente is null

consulta de datos anexados

insert into clientes 
select * from clientes_madrid

delete from clientes where poblacion='madrid'

insert into clientes (codigocliente,empresa,poblacion,telefono) 
select codigocliente,empres,poblacion,telefono from clientes_madrid

referenciascruzadas

transform sum(precio) as total
select nombrearticulo from productos group by nombrearticulo
pivot seccion

transform count(precio) as narticulo
select nombrearticulo from productos group by nombrearticulo
pivot seccion

ddl=create,alter,drop,truncate

create table prueba (id int aut_increment ,nombre varchar(10),apellido varchar(20),edad tinyint,fechana date,carnet bool,primary key( id))
drop table prueba

alter table clientes_madrid add column fechabaja date 

alter table prueba drop colomn poblacion

alter table prueba alter column fechabaja date

alter table prueba add column lugarna varchar(10)
alter table prueba alter column lugarna set default 'desconocido'

alter table prueba alter column lugarna drop default 

indices

create table ejemplo(dni,nombre varchar(10),apellido varchar(10),primary key (dni))

alter table ejemplo add primary key (nombre,apellido)

create index miindice on ejemplo (apellido)
create unique index minindice on ejemplo(nombre,apellido)

alter table ejemplo drop constranint index_numeroclaveprimaria

alter table ejemplo drop primary key

triggers=disparadores
es un objeto que creas en un bbdd,desencadena una accion cuando ocurra algo,insertar,eliminar,actualizar

CREATE TABLE reg_productos(
codigoarticulo VARCHAR( 20 ) ,
nombrearticulo VARCHAR( 20 ) ,
precio INT( 4 ) ,
insertado DATETIME
)

create trigger productos_ai after insert on productos for each row insert into reg_porductos(codigoarticulo,nombrearticulo,precio,insertado) values (new.codigoarticulo,new.nombrearticulo,new.precio,now())
insert into productos (codigoarticulo,nombrearticulo,precio,paisorigen) values ('ar75','pantalon',50,'españa')


CREATE TABLE PRODUCTOS_ACTUALIZADOS (


ANTERIOR_CÓDIGOARTÍCULO VARCHAR(4),
ANTERIOR_NOMBREARTÍCULO VARCHAR(25), 
ANTERIOR_SECCIÓN VARCHAR(15),
ANTERIOR_PRECIO INT(4), 
ANTERIOR_IMPORTADO VARCHAR(15),
ANTERIOR_PAÍSDEORIGEN VARCHAR(15), 
ANTERIOR_FECHA DATE,


NUEVO_CÓDIGOARTÍCULO VARCHAR(4),
NUEVO_NOMBREARTÍCULO VARCHAR(15), 
NUEVO_SECCIÓN VARCHAR(15),
NUEVO_PRECIO INT(4),
NUEVO_IMPORTADO VARCHAR(15), 
NUEVO_PAÍSDEORIGEN VARCHAR(15),
NUEVO_FECHA DATE,USUARIO VARCHAR(15),F_MODIF DATE)﻿
*
*CREATE TRIGGER ACTUALIZA_PRODUCTOS_BU BEFORE UPDATE ON PRODUCTOS FOR EACH ROW INSERT INTO PRODUCTOS_ACTUALIZADOS (ANTERIOR_CÓDIGOARTÍCULO,ANTERIOR_FECHA,ANTERIOR_IMPORTADO,ANTERIRO_NOMBREARTÍCULO,ANTERIOR_PAÍSORIGEN,ANTERIOR_PRECIO,ANTERIOR_SECCION,NUEVO_CÓDIGOARTÍCULO,NUEVO_FECHA,NUEVO_IMPORTADO,NUEVO_NOMBREARTÍCULO,NUEVO_PAÍSORIGEN,NUEVO_PRECIO,NUEVO_SECCION,USUARIO,F_MODIF)
VALUES(OLD.CÓDIGOARTÍCULO,OLD.FECHA,OLD.IMPORTADO,OLD.NOMBREARTÍCULO,OLD.PAÍSORIGEN,OLD.PRECIO,OLD.SECCIÓN,NEW.CÓDIGOARTÍCULO,NEW.FECHA,NEW.IMPORTADO,NEW.NOMBREARTÍCULO,NEW.PAÍSORIGEN,NEW.PRECIO,NEW.SECCIÓN,CURRENT_USER(),NOW())

CREATE TABLE PROD_ELIMINADOS (C_ART VARCHAR(5),NOMBRE VARCHAR(15),SECCION VARCHAR(15),PRECION INT(4),PAIS_O VARCHAR(15)) 
CREATE TRIGGER ELI_PRO_AD AFTER DELETE ON PRODUCTOS FOR EACH ROW INSERT INTO PROD_ELIMINADOS (C_ART,NOMBRE,PAIS_O,PRECIO,SECCION)
VALUES (OLD.CÓDIGOARTÍCULO,OLD.NOMBREARTÍCULO,OLD.PAÍSORIGEN,OLD.PRECIO,OLD.SECCIÓN)

PROCEDIMIENTOS ALMACENADOS

CREATE PROCEDURE MUESTRACLIENTE()
SELECT * FROM CLIENTES WHERE POBLACIÓN='MADRID'

CREATE PROCEDURE ACTUALIZA_PRODUCTOS(N_PRECIO INT, CODIGO VARCHAR(4))
UPDATE PRODUCTOS SET PRECIO=N_PRECIO WHERE CÓDIGOARTÍCULO=CODIGO;
CALL ACTUALIZA_PRODUCTOS(60,'AR22')

PROCEDIMIENTO DELIMITADO
DELIMITER $$
CREATE PROCEDURE CALCULAR_EDAD(AÑO_NACIMIENTO INT)
BEGIN

DECLARE AÑO_ACTUAL INT DEFAULT 2018;
DECLARE EDAD INT;
SET EDAD=AÑO_ACTUAL-AÑO_NACIMIENTO;
SELECT EDAD;

END;$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER REVISA_PRECIO_BU BEFORE UPDATE ON PRODUCTOS FOR EACH ROW
BEGIN

IF(NEW.PRECIO<0)THEN
	SET NEW.PRECIO=0;
ELSEIF(NEW.PRECIO>1000)THEN
	SET NEW.PRECIO=1000;
END IF;

END;$$
DELIMITER ;
UPDATE PRODUCTOS SET PRECIO=15 WHERE CÓDIGOARTÍCULO='AR01'
UPDATE PRODUCTOS SET PRECIO=2500 WHERE CÓDIGOARTÍCULO='AR01'
UPDATE PRODUCTOS SET PRECIO=8500 WHERE CÓDIGOARTÍCULO='AR01'

VISTAS SQL
create view art_deportes as select nombreartículo,sección,precio from productos where sección='deportes'
create view art_ceramica as select nombreartículo,sección,precio from productos where sección='cerámica'
drop view art_ceramica
alter view art_deportes as select nombreartículo,sección,paísorigen from productos where paísorigen='españa'
