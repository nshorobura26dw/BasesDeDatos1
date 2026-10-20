USE cluburumea;

INSERT INTO secciones (codigo, nombre, cuotamensual) VALUES
(1, 'Fútbol',     35.00),
(2, 'Baloncesto', 30.00);

INSERT INTO entrenador (dni, nombre, apellidos, titulacion, telefono) VALUES
('12345678A', 'Iker',  'Etxeberria Goñi',  'Nivel 2 UEFA',            '600111222'),
('23456789B', 'Maite', 'Larrañaga Ruiz',   'Entrenadora Superior FEB', '600333444'),
('34567890C', 'Jon',   'Aranburu Sagarna', 'Nivel 1 UEFA',            '600555666');

INSERT INTO equipos (id_equipo, categoria, temporada, secciones_codigo, entrenador_dni) VALUES
(1, 'Juvenil', '2026-2027', 1, '12345678A'),
(2, 'Cadete',  '2026-2027', 1, '12345678A'),
(3, 'Senior',  '2026-2027', 2, '23456789B'),
(4, 'Infantil','2026-2027', 2, '34567890C');


INSERT INTO jugador (num_ficha, dni, nombre, apellidos, fechanacimiento, telefono, equipos_codigo, id_tutor) VALUES
(1, '45000001D', 'Ander',  'Mendizabal Arrieta', '2007-03-14', '611000001', 1, NULL),
(2, '45000002E', 'Leire',  'Urrutia Etxabe',     '2002-07-22', '611000002', 3, NULL),
(3, '45000003F', 'Gorka',  'Zubiaurre Lasa',     '2001-11-05', '611000003', 3, NULL);

INSERT INTO jugadores (num_ficha, dni, nombre, apellidos, fechanacimiento, telefono, equipos_codigo, id_tutor) VALUES
(4, '45000004G', 'Naiara', 'Olaizola Berasategi', '2009-01-30', '611000004', 2, 1),
(5, '45000005H', 'Xabier', 'Iturbe Gaztelumendi', '2010-09-12', NULL,        4, 2),
(6, '45000006J', 'Amaia',  'Elizondo Prieto',     '2009-05-18', '611000006', 2, 1);

INSERT INTO jugador (num_ficha, dni, nombre, apellidos, fechanacimiento, telefono, equipos_codigo, id_tutor) VALUES
(7, '45000007K', 'Unai',   'Garmendia Sorondo',   '2012-02-08', NULL, 2, 4),
(8, '45000008L', 'Irati',  'Aizpurua Lekuona',    '2012-10-25', NULL, 4, 5);

INSERT INTO partido (id_equipo, num_partido, fecha, rival, resultado, en_casa) VALUES
(1, 1, '2026-09-20', 'Antiguoko KE',   '2-1',  TRUE),
(1, 2, '2026-09-27', 'Real Unión',     '0-0',  FALSE),
(1, 3, '2026-10-04', 'Beasain KE',     NULL,   TRUE),
(2, 1, '2026-09-21', 'Ostadar SKT',    '3-2',  FALSE),
(3, 1, '2026-09-26', 'Gipuzkoa Basket','68-72',TRUE),
(3, 2, '2026-10-03', 'Easo Saskibaloia', NULL, FALSE);