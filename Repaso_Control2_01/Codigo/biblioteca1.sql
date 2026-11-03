-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8 ;
USE `biblioteca` ;

-- -----------------------------------------------------
-- Table `biblioteca`.`editorial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`editorial` (
  `cif` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`cif`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`libros` (
  `isbn` VARCHAR(45) NOT NULL,
  `titulo` VARCHAR(45) NULL,
  `anio` DATE NULL,
  `editorial_cif` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`isbn`),
  INDEX `fk_libros_editorial1_idx` (`editorial_cif` ASC) VISIBLE,
  CONSTRAINT `fk_libros_editorial1`
    FOREIGN KEY (`editorial_cif`)
    REFERENCES `biblioteca`.`editorial` (`cif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`autor` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `nacionalidad` VARCHAR(45) NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`novelas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`novelas` (
  `id_libros` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(45) NULL,
  INDEX `fk_novelas_libros_idx` (`id_libros` ASC) VISIBLE,
  PRIMARY KEY (`id_libros`),
  CONSTRAINT `fk_novelas_libros`
    FOREIGN KEY (`id_libros`)
    REFERENCES `biblioteca`.`libros` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`ensayos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`ensayos` (
  `id_libros` VARCHAR(45) NOT NULL,
  `tema` VARCHAR(45) NULL,
  INDEX `fk_ensayos_libros1_idx` (`id_libros` ASC) VISIBLE,
  PRIMARY KEY (`id_libros`),
  CONSTRAINT `fk_ensayos_libros1`
    FOREIGN KEY (`id_libros`)
    REFERENCES `biblioteca`.`libros` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`autores_libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`autores_libros` (
  `autor_codigo` INT NOT NULL,
  `libros_isbn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`autor_codigo`, `libros_isbn`),
  INDEX `fk_autor_has_libros_libros1_idx` (`libros_isbn` ASC) VISIBLE,
  INDEX `fk_autor_has_libros_autor1_idx` (`autor_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_autor_has_libros_autor1`
    FOREIGN KEY (`autor_codigo`)
    REFERENCES `biblioteca`.`autor` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autor_has_libros_libros1`
    FOREIGN KEY (`libros_isbn`)
    REFERENCES `biblioteca`.`libros` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`ejemplar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`ejemplar` (
  `num` INT NOT NULL,
  `id_libros` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(100) NULL,
  PRIMARY KEY (`num`, `id_libros`),
  INDEX `fk_ejemplar_libros1_idx` (`id_libros` ASC) VISIBLE,
  CONSTRAINT `fk_ejemplar_libros1`
    FOREIGN KEY (`id_libros`)
    REFERENCES `biblioteca`.`libros` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`socios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`socios` (
  `dni` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`prestamos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`prestamos` (
  `socios_dni` VARCHAR(45) NOT NULL,
  `ejemplar_num` INT NOT NULL,
  `ejemplar_id_libros` VARCHAR(45) NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`socios_dni`, `ejemplar_num`, `ejemplar_id_libros`, `fecha`),
  INDEX `fk_socios_has_ejemplar_ejemplar1_idx` (`ejemplar_num` ASC, `ejemplar_id_libros` ASC) VISIBLE,
  INDEX `fk_socios_has_ejemplar_socios1_idx` (`socios_dni` ASC) VISIBLE,
  CONSTRAINT `fk_socios_has_ejemplar_socios1`
    FOREIGN KEY (`socios_dni`)
    REFERENCES `biblioteca`.`socios` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_socios_has_ejemplar_ejemplar1`
    FOREIGN KEY (`ejemplar_num` , `ejemplar_id_libros`)
    REFERENCES `biblioteca`.`ejemplar` (`num` , `id_libros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
