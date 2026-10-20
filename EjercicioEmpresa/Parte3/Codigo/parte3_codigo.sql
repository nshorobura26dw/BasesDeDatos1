-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema empresa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema empresa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `empresa` DEFAULT CHARACTER SET utf8mb3 ;
USE `empresa` ;

-- -----------------------------------------------------
-- Table `empresa`.`oficinas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`oficinas` (
  `oficina` INT NOT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `region` VARCHAR(45) NULL DEFAULT NULL,
  `objetivo` DOUBLE NULL DEFAULT NULL,
  `ventas` DOUBLE NULL DEFAULT NULL,
  `director` INT NULL DEFAULT NULL,
  PRIMARY KEY (`oficina`),
  INDEX `fk_oficinas_empleados_idx` (`director` ASC) VISIBLE,
  CONSTRAINT `fk_oficinas_empleados`
    FOREIGN KEY (`director`)
    REFERENCES `empresa`.`empleados` (`nuemp`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`empleados` (
  `nuemp` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `edad` INT NULL DEFAULT NULL,
  `contrato` DATE NULL DEFAULT NULL,
  `cuota` DOUBLE NULL DEFAULT NULL,
  `ventas` DOUBLE NULL DEFAULT NULL,
  `oficina` INT NULL DEFAULT NULL,
  `jefe` INT NULL DEFAULT NULL,
  PRIMARY KEY (`nuemp`),
  INDEX `fk_empleados_oficinas1_idx` (`oficina` ASC) VISIBLE,
  INDEX `fk_empleados_empleados1_idx` (`jefe` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_empleados1`
    FOREIGN KEY (`jefe`)
    REFERENCES `empresa`.`empleados` (`nuemp`),
  CONSTRAINT `fk_empleados_oficinas1`
    FOREIGN KEY (`oficina`)
    REFERENCES `empresa`.`oficinas` (`oficina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`clientes` (
  `numclie` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `limitecredito` VARCHAR(45) NULL DEFAULT NULL,
  `gestor` INT NULL DEFAULT NULL,
  PRIMARY KEY (`numclie`),
  INDEX `clientes_empleados` (`gestor` ASC) VISIBLE,
  CONSTRAINT `clientes_empleados`
    FOREIGN KEY (`gestor`)
    REFERENCES `empresa`.`empleados` (`nuemp`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`fabricantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`fabricantes` (
  `idfab` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idfab`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`nuevaempleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`nuevaempleados` (
  `nuemp` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `edad` INT NULL DEFAULT NULL,
  `contrato` DATE NULL DEFAULT NULL,
  `cuota` DOUBLE NULL DEFAULT NULL,
  `ventas` DOUBLE NULL DEFAULT NULL,
  `oficina` INT NULL DEFAULT NULL,
  `jefe` INT NULL DEFAULT NULL,
  PRIMARY KEY (`nuemp`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`nuevaclientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`nuevaclientes` (
  `numclie` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `limitecredito` VARCHAR(45) NULL DEFAULT NULL,
  `gestor` INT NULL DEFAULT NULL,
  PRIMARY KEY (`numclie`),
  INDEX `nuevaclientes_nuevaempleados` (`gestor` ASC) VISIBLE,
  CONSTRAINT `nuevaclientes_nuevaempleados`
    FOREIGN KEY (`gestor`)
    REFERENCES `empresa`.`nuevaempleados` (`nuemp`)
    ON DELETE CASCADE
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`nuevaoficinas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`nuevaoficinas` (
  `oficina` INT NOT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `region` VARCHAR(45) NULL DEFAULT NULL,
  `objetivo` DOUBLE NULL DEFAULT NULL,
  `ventas` DOUBLE NULL DEFAULT NULL,
  `director` INT NULL DEFAULT NULL,
  PRIMARY KEY (`oficina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`nuevapedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`nuevapedidos` (
  `codigo` INT NOT NULL,
  `numpedido` INT NULL DEFAULT NULL,
  `fechapedido` DATETIME NULL DEFAULT NULL,
  `importe` INT NULL DEFAULT NULL,
  `idcliente` INT NULL DEFAULT NULL,
  `idemp` INT NULL DEFAULT NULL,
  `idfab` VARCHAR(45) NULL DEFAULT NULL,
  `cantidad` INT NULL DEFAULT NULL,
  `idproducto` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`nuevaproductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`nuevaproductos` (
  `idproducto` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `precio` INT NULL DEFAULT NULL,
  `existencias` INT NULL DEFAULT NULL,
  `idfab` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idfab`, `idproducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`productos` (
  `idproducto` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `precio` DECIMAL(45,0) NULL DEFAULT NULL,
  `existencias` INT NULL DEFAULT NULL,
  `idfab` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idfab`, `idproducto`),
  CONSTRAINT `productos_fabricantes`
    FOREIGN KEY (`idfab`)
    REFERENCES `empresa`.`fabricantes` (`idfab`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`pedidos` (
  `codigo` INT NOT NULL,
  `numpedido` INT NULL DEFAULT NULL,
  `fechapedido` DATETIME NULL DEFAULT NULL,
  `importe` INT NULL DEFAULT NULL,
  `idcliente` INT NULL DEFAULT NULL,
  `idemp` INT NULL DEFAULT NULL,
  `idfab` VARCHAR(45) NULL DEFAULT NULL,
  `cantidad` INT NULL DEFAULT NULL,
  `idproducto` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `pedidos_clientes` (`idcliente` ASC) VISIBLE,
  INDEX `pedidos_empleados` (`idemp` ASC) VISIBLE,
  INDEX `pedidos_productos` (`idfab` ASC, `idproducto` ASC) VISIBLE,
  CONSTRAINT `pedidos_clientes`
    FOREIGN KEY (`idcliente`)
    REFERENCES `empresa`.`clientes` (`numclie`)
    ON UPDATE CASCADE,
  CONSTRAINT `pedidos_empleados`
    FOREIGN KEY (`idemp`)
    REFERENCES `empresa`.`empleados` (`nuemp`)
    ON UPDATE CASCADE,
  CONSTRAINT `pedidos_productos`
    FOREIGN KEY (`idfab` , `idproducto`)
    REFERENCES `empresa`.`productos` (`idfab` , `idproducto`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`titulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`titulos` (
  `nuemp` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nuemp`, `titulo`),
  CONSTRAINT `titulos_empleados`
    FOREIGN KEY (`nuemp`)
    REFERENCES `empresa`.`empleados` (`nuemp`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `empresa`.`directores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`directores` (
  `id_director` INT NOT NULL,
  PRIMARY KEY (`id_director`),
  CONSTRAINT `fk_directores_empleados1`
    FOREIGN KEY (`id_director`)
    REFERENCES `empresa`.`empleados` (`nuemp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`representantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`representantes` (
  `id_representante` INT NOT NULL,
  `cuota` INT NULL,
  `ventas` INT NULL,
  PRIMARY KEY (`id_representante`),
  CONSTRAINT `fk_representantes_empleados1`
    FOREIGN KEY (`id_representante`)
    REFERENCES `empresa`.`empleados` (`nuemp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
