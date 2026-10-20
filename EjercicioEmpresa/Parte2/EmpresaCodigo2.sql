#1
ALTER TABLE clientes
	ADD gestor INT;
    
ALTER TABLE clientes
	ADD CONSTRAINT clientes_empleados
    FOREIGN KEY (gestor)
	REFERENCES empleados(nuemp)
		/*CASCADE, NO ACTION, SET NULL, RESTRICT*/
    ON DELETE NO ACTION
    ON UPDATE CASCADE;
    
#2
ALTER TABLE pedidos
	ADD idcliente INT;

ALTER TABLE pedidos
	ADD CONSTRAINT pedidos_clientes
	FOREIGN KEY (idcliente)
	REFERENCES clientes(numclie)
    ON DELETE NO ACTION
    ON UPDATE CASCADE;

#3
ALTER TABLE pedidos
	ADD idemp INT;

ALTER TABLE pedidos
	ADD CONSTRAINT pedidos_empleados
    FOREIGN KEY (idemp)
    REFERENCES empleados(nuemp)
    ON DELETE NO ACTION
    ON UPDATE CASCADE;

#4
ALTER TABLE productos
	ADD idfab varchar(45);

ALTER TABLE productos
	ADD CONSTRAINT productos_fabricantes
	FOREIGN KEY (idfab)
    REFERENCES fabricantes(idfab);

ALTER TABLE productos
	DROP PRIMARY KEY,
    ADD PRIMARY KEY (idfab, idproducto);
    
#5
ALTER TABLE pedidos
	ADD cantidad INT,
	ADD idproducto varchar(45);
    
ALTER TABLE pedidos
    ADD idfab varchar(45);

ALTER TABLE pedidos
	ADD CONSTRAINT pedidos_productos
		FOREIGN KEY (idfab, idproducto)
        REFERENCES productos(idfab, idproducto)
        ON DELETE NO ACTION
        ON UPDATE CASCADE;

#6
CREATE TABLE titulos (
	nuemp int,
    titulo varchar(45),
    PRIMARY KEY (nuemp, titulo));
    
ALTER TABLE titulos
	ADD CONSTRAINT titulos_empleados
		FOREIGN KEY (nuemp)
        REFERENCES empleados(nuemp)
        ON DELETE NO ACTION
        ON UPDATE CASCADE;

#Datos
INSERT INTO clientes (numclie,nombre,gestor,limitecredito) VALUES 
 (2101,'Luis Garcia',102,65000),
 (2102,'Alvaro Rodriguez',101,605000),
 (2103,'Jaime Llorens',105,50000),
 (2105,'Antonio Canales',101,45000),
 (2106,'Juan Suarez',102,65000),
 (2107,'Julian Lopez',110,35000),
 (2108,'Julia Antequera',109,55000),
 (2109,'Alberto Juanes',103,25000),
 (2111,'Cridtobal Garcia',103,50000),
 (2112,'Maria Silva',109,50000),
 (2113,'Luisa Maron',103,20000),
 (2114,'Cristina Marini',102,20000),
 (2115,'Vicente Martinez',101,20000),
 (2117,'Carlos Tena',101,35000),
 (2118,'June Alvarez',105,60000),
 (2119,'Salomon Bueno',109,25000),
 (2120,'Juan Malo',102,50000),
 (2121,'Vicente Rios',103,45000),
 (2122,'Jose Machante',105,30000),
 (2123,'Jose Libros',102,40000),
 (2124, 'Juan Bolto', 107, 40000);
 
INSERT INTO fabricantes (idfab, nombre) VALUES
('aci','Acicat'),
('bic', 'Bic_Iberia'),
('imm','Ferreteria Imm'),
('qsa', 'Paqsacro'),
('rei', 'Ferreteria Rei'),
('fea', 'Fesmesa');

