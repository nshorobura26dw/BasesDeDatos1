ALTER TABLE empleados
	ADD COLUMN tipo ENUM ('director', 'representante');
    
UPDATE empleados
	SET tipo = 'director'
    WHERE nuemp IN (104, 106, 108);

UPDATE empleados
	SET tipo = 'representante'
    WHERE nuemp IN (101, 102, 103, 105, 107, 109, 110);
    
INSERT INTO directores 
	SELECT nuemp
			FROM empleados
            WHERE tipo = 'director';

INSERT INTO representantes
	SELECT nuemp, cuota, ventas
    FROM empleados
    WHERE tipo = 'representante';
    
ALTER TABLE empleados
	DROP COLUMN cuota,
    DROP COLUMN ventas;
    
ALTER TABLE clientes
	DROP CONSTRAINT clientes_empleados;
    
ALTER TABLE clientes
	ADD CONSTRAINT clientes_representantes
    FOREIGN KEY (gestor) 
		REFERENCES representantes(id_representante);

ALTER TABLE oficinas
	DROP CONSTRAINT fk_oficinas_empleados;

ALTER TABLE oficinas
	ADD CONSTRAINT oficinas_directores
	FOREIGN KEY (director)
		REFERENCES directores(id_director)
	ON UPDATE cascade
    ON DELETE NO ACTION;

Create table nominas (
	num_nomina INT,
    fecha_inicio date,
    fecha_final date,
    importe double,
    primary key (num_nomina)
    );
    
create table directores_nominas (
	num_nomina int,
    id_director int,
    primary key (num_nomina, id_director));

alter table directores_nominas
	add constraint nm_director
		foreign key (id_director)
			references directores(id_director)
	on update cascade
    on delete no action;

alter table directores_nominas
	add constraint nm_nomina
		foreign key (num_nomina)
			references nominas(num_nomina)
		on update cascade
        on delete no action;

alter table nominas
	add column id_empleado int,
	add constraint nominas_empleados
		foreign key (id_empleado)
			references empleados(nuemp)
	on update cascade
    on delete no action;

#Insertar datos: nomina, 
INSERT INTO nominas(num_nomina, fecha_inicio, fecha_final, importe, id_empleado) VALUES
(1,'1986-10-20','1986-10-31',600,101),
(2,'1986-12-10','1986-12-31',700,102),
(3,'1987-03-01','1987-03-31',1200,103),
(4,'1987-05-19','1987-05-31',1600,104),
(5,'1988-02-12','1988-02-28',1100,105),
(6,'1988-06-14','1988-06-30',1100,106),
(7,'1988-11-14','1988-11-30',1000,107),
(8,'1989-10-12','1989-10-31',1250,108),
(9,'1999-10-12','1999-10-31',800,109),
(10,'1990-01-13','1990-01-31',850,110),
(11,'1986-11-01','1986-11-30',900,101),
(12,'1986-01-01','1986-01-31',1000,102),
(13,'1987-04-01','1987-04-30',1200,103),
(14,'1987-06-01','1987-06-25',1800,104),
(15,'1988-03-10','1988-03-20',500,105),
(16,'1988-07-01','1988-07-15',750,106),
(17,'1988-12-15','1988-12-24',625,107),
(18,'1989-11-01','1989-11-30',1350,108),
(19,'1999-11-05','1999-11-20',600,109),
(20,'1990-02-01','1990-02-28',850,110);

INSERT INTO directores_nominas(id_director, num_nomina) VALUES
(104,1),
(104,3),
(104,16),
(104,15),
(104,19),
(106,1),
(106,2),
(106,3),
(106,4),
(106,5),
(108,5),
(108,6),
(108,8),
(108,9),
(104,10),
(104,9),
(104,11),
(106,12),
(106,13),
(106,14),
(106,15),
(108,16),
(108,17),
(108,18),
(106,20),
(104,7);
    
#Consultas
#1
select nombre
from clientes
where gestor in (select id_representante
					from representantes
                    where id_representante in (select nuemp
												from empleados
                                                where nombre = 'Alvaro Jaumes'));

#2
select nuemp, nombre, oficina
from empleados
where oficina in (select oficina
					from oficinas
                    where ventas > objetivo);
                    
#3
select nuemp, nombre
from empleados
where oficina in (select oficina
					from oficinas
					where director not like 108);

#4
select num_nomina
from nominas
where id_empleado in (select nuemp
						from empleados
                        where nombre = 'Luis Antonio');
                        
#5
select idfab, idproducto, descripcion
from productos
where (idfab, idproducto) in (select idfab, idproducto #Tienen que ir en el mismo orden
							from pedidos
                            where importe < 25000);
                            
#6
select *
from clientes
where numclie in (select idcliente
					from pedidos
                    where importe < 3000 and idemp in (select nuemp
														from empleados
                                                        where nombre = 'Juan Rovira'));

#7
select *
from oficinas
where oficina in (select oficina
					from empleados
                    where nuemp in (select id_representante
									from representantes
                                    where ventas > (objetivo * 0.55)));

#8
select *
from nominas
where id_empleado in (select nuemp
						from empleados
                        where oficina in (select oficina
											from oficinas
                                            where region = 'oeste'));

#9
select count(nuemp), oficina
from empleados
group by oficina;

#10
select e.nuemp, e.nombre, p.importe, c.numclie
from empleados e
inner join pedidos p
on p.idemp = e.nuemp
inner join clientes c
on c.numclie = p.idcliente;

#11
