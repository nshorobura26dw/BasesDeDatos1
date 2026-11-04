-- =====================================================================
-- Ejercicio 2: La red social
-- Modelo relacional + datos de ejemplo (MySQL 8)
-- Ejecución: mysql -u usuario -p < 2_redsocial.sql
-- =====================================================================

DROP DATABASE IF EXISTS redsocial;
CREATE DATABASE redsocial CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE redsocial;

-- ---------------------------------------------------------------------
-- Tablas
-- ---------------------------------------------------------------------

-- ubicación (atributo compuesto) = ciudad + pais
-- idUsuarioInvita: relación reflexiva 1:N (NULL si nadie lo invitó)
CREATE TABLE Usuario (
    idUsuario        INT          NOT NULL,
    alias            VARCHAR(30)  NOT NULL,
    ciudad           VARCHAR(50),
    pais             VARCHAR(50),
    idUsuarioInvita  INT,
    PRIMARY KEY (idUsuario),
    FOREIGN KEY (idUsuarioInvita) REFERENCES Usuario (idUsuario)
) ENGINE = InnoDB;

-- Jerarquía parcial y solapada de Usuario: creador de contenido, moderador,
-- las dos cosas a la vez o ninguna. Cada subtipo tiene como clave primaria
-- (y ajena) el idUsuario del supertipo.
CREATE TABLE Creador (
    idUsuario  INT         NOT NULL,
    categoria  VARCHAR(30) NOT NULL,
    PRIMARY KEY (idUsuario),
    FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario)
) ENGINE = InnoDB;

CREATE TABLE Moderador (
    idUsuario  INT      NOT NULL,
    nivel      TINYINT  NOT NULL,
    PRIMARY KEY (idUsuario),
    FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario)
) ENGINE = InnoDB;

-- Atributo multivalor: intereses
CREATE TABLE InteresUsuario (
    idUsuario  INT         NOT NULL,
    interes    VARCHAR(40) NOT NULL,
    PRIMARY KEY (idUsuario, interes),
    FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario)
) ENGINE = InnoDB;

-- Relación 1:N con Usuario
CREATE TABLE Publicacion (
    idPublicacion    INT           NOT NULL,
    texto            VARCHAR(280)  NOT NULL,
    fechaPublicacion DATE          NOT NULL,
    numMeGusta       INT           NOT NULL DEFAULT 0,
    idUsuario        INT           NOT NULL,
    PRIMARY KEY (idPublicacion),
    FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario)
) ENGINE = InnoDB;

CREATE TABLE Grupo (
    idGrupo  INT         NOT NULL,
    nombre   VARCHAR(60) NOT NULL,
    PRIMARY KEY (idGrupo)
) ENGINE = InnoDB;

-- Relación N:M entre Usuario y Grupo, con fecha de alta
CREATE TABLE Pertenece (
    idUsuario  INT  NOT NULL,
    idGrupo    INT  NOT NULL,
    fechaAlta  DATE NOT NULL,
    PRIMARY KEY (idUsuario, idGrupo),
    FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario),
    FOREIGN KEY (idGrupo)   REFERENCES Grupo (idGrupo)
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- Datos de ejemplo
-- ---------------------------------------------------------------------

-- Cada usuario se inserta después del que lo invitó
INSERT INTO Usuario (idUsuario, alias, ciudad, pais, idUsuarioInvita) VALUES
    (1,  'ane_donosti',   'San Sebastián',   'España',   NULL),
    (2,  'mikel_bilbo',   'Bilbao',          'España',   1),
    (3,  'leire_g',       'San Sebastián',   'España',   1),
    (4,  'iker_vitoria',  'Vitoria-Gasteiz', 'España',   2),
    (5,  'nerea_foto',    'Pamplona',        'España',   2),
    (6,  'jon_code',      'San Sebastián',   'España',   3),
    (7,  'amaia_trips',   'Madrid',          'España',   1),
    (8,  'unai_pelota',   'Bilbao',          'España',   4),
    (9,  'itziar_music',  'Barcelona',       'España',   5),
    (10, 'gorka_bread',   'Vitoria-Gasteiz', 'España',   6),
    (11, 'maite_bike',    'Pamplona',        'España',   7),
    (12, 'xabi_lectura',  'Bayona',          'Francia',  8),
    (13, 'oihana_viajes', 'Lisboa',          'Portugal', 1),
    (14, 'peio_txalapar', 'Bilbao',          'España',   9),
    (15, 'nuevo_usuario', 'Donostia',        'España',   10);