INSERT INTO productos (idfab,idproducto,descripcion,precio,existencias) VALUES 
 ('aci','41001','arandela',58.0000,4),
 ('aci','41002','bisagra',80.0000,167),
 ('aci','41003','art t3',112.0000,207),
 ('aci','41004','art t4',123.0000,139),
 ('aci','4100x','junta',26.0000,37),
 ('aci','4100y','extractor',2888.0000,25),
 ('aci','4100z','mont',2625.0000,28),
 ('bic','41003','manivela',652.0000,3),
 ('bic','41089','rodamiento',225.0000,78),
 ('bic','41672','plato',180.0000,0),
 ('fea','112','cubo',148.0000,115),
 ('fea','114','cubo',243.0000,15),
 ('fea','887p', 'tornillo',5.000,32), 
 ('imm','773c','reostato',975.0000,28),
 ('imm','775c','reostato 2',1425.0000,5),
 ('imm','779c','reostato 3',1875.0000,0),
 ('imm','887h','caja clavos',54.0000,223),
 ('imm','887p','perno',25.0000,24),
 ('imm','887x','manivela',475.0000,32),
 ('qsa','xk47','red',355.0000,38),
 ('qsa','xk48','red',134.0000,203),
 ('qsa','xk48a','red',117.0000,37),
 ('rei','2a44g','pas',350.0000,14),
 ('rei','2a44l','bomba l',4500.0000,12),
 ('rei','2a44r','bomba r',4500.0000,12),
 ('rei','2a45c','junta',79.0000,210),
 ('rei','xk48a','cubo',100.0000,125);
 
 INSERT INTO pedidos (codigo,numpedido,fechapedido,idcliente,idemp,idfab,idproducto,cantidad,importe) VALUES 
 (1,110036,'2005-01-02',2107,110,'aci','4100z',9,'22500.0000'),
 (2,110036,'2005-01-02',2117,102,'rei','2a44l',7,'31500.0000'),
 (3,112963,'2005-05-10',2103,105,'aci','41004',28,'3276.0000'),
 (4,112968,'1999-01-11',2102,101,'aci','41004',34,'3978.0000'),
 (5,112975,'2005-02-11',2111,103,'rei','2a44g',6,'2100.0000'),
 (6,112979,'2001-10-12',2114,103,'aci','4100z',6,'15000.0000'),
 (7,112983,'2005-05-10',2103,105,'aci','41004',6,'702.0000'),
 (8,112987,'2005-01-01',2103,105,'aci','4100y',11,'27500.0000'),
 (9,112989,'2005-12-10',2101,101,'fea','114',6,'1458.0000'),
 (10,112992,'1999-04-15',2118,110,'aci','41002',10,'760.0000'),
 (11,112993,'2005-03-10',2106,102,'rei','2a45c',24,'1896.0000'),
 (12,112997,'2005-04-04',2124,107,'bic','41003',1,'652.0000'),
 (13,113003,'2005-02-05',2108,109,'imm','779c',3,'5625.0000'),
 (14,113007,'2005-01-01',2112,102,'imm','773c',3,'2925.0000'),
 (15,113012,'2005-05-05',2111,105,'aci','41003',35,'3745.0000'),
 (16,113013,'2005-08-06',2118,101,'bic','41003',1,'652.0000'),
 (17,113024,'2005-07-04',2114,109,'qsa','xk47',20,'7100.0000'),
 (18,113027,'2005-02-05',2103,105,'aci','41002',54,'4104.0000'),
 (19,113034,'2005-11-05',2107,110,'rei','2a45c',8,'632.0000'),
 (20,113042,'2005-01-01',2113,101,'rei','2a44r',5,'22500.0000'),
 (21,113045,'2005-07-02',2112,109,'rei','2a44r',10,'45000.0000'),
 (22,113048,'2005-02-02',2120,102,'imm','779c',2,'3750.0000'),
 (23,113049,'2005-04-04',2118,107,'qsa','xk47',2,'776.0000'),
 (24,113051,'2005-07-06',2118,101,'qsa','xk47',4,'1420.0000'),
 (25,113055,'1999-04-01',2108,101,'aci','4100x',6,'150.0000'),
 (26,113057,'2005-11-01',2111,103,'aci','4100x',24,'600.0000'),
 (27,113058,'2000-07-04',2108,109,'fea','112',10,'1480.0000'),
 (28,113058,'2005-07-04',2108,109,'fea','112',10,'1480.0000'),
 (29,113062,'2005-07-04',2111,103,'aci','4100x',24,'600.0000'),
 (30,113058,'1999-07-04',2108,109,'fea','112',10,'1480.0000'),
 (31,113062,'2005-07-04',2124,107,'bic','41003',10,'2430.0000'),
 (32,113065,'2005-06-03',2106,102,'qsa','xk47',6,'2130.0000'),
 (33,113069,'2005-08-01',2109,107,'imm','773c',22,'31350.0000');
 
 insert into titulos values 
