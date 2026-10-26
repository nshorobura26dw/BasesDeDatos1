-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema reto_borrador1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema reto_borrador1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `reto_borrador1` DEFAULT CHARACTER SET utf8 ;
USE `reto_borrador1` ;

-- -----------------------------------------------------
-- Table `reto_borrador1`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reto_borrador1`.`empleados` (
  `id_empleado` INT NOT NULL,
  `dni` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `fecha_nacimiento` DATE NULL,
  `puesto` ENUM('Mantenimiento', 'Seguridad', 'Caja', 'Crupier') NULL,
  PRIMARY KEY (`id_empleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reto_borrador1`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reto_borrador1`.`clientes` (
  `id_cliente` INT NOT NULL,
  `dni` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `telefono` INT NULL,
  `fecha_nacimiento` DATE NULL,
  `vip` TINYINT NULL,
  `id_experimentado` INT,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_clientes_clientes1_idx` (`id_experimentado` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_clientes1`
    FOREIGN KEY (`id_experimentado`)
    REFERENCES `reto_borrador1`.`clientes` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reto_borrador1`.`juegos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reto_borrador1`.`juegos` (
  `id_juego` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `apuesta_minima` DECIMAL NULL,
  `apuesta_maxima` DECIMAL NULL,
  PRIMARY KEY (`id_juego`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reto_borrador1`.`eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reto_borrador1`.`eventos` (
  `id_evento` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `fecha` DATE NULL,
  `hora_inicio` TIME NULL,
  `capacidad_maxima` INT NULL,
  PRIMARY KEY (`id_evento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reto_borrador1`.`tickets_entrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reto_borrador1`.`tickets_entrada` (
  `num_ticket` INT NOT NULL,
  `id_evento` INT NOT NULL,
  `precio` DECIMAL NULL,
  `fecha_compra` DATE NULL,
  PRIMARY KEY (`id_evento`, `num_ticket`),
  CONSTRAINT `fk_tickets_entrada_eventos1`
    FOREIGN KEY (`id_evento`)
    REFERENCES `reto_borrador1`.`eventos` (`id_evento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reto_borrador1`.`crupiers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reto_borrador1`.`crupiers` (
  `id_empleado` INT NOT NULL,
  `licencia_mesa` VARCHAR(45) NULL,
  `idiomas` SET('Euskera', 'Castellano', 'Ingles', 'Frances') NULL,
  PRIMARY KEY (`id_empleado`),
  CONSTRAINT `fk_crupiers_empleados`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `reto_borrador1`.`empleados` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reto_borrador1`.`apuestas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reto_borrador1`.`apuestas` (
  `id_cliente` INT NOT NULL,
  `id_juego` INT NOT NULL,
  `fecha_hora` DATETIME(6) NOT NULL,
  `id_crupier` INT NOT NULL,
  `monto` DECIMAL NULL,
  `ganancia` DECIMAL NULL,
  PRIMARY KEY (`id_cliente`, `id_juego`, `fecha_hora`),
  INDEX `fk_clientes_has_juegos_juegos1_idx` (`id_juego` ASC) VISIBLE,
  INDEX `fk_clientes_has_juegos_clientes1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_apuestas_crupiers1_idx` (`id_crupier` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_has_juegos_clientes1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `reto_borrador1`.`clientes` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_has_juegos_juegos1`
    FOREIGN KEY (`id_juego`)
    REFERENCES `reto_borrador1`.`juegos` (`id_juego`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_apuestas_crupiers1`
    FOREIGN KEY (`id_crupier`)
    REFERENCES `reto_borrador1`.`crupiers` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reto_borrador1`.`inscripciones_eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reto_borrador1`.`inscripciones_eventos` (
  `id_cliente` INT NOT NULL,
  `id_evento` INT NOT NULL,
  `asistido` TINYINT NULL,
  PRIMARY KEY (`id_cliente`, `id_evento`),
  INDEX `fk_clientes_has_eventos_eventos1_idx` (`id_evento` ASC) VISIBLE,
  INDEX `fk_clientes_has_eventos_clientes1_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_has_eventos_clientes1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `reto_borrador1`.`clientes` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_has_eventos_eventos1`
    FOREIGN KEY (`id_evento`)
    REFERENCES `reto_borrador1`.`eventos` (`id_evento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
