-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema empresa
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `empresa` ;

-- -----------------------------------------------------
-- Schema empresa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `empresa` DEFAULT CHARACTER SET utf8 ;
USE `empresa` ;

-- -----------------------------------------------------
-- Table `empresa`.`oficinas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `empresa`.`oficinas` ;

CREATE TABLE IF NOT EXISTS `empresa`.`oficinas` (
  `oficina` INT NOT NULL,
  `ciudad` VARCHAR(45) NULL,
  `region` VARCHAR(45) NULL,
  `objetivo` DOUBLE NULL,
  `ventas` DOUBLE NULL,
  `director` INT NOT NULL,
  PRIMARY KEY (`oficina`),
  CONSTRAINT `fk_oficinas_empleados`
    FOREIGN KEY (`director`)
    REFERENCES `empresa`.`empleados` (`nuemp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_oficinas_empleados_idx` ON `empresa`.`oficinas` (`director` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `empresa`.`empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `empresa`.`empleados` ;

CREATE TABLE IF NOT EXISTS `empresa`.`empleados` (
  `nuemp` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `edad` INT NULL,
  `contrato` DATE NULL,
  `cuota` DOUBLE NULL,
  `ventas` DOUBLE NULL,
  `oficina` INT NOT NULL,
  `jefe` INT NOT NULL,
  PRIMARY KEY (`nuemp`),
  CONSTRAINT `fk_empleados_oficinas1`
    FOREIGN KEY (`oficina`)
    REFERENCES `empresa`.`oficinas` (`oficina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_empleados1`
    FOREIGN KEY (`jefe`)
    REFERENCES `empresa`.`empleados` (`nuemp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_empleados_oficinas1_idx` ON `empresa`.`empleados` (`oficina` ASC) VISIBLE;

CREATE INDEX `fk_empleados_empleados1_idx` ON `empresa`.`empleados` (`jefe` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