(101,'administrativo'),
(102,'representante'),
(103,'administrativo'),
(104,'empresariales'),
(105,'comercio'),
(106,'finanzas'),
(107,'comercio'),
(108,'empresariales'),
(109,'administrativo'),
(110,'comercio'),
(104,'informatica'),
(101,'finanzas'),
(106,'comunicaciones'),
(102,'comercio'),
(102,'administrativo'),
(105, 'informatica');

#Consultas
#1
SELECT *
FROM productos
WHERE precio > 200;

#2
SELECT *
FROM productos
WHERE precio >= 100 and precio <= 200;

#3
SELECT idfab,idproducto,descripcion,precio,precio+(precio*0.21) as 'Precio con IVA'
FROM productos;

#4
SELECT numpedido, idfab, idproducto, cantidad, importe, (importe / cantidad) as 'Precio unitario'
FROM pedidos;

#5
SELECT *
FROM clientes
ORDER BY gestor ASC;

#6
SELECT *
FROM pedidos
ORDER BY fechapedido;

#7
SELECT *
FROM pedidos
ORDER BY importe DESC
LIMIT 4;

#8
SELECT numpedido, idfab, idproducto, cantidad, importe/cantidad as 'Precio unitario', importe
FROM pedidos
ORDER BY importe/cantidad ASC
LIMIT 5;

#9
SELECT *
FROM pedidos
WHERE month(fechapedido) = 03;

#10
SELECT numpedido, importe, nombre, limitecredito
FROM pedidos
INNER JOIN clientes
ON  idcliente = numclie;

#11
SELECT descripcion, precio
FROM productos
INNER JOIN pedidos
ON productos.idfab = pedidos.idfab AND productos.idproducto = pedidos.idproducto
WHERE MONTH(fechapedido) = 02;

#12
SELECT numpedido, importe,idproducto, empleados.nombre as nombre_empleado, clientes.nombre as nombre_cliente
FROM pedidos
INNER JOIN empleados
ON idemp = nuemp
INNER JOIN clientes
ON numclie = idcliente
WHERE importe > 25000;

#13 (distinct para agrupar los nuemp que se repiten)
SELECT distinct nuemp
FROM empleados
INNER JOIN pedidos
ON nuemp = idemp
WHERE importe > 10000 or cuota < 10000;

#13 (GROUP BY para agrupar los nuemp que se repiten)
SELECT nuemp
FROM empleados
INNER JOIN pedidos
ON nuemp = idemp
WHERE importe > 10000 or cuota < 10000
GROUP BY nuemp;

#14
SELECT distinct productos.descripcion, clientes.nombre as cliente, empleados.nombre as empleado, region
FROM empleados
INNER JOIN clientes
ON gestor = nuemp
INNER JOIN pedidos
ON idcliente = numclie
INNER JOIN productos
ON productos.idfab = pedidos.idfab AND productos.idproducto = pedidos.idproducto
INNER JOIN oficinas
ON oficinas.oficina = empleados.oficina
WHERE region = 'norte' or region = 'oeste';

#15.1
SELECT empleados.nombre, pedidos.fechapedido, empleados.contrato
FROM empleados
INNER JOIN pedidos
ON nuemp = idemp
WHERE pedidos.fechapedido = empleados.contrato;

#15.2
SELECT empleados.nombre, pedidos.fechapedido, empleados.contrato
FROM empleados
INNER JOIN pedidos
ON nuemp = idemp
WHERE YEAR(pedidos.fechapedido) = YEAR(empleados.contrato) + 17;

#16
SELECT nombre, DATEDIFF(CURRENT_DATE,contrato) as 'Días trabajados', (YEAR(CURRENT_DATE) - edad) as 'Año de nacimiento'
FROM empleados;

#17
SELECT e1.nombre as 'Nombre de empleado', e1.nuemp, e2.nombre as 'Nombre de jefe', e2.cuota as 'Cuota de jefe'
FROM empleados e1
INNER JOIN empleados e2
ON e1.nuemp = e2.jefe
WHERE e1.cuota >= e2.cuota;

