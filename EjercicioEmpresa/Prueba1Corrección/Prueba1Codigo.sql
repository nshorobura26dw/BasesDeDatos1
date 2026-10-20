-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema taller_informatico2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema taller_informatico2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `taller_informatico2` DEFAULT CHARACTER SET utf8 ;
USE `taller_informatico2` ;

-- -----------------------------------------------------
-- Table `taller_informatico2`.`equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller_informatico2`.`equipos` (
  `id_equipo` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(200) NULL,
  PRIMARY KEY (`id_equipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller_informatico2`.`sistemas_operativos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller_informatico2`.`sistemas_operativos` (
  `id_so` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `version` VARCHAR(45) NULL,
  `arquitectura` VARCHAR(45) NULL,
  PRIMARY KEY (`id_so`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller_informatico2`.`ordenadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller_informatico2`.`ordenadores` (
  `id_ordenador` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `fecha_montaje` DATE NULL,
  `estado` VARCHAR(45) NULL,
  `precio_total` DECIMAL(10) NULL,
  `id_equipo` INT NOT NULL,
  `cluster` INT NOT NULL,
  `id_so` INT NOT NULL,
  PRIMARY KEY (`id_ordenador`),
  INDEX `fk_ordenadores_equipos1_idx` (`id_equipo` ASC) VISIBLE,
  INDEX `fk_ordenadores_ordenadores1_idx` (`cluster` ASC) VISIBLE,
  INDEX `fk_ordenadores_sistemas_operativos1_idx` (`id_so` ASC) VISIBLE,
  CONSTRAINT `fk_ordenadores_equipos1`
    FOREIGN KEY (`id_equipo`)
    REFERENCES `taller_informatico2`.`equipos` (`id_equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordenadores_ordenadores1`
    FOREIGN KEY (`cluster`)
    REFERENCES `taller_informatico2`.`ordenadores` (`id_ordenador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordenadores_sistemas_operativos1`
    FOREIGN KEY (`id_so`)
    REFERENCES `taller_informatico2`.`sistemas_operativos` (`id_so`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller_informatico2`.`caracteristicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller_informatico2`.`caracteristicas` (
  `caracteristica` VARCHAR(45) NOT NULL,
  `id_ordenador` INT NOT NULL,
  PRIMARY KEY (`caracteristica`, `id_ordenador`),
  INDEX `fk_caracteristicas_ordenadores_idx` (`id_ordenador` ASC) VISIBLE,
  CONSTRAINT `fk_caracteristicas_ordenadores`
    FOREIGN KEY (`id_ordenador`)
    REFERENCES `taller_informatico2`.`ordenadores` (`id_ordenador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller_informatico2`.`componentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller_informatico2`.`componentes` (
  `id_componentes` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `tipo` VARCHAR(45) NULL,
  `fabricante` VARCHAR(45) NULL,
  `modelo` VARCHAR(45) NULL,
  `precio` INT NULL,
  `id_ordenador` INT NOT NULL,
  PRIMARY KEY (`id_componentes`, `id_ordenador`),
  INDEX `fk_componentes_ordenadores1_idx` (`id_ordenador` ASC) VISIBLE,
  CONSTRAINT `fk_componentes_ordenadores1`
    FOREIGN KEY (`id_ordenador`)
    REFERENCES `taller_informatico2`.`ordenadores` (`id_ordenador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
