CREATE DATABASE  IF NOT EXISTS `live-stock` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `live-stock`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: live-stock
-- ------------------------------------------------------
-- Server version	5.7.11-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `order_`
--

DROP TABLE IF EXISTS `order_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_` (
  `OrderId` int(11) NOT NULL AUTO_INCREMENT,
  `StockSymbol` varchar(5) DEFAULT NULL,
  `OrderType` varchar(4) NOT NULL,
  `NumShares` int(11) NOT NULL,
  `CusAccNum` int(11) DEFAULT '0',
  `Timestamp_` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PriceType` varchar(15) NOT NULL,
  `StopPrice` float DEFAULT '0',
  `CurSharePrice` float DEFAULT NULL,
  `EmpId` int(11) DEFAULT '0',
  `Recorded` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`OrderId`),
  UNIQUE KEY `StockSymbol` (`StockSymbol`,`Timestamp_`,`CusAccNum`,`EmpId`),
  KEY `CusAccNum` (`CusAccNum`),
  KEY `EmpId` (`EmpId`),
  CONSTRAINT `order__ibfk_1` FOREIGN KEY (`StockSymbol`) REFERENCES `stock` (`StockSymbol`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `order__ibfk_2` FOREIGN KEY (`CusAccNum`) REFERENCES `account_` (`AccNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `order__ibfk_3` FOREIGN KEY (`EmpId`) REFERENCES `employee` (`EmpId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_`
--

LOCK TABLES `order_` WRITE;
/*!40000 ALTER TABLE `order_` DISABLE KEYS */;
INSERT INTO `order_` VALUES (1,'GM','Buy',75,1,'2016-03-22 21:42:38','Market',NULL,34.23,NULL,1),(15,'IBM','Sell',10,2,'2016-03-22 23:35:44','Trailing Stop',90,100,NULL,0);
/*!40000 ALTER TABLE `order_` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-23 13:58:21