-- Jerarquía solapada: el usuario 5 es creador y moderador a la vez.
-- El resto de usuarios (4, 6, 8, 9, 10...) no es ni creador ni moderador.
INSERT INTO Creador (idUsuario, categoria) VALUES
    (1, 'Cocina'),
    (5, 'Fotografía'),
    (7, 'Viajes');

INSERT INTO Moderador (idUsuario, nivel) VALUES
    (2, 2),
    (3, 1),
    (5, 3);

-- Los usuarios 12, 13, 14 y 15 no tienen ningún interés
INSERT INTO InteresUsuario (idUsuario, interes) VALUES
    (1, 'Música'),
    (1, 'Cocina'),
    (1, 'Fotografía'),
    (2, 'Tecnología'),
    (2, 'Montaña'),
    (3, 'Música'),
    (3, 'Cine'),
    (4, 'Cine'),
    (5, 'Fotografía'),
    (5, 'Viajes'),
    (6, 'Tecnología'),
    (7, 'Viajes'),
    (8, 'Deporte'),
    (9, 'Música'),
    (9, 'Deporte'),
    (10, 'Cocina'),
    (11, 'Montaña'),
    (11, 'Deporte');

INSERT INTO Publicacion (idPublicacion, texto, fechaPublicacion, numMeGusta, idUsuario) VALUES
    (1,  'Primer día en la red, ¡hola a todos!',        '2018-05-01',   0, 1),
    (2,  'Foto de la playa de la Concha al amanecer',   '2024-07-14', 230, 1),
    (3,  'Receta de pintxos para el fin de semana',     '2025-01-20', 180, 1),
    (4,  '¿Alguien conoce un buen curso de SQL?',       '2023-03-03',  45, 2),
    (5,  'Mi última ruta por los Pirineos',             '2025-08-17', 130, 2),
    (6,  'Concierto de anoche, increíble',              '2019-09-09',   0, 3),
    (7,  'Nuevo álbum favorito del año',                '2026-02-11',  95, 3),
    (8,  'Desde Bilbao, buenos días',                   '2019-12-31',   0, 4),
    (9,  'Maratón de series este fin de semana',        '2024-11-23',  60, 4),
    (10, 'Probando la cámara nueva',                    '2022-04-18', 310, 5),
    (11, 'Atardecer en Vitoria-Gasteiz',                '2025-05-05', 275, 5),
    (12, 'Clase de programación hoy',                   '2026-09-30',  40, 6),
    (13, 'Mi viaje a Lisboa en tres fotos',             '2021-06-12', 150, 7),
    (14, 'Sin novedades por aquí',                      '2019-01-15',   0, 8),
    (15, 'Torneo de pelota vasca este sábado',          '2023-10-07',  88, 9),
    (16, 'Aprendiendo a hacer pan de masa madre',       '2024-02-02', 120, 10),
    (17, 'Ruta en bici por Navarra',                    '2020-03-01',  15, 11),
    (18, 'Hola, soy nuevo',                             '2026-10-20',  12, 15);

INSERT INTO Grupo (idGrupo, nombre) VALUES
    (1, 'Fotografía'),
    (2, 'Montaña y senderismo'),
    (3, 'Cocina vasca'),
    (4, 'Programación'),
    (5, 'Música en directo');

INSERT INTO Pertenece (idUsuario, idGrupo, fechaAlta) VALUES
    (1, 1, '2018-06-01'),
    (1, 3, '2019-02-15'),
    (2, 2, '2022-09-10'),
    (2, 4, '2023-01-20'),
    (3, 5, '2019-10-05'),
    (3, 4, '2024-03-12'),
    (5, 1, '2021-11-30'),
    (5, 2, '2022-05-08'),
    (6, 4, '2023-09-01'),
    (7, 2, '2021-07-14'),
    (9, 5, '2020-01-18'),
    (10, 3, '2024-01-25'),
    (11, 2, '2020-04-02'),
    (4, 4, '2024-10-10');
