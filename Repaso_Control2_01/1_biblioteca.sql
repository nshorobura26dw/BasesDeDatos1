-- =====================================================================
-- Ejercicio 1: La biblioteca
-- Modelo relacional + datos de ejemplo (MySQL 8)
-- Ejecución: mysql -u usuario -p < 1_biblioteca.sql
-- =====================================================================

DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE biblioteca CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE biblioteca;

-- ---------------------------------------------------------------------
-- Tablas
-- ---------------------------------------------------------------------

CREATE TABLE Editorial (
    CIF     VARCHAR(9)   NOT NULL,
    nombre  VARCHAR(60)  NOT NULL,
    PRIMARY KEY (CIF)
) ENGINE = InnoDB;

CREATE TABLE Libro (
    ISBN             VARCHAR(17)  NOT NULL,
    titulo           VARCHAR(120) NOT NULL,
    anioPublicacion  INT,
    CIF              VARCHAR(9)   NOT NULL,
    PRIMARY KEY (ISBN),
    FOREIGN KEY (CIF) REFERENCES Editorial (CIF)
) ENGINE = InnoDB;

-- Jerarquía parcial y disjunta de Libro: novela, ensayo o ninguno de los dos.
-- Cada subtipo tiene como clave primaria (y ajena) el ISBN del supertipo.
CREATE TABLE Novela (
    ISBN    VARCHAR(17) NOT NULL,
    genero  VARCHAR(30) NOT NULL,
    PRIMARY KEY (ISBN),
    FOREIGN KEY (ISBN) REFERENCES Libro (ISBN)
) ENGINE = InnoDB;

CREATE TABLE Ensayo (
    ISBN  VARCHAR(17) NOT NULL,
    tema  VARCHAR(40) NOT NULL,
    PRIMARY KEY (ISBN),
    FOREIGN KEY (ISBN) REFERENCES Libro (ISBN)
) ENGINE = InnoDB;

CREATE TABLE Autor (
    codAutor      INT          NOT NULL,
    nombre        VARCHAR(60)  NOT NULL,
    nacionalidad  VARCHAR(40),
    PRIMARY KEY (codAutor)
) ENGINE = InnoDB;

-- Relación N:M entre Libro y Autor
CREATE TABLE Escribe (
    ISBN      VARCHAR(17) NOT NULL,
    codAutor  INT         NOT NULL,
    PRIMARY KEY (ISBN, codAutor),
    FOREIGN KEY (ISBN)     REFERENCES Libro (ISBN),
    FOREIGN KEY (codAutor) REFERENCES Autor (codAutor)
) ENGINE = InnoDB;

-- Entidad débil: su clave incluye el ISBN del libro
CREATE TABLE Ejemplar (
    ISBN         VARCHAR(17) NOT NULL,
    numEjemplar  INT         NOT NULL,
    estado       VARCHAR(20) NOT NULL,
    PRIMARY KEY (ISBN, numEjemplar),
    FOREIGN KEY (ISBN) REFERENCES Libro (ISBN)
) ENGINE = InnoDB;

CREATE TABLE Socio (
    DNI     VARCHAR(9)  NOT NULL,
    nombre  VARCHAR(60) NOT NULL,
    PRIMARY KEY (DNI)
) ENGINE = InnoDB;

