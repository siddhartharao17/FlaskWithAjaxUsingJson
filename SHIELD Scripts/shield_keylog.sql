-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: shield
-- ------------------------------------------------------
-- Server version	5.7.19-log

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
-- Table structure for table `keylog`
--

DROP TABLE IF EXISTS `keylog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keylog` (
  `u_id` int(50) DEFAULT NULL,
  `keylog_date_time` datetime DEFAULT NULL,
  `application_name` varchar(255) DEFAULT NULL,
  `log_text` varchar(2000) DEFAULT NULL,
  `notification_id` varchar(45) DEFAULT NULL,
  `key_log_id` int(100) NOT NULL AUTO_INCREMENT,
  `unique_identifieri` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`key_log_id`),
  UNIQUE KEY `key_log_id_UNIQUE` (`key_log_id`),
  KEY `login_keylog_u_id_idx` (`u_id`),
  CONSTRAINT `login_keylog_u_id` FOREIGN KEY (`u_id`) REFERENCES `customer` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keylog`
--

LOCK TABLES `keylog` WRITE;
/*!40000 ALTER TABLE `keylog` DISABLE KEYS */;
INSERT INTO `keylog` VALUES (2,'2017-05-08 01:32:32','Untitled - Notepad','this is raw data from notpad','0',1,'2847daf13b52c1fe955236fcf6ad5575'),(2,'2017-05-08 01:36:42','untitled  - Sublime Text (UNREGISTERED)','i am typing on a different editor','0',2,'2847daf13b52c1fe955236fcf6ad2254'),(2,'2017-05-07 01:22:55','Untitled - Notepad','asd@gmail.com is my gmail id ','0',3,'2847daf99b58c3hh112233fcf6ad2254'),(1,'2017-05-07 01:19:42','Microsoft Word','jai@gmail.com','0',4,'2847daf99b58c3hh112233fcf6ad2254'),(1,'2017-05-07 03:55:42','Firefox','google.com','0',5,'2847daf99b58c3hh112233fcf6ad0099'),(1,'2017-05-06 03:22:42','Untitled - Notepad','raw data from notepad','0',6,'2847daf99b58c3hh112233fcf6ad7653'),(1,'2017-05-06 06:12:42','Microsoft Excel','i am typing my userid- 011 and password- 398772262','0',7,'2847daf99b58c3hh112233fcf6ad1100'),(3,'2017-05-03 05:15:22','untitled  - Sublime Text (UNREGISTERED)','parth@gmail.com is my gmail id.   ','0',8,'0077daf99b58c3hh112233fcf6d7709'),(3,'2017-05-03 08:12:42','Firefox','google.com','0',9,'8700daf99b58c3hh112233fcf6ad1000'),(3,'2017-05-03 09:52:42','Microsoft Word','i am typing on microsoft word and trying to open a new file','0',10,'5654daf99b58c3hh675432fcf6ad0954'),(4,'2017-05-02 08:42:42','Untitled Notepad','this is raw data from notepad','0',11,'2847daf99b58c3hh0010124fcf6ad8632'),(4,'2017-05-02 05:32:42','Mysql Workbench','trying to view and open the existing database so that i can edit the database i want to ','0',12,'1247daf99b58c3hh0099001fcf6ad8632'),(4,'2017-05-01 07:11:42','Chrome','msn.com','0',13,'0987daf99b58c3hh9813425fcf6ad8632'),(4,'2017-05-01 06:24:42','Microsoft Explorer','facebook.com','0',14,'1817daf99b58c3hh8984512fcf6am2798'),(5,'2017-04-28 01:55:42','untitled  - Sublime Text (UNREGISTERED)','typing on notepad ++ to save the email and password','0',15,'5989daf99b58c3hh010122fcf6as1989'),(5,'2017-04-27 02:23:42','Untitled - Notepad','raw data from notepad','0',16,'5647daf99b58c3hh0976543fcf6am0887'),(5,'2017-04-27 01:11:12','Firefox','open settings and delete cookie','0',17,'1091daf99b58c3lp0987142fcf6am2291');
/*!40000 ALTER TABLE `keylog` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-05 23:29:48