#18
SELECT AVG(cuota) as 'Promedio', AVG(ventas) as 'Ventas'
FROM empleados;

#19
SELECT AVG(importe) as 'Importe medio', SUM(importe) as 'Importe total', AVG((importe / cantidad)) as 'Precio medio'
FROM pedidos;

#20
SELECT AVG(precio) as 'Precio medio'
FROM productos
WHERE idfab = 'aci';

#21
SELECT empleados.nombre, SUM(importe)
FROM pedidos
INNER JOIN empleados
ON  idemp = nuemp
WHERE nombre = 'Vicente Pantalla';

#22
SELECT MIN(fechapedido) as 'Primer pedido'
FROM pedidos;

#23
SELECT COUNT(codigo) as 'Cantidad de pedidos'
FROM pedidos
WHERE importe > 1500;

#24
CREATE TABLE nuevaempleados (
	nuemp int,
    nombre varchar(45),
    edad int,
    contrato date,
    cuota double,
    ventas double,
    oficina int,
    jefe int,
    PRIMARY KEY (nuemp));
    
#25
CREATE TABLE nuevaoficinas (
	oficina int,
    ciudad varchar(45),
    region varchar(45),
    objetivo double,
    ventas double,
    director int,
    PRIMARY KEY (oficina));
    
#26
CREATE TABLE nuevaproductos (
	idproducto varchar(45),
    descripcion varchar(45),
    precio int,
    existencias int,
    idfab varchar(45),
    PRIMARY KEY (idproducto));
    
#27
CREATE TABLE nuevapedidos (
	codigo int,
    numpedido int,
    fechapedido datetime,
    importe int,
    idcliente int,
    idemp int,
    idfab varchar(45),
    cantidad int,
    idproducto varchar(45),
    PRIMARY KEY (codigo));
    
#28
CREATE TABLE nuevaclientes (
	numclie int,
    nombre varchar(45),
    limitecredito varchar(45),
    gestor int,
    PRIMARY KEY (numclie));
    
#Datos


INSERT INTO nuevaclientes (numclie,nombre,gestor,limitecredito) VALUES 
 (2101,'Luis Garcia',102,65000),
 (2102,'Alvaro Rodriguez',101,605000),
 (2103,'Jaime Llorens',105,50000),
 (2105,'Antonio Canales',101,45000),
 (2106,'Juan Suarez',102,65000),
 (2107,'Julian Lopez',110,35000),
 (2108,'Julia Antequera',109,55000),
 (2109,'Alberto Juanes',103,25000),
 (2111,'Cridtobal Garcia',103,50000),
 (2112,'Maria Silva',109,50000),
 (2113,'Luisa Maron',103,20000),
 (2114,'Cristina Marini',102,20000),
 (2115,'Vicente Martinez',101,20000),
 (2117,'Carlos Tena',101,35000),
 (2118,'June Alvarez',105,60000),
 (2119,'Salomon Bueno',109,25000),
 (2120,'Juan Malo',102,50000),
 (2121,'Vicente Rios',103,45000),
 (2122,'Jose Machante',105,30000),
 (2123,'Jose Libros',102,40000),
 (2124, 'Juan Bolto', 107, 40000);

