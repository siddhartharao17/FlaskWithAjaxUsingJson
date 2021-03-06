-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: shield
-- ------------------------------------------------------
-- Server version	5.7.20-log

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
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat` (
  `rep_name` varchar(255) DEFAULT NULL,
  `u_id` int(50) DEFAULT NULL,
  `chat_record` text,
  `start_date_time` datetime DEFAULT NULL,
  `end_date_time` datetime DEFAULT NULL,
  `chat_id` varchar(45) NOT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `login_chat_u_id_idx` (`u_id`),
  CONSTRAINT `login_chat_u_id` FOREIGN KEY (`u_id`) REFERENCES `customer` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_card`
--

DROP TABLE IF EXISTS `credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_card` (
  `u_id` int(50) NOT NULL,
  `cc_number` varchar(256) NOT NULL DEFAULT '0',
  `cc_type` varchar(256) DEFAULT NULL,
  `security_code` varchar(256) DEFAULT NULL,
  `cc_name` varchar(50) DEFAULT NULL,
  `cc_exdate` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cc_number`),
  KEY `login_cc_u_id_idx` (`u_id`),
  CONSTRAINT `credit_card_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `customer` (`u_id`),
  CONSTRAINT `login_cc_u_id` FOREIGN KEY (`u_id`) REFERENCES `customer` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
INSERT INTO `credit_card` VALUES (3,'4222222222222222222','visa','2222','dddddddddd','2/2019'),(2,'4263873876384673573','visa','1111','Test User 1','3/2019'),(30,'4333333332333335645','visa','2222','kaur','2/2019'),(1,'4867823532893787253','visa','1223','hgehjwge','3/2019'),(4,'5644475676864566778','discover','2222','varad shere','2/2222');
/*!40000 ALTER TABLE `credit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `u_id` int(50) NOT NULL AUTO_INCREMENT,
  `username` varchar(150) NOT NULL,
  `password` varchar(145) NOT NULL,
  `auth_token` varchar(300) DEFAULT NULL,
  `login_source` varchar(145) DEFAULT NULL,
  `email_id` varchar(145) NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zip` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `role` varchar(10) DEFAULT NULL,
  `subscription_type` varchar(45) DEFAULT NULL,
  `subscribed_on` datetime DEFAULT NULL,
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `Username_UNIQUE` (`username`),
  UNIQUE KEY `u_id_UNIQUE` (`u_id`),
  KEY `login_FK_idx` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'nikhil','nikhil','qerf349843','','nikhil@gmail.com','Nikhil','Mulik','Jersey City','82 Wheeler Ave','NJ','07306','USA','4345553275','user','Basic','2017-11-01 11:00:00'),(2,'test_user1','123','934839hhg','','test_user1@shield.com','User1','Test','Jersey City','123 Bleeker Ave','NJ','07308','USA',NULL,'user','Basic',NULL),(3,'tony','tony','30284jjgge',NULL,'tony@gmail.com','Tony','XYZ ','Jersey City','230 Logan Ave','NY','10038','USA',NULL,NULL,NULL,NULL),(4,'support','123','32904872f',NULL,'shield_support','Support User1','Shere','Jersey City','53 Water St','NJ','07306','USA','3333',NULL,NULL,NULL),(5,'support1','123','34874wkfh',NULL,'support@gmail.om','support','user','New York','55 River St','NY','07310','USA',NULL,'support',NULL,NULL),(30,'johnd','12345',NULL,NULL,'johnd@gmail.com','John','Doe','abcd sdsb ','some street ','NJ','07333','',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature` (
  `feature_id` varchar(255) NOT NULL,
  `feature_name` char(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `u_id` int(50) DEFAULT NULL,
  `is_subscribed` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `feature_id_UNIQUE` (`feature_id`),
  KEY `loginfeature u_id_idx` (`feature_id`,`u_id`),
  KEY `login_feature_u_id_idx` (`u_id`),
  CONSTRAINT `login_feature_u_id` FOREIGN KEY (`u_id`) REFERENCES `customer` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES ('1','Web Cam Capture',1000,'web cam capture',1,'false'),('2','Key Log',1500,'Key Log',1,'true'),('3','Screenshot',1000,'Screenshot',1,'true'),('4','Remote Lock',2000,'Remote Lock',1,'false');
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature_info`
--

DROP TABLE IF EXISTS `feature_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature_info` (
  `mac_address` varchar(255) DEFAULT NULL,
  `u_id` int(50) NOT NULL,
  `subscribed_feature_ids` varchar(255) DEFAULT NULL,
  `installer_id` varchar(35) NOT NULL,
  `profile_id` varchar(45) NOT NULL,
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `mac_address_UNIQUE` (`mac_address`),
  KEY `login_userprofile_u_id_idx` (`u_id`),
  CONSTRAINT `login_userprofile_u_id` FOREIGN KEY (`u_id`) REFERENCES `customer` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature_info`
--

LOCK TABLES `feature_info` WRITE;
/*!40000 ALTER TABLE `feature_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `feature_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `invoice_id` varchar(255) NOT NULL,
  `created_date` varchar(255) DEFAULT NULL,
  `feature_id` varchar(255) DEFAULT NULL,
  `amount_paid` int(100) DEFAULT NULL,
  `payment_method` char(100) DEFAULT NULL,
  `u_id` int(50) NOT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `login_invoice_u_id_idx` (`u_id`),
  CONSTRAINT `login_invoice_u_id` FOREIGN KEY (`u_id`) REFERENCES `customer` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keylog`
--

DROP TABLE IF EXISTS `keylog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keylog` (
  `u_id` int(50) DEFAULT NULL,
  `keylog_timestamp` varchar(100) DEFAULT NULL,
  `application_name` varchar(255) DEFAULT NULL,
  `log_text` varchar(2000) DEFAULT NULL,
  `notification_id` varchar(45) DEFAULT NULL,
  `keylog_id` int(100) NOT NULL AUTO_INCREMENT,
  `unique_identifier` varchar(100) DEFAULT NULL,
  `img` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`keylog_id`),
  UNIQUE KEY `key_log_id_UNIQUE` (`keylog_id`),
  KEY `login_keylog_u_id_idx` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keylog`
--

LOCK TABLES `keylog` WRITE;
/*!40000 ALTER TABLE `keylog` DISABLE KEYS */;
INSERT INTO `keylog` VALUES (2,'2017-05-08 01:32:32','Untitled - Notepad','this is raw data from notpad','0',1,'2847daf13b52c1fe955236fcf6ad5575','notepad'),(2,'2017-05-08 01:36:42','untitled  - Sublime Text (UNREGISTERED)','i am typing on a different editor','0',2,'2847daf13b52c1fe955236fcf6ad2254','sublimetxt'),(2,'2017-05-07 01:22:55','Untitled - Notepad','asd@gmail.com is my gmail id ','0',3,'2847daf99b58c3hh112233fcf6ad2254','notepad'),(1,'2017-05-07 01:19:42','Microsoft Word','jai@gmail.com','0',4,'2847daf99b58c3hh112233fcf6ad2254','msword'),(1,'2017-05-07 03:55:42','Firefox','google.com','0',5,'2847daf99b58c3hh112233fcf6ad0099','firefox'),(1,'2017-05-06 03:22:42','Untitled - Notepad','raw data from notepad','0',6,'2847daf99b58c3hh112233fcf6ad7653','notepad'),(1,'2017-05-06 06:12:42','Microsoft Excel','i am typing my userid- 011 and password- 398772262','0',7,'2847daf99b58c3hh112233fcf6ad1100','msexcel'),(3,'2017-05-03 05:15:22','untitled  - Sublime Text (UNREGISTERED)','parth@gmail.com is my gmail id.   ','0',8,'0077daf99b58c3hh112233fcf6d7709','sublimetxt'),(3,'2017-05-03 08:12:42','Firefox','google.com','0',9,'8700daf99b58c3hh112233fcf6ad1000','firefox'),(3,'2017-05-03 09:52:42','Microsoft Word','i am typing on microsoft word and trying to open a new file','0',10,'5654daf99b58c3hh675432fcf6ad0954','msword'),(4,'2017-05-02 08:42:42','Untitled Notepad','this is raw data from notepad','0',11,'2847daf99b58c3hh0010124fcf6ad8632','notepad'),(4,'2017-05-02 05:32:42','Mysql Workbench','trying to view and open the existing database so that i can edit the database i want to ','0',12,'1247daf99b58c3hh0099001fcf6ad8632','workbench'),(4,'2017-05-01 07:11:42','Chrome','msn.com','0',13,'0987daf99b58c3hh9813425fcf6ad8632','chrome'),(4,'2017-05-01 06:24:42','Microsoft Explorer','facebook.com','0',14,'1817daf99b58c3hh8984512fcf6am2798','iexplorer'),(5,'2017-04-28 01:55:42','untitled  - Sublime Text (UNREGISTERED)','typing on notepad ++ to save the email and password','0',15,'5989daf99b58c3hh010122fcf6as1989','sublimetxt'),(5,'2017-04-27 02:23:42','Untitled - Notepad','raw data from notepad','0',16,'5647daf99b58c3hh0976543fcf6am0887','notepad'),(5,'2017-04-27 01:11:12','Firefox','open settings and delete cookie','0',17,'1091daf99b58c3lp0987142fcf6am2291','firefox');
/*!40000 ALTER TABLE `keylog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `notification_id` varchar(255) NOT NULL,
  `notification_message` varchar(255) DEFAULT NULL,
  `notification_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  UNIQUE KEY `notification_id_UNIQUE` (`notification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scrshot_capture`
--

DROP TABLE IF EXISTS `scrshot_capture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scrshot_capture` (
  `u_id` int(50) DEFAULT NULL,
  `scrshot_date_time` datetime DEFAULT NULL,
  `image_id` varchar(50) DEFAULT NULL,
  `scrshot_id` int(11) NOT NULL AUTO_INCREMENT,
  `mac_address` varchar(255) DEFAULT NULL,
  `image_url` longtext,
  PRIMARY KEY (`scrshot_id`),
  KEY `profile_mac_address_idx` (`mac_address`),
  KEY `login_scrshotcapture_u_id_idx` (`u_id`),
  CONSTRAINT `login_scrshotcapture_u_id` FOREIGN KEY (`u_id`) REFERENCES `customer` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scrshot_capture`
--

LOCK TABLES `scrshot_capture` WRITE;
/*!40000 ALTER TABLE `scrshot_capture` DISABLE KEYS */;
INSERT INTO `scrshot_capture` VALUES (1,'2017-12-01 17:18:26',NULL,24,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-18-25.png'),(1,'2017-12-01 17:19:27',NULL,25,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-19-25.png'),(1,'2017-12-01 17:20:28',NULL,26,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-20-26.png'),(1,'2017-12-01 17:21:28',NULL,27,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-21-27.png'),(1,'2017-12-01 17:22:29',NULL,28,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-22-27.png'),(1,'2017-12-01 17:23:29',NULL,29,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-23-28.png'),(1,'2017-12-01 17:24:29',NULL,30,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-24-28.png'),(1,'2017-12-01 17:25:30',NULL,31,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-25-29.png'),(1,'2017-12-01 17:26:30',NULL,32,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-26-29.png'),(1,'2017-12-01 17:27:31',NULL,33,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-27-30.png'),(1,'2017-12-01 17:28:31',NULL,34,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-28-30.png'),(1,'2017-12-01 17:36:46',NULL,35,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-36-45.png'),(1,'2017-12-01 17:37:46',NULL,36,NULL,'ScrShot_Images\\myScreen_Dec_01_2017_17-37-45.png');
/*!40000 ALTER TABLE `scrshot_capture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smart_device`
--

DROP TABLE IF EXISTS `smart_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smart_device` (
  `device_bluetooth_id` varchar(255) NOT NULL,
  `device_name` varchar(255) DEFAULT NULL,
  KEY `smartlockbluetooth_id_idx` (`device_bluetooth_id`),
  CONSTRAINT `smartlockbluetooth_id` FOREIGN KEY (`device_bluetooth_id`) REFERENCES `smart_lock` (`device_bluetooth_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smart_device`
--

LOCK TABLES `smart_device` WRITE;
/*!40000 ALTER TABLE `smart_device` DISABLE KEYS */;
/*!40000 ALTER TABLE `smart_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smart_lock`
--

DROP TABLE IF EXISTS `smart_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smart_lock` (
  `device_bluetooth_id` varchar(255) NOT NULL,
  `smartlock_date_time` datetime DEFAULT NULL,
  `u_id` int(50) DEFAULT NULL,
  `notification_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`device_bluetooth_id`),
  KEY `notification_id_idx` (`notification_id`),
  KEY `logn_smartlock_u_id_idx` (`u_id`),
  CONSTRAINT `logn_smartlock_u_id` FOREIGN KEY (`u_id`) REFERENCES `customer` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `notification_id` FOREIGN KEY (`notification_id`) REFERENCES `notification` (`notification_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smart_lock`
--

LOCK TABLES `smart_lock` WRITE;
/*!40000 ALTER TABLE `smart_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `smart_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webcam_capture`
--

DROP TABLE IF EXISTS `webcam_capture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webcam_capture` (
  `u_id` int(50) DEFAULT NULL,
  `webcam_date_time` datetime DEFAULT NULL,
  `image_id` varchar(50) DEFAULT NULL,
  `webcam_id` int(11) NOT NULL AUTO_INCREMENT,
  `mac_address` varchar(255) DEFAULT NULL,
  `image_url` longtext,
  PRIMARY KEY (`webcam_id`),
  KEY `profile_mac_address_idx` (`mac_address`),
  KEY `login_webcamcapture_u_id_idx` (`u_id`),
  CONSTRAINT `login_webcamcapture_u_id` FOREIGN KEY (`u_id`) REFERENCES `customer` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webcam_capture`
--

LOCK TABLES `webcam_capture` WRITE;
/*!40000 ALTER TABLE `webcam_capture` DISABLE KEYS */;
INSERT INTO `webcam_capture` VALUES (1,'2016-08-10 00:11:34',NULL,17,NULL,'Webcam_Images\\intrusion_Aug_10_2016_00-11-33.png'),(1,'2017-01-10 00:12:55',NULL,18,NULL,'Webcam_Images\\intrusion_Jan_10_2017_00-12-54.png'),(1,'2017-11-10 00:16:51',NULL,19,NULL,'Webcam_Images\\intrusion_Nov_10_2017_00-16-49.png'),(1,'2017-11-10 00:17:51',NULL,20,NULL,'Webcam_Images\\intrusion_Nov_10_2017_00-17-50.png'),(1,'2017-11-10 17:40:17',NULL,21,NULL,'Webcam_Images\\intrusion_Nov_10_2017_17-40-16.png'),(1,'2017-11-10 17:44:09',NULL,22,NULL,'Webcam_Images\\intrusion_Nov_10_2017_17-41-40.png'),(1,'2017-11-10 17:44:10',NULL,23,NULL,'Webcam_Images\\intrusion_Nov_10_2017_17-42-12.png'),(1,'2016-11-10 17:44:10',NULL,24,NULL,'Webcam_Images\\intrusion_Nov_10_2016_17-42-12.png'),(1,'2017-05-10 17:44:10',NULL,25,NULL,'Webcam_Images\\intrusion_May_10_2017_17-44-10.png'),(1,'2017-05-10 17:44:23',NULL,26,NULL,'Webcam_Images\\intrusion_May_10_2017_17-44-23.png'),(1,'2016-11-10 17:44:10',NULL,27,NULL,'Webcam_Images\\intrusion_Nov_10_2016_17-44-10.png'),(1,'2016-11-10 17:44:13',NULL,28,NULL,'Webcam_Images\\intrusion_Nov_10_2016_17-42-13.png');
/*!40000 ALTER TABLE `webcam_capture` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-14  2:46:55
