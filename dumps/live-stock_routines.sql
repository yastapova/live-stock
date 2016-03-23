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
-- Temporary view structure for view `customerrevenue`
--

DROP TABLE IF EXISTS `customerrevenue`;
/*!50001 DROP VIEW IF EXISTS `customerrevenue`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `customerrevenue` AS SELECT 
 1 AS `CusAccNum`,
 1 AS `TotalRevenue`*/;
SET character_set_client = @saved_cs_client;

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
-- Temporary view structure for view `customerevenue`
--

DROP TABLE IF EXISTS `customerevenue`;
/*!50001 DROP VIEW IF EXISTS `customerevenue`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `customerevenue` AS SELECT 
 1 AS `CusAccNum`,
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
-- Temporary view structure for view `employeerevenue`
--

DROP TABLE IF EXISTS `employeerevenue`;
/*!50001 DROP VIEW IF EXISTS `employeerevenue`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `employeerevenue` AS SELECT 
 1 AS `EmpId`,
 1 AS `TotalRevenue`*/;
SET character_set_client = @saved_cs_client;

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
-- Final view structure for view `customerrevenue`
--

/*!50001 DROP VIEW IF EXISTS `customerrevenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customerrevenue` AS select `o`.`CusAccNum` AS `CusAccNum`,sum(`t`.`TransFee`) AS `TotalRevenue` from (`order_` `o` join `transact` `t`) where ((`o`.`Recorded` = 1) and (`o`.`OrderId` = `t`.`OrderId`)) group by `o`.`CusAccNum` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

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
-- Final view structure for view `customerevenue`
--

/*!50001 DROP VIEW IF EXISTS `customerevenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customerevenue` AS select `o`.`CusAccNum` AS `CusAccNum`,sum(`t`.`TransFee`) AS `TotalRevenue` from (`order_` `o` join `transact` `t`) where ((`o`.`Recorded` = 1) and (`o`.`OrderId` = `t`.`OrderId`)) group by `o`.`CusAccNum` */;
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
-- Final view structure for view `employeerevenue`
--

/*!50001 DROP VIEW IF EXISTS `employeerevenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employeerevenue` AS select `o`.`EmpId` AS `EmpId`,sum(`t`.`TransFee`) AS `TotalRevenue` from (`order_` `o` join `transact` `t`) where ((`o`.`OrderId` = `t`.`OrderId`) and (`o`.`Recorded` = 1) and (`o`.`EmpId` <> 0)) group by `o`.`EmpId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'live-stock'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-23 13:58:21