INSERT INTO nuevaproductos (idfab,idproducto,descripcion,precio,existencias) VALUES 
 ('aci','41001','arandela',58.0000,4),
 ('aci','41002','bisagra',80.0000,167),
 ('aci','41003','art t3',112.0000,207),
 ('aci','41004','art t4',123.0000,139),
 ('aci','4100x','junta',26.0000,37),
 ('aci','4100y','extractor',2888.0000,25),
 ('aci','4100z','mont',2625.0000,28),
 ('bic','41003','manivela',652.0000,3),
 ('bic','41089','rodamiento',225.0000,78),
 ('bic','41672','plato',180.0000,0),
 ('fea','112','cubo',148.0000,115),
 ('fea','114','cubo',243.0000,15),
 ('fea','887p', 'tornillo',5.000,32), 
 ('imm','773c','reostato',975.0000,28),
 ('imm','775c','reostato 2',1425.0000,5),
 ('imm','779c','reostato 3',1875.0000,0),
 ('imm','887h','caja clavos',54.0000,223),
 ('imm','887p','perno',25.0000,24),
 ('imm','887x','manivela',475.0000,32),
 ('qsa','xk47','red',355.0000,38),
 ('qsa','xk48','red',134.0000,203),
 ('qsa','xk48a','red',117.0000,37),
 ('rei','2a44g','pas',350.0000,14),
 ('rei','2a44l','bomba l',4500.0000,12),
 ('rei','2a44r','bomba r',4500.0000,12),
 ('rei','2a45c','junta',79.0000,210),
 ('rei','xk48a','cubo',100.0000,125);
 
 INSERT INTO nuevapedidos (codigo,numpedido,fechapedido,idcliente,idemp,idfab,idproducto,cantidad,importe) VALUES 
 (1,110036,'2005-01-02',2107,110,'aci','4100z',9,'22500.0000'),
 (2,110036,'2005-01-02',2117,102,'rei','2a44l',7,'31500.0000'),
 (3,112963,'2005-05-10',2103,105,'aci','41004',28,'3276.0000'),
 (4,112968,'1999-01-11',2102,101,'aci','41004',34,'3978.0000'),
 (5,112975,'2005-02-11',2111,103,'rei','2a44g',6,'2100.0000'),
 (6,112979,'2001-10-12',2114,103,'aci','4100z',6,'15000.0000'),
 (7,112983,'2005-05-10',2103,105,'aci','41004',6,'702.0000'),
 (8,112987,'2005-01-01',2103,105,'aci','4100y',11,'27500.0000'),
 (9,112989,'2005-12-10',2101,101,'fea','114',6,'1458.0000'),
 (10,112992,'1999-04-15',2118,110,'aci','41002',10,'760.0000'),
 (11,112993,'2005-03-10',2106,102,'rei','2a45c',24,'1896.0000'),
 (12,112997,'2005-04-04',2124,107,'bic','41003',1,'652.0000'),
 (13,113003,'2005-02-05',2108,109,'imm','779c',3,'5625.0000'),
 (14,113007,'2005-01-01',2112,102,'imm','773c',3,'2925.0000'),
 (15,113012,'2005-05-05',2111,105,'aci','41003',35,'3745.0000'),
 (16,113013,'2005-08-06',2118,101,'bic','41003',1,'652.0000'),
 (17,113024,'2005-07-04',2114,109,'qsa','xk47',20,'7100.0000'),
 (18,113027,'2005-02-05',2103,105,'aci','41002',54,'4104.0000'),
 (19,113034,'2005-11-05',2107,110,'rei','2a45c',8,'632.0000'),
 (20,113042,'2005-01-01',2113,101,'rei','2a44r',5,'22500.0000'),
 (21,113045,'2005-07-02',2112,109,'rei','2a44r',10,'45000.0000'),
 (22,113048,'2005-02-02',2120,102,'imm','779c',2,'3750.0000'),
 (23,113049,'2005-04-04',2118,107,'qsa','xk47',2,'776.0000'),
 (24,113051,'2005-07-06',2118,101,'qsa','xk47',4,'1420.0000'),
 (25,113055,'1999-04-01',2108,101,'aci','4100x',6,'150.0000'),
 (26,113057,'2005-11-01',2111,103,'aci','4100x',24,'600.0000'),
 (27,113058,'2000-07-04',2108,109,'fea','112',10,'1480.0000'),
 (28,113058,'2005-07-04',2108,109,'fea','112',10,'1480.0000'),
 (29,113062,'2005-07-04',2111,103,'aci','4100x',24,'600.0000'),
 (30,113058,'1999-07-04',2108,109,'fea','112',10,'1480.0000'),
 (31,113062,'2005-07-04',2124,107,'bic','41003',10,'2430.0000'),
 (32,113065,'2005-06-03',2106,102,'qsa','xk47',6,'2130.0000'),
 (33,113069,'2005-08-01',2109,107,'imm','773c',22,'31350.0000');
 
 INSERT INTO nuevaoficinas (oficina, ciudad, region, objetivo, ventas) VALUES 
