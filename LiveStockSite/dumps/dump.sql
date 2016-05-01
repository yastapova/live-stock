-- MySQL dump 10.13  Distrib 5.7.11, for Win64 (x86_64)
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
-- Current Database: `live-stock`
--

/*!40000 DROP DATABASE IF EXISTS `live-stock`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `live-stock` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `live-stock`;

--
-- Table structure for table `account_`
--

DROP TABLE IF EXISTS `account_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_` (
  `AccNum` int(11) NOT NULL AUTO_INCREMENT,
  `AccCreDate` datetime DEFAULT NULL,
  `CreditCNum` varchar(16) NOT NULL,
  `CusId` int(11) NOT NULL,
  PRIMARY KEY (`AccNum`),
  KEY `CusId` (`CusId`),
  CONSTRAINT `account__ibfk_1` FOREIGN KEY (`CusId`) REFERENCES `customer` (`CusId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_`
--

LOCK TABLES `account_` WRITE;
/*!40000 ALTER TABLE `account_` DISABLE KEYS */;
INSERT INTO `account_` VALUES (1,'2006-10-01 00:00:00','1234567812345678',4),(2,'2006-10-15 00:00:00','5678123456781234',2),(3,'2016-04-28 00:07:08','1231231312312312',4),(4,'2016-04-28 09:46:47','2131443123123141',4);
/*!40000 ALTER TABLE `account_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `bestsellers`
--

DROP TABLE IF EXISTS `bestsellers`;
/*!50001 DROP VIEW IF EXISTS `bestsellers`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `bestsellers` AS SELECT 
 1 AS `StockSymbol`,
 1 AS `TotalShares`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `conditionalpricehistory`
--

DROP TABLE IF EXISTS `conditionalpricehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditionalpricehistory` (
  `OrderId` int(11) NOT NULL,
  `CurSharePrice` float DEFAULT NULL,
  `PriceType` varchar(15) NOT NULL,
  `StopPrice` float DEFAULT NULL,
  `Timestamp_` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`OrderId`,`PriceType`,`Timestamp_`),
  CONSTRAINT `conditionalpricehistory_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `order_` (`OrderId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditionalpricehistory`
--

LOCK TABLES `conditionalpricehistory` WRITE;
/*!40000 ALTER TABLE `conditionalpricehistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `conditionalpricehistory` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER PriceTypes2
	BEFORE INSERT ON ConditionalPriceHistory FOR EACH ROW
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER SellOrder
	AFTER INSERT ON ConditionalPriceHistory FOR EACH ROW
    BEGIN
		IF (NEW.CurSharePrice <= NEW.StopPrice 
			AND 1 = (SELECT O.Recorded
					FROM ORDER_ O
					WHERE NEW.OrderId = O.OrderId))
		THEN INSERT INTO Transact (OrderId, PricePerShare)
			VALUES (NEW.OrderId, NEW.CurSharePrice);
		END IF;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `LastName` varchar(20) NOT NULL,
  `FirstName` varchar(20) NOT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `State` varchar(20) DEFAULT NULL,
  `ZipCode` char(5) DEFAULT NULL,
  `Telephone` char(10) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Rating` int(11) NOT NULL,
  `CusId` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`CusId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('Du','Victor','456 Fortune Road','Stony Brook','NY','11790','5166324360','vicdu@cs.sunysb.edu',1,2),('Smith','John','789 Peace Blvd.','Los Angeles','CA','93536','3154434321','jsmith@ic.sunysb.edu',1,3),('Philip','Lewis','135 Knowledge Lane','Stony Brook','NY','11794','5166668888','pml@cs.sunysb.edu',1,4),('0987','0987','0987','0987','0987','0987','0987','0987',1,6),('09876','09876','09876','09876','09876','09876','09876','09876',1,7);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Ratings 
	BEFORE INSERT ON Customer FOR EACH ROW
		SET NEW.Rating = IF
			(NEW.Rating > -1 AND NEW.Rating < 11,
			NEW.Rating,
            NULL) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `SSN` char(9) NOT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `State` varchar(20) DEFAULT NULL,
  `ZipCode` char(5) DEFAULT NULL,
  `Telephone` char(10) DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `HourlyRate` float DEFAULT NULL,
  `EmpId` int(11) NOT NULL AUTO_INCREMENT,
  `Position_` varchar(7) NOT NULL,
  PRIMARY KEY (`EmpId`),
  UNIQUE KEY `SSN` (`SSN`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('11','123123','1231a','231','231','1231','121','12321','1231-11-11 00:00:00',12,5,'CusRep'),('54321','54321','54321','54321','54321','54321','54321','1231321','1111-11-11 00:00:00',11,6,'CusRep'),('11111','abcd','abcd','abcd','abcd','abcd','11111','111','1111-11-11 00:00:00',11,7,'CusRep'),('12','abcd','abcd','abcd','abcd','abcd','111','11','1111-11-11 00:00:00',11,9,'CusRep'),('89','test','test','test','test','test','11111','11111','1111-11-11 00:00:00',12,10,'CusRep'),('12345','12345','12345','12345','12345','12345','12345','12345','1111-11-11 00:00:00',11,11,'Manager'),('2131231','54321','54321','54321','54321','54321','54321','54321','1111-11-11 00:00:00',43,13,'CusRep'),('789123456','Warren','David','456 Sunken Street','Stony Brook','NY','11794','6316329987','2006-02-02 00:00:00',50,14,'Manager');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Positions 
	BEFORE INSERT ON Employee FOR EACH ROW
		SET NEW.Position_ = IF
			(NEW.Position_ IN ('Manager', 'CusRep', 'Other'),
			NEW.Position_,
            NULL) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `Usr` varchar(20) NOT NULL,
  `Pwd` varchar(20) NOT NULL,
  `AccType` int(11) NOT NULL,
  `Id` int(11) NOT NULL,
  PRIMARY KEY (`Usr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES ('12345','12345',3,11),('54321','54321',2,13),('Boss','password',3,2),('Clark','adventure',1,4),('CoolPerson','2cool4school',1,1),('Dsmith','12345',2,1),('DuVic','horse',1,2),('Wordsmith','pen>sword',1,3);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `mosttraded`
--

DROP TABLE IF EXISTS `mosttraded`;
/*!50001 DROP VIEW IF EXISTS `mosttraded`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `mosttraded` AS SELECT 
 1 AS `StockSymbol`,
 1 AS `NumOrders`*/;
