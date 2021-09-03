-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: redemrp
-- ------------------------------------------------------
-- Server version	5.5.5-10.5.8-MariaDB

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
-- Table structure for table `boates`
--

DROP TABLE IF EXISTS `boates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boates` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `boat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boates`
--

LOCK TABLES `boates` WRITE;
/*!40000 ALTER TABLE `boates` DISABLE KEYS */;
/*!40000 ALTER TABLE `boates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `characterid` int(11) DEFAULT 0,
  `money` int(11) DEFAULT 0,
  `gold` int(11) DEFAULT 0,
  `xp` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 0,
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'first',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'last',
  `jobgrade` int(11) DEFAULT 0,
  `coords` varchar(2000) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` VALUES (25,'steam:110000101ae5b61',1,52055,55555,115,4,'unemployed','Dad','Dad',0,'{\"z\":121.97614288330078,\"x\":-265.91461181640627,\"y\":844.6067504882813}'),(26,'steam:110000101ae5b61',2,565656,565,555,44,'moonshiner','JJ','Switzer',2,'{\"x\":215.860595703125,\"z\":190.9054718017578,\"y\":987.504150390625}');
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clothes`
--

DROP TABLE IF EXISTS `clothes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clothes` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `clothes` varchar(6000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clothes`
--

LOCK TABLES `clothes` WRITE;
/*!40000 ALTER TABLE `clothes` DISABLE KEYS */;
INSERT INTO `clothes` VALUES ('steam:110000101ae5b61',1,'{\"poncho\":\"25\",\"shirt\":\"123\",\"name\":\"dD\",\"value\":true,\"bandana\":\"1\",\"offhand\":\"47\",\"eyewear\":\"1\",\"gloves\":\"1\",\"gunbelts\":\"43\",\"spurs\":\"1\",\"mask\":\"25\",\"beltbuckle\":\"1\",\"boots\":\"202\",\"belts\":\"36\",\"vest\":\"79\",\"suspenders\":\"32\",\"skirt\":\"1\",\"coat\":\"1\",\"pants\":\"106\",\"hat\":\"358\",\"neckties\":\"1\"}'),('steam:110000101ae5b61',2,'{\"value\":true,\"neckties\":\"1\",\"name\":\"test\",\"beltbuckle\":\"1\",\"offhand\":\"47\",\"suspenders\":\"32\",\"gloves\":\"1\",\"pants\":\"271\",\"belts\":\"36\",\"eyewear\":\"1\",\"vest\":\"1\",\"boots\":\"127\",\"coat\":\"1\",\"poncho\":\"1\",\"bandana\":\"1\",\"gunbelts\":\"43\",\"skirt\":\"1\",\"shirt\":\"1\",\"spurs\":\"1\",\"hat\":\"7\",\"mask\":\"1\"}'),('steam:110000101ae5b61',3,'{\"suspenders\":\"32\",\"boots\":\"81\",\"spurs\":\"1\",\"belts\":\"36\",\"offhand\":\"51\",\"name\":\"test\",\"mask\":\"36\",\"neckties\":\"1\",\"beltbuckle\":\"4\",\"gunbelts\":\"50\",\"vest\":\"59\",\"value\":true,\"gloves\":\"3\",\"shirt\":\"88\",\"coat\":\"1\",\"poncho\":\"14\",\"pants\":\"64\",\"bandana\":\"4\",\"skirt\":\"1\",\"eyewear\":\"9\",\"hat\":\"186\"}');
/*!40000 ALTER TABLE `clothes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coaches`
--

DROP TABLE IF EXISTS `coaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coaches` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `coach` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coaches`
--

LOCK TABLES `coaches` WRITE;
/*!40000 ALTER TABLE `coaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `coaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complementos_caballo`
--

DROP TABLE IF EXISTS `complementos_caballo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complementos_caballo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steamid` varchar(45) NOT NULL,
  `charid` tinyint(2) NOT NULL,
  `nombre_complemento` varchar(50) NOT NULL,
  `tipo` int(1) NOT NULL,
  `hash` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complementos_caballo`
--

LOCK TABLES `complementos_caballo` WRITE;
/*!40000 ALTER TABLE `complementos_caballo` DISABLE KEYS */;
/*!40000 ALTER TABLE `complementos_caballo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coords`
--

DROP TABLE IF EXISTS `coords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coords` (
  `characterid` tinyint(11) NOT NULL,
  `identifier` varchar(22) NOT NULL,
  `coords` longtext NOT NULL,
  PRIMARY KEY (`characterid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coords`
--

LOCK TABLES `coords` WRITE;
/*!40000 ALTER TABLE `coords` DISABLE KEYS */;
/*!40000 ALTER TABLE `coords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dogs`
--

DROP TABLE IF EXISTS `dogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dogs` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `dog` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dogs`
--

LOCK TABLES `dogs` WRITE;
/*!40000 ALTER TABLE `dogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `dogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horses`
--

DROP TABLE IF EXISTS `horses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horses` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `horse` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horses`
--

LOCK TABLES `horses` WRITE;
/*!40000 ALTER TABLE `horses` DISABLE KEYS */;
/*!40000 ALTER TABLE `horses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outfits`
--

DROP TABLE IF EXISTS `outfits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outfits` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `clothes` varchar(6255) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outfits`
--

LOCK TABLES `outfits` WRITE;
/*!40000 ALTER TABLE `outfits` DISABLE KEYS */;
INSERT INTO `outfits` VALUES ('steam:110000101ae5b61',2,'{\"value\":true,\"neckties\":\"1\",\"name\":\"test\",\"beltbuckle\":\"1\",\"offhand\":\"47\",\"suspenders\":\"32\",\"gloves\":\"1\",\"pants\":\"271\",\"belts\":\"36\",\"eyewear\":\"1\",\"vest\":\"1\",\"boots\":\"127\",\"coat\":\"1\",\"poncho\":\"1\",\"bandana\":\"1\",\"gunbelts\":\"43\",\"skirt\":\"1\",\"shirt\":\"1\",\"spurs\":\"1\",\"hat\":\"7\",\"mask\":\"1\"}','test'),('steam:110000101ae5b61',3,'{\"suspenders\":\"32\",\"boots\":\"81\",\"spurs\":\"1\",\"belts\":\"36\",\"offhand\":\"51\",\"name\":\"test\",\"mask\":\"36\",\"neckties\":\"1\",\"beltbuckle\":\"4\",\"gunbelts\":\"50\",\"vest\":\"59\",\"value\":true,\"gloves\":\"3\",\"shirt\":\"88\",\"coat\":\"1\",\"poncho\":\"14\",\"pants\":\"64\",\"bandana\":\"4\",\"skirt\":\"1\",\"eyewear\":\"9\",\"hat\":\"186\"}','test'),('steam:110000101ae5b61',1,'{\"poncho\":\"25\",\"shirt\":\"123\",\"name\":\"dD\",\"value\":true,\"bandana\":\"1\",\"offhand\":\"47\",\"eyewear\":\"1\",\"gloves\":\"1\",\"gunbelts\":\"43\",\"spurs\":\"1\",\"mask\":\"25\",\"beltbuckle\":\"1\",\"boots\":\"202\",\"belts\":\"36\",\"vest\":\"79\",\"suspenders\":\"32\",\"skirt\":\"1\",\"coat\":\"1\",\"pants\":\"106\",\"hat\":\"358\",\"neckties\":\"1\"}','dD');
/*!40000 ALTER TABLE `outfits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skins`
--

DROP TABLE IF EXISTS `skins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skins` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `skin` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skins`
--

LOCK TABLES `skins` WRITE;
/*!40000 ALTER TABLE `skins` DISABLE KEYS */;
INSERT INTO `skins` VALUES ('steam:110000101ae5b61',1,'{\"eyes_angle\":\"0\",\"ears_height\":\"0\",\"eyebrow_depth\":\"0\",\"nose_angle\":\"0\",\"moles_t\":\"1\",\"jaw_depth\":\"0\",\"cheekbones_height\":\"0\",\"skincolor\":\"3\",\"ears_width\":\"0\",\"eyes_depth\":\"0\",\"lower_lip_depth\":\"0\",\"beard\":\"1\",\"chin_height\":\"0\",\"eyes_distance\":\"0\",\"spots_t\":\"1\",\"cheekbones_depth\":\"0\",\"earlobe_size\":\"0\",\"upper_lip_depth\":\"0\",\"bodysize\":\"3\",\"nose_width\":\"0\",\"cheekbones_width\":\"0\",\"eyebrows_c3\":\"1\",\"eyebrows_op\":\"1\",\"sex\":\"1\",\"mouth_y_pos\":\"0\",\"nostrils_distance\":\"0\",\"eyebrow_height\":\"0\",\"upper_lip_width\":\"0\",\"freckles_op\":\"1\",\"eyebrows_c1\":\"1\",\"eyebrow_width\":\"0\",\"ageing_t\":\"1\",\"eyebrows_t\":\"1\",\"lower_lip_height\":\"0\",\"eyelid_height\":\"0\",\"upper_lip_height\":\"0\",\"mouth_x_pos\":\"0\",\"jaw_width\":\"0\",\"mouth_depth\":\"0\",\"chin_depth\":\"0\",\"eyebrows_id\":\"1\",\"eyecolor\":\"2\",\"nose_height\":\"0\",\"chin_width\":\"0\",\"face\":\"1\",\"mouth_width\":\"0\",\"hair\":\"1\",\"lower_lip_width\":\"0\",\"spots_op\":\"1\",\"scars_t\":\"1\",\"eyebrows_c2\":\"1\",\"face_width\":\"0\",\"moles_op\":\"1\",\"scars_op\":\"1\",\"value\":true,\"nose_size\":\"0\",\"nose_curvature\":\"0\",\"ears_angle\":\"0\",\"freckles_t\":\"1\",\"jaw_height\":\"0\",\"eyelid_width\":\"0\",\"ageing_op\":\"1\"}'),('steam:110000101ae5b61',2,'{\"jaw_height\":\"0\",\"chin_height\":\"0\",\"eyebrows_id\":\"1\",\"value\":true,\"eyebrows_op\":\"56\",\"eyebrow_depth\":\"0\",\"nose_height\":\"0\",\"jaw_width\":\"0\",\"upper_lip_width\":\"0\",\"mouth_width\":\"0\",\"eyes_distance\":\"0\",\"eyes_angle\":\"0\",\"eyebrows_c3\":\"1\",\"eyebrows_t\":\"9\",\"ears_width\":\"0\",\"scars_op\":\"1\",\"face_width\":\"0\",\"chin_depth\":\"0\",\"sex\":\"1\",\"lower_lip_depth\":\"0\",\"bodysize\":\"3\",\"jaw_depth\":\"0\",\"eyecolor\":\"3\",\"chin_width\":\"0\",\"eyebrow_height\":\"0\",\"ears_height\":\"0\",\"lower_lip_height\":\"0\",\"ageing_t\":\"1\",\"eyebrows_c2\":\"1\",\"spots_op\":\"1\",\"cheekbones_depth\":\"0\",\"ageing_op\":\"1\",\"scars_t\":\"1\",\"freckles_t\":\"1\",\"beard\":\"65\",\"upper_lip_height\":\"0\",\"moles_op\":\"1\",\"eyelid_width\":\"0\",\"spots_t\":\"1\",\"ears_angle\":\"0\",\"nose_angle\":\"0\",\"moles_t\":\"1\",\"nose_curvature\":\"0\",\"nose_width\":\"0\",\"mouth_x_pos\":\"0\",\"upper_lip_depth\":\"0\",\"eyes_depth\":\"0\",\"lower_lip_width\":\"0\",\"mouth_y_pos\":\"0\",\"cheekbones_width\":\"0\",\"earlobe_size\":\"0\",\"eyelid_height\":\"0\",\"nose_size\":\"0\",\"nostrils_distance\":\"0\",\"eyebrow_width\":\"0\",\"face\":\"1\",\"hair\":\"164\",\"cheekbones_height\":\"0\",\"eyebrows_c1\":\"1\",\"mouth_depth\":\"0\",\"freckles_op\":\"1\",\"skincolor\":\"3\"}'),('steam:110000101ae5b61',3,'{\"face_width\":\"0\",\"jaw_width\":\"0\",\"bodysize\":\"3\",\"upper_lip_depth\":\"0\",\"eyecolor\":\"2\",\"ageing_t\":\"13\",\"lower_lip_width\":\"0\",\"eyebrows_c3\":\"160\",\"eyes_angle\":\"0\",\"value\":true,\"lower_lip_depth\":\"0\",\"eyebrows_op\":\"42\",\"ears_angle\":\"0\",\"chin_width\":\"0\",\"eyebrows_t\":\"12\",\"cheekbones_depth\":\"0\",\"upper_lip_height\":\"0\",\"freckles_op\":\"46\",\"moles_op\":\"38\",\"nostrils_distance\":\"0\",\"spots_t\":\"7\",\"eyebrow_width\":\"0\",\"jaw_depth\":\"0\",\"cheekbones_height\":\"0\",\"ears_width\":\"0\",\"hair\":\"298\",\"freckles_t\":\"5\",\"eyebrows_c1\":\"102\",\"eyelid_height\":\"0\",\"lower_lip_height\":\"0\",\"upper_lip_width\":\"0\",\"cheekbones_width\":\"0\",\"eyebrow_depth\":\"0\",\"eyes_depth\":\"0\",\"nose_width\":\"0\",\"mouth_x_pos\":\"0\",\"chin_depth\":\"0\",\"nose_curvature\":\"0\",\"mouth_y_pos\":\"0\",\"beard\":\"258\",\"skincolor\":\"3\",\"scars_op\":\"40\",\"ears_height\":\"0\",\"eyebrow_height\":\"0\",\"nose_angle\":\"0\",\"earlobe_size\":\"0\",\"eyebrows_id\":\"12\",\"eyebrows_c2\":\"149\",\"jaw_height\":\"0\",\"nose_size\":\"0\",\"mouth_width\":\"0\",\"sex\":\"1\",\"spots_op\":\"19\",\"ageing_op\":\"38\",\"moles_t\":\"5\",\"face\":\"1\",\"chin_height\":\"0\",\"eyes_distance\":\"0\",\"scars_t\":\"10\",\"nose_height\":\"0\",\"eyelid_width\":\"0\",\"mouth_depth\":\"0\"}');
/*!40000 ALTER TABLE `skins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stables`
--

DROP TABLE IF EXISTS `stables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `charid` int(11) DEFAULT 0,
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT 'Horse',
  `vehicles` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `type` varchar(11) COLLATE utf8mb4_bin DEFAULT NULL,
  `bondxp` int(11) DEFAULT 0,
  `stabled` tinyint(1) DEFAULT 1,
  `healthy` tinyint(1) DEFAULT 1,
  `default` tinyint(1) DEFAULT 0,
  `saddle` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `blanket` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `mane` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `tail` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `bag` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `bedroll` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `stirups` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stables`
--

LOCK TABLES `stables` WRITE;
/*!40000 ALTER TABLE `stables` DISABLE KEYS */;
/*!40000 ALTER TABLE `stables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undead`
--

DROP TABLE IF EXISTS `undead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `undead` (
  `id` char(40) NOT NULL,
  `name` varchar(255) NOT NULL,
  `killed` int(10) unsigned DEFAULT 0,
  `murders` int(10) unsigned DEFAULT 0,
  `deaths` int(10) unsigned DEFAULT 0,
  `lossed` int(10) unsigned DEFAULT 0,
  `pvpkills` int(10) unsigned DEFAULT 0,
  `pvpdeaths` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undead`
--

LOCK TABLES `undead` WRITE;
/*!40000 ALTER TABLE `undead` DISABLE KEYS */;
INSERT INTO `undead` VALUES ('de6e9ef166705f174b32dd2f818170534edcbd85','xmindpingx',325,84,59,282,0,9);
/*!40000 ALTER TABLE `undead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_inventory`
--

DROP TABLE IF EXISTS `user_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_inventory` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `charid` int(11) NOT NULL,
  `items` varchar(8000) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_inventory`
--

LOCK TABLES `user_inventory` WRITE;
/*!40000 ALTER TABLE `user_inventory` DISABLE KEYS */;
INSERT INTO `user_inventory` VALUES ('steam:110000101ae5b61',3,'[{\"amount\":3,\"meta\":[],\"name\":\"water\"},{\"amount\":3,\"meta\":[],\"name\":\"bread\"}]'),('steam:110000101ae5b61',1,'[{\"name\":\"water\",\"amount\":3,\"meta\":[]},{\"name\":\"bread\",\"amount\":3,\"meta\":[]}]'),('steam:110000101ae5b61',2,'[{\"meta\":[],\"name\":\"bread\",\"amount\":3},{\"meta\":[],\"name\":\"water\",\"amount\":3}]');
/*!40000 ALTER TABLE `user_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_locker`
--

DROP TABLE IF EXISTS `user_locker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_locker` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `charid` int(11) NOT NULL,
  `items` varchar(16000) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_locker`
--

LOCK TABLES `user_locker` WRITE;
/*!40000 ALTER TABLE `user_locker` DISABLE KEYS */;
INSERT INTO `user_locker` VALUES ('steam:110000101ae5b61',1,'[]'),('steam:110000101ae5b61',2,'[]'),('steam:110000101ae5b61',3,'[]');
/*!40000 ALTER TABLE `user_locker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `id` int(11) NOT NULL,
  `current` varchar(3) COLLATE utf8mb4_bin DEFAULT 'no',
  `resource` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'redemrp'
--

--
-- Dumping routines for database 'redemrp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-18 18:54:12