(11, 'Valencia', 'este', 575000, 693000), 
(12, 'Alicante', 'este', 800000, 735000),
(13, 'Castellón', 'este', 350000, 368000),
(21, 'Badajoz', 'oeste', 725000, 836000),
(22, 'A Coruña', 'oeste', 300000, 186000),
(23, 'Madrid', 'centro', NULL, NULL),
(24, 'Madrid', 'centro', 250000, 150000),
(26, 'Pamplona', 'norte', NULL, NULL),
(28, 'Valencia', 'este', 900000, 0);

INSERT INTO nuevaempleados (nuemp, nombre, edad, contrato, cuota, ventas, oficina) VALUES
(101,'Antonio Viguer', 45, '1986-10-10', 300000, 305000, 12),
(102,'Alvaro Jaumes', 48, '1986-12-10', 350000, 474000, 21),
(103, 'Juan Rovira', 29, '1987-03-01', 275000, 286000, 12),
(104, 'Jose Gonzalez', 33, '1987-05-19', 20000, 143000, 12),
(105, 'Vicente Pantalla', 37, '1988-02-12', 350000, 368000, 13),
(106, 'Luis Antonio', 52, '1988-06-14', 275000, 299000, 11),
(107, 'Jorge Gutierrez', 49, '1988-11-14', 300000, 186000, 22),
(108, 'Ana Bustamante', 62, '1989-10-12', 350000, 361000, 21),
(109, 'Maria Sunta', 31, '1999-10-12', 30000, 392000, 11),
(110, 'Juan Victor', 41, '1990-01-13', 0, 76000, NULL);

ALTER TABLE nuevaproductos
	DROP PRIMARY KEY,
    ADD PRIMARY KEY (idfab, idproducto);

#29
UPDATE nuevaproductos
SET precio = precio + (precio * 0.05)
WHERE idfab = 'aci';

#30
INSERT INTO nuevaoficinas (oficina, ciudad, region, objetivo, ventas, director) VALUES
(30, 'Madrid', 'Centro', 600, NULL, NULL);

#31
UPDATE nuevaempleados
SET oficina = 30
WHERE oficina = 21;

#32
DELETE FROM nuevapedidos
WHERE idemp = 105;

#33
UPDATE nuevaempleados
SET oficina = 21
WHERE oficina = 30;

#34
UPDATE nuevaclientes
SET limitecredito = limitecredito + 100
WHERE nombre like 'J%';

#35
DELETE FROM nuevaproductos
WHERE idfab = 'aci' and existencias < 200;

#36
UPDATE nuevaclientes
SET nombre = 'Jon Bueno',
	limitecredito = limitecredito + limitecredito * 0.01
WHERE numclie = 2120;

#37
ALTER TABLE nuevaclientes
	ADD CONSTRAINT nuevaclientes_nuevaempleados
		FOREIGN KEY (gestor)
        REFERENCES nuevaempleados(nuemp)
        ON DELETE CASCADE
        ON UPDATE SET NULL;
        
#37: comprobaciones
#37.1
SELECT numclie
FROM nuevaclientes
INNER JOIN nuevaempleados
ON gestor = nuemp
WHERE nuemp = 109;

#37.2
DELETE 
FROM nuevaempleados
WHERE nuemp = 109;

#37.3
SELECT numclie
FROM nuevaclientes
INNER JOIN nuevaempleados
ON gestor = nuemp
WHERE nuemp = 109;

#37.4
SELECT numclie
FROM nuevaclientes
INNER JOIN nuevaempleados
ON gestor = nuemp
WHERE nuemp = 101;

#37.5
UPDATE nuevaempleados
SET nuemp = 201
WHERE nuemp = 101;

#37.6
SELECT numclie
FROM nuevaclientes
INNER JOIN nuevaempleados
ON gestor = nuemp
WHERE nuemp = 101;

#No sale nada, porque al actualizar el número de empleado, los datos de sus clientes desaparecieron (ON UPDATE SET NULL)

#38
UPDATE nuevaempleados
SET oficina = 112
WHERE oficina = 12;

#Comprobar qué ha pasado con sus empleados
SELECT nuemp, nombre
FROM nuevaempleados
WHERE oficina = 12;

#Sale NULL, porque se han pasado a la oficina 112