SET character_set_client = @saved_cs_client;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_`
--

LOCK TABLES `order_` WRITE;
/*!40000 ALTER TABLE `order_` DISABLE KEYS */;
INSERT INTO `order_` VALUES (1,'F','Sell',30,1,'2016-04-27 18:42:22','Market',NULL,NULL,NULL,NULL,1,1),(2,'IBM','Sell',22,1,'2016-04-28 10:12:50','Market',0,NULL,NULL,NULL,1,1),(3,'IBM','Sell',1231,2,'2016-04-29 23:00:00','Market',0,NULL,91.43,14,0,0);
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
			(NEW.NumShares > 0,
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
			THEN IF(NEW.OrderType = 'Sell')
				THEN IF(NEW.PriceType = 'Market')
					THEN IF(NEW.NumShares <= 
							(SELECT P.NumShares
							FROM Portfolio P
							WHERE NEW.CusAccNum = P.AccNum
							AND NEW.StockSymbol = P.StockSymbol))
						THEN INSERT INTO Transact(OrderId)
							VALUES(NEW.OrderId);
						SET NEW.Completed = 1;
					END IF;
				END IF;
                IF(NEW.PriceType <> 'Market')
					THEN IF(NEW.NumShares <= 
							(SELECT P.NumShares
							FROM Portfolio P
							WHERE NEW.CusAccNum = P.AccNum
							AND NEW.StockSymbol = P.StockSymbol)
                            AND EXISTS(SELECT *
										FROM ConditionalPriceHistory C
                                        WHERE C.CurSharePrice <= C.StopPrice
                                        AND C.OrderId = NEW.OrderId)
                                        AND C.Timestamp_= (SELECT MAX(H.Timestamp_)
															FROM ConditionalPriceHistory H
															WHERE O.OrderId = H.OrderId))
						THEN INSERT INTO Transact(OrderId)
							VALUES(NEW.OrderId);
						SET NEW.Completed = 1;
					END IF;
                END IF;
			END IF;
            IF(NEW.OrderType = 'Buy')
				THEN IF(NEW.NumShares <= 
						(SELECT S.NumAvailShares
						FROM Stock S
						WHERE NEW.StockSymbol = S.StockSymbol))
					THEN INSERT INTO Transact(OrderId)
						VALUES(NEW.OrderId);
					SET NEW.Completed = 1;
				END IF;
			END IF;
        END IF */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `portfolio`
--

DROP TABLE IF EXISTS `portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portfolio` (
  `AccNum` int(11) NOT NULL,
  `StockSymbol` char(5) NOT NULL,
  `NumShares` int(11) DEFAULT NULL,
  `Stop_` varchar(8) NOT NULL,
  `StopPrice` float DEFAULT NULL,
  PRIMARY KEY (`AccNum`,`StockSymbol`),
  KEY `StockSymbol` (`StockSymbol`),
  CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`AccNum`) REFERENCES `account_` (`AccNum`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `portfolio_ibfk_2` FOREIGN KEY (`StockSymbol`) REFERENCES `stock` (`StockSymbol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portfolio`
--

LOCK TABLES `portfolio` WRITE;
/*!40000 ALTER TABLE `portfolio` DISABLE KEYS */;
INSERT INTO `portfolio` VALUES (1,'F',70,'None',NULL),(1,'GM',250,'None',NULL),(2,'IBM',50,'None',NULL),(3,'F',100,'None',NULL),(3,'GM',250,'None',NULL);
/*!40000 ALTER TABLE `portfolio` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Stops 
	BEFORE INSERT ON Portfolio FOR EACH ROW
		SET NEW.Stop_ = IF
			(NEW.Stop_ IN ('Trailing', 'Hidden', 'None'),
			NEW.Stop_,
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER NumSharesValid2
	BEFORE INSERT ON Portfolio FOR EACH ROW
	SET NEW.NumShares = IF
		(NEW.NumShares > -1,
        NEW.NumShares,
        NULL) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock` (
  `StockSymbol` varchar(5) NOT NULL,
  `StockName` varchar(20) NOT NULL,
  `StockType` varchar(20) DEFAULT NULL,
  `SharePrice` float NOT NULL,
  `NumAvailShares` int(11) NOT NULL,
  PRIMARY KEY (`StockSymbol`),
  UNIQUE KEY `StockName` (`StockName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES ('F','Ford','automotive',9,780),('GM','General Motors','automotive',34.23,1000),('IBM','IBM','computer',91.43,500);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER SharePriceValid
	BEFORE INSERT ON Stock FOR EACH ROW
	SET NEW.SharePrice = IF
		(NEW.SharePrice > 0,
        NEW.SharePrice,
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AvailSharesValid
	BEFORE INSERT ON Stock FOR EACH ROW
	SET NEW.NumAvailShares = IF
		(NEW.NumAvailShares > -1,
        NEW.NumAvailShares,
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER InitialAddToStockPriceHistory
	AFTER INSERT ON Stock FOR EACH ROW
		INSERT INTO StockPriceHistory(StockSymbol, SharePrice)
        VALUES(NEW.StockSymbol, NEW.SharePrice) */;;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER UpdateHiddenStop
	AFTER UPDATE ON Stock FOR EACH ROW
    IF (NEW.SharePrice <> OLD.SharePrice)
		THEN INSERT INTO ConditionalPriceHistory(OrderId, PriceType, StopPrice, CurSharePrice, Timestamp_)
			SELECT O.OrderId, O.PriceType, O.StopPrice, NEW.SharePrice, NOW()
            FROM Order_ O
            WHERE NEW.StockSymbol = O.StockSymbol
            AND O.PriceType IN ('Hidden Stop')
            AND O.Completed = 0;
	END IF */;;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER UpdateTrailingStop
	AFTER UPDATE ON Stock FOR EACH ROW
	BEGIN
		IF (NEW.SharePrice > OLD.SharePrice)
        THEN INSERT INTO ConditionalPriceHistory(OrderId, PriceType, StopPrice, CurSharePrice)
			(SELECT O.OrderId, O.PriceType, NEW.SharePrice - O.StopDiff, NEW.SharePrice
			FROM Order_ O, ConditionalPriceHistory C
			WHERE NEW.StockSymbol = O.StockSymbol
            AND C.Timestamp_= (SELECT MAX(H.Timestamp_)
							  FROM ConditionalPriceHistory H
							  WHERE O.OrderId = H.OrderId)
            AND O.PriceType = 'Trailing Stop'
            AND O.StopDiff < NEW.SharePrice - C.StopPrice
            AND O.Completed = 0);
        END IF;
        IF (NEW.SharePrice < OLD.SharePrice)
		THEN INSERT INTO ConditionalPriceHistory(OrderId, PriceType, StopPrice, CurSharePrice, Timestamp_)
			SELECT O.OrderId, O.PriceType, C.StopPrice, NEW.SharePrice, NOW()
            FROM Order_ O, ConditionalPriceHistory C
            WHERE NEW.StockSymbol = O.StockSymbol
            AND C.Timestamp_= (SELECT MAX(H.Timestamp_)
							  FROM ConditionalPriceHistory H
							  WHERE O.OrderId = H.OrderId)
            AND O.PriceType IN ('Trailing Stop')
            AND O.Completed = 0;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AddToStockPriceHistory
	AFTER UPDATE ON Stock FOR EACH ROW
    BEGIN
		IF (NEW.SharePrice <> OLD.SharePrice)
		THEN INSERT INTO StockPriceHistory(StockSymbol, SharePrice)
			VALUES(NEW.StockSymbol, NEW.SharePrice);
		END IF;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stockpricehistory`
--

DROP TABLE IF EXISTS `stockpricehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockpricehistory` (
  `StockSymbol` varchar(5) NOT NULL,
  `SharePrice` float DEFAULT NULL,
  `Timestamp_` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`StockSymbol`,`Timestamp_`),
  CONSTRAINT `stockpricehistory_ibfk_1` FOREIGN KEY (`StockSymbol`) REFERENCES `stock` (`StockSymbol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockpricehistory`
--

LOCK TABLES `stockpricehistory` WRITE;
/*!40000 ALTER TABLE `stockpricehistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `stockpricehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `stockrevenue`
--

DROP TABLE IF EXISTS `stockrevenue`;
/*!50001 DROP VIEW IF EXISTS `stockrevenue`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `stockrevenue` AS SELECT 
 1 AS `StockSymbol`,
 1 AS `TotalRevenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `stocktyperevenue`
--

DROP TABLE IF EXISTS `stocktyperevenue`;
/*!50001 DROP VIEW IF EXISTS `stocktyperevenue`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `stocktyperevenue` AS SELECT 
 1 AS `StockType`,
 1 AS `TotalRevenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `suggest`
--

DROP TABLE IF EXISTS `suggest`;
/*!50001 DROP VIEW IF EXISTS `suggest`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `suggest` AS SELECT 
 1 AS `StockSymbol`,
 1 AS `SharePrice`,
 1 AS `NumAvailShares`,
 1 AS `StockType`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transact`
--

DROP TABLE IF EXISTS `transact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transact` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `OrderId` int(11) DEFAULT NULL,
  `TransFee` float DEFAULT NULL,
  `TimeStamp_` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PricePerShare` float DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `OrderId` (`OrderId`),
  CONSTRAINT `transact_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `order_` (`OrderId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transact`
--

LOCK TABLES `transact` WRITE;
/*!40000 ALTER TABLE `transact` DISABLE KEYS */;
INSERT INTO `transact` VALUES (1,1,13.5,'2016-04-29 13:33:54',9);
/*!40000 ALTER TABLE `transact` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER GetPrices2
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN 
		SET NEW.PricePerShare = (SELECT S.SharePrice
								 FROM Stock S, Order_ O
								 WHERE S.StockSymbol = O.StockSymbol
										AND O.OrderId = NEW.OrderId);
		SET NEW.TransFee = NEW.PricePerShare * (SELECT O.NumShares FROM Order_ O WHERE O.OrderId = NEW.OrderId) * 0.05;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER UpdatePortfolio
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN
		UPDATE Portfolio P
		SET P.NumShares = P.NumShares + 
			(SELECT O.NumShares * POW(-1, O.OrderType = 'Sell')
				FROM Order_ O, Account_ A
				WHERE NEW.OrderId = O.OrderId
				AND O.CusAccNum = A.AccNum
				AND O.StockSymbol = P.StockSymbol
                AND P.AccNum = A.AccNum
				LIMIT 1)
		WHERE P.AccNum = 
			(SELECT A.AccNum
            FROM Account_ A, Order_ O
            WHERE NEW.OrderID = O.OrderId
			AND O.CusAccNum = A.AccNum
            AND O.StockSymbol = P.StockSymbol);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AddToAccount
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN
		IF(NOT EXISTS(SELECT * FROM Portfolio P, Account_ A, Order_ O
					  WHERE NEW.OrderId = O.OrderId
                      AND O.CusAccNum = A.AccNum
                      AND A.AccNum = P.AccNum
                      AND P.StockSymbol = O.StockSymbol))
		THEN INSERT INTO Portfolio(AccNum, StockSymbol, NumShares, Stop_)
			VALUES((SELECT O.CusAccNum, O.StockSymbol, O.NumShares, 'None'
				   FROM Order_ O
                   WHERE NEW.OrderId = O.OrderId
                   LIMIT 1));
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER UpdateStockQuantity
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN
		UPDATE Stock S
		SET S.NumAvailShares = S.NumAvailShares - 
			(SELECT O.NumShares * POW(-1, O.OrderType = 'Sell')
			FROM Order_ O
			WHERE NEW.OrderId = O.OrderId)
		WHERE S.StockSymbol = 
			(SELECT O.StockSymbol
			FROM Order_ O
			WHERE NEW.OrderId = O.OrderId);
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `live-stock`
--

USE `live-stock`;

--
-- Final view structure for view `bestsellers`
--

/*!50001 DROP VIEW IF EXISTS `bestsellers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bestsellers` AS select `o`.`StockSymbol` AS `StockSymbol`,sum(`o`.`NumShares`) AS `TotalShares` from `order_` `o` group by `o`.`StockSymbol` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mosttraded`
--

/*!50001 DROP VIEW IF EXISTS `mosttraded`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mosttraded` AS select `o`.`StockSymbol` AS `StockSymbol`,count(0) AS `NumOrders` from `order_` `o` group by `o`.`StockSymbol` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stockrevenue`
--

/*!50001 DROP VIEW IF EXISTS `stockrevenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stockrevenue` AS select `o`.`StockSymbol` AS `StockSymbol`,sum(`t`.`TransFee`) AS `TotalRevenue` from (`order_` `o` join `transact` `t`) where ((`o`.`Recorded` = 1) and (`o`.`OrderId` = `t`.`OrderId`)) group by `o`.`StockSymbol` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stocktyperevenue`
--

/*!50001 DROP VIEW IF EXISTS `stocktyperevenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stocktyperevenue` AS select `s`.`StockType` AS `StockType`,sum(`t`.`TransFee`) AS `TotalRevenue` from ((`stock` `s` join `transact` `t`) join `order_` `o`) where ((`o`.`StockSymbol` = `s`.`StockSymbol`) and (`o`.`Recorded` = 1) and (`o`.`OrderId` = `t`.`OrderId`)) group by `s`.`StockType` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `suggest`
--

/*!50001 DROP VIEW IF EXISTS `suggest`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `suggest` AS select `s`.`StockSymbol` AS `StockSymbol`,`s`.`SharePrice` AS `SharePrice`,`s`.`NumAvailShares` AS `NumAvailShares`,`s`.`StockType` AS `StockType` from (`stock` `s` join `order_` `o`) where ((`o`.`CusAccNum` = 1) and (`o`.`StockSymbol` = `s`.`StockSymbol`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-30 16:06:43
