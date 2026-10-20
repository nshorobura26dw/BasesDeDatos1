CREATE DATABASE  IF NOT EXISTS `empresa` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `empresa`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: empresa
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `numclie` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `limitecredito` varchar(45) DEFAULT NULL,
  `gestor` int DEFAULT NULL,
  PRIMARY KEY (`numclie`),
  KEY `clientes_empleados` (`gestor`),
  CONSTRAINT `clientes_empleados` FOREIGN KEY (`gestor`) REFERENCES `empleados` (`nuemp`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (2101,'Luis Garcia','65000',102),(2102,'Alvaro Rodriguez','605000',101),(2103,'Jaime Llorens','50000',105),(2105,'Antonio Canales','45000',101),(2106,'Juan Suarez','65000',102),(2107,'Julian Lopez','35000',110),(2108,'Julia Antequera','55000',109),(2109,'Alberto Juanes','25000',103),(2111,'Cridtobal Garcia','50000',103),(2112,'Maria Silva','50000',109),(2113,'Luisa Maron','20000',103),(2114,'Cristina Marini','20000',102),(2115,'Vicente Martinez','20000',101),(2117,'Carlos Tena','35000',101),(2118,'June Alvarez','60000',105),(2119,'Salomon Bueno','25000',109),(2120,'Juan Malo','50000',102),(2121,'Vicente Rios','45000',103),(2122,'Jose Machante','30000',105),(2123,'Jose Libros','40000',102),(2124,'Juan Bolto','40000',107);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `nuemp` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `edad` int DEFAULT NULL,
  `contrato` date DEFAULT NULL,
  `cuota` double DEFAULT NULL,
  `ventas` double DEFAULT NULL,
  `oficina` int DEFAULT NULL,
  `jefe` int DEFAULT NULL,
  PRIMARY KEY (`nuemp`),
  KEY `fk_empleados_oficinas1_idx` (`oficina`),
  KEY `fk_empleados_empleados1_idx` (`jefe`),
  CONSTRAINT `fk_empleados_empleados1` FOREIGN KEY (`jefe`) REFERENCES `empleados` (`nuemp`),
  CONSTRAINT `fk_empleados_oficinas1` FOREIGN KEY (`oficina`) REFERENCES `oficinas` (`oficina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (101,'Antonio Viguer',45,'1986-10-10',300000,305000,12,104),(102,'Alvaro Jaumes',48,'1986-12-10',350000,474000,21,108),(103,'Juan Rovira',29,'1987-03-01',275000,286000,12,104),(104,'Jose Gonzalez',33,'1987-05-19',20000,143000,12,106),(105,'Vicente Pantalla',37,'1988-02-12',350000,368000,13,104),(106,'Luis Antonio',52,'1988-06-14',275000,299000,11,NULL),(107,'Jorge Gutierrez',49,'1988-11-14',300000,186000,22,108),(108,'Ana Bustamante',62,'1989-10-12',350000,361000,21,106),(109,'Maria Sunta',31,'1999-10-12',30000,392000,11,106),(110,'Juan Victor',41,'1990-01-13',0,76000,NULL,104);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fabricantes`
--

DROP TABLE IF EXISTS `fabricantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fabricantes` (
  `idfab` varchar(45) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idfab`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fabricantes`
--

LOCK TABLES `fabricantes` WRITE;
/*!40000 ALTER TABLE `fabricantes` DISABLE KEYS */;
INSERT INTO `fabricantes` VALUES ('aci','Acicat'),('bic','Bic_Iberia'),('fea','Fesmesa'),('imm','Ferreteria Imm'),('qsa','Paqsacro'),('rei','Ferreteria Rei');
/*!40000 ALTER TABLE `fabricantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nuevaclientes`
--

DROP TABLE IF EXISTS `nuevaclientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nuevaclientes` (
  `numclie` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `limitecredito` varchar(45) DEFAULT NULL,
  `gestor` int DEFAULT NULL,
  PRIMARY KEY (`numclie`),
  KEY `nuevaclientes_nuevaempleados` (`gestor`),
  CONSTRAINT `nuevaclientes_nuevaempleados` FOREIGN KEY (`gestor`) REFERENCES `nuevaempleados` (`nuemp`) ON DELETE CASCADE ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nuevaclientes`
--

LOCK TABLES `nuevaclientes` WRITE;
/*!40000 ALTER TABLE `nuevaclientes` DISABLE KEYS */;
INSERT INTO `nuevaclientes` VALUES (2101,'Luis Garcia','65000',102),(2102,'Alvaro Rodriguez','605000',NULL),(2103,'Jaime Llorens','50100',105),(2105,'Antonio Canales','45000',NULL),(2106,'Juan Suarez','65100',102),(2107,'Julian Lopez','35100',110),(2109,'Alberto Juanes','25000',103),(2111,'Cridtobal Garcia','50000',103),(2113,'Luisa Maron','20000',103),(2114,'Cristina Marini','20000',102),(2115,'Vicente Martinez','20000',NULL),(2117,'Carlos Tena','35000',NULL),(2118,'June Alvarez','60100',105),(2120,'Jon Bueno','50601',102),(2121,'Vicente Rios','45000',103),(2122,'Jose Machante','30100',105),(2123,'Jose Libros','40100',102),(2124,'Juan Bolto','40100',107);
/*!40000 ALTER TABLE `nuevaclientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nuevaempleados`
--

DROP TABLE IF EXISTS `nuevaempleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nuevaempleados` (
  `nuemp` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `edad` int DEFAULT NULL,
  `contrato` date DEFAULT NULL,
  `cuota` double DEFAULT NULL,
  `ventas` double DEFAULT NULL,
  `oficina` int DEFAULT NULL,
  `jefe` int DEFAULT NULL,
  PRIMARY KEY (`nuemp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nuevaempleados`
--

LOCK TABLES `nuevaempleados` WRITE;
/*!40000 ALTER TABLE `nuevaempleados` DISABLE KEYS */;
INSERT INTO `nuevaempleados` VALUES (102,'Alvaro Jaumes',48,'1986-12-10',350000,474000,21,NULL),(103,'Juan Rovira',29,'1987-03-01',275000,286000,112,NULL),(104,'Jose Gonzalez',33,'1987-05-19',20000,143000,112,NULL),(105,'Vicente Pantalla',37,'1988-02-12',350000,368000,13,NULL),(106,'Luis Antonio',52,'1988-06-14',275000,299000,11,NULL),(107,'Jorge Gutierrez',49,'1988-11-14',300000,186000,22,NULL),(108,'Ana Bustamante',62,'1989-10-12',350000,361000,21,NULL),(110,'Juan Victor',41,'1990-01-13',0,76000,NULL,NULL),(201,'Antonio Viguer',45,'1986-10-10',300000,305000,112,NULL);
/*!40000 ALTER TABLE `nuevaempleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nuevaoficinas`
--

DROP TABLE IF EXISTS `nuevaoficinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nuevaoficinas` (
  `oficina` int NOT NULL,
  `ciudad` varchar(45) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  `objetivo` double DEFAULT NULL,
  `ventas` double DEFAULT NULL,
  `director` int DEFAULT NULL,
  PRIMARY KEY (`oficina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nuevaoficinas`
--

LOCK TABLES `nuevaoficinas` WRITE;
/*!40000 ALTER TABLE `nuevaoficinas` DISABLE KEYS */;
INSERT INTO `nuevaoficinas` VALUES (11,'Valencia','este',575000,693000,NULL),(12,'Alicante','este',800000,735000,NULL),(13,'Castellón','este',350000,368000,NULL),(21,'Badajoz','oeste',725000,836000,NULL),(22,'A Coruña','oeste',300000,186000,NULL),(23,'Madrid','centro',NULL,NULL,NULL),(24,'Madrid','centro',250000,150000,NULL),(26,'Pamplona','norte',NULL,NULL,NULL),(28,'Valencia','este',900000,0,NULL),(30,'Madrid','Centro',600,NULL,NULL);
/*!40000 ALTER TABLE `nuevaoficinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nuevapedidos`
--

DROP TABLE IF EXISTS `nuevapedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nuevapedidos` (
  `codigo` int NOT NULL,
  `numpedido` int DEFAULT NULL,
  `fechapedido` datetime DEFAULT NULL,
  `importe` int DEFAULT NULL,
  `idcliente` int DEFAULT NULL,
  `idemp` int DEFAULT NULL,
  `idfab` varchar(45) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `idproducto` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nuevapedidos`
--

LOCK TABLES `nuevapedidos` WRITE;
/*!40000 ALTER TABLE `nuevapedidos` DISABLE KEYS */;
INSERT INTO `nuevapedidos` VALUES (1,110036,'2005-01-02 00:00:00',22500,2107,110,'aci',9,'4100z'),(2,110036,'2005-01-02 00:00:00',31500,2117,102,'rei',7,'2a44l'),(4,112968,'1999-01-11 00:00:00',3978,2102,101,'aci',34,'41004'),(5,112975,'2005-02-11 00:00:00',2100,2111,103,'rei',6,'2a44g'),(6,112979,'2001-10-12 00:00:00',15000,2114,103,'aci',6,'4100z'),(9,112989,'2005-12-10 00:00:00',1458,2101,101,'fea',6,'114'),(10,112992,'1999-04-15 00:00:00',760,2118,110,'aci',10,'41002'),(11,112993,'2005-03-10 00:00:00',1896,2106,102,'rei',24,'2a45c'),(12,112997,'2005-04-04 00:00:00',652,2124,107,'bic',1,'41003'),(13,113003,'2005-02-05 00:00:00',5625,2108,109,'imm',3,'779c'),(14,113007,'2005-01-01 00:00:00',2925,2112,102,'imm',3,'773c'),(16,113013,'2005-08-06 00:00:00',652,2118,101,'bic',1,'41003'),(17,113024,'2005-07-04 00:00:00',7100,2114,109,'qsa',20,'xk47'),(19,113034,'2005-11-05 00:00:00',632,2107,110,'rei',8,'2a45c'),(20,113042,'2005-01-01 00:00:00',22500,2113,101,'rei',5,'2a44r'),(21,113045,'2005-07-02 00:00:00',45000,2112,109,'rei',10,'2a44r'),(22,113048,'2005-02-02 00:00:00',3750,2120,102,'imm',2,'779c'),(23,113049,'2005-04-04 00:00:00',776,2118,107,'qsa',2,'xk47'),(24,113051,'2005-07-06 00:00:00',1420,2118,101,'qsa',4,'xk47'),(25,113055,'1999-04-01 00:00:00',150,2108,101,'aci',6,'4100x'),(26,113057,'2005-11-01 00:00:00',600,2111,103,'aci',24,'4100x'),(27,113058,'2000-07-04 00:00:00',1480,2108,109,'fea',10,'112'),(28,113058,'2005-07-04 00:00:00',1480,2108,109,'fea',10,'112'),(29,113062,'2005-07-04 00:00:00',600,2111,103,'aci',24,'4100x'),(30,113058,'1999-07-04 00:00:00',1480,2108,109,'fea',10,'112'),(31,113062,'2005-07-04 00:00:00',2430,2124,107,'bic',10,'41003'),(32,113065,'2005-06-03 00:00:00',2130,2106,102,'qsa',6,'xk47'),(33,113069,'2005-08-01 00:00:00',31350,2109,107,'imm',22,'773c');
/*!40000 ALTER TABLE `nuevapedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nuevaproductos`
--

DROP TABLE IF EXISTS `nuevaproductos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nuevaproductos` (
  `idproducto` varchar(45) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `precio` int DEFAULT NULL,
  `existencias` int DEFAULT NULL,
  `idfab` varchar(45) NOT NULL,
  PRIMARY KEY (`idfab`,`idproducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nuevaproductos`
--

LOCK TABLES `nuevaproductos` WRITE;
/*!40000 ALTER TABLE `nuevaproductos` DISABLE KEYS */;
INSERT INTO `nuevaproductos` VALUES ('41003','art t3',118,207,'aci'),('41003','manivela',652,3,'bic'),('41089','rodamiento',225,78,'bic'),('41672','plato',180,0,'bic'),('112','cubo',148,115,'fea'),('114','cubo',243,15,'fea'),('887p','tornillo',5,32,'fea'),('773c','reostato',975,28,'imm'),('775c','reostato 2',1425,5,'imm'),('779c','reostato 3',1875,0,'imm'),('887h','caja clavos',54,223,'imm'),('887p','perno',25,24,'imm'),('887x','manivela',475,32,'imm'),('xk47','red',355,38,'qsa'),('xk48','red',134,203,'qsa'),('xk48a','red',117,37,'qsa'),('2a44g','pas',350,14,'rei'),('2a44l','bomba l',4500,12,'rei'),('2a44r','bomba r',4500,12,'rei'),('2a45c','junta',79,210,'rei'),('xk48a','cubo',100,125,'rei');
/*!40000 ALTER TABLE `nuevaproductos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oficinas`
--

DROP TABLE IF EXISTS `oficinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oficinas` (
  `oficina` int NOT NULL,
  `ciudad` varchar(45) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  `objetivo` double DEFAULT NULL,
  `ventas` double DEFAULT NULL,
  `director` int DEFAULT NULL,
  PRIMARY KEY (`oficina`),
  KEY `fk_oficinas_empleados_idx` (`director`),
  CONSTRAINT `fk_oficinas_empleados` FOREIGN KEY (`director`) REFERENCES `empleados` (`nuemp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oficinas`
--

LOCK TABLES `oficinas` WRITE;
/*!40000 ALTER TABLE `oficinas` DISABLE KEYS */;
INSERT INTO `oficinas` VALUES (11,'Valencia','este',575000,693000,106),(12,'Alicante','este',800000,735000,104),(13,'Castellón','este',350000,368000,104),(21,'Badajoz','oeste',725000,836000,108),(22,'A Coruña','oeste',300000,186000,108),(23,'Madrid','centro',NULL,NULL,108),(24,'Madrid','centro',250000,150000,108),(26,'Pamplona','norte',NULL,NULL,NULL),(28,'Valencia','este',900000,0,NULL);
/*!40000 ALTER TABLE `oficinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `codigo` int NOT NULL,
  `numpedido` int DEFAULT NULL,
  `fechapedido` datetime DEFAULT NULL,
  `importe` int DEFAULT NULL,
  `idcliente` int DEFAULT NULL,
  `idemp` int DEFAULT NULL,
  `idfab` varchar(45) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `idproducto` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `pedidos_clientes` (`idcliente`),
  KEY `pedidos_empleados` (`idemp`),
  KEY `pedidos_productos` (`idfab`,`idproducto`),
  CONSTRAINT `pedidos_clientes` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`numclie`) ON UPDATE CASCADE,
  CONSTRAINT `pedidos_empleados` FOREIGN KEY (`idemp`) REFERENCES `empleados` (`nuemp`) ON UPDATE CASCADE,
  CONSTRAINT `pedidos_productos` FOREIGN KEY (`idfab`, `idproducto`) REFERENCES `productos` (`idfab`, `idproducto`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,110036,'2005-01-02 00:00:00',22500,2107,110,'aci',9,'4100z'),(2,110036,'2005-01-02 00:00:00',31500,2117,102,'rei',7,'2a44l'),(3,112963,'2005-05-10 00:00:00',3276,2103,105,'aci',28,'41004'),(4,112968,'1999-01-11 00:00:00',3978,2102,101,'aci',34,'41004'),(5,112975,'2005-02-11 00:00:00',2100,2111,103,'rei',6,'2a44g'),(6,112979,'2001-10-12 00:00:00',15000,2114,103,'aci',6,'4100z'),(7,112983,'2005-05-10 00:00:00',702,2103,105,'aci',6,'41004'),(8,112987,'2005-01-01 00:00:00',27500,2103,105,'aci',11,'4100y'),(9,112989,'2005-12-10 00:00:00',1458,2101,101,'fea',6,'114'),(10,112992,'1999-04-15 00:00:00',760,2118,110,'aci',10,'41002'),(11,112993,'2005-03-10 00:00:00',1896,2106,102,'rei',24,'2a45c'),(12,112997,'2005-04-04 00:00:00',652,2124,107,'bic',1,'41003'),(13,113003,'2005-02-05 00:00:00',5625,2108,109,'imm',3,'779c'),(14,113007,'2005-01-01 00:00:00',2925,2112,102,'imm',3,'773c'),(15,113012,'2005-05-05 00:00:00',3745,2111,105,'aci',35,'41003'),(16,113013,'2005-08-06 00:00:00',652,2118,101,'bic',1,'41003'),(17,113024,'2005-07-04 00:00:00',7100,2114,109,'qsa',20,'xk47'),(18,113027,'2005-02-05 00:00:00',4104,2103,105,'aci',54,'41002'),(19,113034,'2005-11-05 00:00:00',632,2107,110,'rei',8,'2a45c'),(20,113042,'2005-01-01 00:00:00',22500,2113,101,'rei',5,'2a44r'),(21,113045,'2005-07-02 00:00:00',45000,2112,109,'rei',10,'2a44r'),(22,113048,'2005-02-02 00:00:00',3750,2120,102,'imm',2,'779c'),(23,113049,'2005-04-04 00:00:00',776,2118,107,'qsa',2,'xk47'),(24,113051,'2005-07-06 00:00:00',1420,2118,101,'qsa',4,'xk47'),(25,113055,'1999-04-01 00:00:00',150,2108,101,'aci',6,'4100x'),(26,113057,'2005-11-01 00:00:00',600,2111,103,'aci',24,'4100x'),(27,113058,'2000-07-04 00:00:00',1480,2108,109,'fea',10,'112'),(28,113058,'2005-07-04 00:00:00',1480,2108,109,'fea',10,'112'),(29,113062,'2005-07-04 00:00:00',600,2111,103,'aci',24,'4100x'),(30,113058,'1999-07-04 00:00:00',1480,2108,109,'fea',10,'112'),(31,113062,'2005-07-04 00:00:00',2430,2124,107,'bic',10,'41003'),(32,113065,'2005-06-03 00:00:00',2130,2106,102,'qsa',6,'xk47'),(33,113069,'2005-08-01 00:00:00',31350,2109,107,'imm',22,'773c');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `idproducto` varchar(45) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `precio` decimal(45,0) DEFAULT NULL,
  `existencias` int DEFAULT NULL,
  `idfab` varchar(45) NOT NULL,
  PRIMARY KEY (`idfab`,`idproducto`),
  CONSTRAINT `productos_fabricantes` FOREIGN KEY (`idfab`) REFERENCES `fabricantes` (`idfab`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES ('41001','arandela',58,4,'aci'),('41002','bisagra',80,167,'aci'),('41003','art t3',112,207,'aci'),('41004','art t4',123,139,'aci'),('4100x','junta',26,37,'aci'),('4100y','extractor',2888,25,'aci'),('4100z','mont',2625,28,'aci'),('41003','manivela',652,3,'bic'),('41089','rodamiento',225,78,'bic'),('41672','plato',180,0,'bic'),('112','cubo',148,115,'fea'),('114','cubo',243,15,'fea'),('887p','tornillo',5,32,'fea'),('773c','reostato',975,28,'imm'),('775c','reostato 2',1425,5,'imm'),('779c','reostato 3',1875,0,'imm'),('887h','caja clavos',54,223,'imm'),('887p','perno',25,24,'imm'),('887x','manivela',475,32,'imm'),('xk47','red',355,38,'qsa'),('xk48','red',134,203,'qsa'),('xk48a','red',117,37,'qsa'),('2a44g','pas',350,14,'rei'),('2a44l','bomba l',4500,12,'rei'),('2a44r','bomba r',4500,12,'rei'),('2a45c','junta',79,210,'rei'),('xk48a','cubo',100,125,'rei');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `titulos`
--

DROP TABLE IF EXISTS `titulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `titulos` (
  `nuemp` int NOT NULL,
  `titulo` varchar(45) NOT NULL,
  PRIMARY KEY (`nuemp`,`titulo`),
  CONSTRAINT `titulos_empleados` FOREIGN KEY (`nuemp`) REFERENCES `empleados` (`nuemp`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titulos`
--

LOCK TABLES `titulos` WRITE;
/*!40000 ALTER TABLE `titulos` DISABLE KEYS */;
INSERT INTO `titulos` VALUES (101,'administrativo'),(101,'finanzas'),(102,'administrativo'),(102,'comercio'),(102,'representante'),(103,'administrativo'),(104,'empresariales'),(104,'informatica'),(105,'comercio'),(105,'informatica'),(106,'comunicaciones'),(106,'finanzas'),(107,'comercio'),(108,'empresariales'),(109,'administrativo'),(110,'comercio');
/*!40000 ALTER TABLE `titulos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-01 10:42:50
