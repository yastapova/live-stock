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
  `StopDiff` float DEFAULT NULL,
  `CurSharePrice` float DEFAULT NULL,
  `EmpId` int(11) DEFAULT '0',
  `Recorded` tinyint(1) DEFAULT '0',
  `Completed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`OrderId`),
  UNIQUE KEY `StockSymbol` (`StockSymbol`,`Timestamp_`,`CusAccNum`,`EmpId`),
  KEY `CusAccNum` (`CusAccNum`),
  KEY `EmpId` (`EmpId`),
  CONSTRAINT `order__ibfk_1` FOREIGN KEY (`StockSymbol`) REFERENCES `stock` (`StockSymbol`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `order__ibfk_2` FOREIGN KEY (`CusAccNum`) REFERENCES `account_` (`AccNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `order__ibfk_3` FOREIGN KEY (`EmpId`) REFERENCES `employee` (`EmpId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_`
--

LOCK TABLES `order_` WRITE;
/*!40000 ALTER TABLE `order_` DISABLE KEYS */;
INSERT INTO `order_` VALUES (1,'GM','Buy',75,1,'2016-04-03 22:09:55','Market',NULL,NULL,34.23,1,1,1),(2,'IBM','Sell',10,2,'2016-04-03 22:11:21','Trailing Stop',90,1.43,91.43,1,0,0),(3,'IBM','Buy',10,2,'2016-04-03 22:14:19','Market',NULL,NULL,95,1,1,1),(4,'IBM','Sell',10,2,'2016-04-03 22:15:22','Market',NULL,NULL,95,1,1,1),(5,'IBM','Sell',10,2,'2016-04-03 22:18:41','Market',NULL,NULL,95,1,1,1),(6,'IBM','Sell',10,2,'2016-04-03 22:20:42','Market',NULL,NULL,95,1,1,1),(7,'IBM','Sell',10,2,'2016-04-03 22:21:58','Market',NULL,NULL,95,1,1,1),(8,'IBM','Sell',10,2,'2016-04-03 22:24:24','Market',NULL,NULL,95,1,1,1),(9,'IBM','Sell',155,2,'2016-04-03 22:26:20','Trailing Stop',90,5,95,1,0,0),(10,'GM','Sell',355,1,'2016-04-03 22:27:27','Market',NULL,NULL,34.23,1,1,1),(11,'GM','Sell',355,1,'2016-04-03 22:35:21','Market',NULL,NULL,34.23,1,1,1);
/*!40000 ALTER TABLE `order_` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER NumSharesValid
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.NumShares = IF
			(NEW.NumShares <= (SELECT S.NumAvailShares FROM Stock S WHERE S.StockSymbol = NEW.StockSymbol)
            AND NEW.NumShares > 0,
            NEW.NumShares,
            NULL) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER GetPrices
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.CurSharePrice = (SELECT S.SharePrice FROM Stock S WHERE S.StockSymbol = NEW.StockSymbol) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER OrderTypes 
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.OrderType = IF
			(NEW.OrderType IN ('Buy', 'Sell'),
			NEW.OrderType,
            NULL) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER PriceTypes 
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.PriceType = IF
			(NEW.PriceType IN ('Market', 'Market on Close', 'Trailing Stop', 'Hidden Stop'),
			NEW.PriceType,
            NULL) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER CalcStopDiff
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.StopDiff = IF
			(NEW.PriceType IN ('Trailing Stop', 'Hidden Stop'),
            NEW.CurSharePrice - NEW.StopPrice,
            NULL) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER InitalAddToConditionalPriceHistoryShare
	AFTER INSERT ON Order_ FOR EACH ROW
	BEGIN
		IF (NEW.PriceType IN ('Trailing Stop', 'Hidden Stop'))
		THEN INSERT INTO ConditionalPriceHistory(OrderId, CurSharePrice, PriceType, StopPrice)
			VALUES(NEW.OrderId, NEW.CurSharePrice, NEW. PriceType, NEW.StopPrice);
        END IF;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER DoTransact
	BEFORE UPDATE ON Order_ FOR EACH ROW
		IF(NEW.Recorded <> OLD.Recorded)
			THEN INSERT INTO Transact(OrderId)
				VALUES(NEW.OrderId);
			SET NEW.Completed = 1;
        END IF */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-03 22:49:15
