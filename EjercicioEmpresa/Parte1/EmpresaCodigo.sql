INSERT INTO oficinas (oficina, ciudad, region, objetivo, ventas) VALUES 
(11, 'Valencia', 'este', 575000, 693000), 
(12, 'Alicante', 'este', 800000, 735000),
(13, 'Castellón', 'este', 350000, 368000),
(21, 'Badajoz', 'oeste', 725000, 836000),
(22, 'A Coruña', 'oeste', 300000, 186000),
(23, 'Madrid', 'centro', NULL, NULL),
(24, 'Madrid', 'centro', 250000, 150000),
(26, 'Pamplona', 'norte', NULL, NULL),
(28, 'Valencia', 'este', 900000, 0);

INSERT INTO empleados (nuemp, nombre, edad, contrato, cuota, ventas, oficina) VALUES
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

UPDATE oficinas
SET director = 106
WHERE oficina = 11;

UPDATE oficinas
SET director = 104
WHERE oficina = 12;

UPDATE oficinas
SET director = 104
WHERE oficina = 13;

UPDATE oficinas
SET director = 108
WHERE oficina = 21;

UPDATE oficinas
SET director = 108
WHERE oficina = 22;

UPDATE oficinas
SET director = 108
WHERE oficina = 23;

UPDATE oficinas
SET director = 108
WHERE oficina = 24;

UPDATE oficinas
SET director = NULL
WHERE oficina = 26;

UPDATE oficinas
SET director = NULL
WHERE oficina = 28;

UPDATE empleados
SET oficina = 12, jefe = 104
WHERE nuemp = 101;

UPDATE empleados
SET oficina = 21, jefe = 108
WHERE nuemp = 102;

UPDATE empleados
SET oficina = 12, jefe = 104
WHERE nuemp = 103;

UPDATE empleados
SET oficina = 12, jefe = 106
WHERE nuemp = 104;

UPDATE empleados
SET oficina = 13, jefe = 104
WHERE nuemp = 105;

UPDATE empleados
SET oficina = 11, jefe = NULL
WHERE nuemp = 106;

UPDATE empleados
SET oficina = 22, jefe = 108
WHERE nuemp = 107;

UPDATE empleados
SET oficina = 21, jefe = 106
WHERE nuemp = 108;

UPDATE empleados
SET oficina = 11, jefe = 106
WHERE nuemp = 109;

UPDATE empleados
SET oficina = NULL, jefe = 104
WHERE nuemp = 110;

SELECT *
FROM empleados
WHERE nombre like 'Jose%';

SELECT *
FROM empleados
WHERE nombre like 'J%';

SELECT *
FROM oficinas
WHERE region = 'este' or region = 'norte';

SELECT *
FROM oficinas
ORDER BY region ASC, ciudad ASC, oficina DESC;

SELECT oficina, ciudad, region
FROM oficinas
WHERE region = 'este' or region = 'norte'
ORDER BY region DESC;

SELECT nuemp
FROM empleados
WHERE oficina > 0;

SELECT oficina
FROM oficinas
WHERE director IS NULL;

SELECT nombre, edad, region
FROM empleados e INNER JOIN 
oficinas o ON e.oficina = o.oficina;

SELECT nombre, e.oficina, objetivo
FROM empleados e INNER JOIN oficinas o 
ON e.nuemp = o.director
WHERE objetivo >= 300000 and objetivo <= 600000;

#10
SELECT ciudad, nuemp, nombre
FROM empleados e INNER JOIN
oficinas o ON e.oficina = o.oficina
WHERE region = 'este' or 'oeste';

#10.1
SELECT oficinas.oficina, ciudad, nombre, nuemp
FROM oficinas
INNER JOIN empleados
ON oficinas.oficina = empleados.oficina
WHERE region in ('este', 'oeste');

#10.2
SELECT e.oficina, ciudad, nombre, nuemp
FROM empleados e
LEFT JOIN oficinas o
ON e.oficina = o.oficina
WHERE region = 'este' or region = 'oeste';

#10.3
SELECT e.oficina, ciudad, nombre, nuemp
FROM empleados e INNER JOIN oficinas o
ON e.nuemp = o.director
WHERE region in ('este', 'oeste');

#10.4
SELECT e.oficina, ciudad, nombre, nuemp, region
FROM empleados e RIGHT JOIN oficinas o
ON e.nuemp = o.director
WHERE region IN ('este', 'oeste') and director IS NULL;

#11
SELECT nombre, DATEDIFF(CURRENT_DATE, contrato) AS 'Dias trabajando', YEAR(CURRENT_DATE) - edad AS 'Año de nacimiento'
FROM empleados;

SELECT nombre, contrato
FROM empleados
WHERE edad > 50;

SELECT nombre, edad
FROM empleados
WHERE oficina = 12
ORDER BY edad ASC;

SELECT *
FROM empleados
WHERE cuota >= 350000 and ventas <= 500000;

SELECT *
FROM empleados
WHERE ventas >= cuota;

SELECT ciudad
FROM oficinas
WHERE region = 'este' and objetivo > 500000;

SELECT oficina, ciudad, ventas
FROM oficinas
WHERE ciudad != 'Madrid' and ciudad <> 'Valencia';