-- Relación N:M entre Socio y Ejemplar, con fechas
CREATE TABLE Prestamo (
    DNI               VARCHAR(9)  NOT NULL,
    ISBN              VARCHAR(17) NOT NULL,
    numEjemplar       INT         NOT NULL,
    fechaPrestamo     DATE        NOT NULL,
    fechaDevolucion   DATE,
    PRIMARY KEY (DNI, ISBN, numEjemplar, fechaPrestamo),
    FOREIGN KEY (DNI) REFERENCES Socio (DNI),
    FOREIGN KEY (ISBN, numEjemplar) REFERENCES Ejemplar (ISBN, numEjemplar)
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- Datos de ejemplo
-- ---------------------------------------------------------------------

INSERT INTO Editorial (CIF, nombre) VALUES
    ('A28000001', 'Planeta'),
    ('A28000002', 'Alianza Editorial'),
    ('B20000003', 'Erein'),
    ('A08000004', 'Anagrama');

INSERT INTO Libro (ISBN, titulo, anioPublicacion, CIF) VALUES
    ('978-84-376-0494-7', 'Cien años de soledad',        1967, 'A28000001'),
    ('978-84-204-1234-5', 'La sombra del viento',        2001, 'A28000001'),
    ('978-84-204-2345-6', 'El juego del ángel',          2008, 'A28000001'),
    ('978-84-206-3456-7', 'Don Quijote de la Mancha',    1605, 'A28000002'),
    ('978-84-206-4567-8', 'La Regenta',                  1885, 'A28000002'),
    ('978-84-206-5678-9', 'Niebla',                      1914, 'A28000002'),
    ('978-84-914-6789-0', 'Obabakoak',                   1988, 'B20000003'),
    ('978-84-914-7890-1', 'Soinujolearen semea',         2003, 'B20000003'),
    ('978-84-339-8901-2', 'Los detectives salvajes',     1998, 'A08000004'),
    ('978-84-206-9012-3', 'La rebelión de las masas',      1930, 'A28000002'),
    ('978-84-206-0123-4', 'Del sentimiento trágico de la vida', 1913, 'A28000002'),
    ('978-84-339-1234-6', 'Bodas de sangre',               1933, 'A08000004');

-- Jerarquía: un libro está como mucho en uno de los dos subtipos.
-- Obabakoak (relatos) y Bodas de sangre (teatro) no son ni novela ni ensayo.
INSERT INTO Novela (ISBN, genero) VALUES
    ('978-84-376-0494-7', 'Realismo mágico'),
    ('978-84-204-1234-5', 'Misterio'),
    ('978-84-204-2345-6', 'Misterio'),
    ('978-84-206-3456-7', 'Aventuras'),
    ('978-84-206-4567-8', 'Realista'),
    ('978-84-206-5678-9', 'Filosófica'),
    ('978-84-914-7890-1', 'Histórica'),
    ('978-84-339-8901-2', 'Contemporánea');

INSERT INTO Ensayo (ISBN, tema) VALUES
    ('978-84-206-9012-3', 'Sociología'),
    ('978-84-206-0123-4', 'Filosofía');

INSERT INTO Autor (codAutor, nombre, nacionalidad) VALUES
    (1, 'Gabriel García Márquez', 'Colombiana'),
    (2, 'Carlos Ruiz Zafón',      'Española'),
    (3, 'Miguel de Cervantes',    'Española'),
    (4, 'Leopoldo Alas Clarín',   'Española'),
    (5, 'Miguel de Unamuno',      'Española'),
    (6, 'Bernardo Atxaga',        'Española'),
    (7, 'Roberto Bolaño',         'Chilena'),
    (8, 'Aintzane Etxeberria',    'Española'),
    (9, 'José Ortega y Gasset',   'Española'),
    (10, 'Federico García Lorca', 'Española');

INSERT INTO Escribe (ISBN, codAutor) VALUES
    ('978-84-376-0494-7', 1),
    ('978-84-204-1234-5', 2),
    ('978-84-204-2345-6', 2),
    ('978-84-206-3456-7', 3),
    ('978-84-206-4567-8', 4),
    ('978-84-206-5678-9', 5),
    ('978-84-914-6789-0', 6),
    ('978-84-914-6789-0', 8),   -- libro con dos autores
    ('978-84-914-7890-1', 6),
    ('978-84-339-8901-2', 7),
    ('978-84-206-9012-3', 9),
    ('978-84-206-0123-4', 5),
    ('978-84-339-1234-6', 10);

INSERT INTO Ejemplar (ISBN, numEjemplar, estado) VALUES
    ('978-84-376-0494-7', 1, 'Bueno'),
    ('978-84-376-0494-7', 2, 'Regular'),
    ('978-84-376-0494-7', 3, 'Bueno'),
    ('978-84-204-1234-5', 1, 'Bueno'),
    ('978-84-204-1234-5', 2, 'Bueno'),
    ('978-84-204-2345-6', 1, 'Regular'),
    ('978-84-206-3456-7', 1, 'Bueno'),
    ('978-84-206-3456-7', 2, 'Deteriorado'),
    ('978-84-206-4567-8', 1, 'Bueno'),
    ('978-84-206-4567-8', 2, 'Bueno'),
    ('978-84-206-5678-9', 1, 'Regular'),
    ('978-84-914-6789-0', 1, 'Bueno'),
    ('978-84-914-7890-1', 1, 'Bueno'),
    ('978-84-339-8901-2', 1, 'Regular'),
    ('978-84-206-9012-3', 1, 'Bueno'),
    ('978-84-206-0123-4', 1, 'Regular'),
    ('978-84-339-1234-6', 1, 'Bueno');

INSERT INTO Socio (DNI, nombre) VALUES
    ('11111111A', 'Mikel Goikoetxea'),
    ('22222222B', 'Leire Aranburu'),
    ('33333333C', 'Iker Etxeberria'),
    ('44444444D', 'Nerea Zubiaurre'),
    ('55555555E', 'Jon Ugarte');

-- fechaDevolucion NULL = préstamo todavía sin devolver
INSERT INTO Prestamo (DNI, ISBN, numEjemplar, fechaPrestamo, fechaDevolucion) VALUES
    ('11111111A', '978-84-376-0494-7', 1, '2019-03-04', '2019-03-25'),
    ('11111111A', '978-84-376-0494-7', 1, '2024-05-10', '2024-05-30'),
    ('22222222B', '978-84-204-1234-5', 1, '2019-11-02', '2019-11-20'),
    ('22222222B', '978-84-206-3456-7', 1, '2025-09-15', NULL),
    ('33333333C', '978-84-914-6789-0', 1, '2026-10-01', NULL),
    ('44444444D', '978-84-206-4567-8', 2, '2023-02-14', '2023-03-01'),
    ('44444444D', '978-84-204-2345-6', 1, '2018-06-20', '2018-07-10');
