-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`secciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`secciones` ;

CREATE TABLE IF NOT EXISTS `mydb`.`secciones` (
  `id_secciones` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `cuota_mensual` DECIMAL(45) NULL,
  PRIMARY KEY (`id_secciones`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`entrenador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`entrenador` ;

CREATE TABLE IF NOT EXISTS `mydb`.`entrenador` (
  `dni` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `titulacion` VARCHAR(45) NULL,
  `telefono` INT NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`equipos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`equipos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`equipos` (
  `codigo` INT NOT NULL,
  `categoria` VARCHAR(45) NULL,
  `temporada` VARCHAR(45) NULL,
  `id_secciones` INT NOT NULL,
  `entrenador_dni` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_equipos_secciones_idx` (`id_secciones` ASC) VISIBLE,
  INDEX `fk_equipos_entrenador1_idx` (`entrenador_dni` ASC) VISIBLE,
  CONSTRAINT `fk_equipos_secciones`
    FOREIGN KEY (`id_secciones`)
    REFERENCES `mydb`.`secciones` (`id_secciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipos_entrenador1`
    FOREIGN KEY (`entrenador_dni`)
    REFERENCES `mydb`.`entrenador` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`jugadores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`jugadores` ;

CREATE TABLE IF NOT EXISTS `mydb`.`jugadores` (
  `num_ficha` INT NOT NULL,
  `dni` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `fecha_nacimiento` DATE NULL,
  `telefono` INT NULL,
  `equipos_codigo` INT NOT NULL,
  `id_tutor` INT NOT NULL,
  PRIMARY KEY (`num_ficha`),
  INDEX `fk_jugadores_equipos1_idx` (`equipos_codigo` ASC) VISIBLE,
  INDEX `fk_jugadores_jugadores1_idx` (`id_tutor` ASC) VISIBLE,
  CONSTRAINT `fk_jugadores_equipos1`
    FOREIGN KEY (`equipos_codigo`)
    REFERENCES `mydb`.`equipos` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jugadores_jugadores1`
    FOREIGN KEY (`id_tutor`)
    REFERENCES `mydb`.`jugadores` (`num_ficha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`partidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`partidos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`partidos` (
  `num_partido` INT NOT NULL,
  `fecha` DATE NULL,
  `rival` VARCHAR(45) NULL,
  `resultado` VARCHAR(45) NULL,
  `en_casa` TINYINT NULL,
  `equipos_codigo` INT NOT NULL,
  PRIMARY KEY (`num_partido`, `equipos_codigo`),
  INDEX `fk_partidos_equipos1_idx` (`equipos_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_partidos_equipos1`
    FOREIGN KEY (`equipos_codigo`)
    REFERENCES `mydb`.`equipos` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
