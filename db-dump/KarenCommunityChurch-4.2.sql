-- mysqldump-php https://github.com/ifsnop/mysqldump-php
--
-- Host: localhost	Database: churchcrm
-- ------------------------------------------------------
-- Server version 	5.5.5-10.4.17-MariaDB
-- Date: Fri, 15 Jan 2021 11:29:00 +0300

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
-- Table structure for table `calendars`
--

DROP TABLE IF EXISTS `calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendars` (
  `calendar_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `accesstoken` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `foregroundColor` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `backgroundColor` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`calendar_id`),
  UNIQUE KEY `accesstoken` (`accesstoken`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendars`
--

LOCK TABLES `calendars` WRITE;
/*!40000 ALTER TABLE `calendars` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `calendars` VALUES (1,'Public Calendar',NULL,'FFFFFF','00AA00'),(2,'Private Calendar',NULL,'FFFFFF','0000AA');
/*!40000 ALTER TABLE `calendars` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `calendars` with 2 row(s)
--

--
-- Table structure for table `calendar_events`
--

DROP TABLE IF EXISTS `calendar_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_events` (
  `calendar_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  PRIMARY KEY (`calendar_id`,`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_events`
--

LOCK TABLES `calendar_events` WRITE;
/*!40000 ALTER TABLE `calendar_events` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `calendar_events` VALUES (1,2);
/*!40000 ALTER TABLE `calendar_events` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `calendar_events` with 1 row(s)
--

--
-- Table structure for table `canvassdata_can`
--

DROP TABLE IF EXISTS `canvassdata_can`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canvassdata_can` (
  `can_ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `can_famID` mediumint(9) NOT NULL DEFAULT 0,
  `can_Canvasser` mediumint(9) NOT NULL DEFAULT 0,
  `can_FYID` mediumint(9) DEFAULT NULL,
  `can_date` date DEFAULT NULL,
  `can_Positive` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `can_Critical` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `can_Insightful` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `can_Financial` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `can_Suggestion` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `can_NotInterested` tinyint(1) NOT NULL DEFAULT 0,
  `can_WhyNotInterested` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`can_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canvassdata_can`
--

LOCK TABLES `canvassdata_can` WRITE;
/*!40000 ALTER TABLE `canvassdata_can` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `canvassdata_can` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `canvassdata_can` with 0 row(s)
--

--
-- Table structure for table `church_location_person`
--

DROP TABLE IF EXISTS `church_location_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `church_location_person` (
  `location_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  `person_location_role_id` int(11) NOT NULL,
  PRIMARY KEY (`location_id`,`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `church_location_person`
--

LOCK TABLES `church_location_person` WRITE;
/*!40000 ALTER TABLE `church_location_person` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `church_location_person` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `church_location_person` with 0 row(s)
--

--
-- Table structure for table `church_location_role`
--

DROP TABLE IF EXISTS `church_location_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `church_location_role` (
  `location_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `role_order` int(11) NOT NULL,
  `role_title` int(11) NOT NULL,
  PRIMARY KEY (`location_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `church_location_role`
--

LOCK TABLES `church_location_role` WRITE;
/*!40000 ALTER TABLE `church_location_role` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `church_location_role` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `church_location_role` with 0 row(s)
--

--
-- Table structure for table `config_cfg`
--

DROP TABLE IF EXISTS `config_cfg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_cfg` (
  `cfg_id` int(11) NOT NULL DEFAULT 0,
  `cfg_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cfg_value` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`cfg_id`),
  UNIQUE KEY `cfg_name` (`cfg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_cfg`
--

LOCK TABLES `config_cfg` WRITE;
/*!40000 ALTER TABLE `config_cfg` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `config_cfg` VALUES (23,'sDefaultCountry','Kenya'),(28,'bSMTPAuth',''),(30,'sSMTPPass','secret'),(48,'bHideFriendDate',''),(49,'bHideFamilyNewsletter',''),(50,'bHideWeddingDate',''),(51,'bHideLatLon',''),(52,'bUseDonationEnvelopes',''),(53,'sHeader','Karen Community Church'),(58,'bUseScannedChecks',''),(64,'sDistanceUnit','kilometers'),(65,'sTimeZone','Africa/Nairobi'),(67,'bForceUppercaseZip',''),(72,'bEnableNonDeductible',''),(80,'bEnableSelfRegistration',''),(102,'sDateFormatLong','d/m/Y'),(103,'sDateFormatNoYear','d/m'),(999,'bRegistered',''),(1003,'sChurchName','Karen Community Church'),(1027,'sPledgeSummary2','as of'),(1028,'sDirectoryDisclaimer1','Every effort was made to insure the accuracy of this directory.  If there are any errors or omissions, please contact the church office.This directory is for the use of the people of'),(1035,'bEnableGravatarPhotos',''),(1036,'bEnableExternalBackupTarget',''),(1037,'sExternalBackupType','WebDAV'),(1046,'sLastIntegrityCheckTimeStamp','20210114-150822'),(1047,'sChurchCountry','Kenya'),(2010,'bAllowEmptyLastName',''),(2013,'sChurchWebSite','https://www.karencommunitychurch.org/'),(2017,'bEnableExternalCalendarAPI','1'),(2045,'bPHPMailerAutoTLS',''),(2046,'sPHPMailerSMTPSecure',''),(2050,'bEnabledMenuLinks',''),(2060,'IncludeDataInNewPersonNotifications',''),(2061,'bSearchIncludeFamilyCustomProperties',''),(2062,'bBackupExtraneousImages',''),(2064,'sLastSoftwareUpdateCheckTimeStamp','20210115-100210'),(2065,'bAllowPrereleaseUpgrade',''),(2069,'bRequire2FA',''),(2071,'bSendUserDeletedEmail',''),(2073,'bEnabledDashboardV2','1'),(20142,'bHSTSEnable','');
/*!40000 ALTER TABLE `config_cfg` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `config_cfg` with 41 row(s)
--

--
-- Table structure for table `deposit_dep`
--

DROP TABLE IF EXISTS `deposit_dep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deposit_dep` (
  `dep_ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `dep_Date` date DEFAULT NULL,
  `dep_Comment` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `dep_EnteredBy` mediumint(9) unsigned DEFAULT NULL,
  `dep_Closed` tinyint(1) NOT NULL DEFAULT 0,
  `dep_Type` enum('Bank','CreditCard','BankDraft','eGive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Bank',
  PRIMARY KEY (`dep_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposit_dep`
--

LOCK TABLES `deposit_dep` WRITE;
/*!40000 ALTER TABLE `deposit_dep` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `deposit_dep` VALUES (1,'2021-01-12','Churches are businesses',NULL,0,'Bank');
/*!40000 ALTER TABLE `deposit_dep` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `deposit_dep` with 1 row(s)
--

--
-- Table structure for table `donateditem_di`
--

DROP TABLE IF EXISTS `donateditem_di`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `donateditem_di` (
  `di_ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `di_item` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `di_FR_ID` mediumint(9) unsigned NOT NULL,
  `di_donor_ID` mediumint(9) NOT NULL DEFAULT 0,
  `di_buyer_ID` mediumint(9) NOT NULL DEFAULT 0,
  `di_multibuy` smallint(1) NOT NULL DEFAULT 0,
  `di_title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `di_description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `di_sellprice` decimal(8,2) DEFAULT NULL,
  `di_estprice` decimal(8,2) DEFAULT NULL,
  `di_minimum` decimal(8,2) DEFAULT NULL,
  `di_materialvalue` decimal(8,2) DEFAULT NULL,
  `di_EnteredBy` smallint(5) unsigned NOT NULL DEFAULT 0,
  `di_EnteredDate` date NOT NULL,
  `di_picture` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`di_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donateditem_di`
--

LOCK TABLES `donateditem_di` WRITE;
/*!40000 ALTER TABLE `donateditem_di` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `donateditem_di` VALUES (1,'Test_Item',1,0,0,0,'Test_Fundraiser','',0.00,0.00,0.00,0.00,1,'2021-01-12','');
/*!40000 ALTER TABLE `donateditem_di` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `donateditem_di` with 1 row(s)
--

--
-- Table structure for table `donationfund_fun`
--

DROP TABLE IF EXISTS `donationfund_fun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `donationfund_fun` (
  `fun_ID` tinyint(3) NOT NULL AUTO_INCREMENT,
  `fun_Active` enum('true','false') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'true',
  `fun_Name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fun_Description` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fun_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donationfund_fun`
--

LOCK TABLES `donationfund_fun` WRITE;
/*!40000 ALTER TABLE `donationfund_fun` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `donationfund_fun` VALUES (1,'true','Pledges','Pledge income for the operating budget');
/*!40000 ALTER TABLE `donationfund_fun` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `donationfund_fun` with 1 row(s)
--

--
-- Table structure for table `egive_egv`
--

DROP TABLE IF EXISTS `egive_egv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `egive_egv` (
  `egv_egiveID` varchar(16) CHARACTER SET utf8 NOT NULL,
  `egv_famID` int(11) NOT NULL,
  `egv_DateEntered` datetime NOT NULL,
  `egv_DateLastEdited` datetime NOT NULL,
  `egv_EnteredBy` smallint(6) NOT NULL DEFAULT 0,
  `egv_EditedBy` smallint(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `egive_egv`
--

LOCK TABLES `egive_egv` WRITE;
/*!40000 ALTER TABLE `egive_egv` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `egive_egv` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `egive_egv` with 0 row(s)
--

--
-- Table structure for table `email_message_pending_emp`
--

DROP TABLE IF EXISTS `email_message_pending_emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_message_pending_emp` (
  `emp_usr_id` mediumint(9) unsigned NOT NULL DEFAULT 0,
  `emp_to_send` smallint(5) unsigned NOT NULL DEFAULT 0,
  `emp_subject` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `emp_message` text COLLATE utf8_unicode_ci NOT NULL,
  `emp_attach_name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `emp_attach` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_message_pending_emp`
--

LOCK TABLES `email_message_pending_emp` WRITE;
/*!40000 ALTER TABLE `email_message_pending_emp` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `email_message_pending_emp` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `email_message_pending_emp` with 0 row(s)
--

--
-- Table structure for table `email_recipient_pending_erp`
--

DROP TABLE IF EXISTS `email_recipient_pending_erp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_recipient_pending_erp` (
  `erp_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `erp_usr_id` mediumint(9) unsigned NOT NULL DEFAULT 0,
  `erp_num_attempt` smallint(5) unsigned NOT NULL DEFAULT 0,
  `erp_failed_time` datetime DEFAULT NULL,
  `erp_email_address` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_recipient_pending_erp`
--

LOCK TABLES `email_recipient_pending_erp` WRITE;
/*!40000 ALTER TABLE `email_recipient_pending_erp` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `email_recipient_pending_erp` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `email_recipient_pending_erp` with 0 row(s)
--

--
-- Table structure for table `eventcountnames_evctnm`
--

DROP TABLE IF EXISTS `eventcountnames_evctnm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventcountnames_evctnm` (
  `evctnm_countid` int(5) NOT NULL AUTO_INCREMENT,
  `evctnm_eventtypeid` smallint(5) NOT NULL DEFAULT 0,
  `evctnm_countname` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `evctnm_notes` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  UNIQUE KEY `evctnm_countid` (`evctnm_countid`),
  UNIQUE KEY `evctnm_eventtypeid` (`evctnm_eventtypeid`,`evctnm_countname`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventcountnames_evctnm`
--

LOCK TABLES `eventcountnames_evctnm` WRITE;
/*!40000 ALTER TABLE `eventcountnames_evctnm` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `eventcountnames_evctnm` VALUES (1,1,'Total',''),(2,1,'Members',''),(3,1,'Visitors',''),(4,2,'Total',''),(5,2,'Members',''),(6,2,'Visitors',''),(7,3,'1',''),(8,3,'Total','');
/*!40000 ALTER TABLE `eventcountnames_evctnm` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `eventcountnames_evctnm` with 8 row(s)
--

--
-- Table structure for table `eventcounts_evtcnt`
--

DROP TABLE IF EXISTS `eventcounts_evtcnt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventcounts_evtcnt` (
  `evtcnt_eventid` int(5) NOT NULL DEFAULT 0,
  `evtcnt_countid` int(5) NOT NULL DEFAULT 0,
  `evtcnt_countname` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `evtcnt_countcount` int(6) DEFAULT NULL,
  `evtcnt_notes` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`evtcnt_eventid`,`evtcnt_countid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventcounts_evtcnt`
--

LOCK TABLES `eventcounts_evtcnt` WRITE;
/*!40000 ALTER TABLE `eventcounts_evtcnt` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `eventcounts_evtcnt` VALUES (1,7,'1',69,'yeet'),(1,8,'Total',420,'yeet');
/*!40000 ALTER TABLE `eventcounts_evtcnt` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `eventcounts_evtcnt` with 2 row(s)
--

--
-- Table structure for table `events_event`
--

DROP TABLE IF EXISTS `events_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events_event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_type` int(11) NOT NULL DEFAULT 0,
  `event_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `event_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_text` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_start` datetime NOT NULL,
  `event_end` datetime NOT NULL,
  `inactive` int(1) NOT NULL DEFAULT 0,
  `event_typename` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `location_id` int(11) DEFAULT NULL,
  `primary_contact_person_id` int(11) DEFAULT NULL,
  `secondary_contact_person_id` int(11) DEFAULT NULL,
  `event_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_event`
--

LOCK TABLES `events_event` WRITE;
/*!40000 ALTER TABLE `events_event` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `events_event` VALUES (1,3,'2019-11-30-Annual Events','testing annual event. think birthday','','2019-11-30 07:00:00','2019-11-30 08:00:00',0,'',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `events_event` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `events_event` with 1 row(s)
--

--
-- Table structure for table `event_attend`
--

DROP TABLE IF EXISTS `event_attend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_attend` (
  `attend_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL DEFAULT 0,
  `person_id` int(11) NOT NULL DEFAULT 0,
  `checkin_date` datetime DEFAULT NULL,
  `checkin_id` int(11) DEFAULT NULL,
  `checkout_date` datetime DEFAULT NULL,
  `checkout_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`attend_id`),
  UNIQUE KEY `event_id` (`event_id`,`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_attend`
--

LOCK TABLES `event_attend` WRITE;
/*!40000 ALTER TABLE `event_attend` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `event_attend` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `event_attend` with 0 row(s)
--

--
-- Table structure for table `event_audience`
--

DROP TABLE IF EXISTS `event_audience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_audience` (
  `event_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`event_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_audience`
--

LOCK TABLES `event_audience` WRITE;
/*!40000 ALTER TABLE `event_audience` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `event_audience` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `event_audience` with 0 row(s)
--

--
-- Table structure for table `event_types`
--

DROP TABLE IF EXISTS `event_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_types` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type_defstarttime` time NOT NULL DEFAULT '00:00:00',
  `type_defrecurtype` enum('none','weekly','monthly','yearly') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'none',
  `type_defrecurDOW` enum('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Sunday',
  `type_defrecurDOM` char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `type_defrecurDOY` date NOT NULL DEFAULT '2000-01-01',
  `type_active` int(1) NOT NULL DEFAULT 1,
  `type_grpid` mediumint(9) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_types`
--

LOCK TABLES `event_types` WRITE;
/*!40000 ALTER TABLE `event_types` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `event_types` VALUES (1,'Church Service','10:30:00','weekly','Sunday','','2016-01-01',1,NULL),(2,'Sunday School','09:30:00','weekly','Sunday','','2016-01-01',1,NULL),(3,'Annual Events','07:00:00','yearly','Sunday','0','0000-00-00',1,NULL);
/*!40000 ALTER TABLE `event_types` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `event_types` with 3 row(s)
--

--
-- Table structure for table `family_custom`
--

DROP TABLE IF EXISTS `family_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `family_custom` (
  `fam_ID` mediumint(9) NOT NULL DEFAULT 0,
  PRIMARY KEY (`fam_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `family_custom`
--

LOCK TABLES `family_custom` WRITE;
/*!40000 ALTER TABLE `family_custom` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `family_custom` VALUES (2);
/*!40000 ALTER TABLE `family_custom` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `family_custom` with 1 row(s)
--

--
-- Table structure for table `family_custom_master`
--

DROP TABLE IF EXISTS `family_custom_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `family_custom_master` (
  `fam_custom_Order` smallint(6) NOT NULL DEFAULT 0,
  `fam_custom_Field` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `fam_custom_Name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `fam_custom_Special` mediumint(8) unsigned DEFAULT NULL,
  `fam_custom_FieldSec` tinyint(4) NOT NULL DEFAULT 1,
  `type_ID` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `family_custom_master`
--

LOCK TABLES `family_custom_master` WRITE;
/*!40000 ALTER TABLE `family_custom_master` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `family_custom_master` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `family_custom_master` with 0 row(s)
--

--
-- Table structure for table `family_fam`
--

DROP TABLE IF EXISTS `family_fam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `family_fam` (
  `fam_ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `fam_Name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_Address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_Address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_City` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_State` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_Zip` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_Country` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_HomePhone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_WorkPhone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_CellPhone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_Email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_WeddingDate` date DEFAULT NULL,
  `fam_DateEntered` datetime NOT NULL,
  `fam_DateLastEdited` datetime DEFAULT NULL,
  `fam_EnteredBy` smallint(5) NOT NULL DEFAULT 0,
  `fam_EditedBy` smallint(5) unsigned DEFAULT 0,
  `fam_scanCheck` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_scanCredit` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `fam_SendNewsLetter` enum('FALSE','TRUE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'FALSE',
  `fam_DateDeactivated` date DEFAULT NULL,
  `fam_OkToCanvass` enum('FALSE','TRUE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'FALSE',
  `fam_Canvasser` smallint(5) unsigned NOT NULL DEFAULT 0,
  `fam_Latitude` double DEFAULT NULL,
  `fam_Longitude` double DEFAULT NULL,
  `fam_Envelope` mediumint(9) NOT NULL DEFAULT 0,
  PRIMARY KEY (`fam_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `family_fam`
--

LOCK TABLES `family_fam` WRITE;
/*!40000 ALTER TABLE `family_fam` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `family_fam` VALUES (1,'Name','','','','','','Afghanistan (‫افغانستان‬‎)','(254) 123-4567','','','test@server.com',NULL,'2021-01-07 12:26:48',NULL,1,0,NULL,NULL,'FALSE',NULL,'FALSE',0,NULL,NULL,0),(2,'Otungulo','1234-55655','','Nairobi','','69420','Kenya','(254) 123-4567','','','secondary@mailclient.com','2021-01-08','2021-01-08 12:58:35',NULL,1,0,NULL,NULL,'TRUE',NULL,'TRUE',0,69,420,0);
/*!40000 ALTER TABLE `family_fam` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `family_fam` with 2 row(s)
--

--
-- Table structure for table `fundraiser_fr`
--

DROP TABLE IF EXISTS `fundraiser_fr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fundraiser_fr` (
  `fr_ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `fr_date` date DEFAULT NULL,
  `fr_title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `fr_description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `fr_EnteredBy` smallint(5) unsigned NOT NULL DEFAULT 0,
  `fr_EnteredDate` date NOT NULL,
  PRIMARY KEY (`fr_ID`),
  UNIQUE KEY `fr_ID` (`fr_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fundraiser_fr`
--

LOCK TABLES `fundraiser_fr` WRITE;
/*!40000 ALTER TABLE `fundraiser_fr` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `fundraiser_fr` VALUES (1,'2021-01-12','Test_Fundraiser','Gimme moneys',1,'2021-01-12');
/*!40000 ALTER TABLE `fundraiser_fr` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `fundraiser_fr` with 1 row(s)
--

--
-- Table structure for table `groupprop_master`
--

DROP TABLE IF EXISTS `groupprop_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupprop_master` (
  `grp_ID` mediumint(9) unsigned NOT NULL DEFAULT 0,
  `prop_ID` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `prop_Field` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `prop_Name` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prop_Description` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_ID` smallint(5) unsigned NOT NULL DEFAULT 0,
  `prop_Special` mediumint(9) unsigned DEFAULT NULL,
  `prop_PersonDisplay` enum('false','true') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'false'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Group-specific properties order, name, description, type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupprop_master`
--

LOCK TABLES `groupprop_master` WRITE;
/*!40000 ALTER TABLE `groupprop_master` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `groupprop_master` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `groupprop_master` with 0 row(s)
--

--
-- Table structure for table `group_grp`
--

DROP TABLE IF EXISTS `group_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_grp` (
  `grp_ID` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `grp_Type` tinyint(4) NOT NULL DEFAULT 0,
  `grp_RoleListID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `grp_DefaultRole` mediumint(9) NOT NULL DEFAULT 0,
  `grp_Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `grp_Description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `grp_hasSpecialProps` tinyint(1) NOT NULL DEFAULT 0,
  `grp_active` tinyint(1) NOT NULL DEFAULT 1,
  `grp_include_email_export` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`grp_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_grp`
--

LOCK TABLES `group_grp` WRITE;
/*!40000 ALTER TABLE `group_grp` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `group_grp` VALUES (1,1,13,1,'Test','test group',0,1,1);
/*!40000 ALTER TABLE `group_grp` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `group_grp` with 1 row(s)
--

--
-- Table structure for table `istlookup_lu`
--

DROP TABLE IF EXISTS `istlookup_lu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `istlookup_lu` (
  `lu_fam_ID` mediumint(9) NOT NULL DEFAULT 0,
  `lu_LookupDateTime` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `lu_DeliveryLine1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_DeliveryLine2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_City` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_State` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_ZipAddon` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_Zip` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_Addon` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_LOTNumber` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_DPCCheckdigit` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_RecordType` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_LastLine` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_CarrierRoute` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_ReturnCodes` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_ErrorCodes` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lu_ErrorDesc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lu_fam_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='US Address Verification Lookups From Intelligent Search Tech';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `istlookup_lu`
--

LOCK TABLES `istlookup_lu` WRITE;
/*!40000 ALTER TABLE `istlookup_lu` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `istlookup_lu` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `istlookup_lu` with 0 row(s)
--

--
-- Table structure for table `kioskassginment_kasm`
--

DROP TABLE IF EXISTS `kioskassginment_kasm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kioskassginment_kasm` (
  `kasm_ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `kasm_kdevId` mediumint(9) DEFAULT NULL,
  `kasm_AssignmentType` mediumint(9) DEFAULT NULL,
  `kasm_EventId` mediumint(9) DEFAULT 0,
  PRIMARY KEY (`kasm_ID`),
  UNIQUE KEY `kasm_ID` (`kasm_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kioskassginment_kasm`
--

LOCK TABLES `kioskassginment_kasm` WRITE;
/*!40000 ALTER TABLE `kioskassginment_kasm` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `kioskassginment_kasm` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `kioskassginment_kasm` with 0 row(s)
--

--
-- Table structure for table `kioskdevice_kdev`
--

DROP TABLE IF EXISTS `kioskdevice_kdev`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kioskdevice_kdev` (
  `kdev_ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `kdev_GUIDHash` char(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kdev_Name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kdev_deviceType` mediumint(9) NOT NULL DEFAULT 0,
  `kdev_lastHeartbeat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `kdev_Accepted` tinyint(1) DEFAULT NULL,
  `kdev_PendingCommands` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`kdev_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kioskdevice_kdev`
--

LOCK TABLES `kioskdevice_kdev` WRITE;
/*!40000 ALTER TABLE `kioskdevice_kdev` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `kioskdevice_kdev` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `kioskdevice_kdev` with 0 row(s)
--

--
-- Table structure for table `list_lst`
--

DROP TABLE IF EXISTS `list_lst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list_lst` (
  `lst_ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `lst_OptionID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `lst_OptionSequence` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `lst_OptionName` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list_lst`
--

LOCK TABLES `list_lst` WRITE;
/*!40000 ALTER TABLE `list_lst` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `list_lst` VALUES (1,1,1,'Member'),(1,2,2,'Regular Attender'),(1,3,3,'Guest'),(1,5,4,'Non-Attender'),(1,4,5,'Non-Attender (staff)'),(2,1,1,'Head of Household'),(2,2,2,'Spouse'),(2,3,3,'Child'),(2,4,4,'Other Relative'),(2,5,5,'Non Relative'),(3,1,1,'Ministry'),(3,2,2,'Team'),(3,3,3,'Bible Study'),(3,4,4,'Sunday School Class'),(4,1,1,'True / False'),(4,2,2,'Date'),(4,3,3,'Text Field (50 char)'),(4,4,4,'Text Field (100 char)'),(4,5,5,'Text Field (Long)'),(4,6,6,'Year'),(4,7,7,'Season'),(4,8,8,'Number'),(4,9,9,'Person from Group'),(4,10,10,'Money'),(4,11,11,'Phone Number'),(4,12,12,'Custom Drop-Down List'),(5,1,1,'bAll'),(5,2,2,'bAdmin'),(5,3,3,'bAddRecords'),(5,4,4,'bEditRecords'),(5,5,5,'bDeleteRecords'),(5,7,7,'bManageGroups'),(5,8,8,'bFinance'),(5,9,9,'bNotes'),(5,11,11,'bCanvasser'),(10,1,1,'Teacher'),(10,2,2,'Student'),(11,1,1,'Member'),(12,1,1,'Teacher'),(12,2,2,'Student'),(13,1,1,'Member');
/*!40000 ALTER TABLE `list_lst` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `list_lst` with 41 row(s)
--

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_typeId` int(11) NOT NULL,
  `location_name` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `location_address` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `location_city` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `location_state` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `location_zip` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `location_country` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `location_phone` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location_email` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location_timzezone` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `locations` with 0 row(s)
--

--
-- Table structure for table `menu_links`
--

DROP TABLE IF EXISTS `menu_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_links` (
  `linkId` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `linkName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkUri` text COLLATE utf8_unicode_ci NOT NULL,
  `linkOrder` int(11) NOT NULL,
  PRIMARY KEY (`linkId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_links`
--

LOCK TABLES `menu_links` WRITE;
/*!40000 ALTER TABLE `menu_links` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `menu_links` VALUES (1,'Test','http://www.google.com',0);
/*!40000 ALTER TABLE `menu_links` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `menu_links` with 1 row(s)
--

--
-- Table structure for table `multibuy_mb`
--

DROP TABLE IF EXISTS `multibuy_mb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multibuy_mb` (
  `mb_ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `mb_per_ID` mediumint(9) NOT NULL DEFAULT 0,
  `mb_item_ID` mediumint(9) NOT NULL DEFAULT 0,
  `mb_count` decimal(8,0) DEFAULT NULL,
  PRIMARY KEY (`mb_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multibuy_mb`
--

LOCK TABLES `multibuy_mb` WRITE;
/*!40000 ALTER TABLE `multibuy_mb` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `multibuy_mb` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `multibuy_mb` with 0 row(s)
--

--
-- Table structure for table `note_nte`
--

DROP TABLE IF EXISTS `note_nte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note_nte` (
  `nte_ID` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `nte_per_ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `nte_fam_ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `nte_Private` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `nte_Text` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `nte_DateEntered` datetime NOT NULL,
  `nte_DateLastEdited` datetime DEFAULT NULL,
  `nte_EnteredBy` mediumint(8) NOT NULL DEFAULT 0,
  `nte_EditedBy` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `nte_Type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`nte_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note_nte`
--

LOCK TABLES `note_nte` WRITE;
/*!40000 ALTER TABLE `note_nte` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `note_nte` VALUES (1,1,0,0,'system user changed password','2021-01-07 12:09:34',NULL,1,0,'user'),(2,2,0,0,'Created','2021-01-07 12:26:48',NULL,1,0,'create'),(3,3,0,0,'Created via Family','2021-01-08 12:58:35',NULL,1,0,'create'),(4,4,0,0,'Created via Family','2021-01-08 12:58:36',NULL,1,0,'create'),(5,0,2,0,'Created','2021-01-08 12:58:35',NULL,1,0,'create');
/*!40000 ALTER TABLE `note_nte` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `note_nte` with 5 row(s)
--

--
-- Table structure for table `paddlenum_pn`
--

DROP TABLE IF EXISTS `paddlenum_pn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paddlenum_pn` (
  `pn_ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `pn_fr_ID` mediumint(9) unsigned DEFAULT NULL,
  `pn_Num` mediumint(9) unsigned DEFAULT NULL,
  `pn_per_ID` mediumint(9) NOT NULL DEFAULT 0,
  PRIMARY KEY (`pn_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paddlenum_pn`
--

LOCK TABLES `paddlenum_pn` WRITE;
/*!40000 ALTER TABLE `paddlenum_pn` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `paddlenum_pn` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `paddlenum_pn` with 0 row(s)
--

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(50) NOT NULL,
  `permission_desc` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `permission_name` (`permission_name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `permissions` VALUES (1,'addPeople','Add People'),(3,'updatePeople','Update People'),(4,'deletePeopleRecords','Delete People Records'),(5,'curdProperties','Manage Properties '),(6,'crudClassifications','Manage Classifications'),(7,'crudGroups','Manage Groups'),(8,'crudRoles','Manage Roles'),(9,'crudDonations','Manage Donations'),(10,'curdFinance','Manage Finance'),(11,'curdNotes','Manage Notes'),(12,'canvasser','Canvasser volunteer'),(13,'editSelf','Edit own family only'),(14,'emailMailto','Allow to see Mailto Links'),(15,'createDirectory','Create Directories'),(16,'exportCSV','Export CSV files'),(17,'usAddressVerification','Use IST Address Verification'),(18,'crudEvent','Manage Events');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `permissions` with 17 row(s)
--

--
-- Table structure for table `person2group2role_p2g2r`
--

DROP TABLE IF EXISTS `person2group2role_p2g2r`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person2group2role_p2g2r` (
  `p2g2r_per_ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `p2g2r_grp_ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `p2g2r_rle_ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`p2g2r_per_ID`,`p2g2r_grp_ID`),
  KEY `p2g2r_per_ID` (`p2g2r_per_ID`,`p2g2r_grp_ID`,`p2g2r_rle_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person2group2role_p2g2r`
--

LOCK TABLES `person2group2role_p2g2r` WRITE;
/*!40000 ALTER TABLE `person2group2role_p2g2r` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `person2group2role_p2g2r` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `person2group2role_p2g2r` with 0 row(s)
--

--
-- Table structure for table `person2volunteeropp_p2vo`
--

DROP TABLE IF EXISTS `person2volunteeropp_p2vo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person2volunteeropp_p2vo` (
  `p2vo_ID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `p2vo_per_ID` mediumint(9) DEFAULT NULL,
  `p2vo_vol_ID` mediumint(9) DEFAULT NULL,
  PRIMARY KEY (`p2vo_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person2volunteeropp_p2vo`
--

LOCK TABLES `person2volunteeropp_p2vo` WRITE;
/*!40000 ALTER TABLE `person2volunteeropp_p2vo` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `person2volunteeropp_p2vo` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `person2volunteeropp_p2vo` with 0 row(s)
--

--
-- Table structure for table `person_custom`
--

DROP TABLE IF EXISTS `person_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_custom` (
  `per_ID` mediumint(9) NOT NULL DEFAULT 0,
  PRIMARY KEY (`per_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_custom`
--

LOCK TABLES `person_custom` WRITE;
/*!40000 ALTER TABLE `person_custom` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `person_custom` VALUES (2),(3),(4);
/*!40000 ALTER TABLE `person_custom` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `person_custom` with 3 row(s)
--

--
-- Table structure for table `person_custom_master`
--

DROP TABLE IF EXISTS `person_custom_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_custom_master` (
  `custom_Order` smallint(6) NOT NULL DEFAULT 0,
  `custom_Field` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `custom_Name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `custom_Special` mediumint(8) unsigned DEFAULT NULL,
  `custom_FieldSec` tinyint(4) NOT NULL,
  `type_ID` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`custom_Field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_custom_master`
--

LOCK TABLES `person_custom_master` WRITE;
/*!40000 ALTER TABLE `person_custom_master` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `person_custom_master` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `person_custom_master` with 0 row(s)
--

--
-- Table structure for table `person_per`
--

DROP TABLE IF EXISTS `person_per`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_per` (
  `per_ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `per_Title` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_FirstName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_MiddleName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_LastName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_Suffix` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_Address1` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_Address2` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_City` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_State` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_Zip` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_Country` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_HomePhone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_WorkPhone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_CellPhone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_Email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_WorkEmail` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_BirthMonth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `per_BirthDay` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `per_BirthYear` year(4) DEFAULT NULL,
  `per_MembershipDate` date DEFAULT NULL,
  `per_Gender` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `per_fmr_ID` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `per_cls_ID` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `per_fam_ID` smallint(5) unsigned NOT NULL DEFAULT 0,
  `per_Envelope` smallint(5) unsigned DEFAULT NULL,
  `per_DateLastEdited` datetime DEFAULT NULL,
  `per_DateEntered` datetime NOT NULL,
  `per_EnteredBy` smallint(5) NOT NULL DEFAULT 0,
  `per_EditedBy` smallint(5) unsigned DEFAULT 0,
  `per_FriendDate` date DEFAULT NULL,
  `per_Flags` mediumint(9) NOT NULL DEFAULT 0,
  `per_FacebookID` bigint(20) unsigned DEFAULT NULL,
  `per_Twitter` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_LinkedIn` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`per_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_per`
--

LOCK TABLES `person_per` WRITE;
/*!40000 ALTER TABLE `person_per` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `person_per` VALUES (1,NULL,'Church',NULL,'Admin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'0000',NULL,0,0,0,0,NULL,NULL,'2004-08-25 18:00:00',1,0,NULL,0,NULL,NULL,NULL),(2,'','A','User','Name','Jr','','','','','','Afghanistan (‫افغانستان‬‎)','(254) 123-4567','','','test@server.com','',6,15,'1993',NULL,1,3,3,1,0,NULL,'2021-01-07 12:26:48',1,0,'2021-01-07',0,0,'',''),(3,NULL,'A','Family','Member','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,18,'1997',NULL,2,3,0,2,NULL,NULL,'2021-01-08 12:58:35',1,0,NULL,0,NULL,NULL,NULL),(4,NULL,'Another','Family','Member','Sr',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,6,'1985',NULL,1,1,0,2,NULL,NULL,'2021-01-08 12:58:36',1,0,NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `person_per` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `person_per` with 4 row(s)
--

--
-- Table structure for table `person_permission`
--

DROP TABLE IF EXISTS `person_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_permission` (
  `per_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`per_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_permission`
--

LOCK TABLES `person_permission` WRITE;
/*!40000 ALTER TABLE `person_permission` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `person_permission` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `person_permission` with 0 row(s)
--

--
-- Table structure for table `person_roles`
--

DROP TABLE IF EXISTS `person_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_roles` (
  `per_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`per_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_roles`
--

LOCK TABLES `person_roles` WRITE;
/*!40000 ALTER TABLE `person_roles` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `person_roles` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `person_roles` with 0 row(s)
--

--
-- Table structure for table `pledge_plg`
--

DROP TABLE IF EXISTS `pledge_plg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pledge_plg` (
  `plg_plgID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `plg_FamID` mediumint(9) DEFAULT NULL,
  `plg_FYID` mediumint(9) DEFAULT NULL,
  `plg_date` date DEFAULT NULL,
  `plg_amount` decimal(8,2) DEFAULT NULL,
  `plg_schedule` enum('Weekly','Monthly','Quarterly','Once','Other') COLLATE utf8_unicode_ci DEFAULT NULL,
  `plg_method` enum('CREDITCARD','CHECK','CASH','BANKDRAFT','EGIVE') COLLATE utf8_unicode_ci DEFAULT NULL,
  `plg_comment` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `plg_DateLastEdited` date NOT NULL DEFAULT '2016-01-01',
  `plg_EditedBy` mediumint(9) NOT NULL DEFAULT 0,
  `plg_PledgeOrPayment` enum('Pledge','Payment') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Pledge',
  `plg_fundID` tinyint(3) unsigned DEFAULT NULL,
  `plg_depID` mediumint(9) unsigned DEFAULT NULL,
  `plg_CheckNo` bigint(16) unsigned DEFAULT NULL,
  `plg_Problem` tinyint(1) DEFAULT NULL,
  `plg_scanString` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `plg_aut_ID` mediumint(9) NOT NULL DEFAULT 0,
  `plg_aut_Cleared` tinyint(1) NOT NULL DEFAULT 0,
  `plg_aut_ResultID` mediumint(9) NOT NULL DEFAULT 0,
  `plg_NonDeductible` decimal(8,2) NOT NULL,
  `plg_GroupKey` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`plg_plgID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pledge_plg`
--

LOCK TABLES `pledge_plg` WRITE;
/*!40000 ALTER TABLE `pledge_plg` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `pledge_plg` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `pledge_plg` with 0 row(s)
--

--
-- Table structure for table `propertytype_prt`
--

DROP TABLE IF EXISTS `propertytype_prt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `propertytype_prt` (
  `prt_ID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `prt_Class` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `prt_Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `prt_Description` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`prt_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propertytype_prt`
--

LOCK TABLES `propertytype_prt` WRITE;
/*!40000 ALTER TABLE `propertytype_prt` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `propertytype_prt` VALUES (1,'p','General','General Person Properties'),(2,'f','General','General Family Properties'),(3,'g','General','General Group Properties');
/*!40000 ALTER TABLE `propertytype_prt` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `propertytype_prt` with 3 row(s)
--

--
-- Table structure for table `property_pro`
--

DROP TABLE IF EXISTS `property_pro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_pro` (
  `pro_ID` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `pro_Class` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `pro_prt_ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `pro_Name` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `pro_Description` text COLLATE utf8_unicode_ci NOT NULL,
  `pro_Prompt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pro_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_pro`
--

LOCK TABLES `property_pro` WRITE;
/*!40000 ALTER TABLE `property_pro` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `property_pro` VALUES (1,'p',1,'Disabled','has a disability.','What is the nature of the disability?'),(2,'f',2,'Single Parent','is a single-parent household.',''),(3,'g',3,'Youth','is youth-oriented.','');
/*!40000 ALTER TABLE `property_pro` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `property_pro` with 3 row(s)
--

--
-- Table structure for table `queryparameteroptions_qpo`
--

DROP TABLE IF EXISTS `queryparameteroptions_qpo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queryparameteroptions_qpo` (
  `qpo_ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `qpo_qrp_ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `qpo_Display` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `qpo_Value` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`qpo_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queryparameteroptions_qpo`
--

LOCK TABLES `queryparameteroptions_qpo` WRITE;
/*!40000 ALTER TABLE `queryparameteroptions_qpo` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `queryparameteroptions_qpo` VALUES (1,4,'Male','1'),(2,4,'Female','2'),(3,6,'Male','1'),(4,6,'Female','2'),(5,15,'Name','CONCAT(COALESCE(`per_FirstName`,\'\'),COALESCE(`per_MiddleName`,\'\'),COALESCE(`per_LastName`,\'\'))'),(6,15,'Zip Code','fam_Zip'),(7,15,'State','fam_State'),(8,15,'City','fam_City'),(9,15,'Home Phone','per_HomePhone'),(10,27,'2012/2013','17'),(11,27,'2013/2014','18'),(12,27,'2014/2015','19'),(13,27,'2015/2016','20'),(14,28,'2012/2013','17'),(15,28,'2013/2014','18'),(16,28,'2014/2015','19'),(17,28,'2015/2016','20'),(18,30,'2012/2013','17'),(19,30,'2013/2014','18'),(20,30,'2014/2015','19'),(21,30,'2015/2016','20'),(22,31,'2012/2013','17'),(23,31,'2013/2014','18'),(24,31,'2014/2015','19'),(25,31,'2015/2016','20'),(26,15,'Email','per_Email'),(27,15,'WorkEmail','per_WorkEmail'),(28,32,'2012/2013','17'),(29,32,'2013/2014','18'),(30,32,'2014/2015','19'),(31,32,'2015/2016','20'),(32,33,'Member','1'),(33,33,'Regular Attender','2'),(34,33,'Guest','3'),(35,33,'Non-Attender','4'),(36,33,'Non-Attender (staff)','5');
/*!40000 ALTER TABLE `queryparameteroptions_qpo` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `queryparameteroptions_qpo` with 36 row(s)
--

--
-- Table structure for table `queryparameters_qrp`
--

DROP TABLE IF EXISTS `queryparameters_qrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queryparameters_qrp` (
  `qrp_ID` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `qrp_qry_ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `qrp_Type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `qrp_OptionSQL` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrp_Name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrp_Description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrp_Alias` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrp_Default` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrp_Required` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `qrp_InputBoxSize` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `qrp_Validation` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `qrp_NumericMax` int(11) DEFAULT NULL,
  `qrp_NumericMin` int(11) DEFAULT NULL,
  `qrp_AlphaMinLength` int(11) DEFAULT NULL,
  `qrp_AlphaMaxLength` int(11) DEFAULT NULL,
  PRIMARY KEY (`qrp_ID`),
  KEY `qrp_qry_ID` (`qrp_qry_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queryparameters_qrp`
--

LOCK TABLES `queryparameters_qrp` WRITE;
/*!40000 ALTER TABLE `queryparameters_qrp` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `queryparameters_qrp` VALUES (1,4,0,NULL,'Minimum Age','The minimum age for which you want records returned.','min','0',0,5,'n',120,0,NULL,NULL),(2,4,0,NULL,'Maximum Age','The maximum age for which you want records returned.','max','120',1,5,'n',120,0,NULL,NULL),(4,6,1,'','Gender','The desired gender to search the database for.','gender','1',1,0,'',0,0,0,0),(5,7,2,'SELECT lst_OptionID as Value, lst_OptionName as Display FROM list_lst WHERE lst_ID=2 ORDER BY lst_OptionSequence','Family Role','Select the desired family role.','role','1',0,0,'',0,0,0,0),(6,7,1,'','Gender','The gender for which you would like records returned.','gender','1',1,0,'',0,0,0,0),(8,9,2,'SELECT pro_ID AS Value, pro_Name as Display \r\nFROM property_pro\r\nWHERE pro_Class= \'p\' \r\nORDER BY pro_Name ','Property','The property for which you would like person records returned.','PropertyID','0',1,0,'',0,0,0,0),(9,10,2,'SELECT distinct don_date as Value, don_date as Display FROM donations_don ORDER BY don_date ASC','Beginning Date','Please select the beginning date to calculate total contributions for each member (i.e. YYYY-MM-DD). NOTE: You can only choose dates that conatain donations.','startdate','1',1,0,'0',0,0,0,0),(10,10,2,'SELECT distinct don_date as Value, don_date as Display FROM donations_don\r\nORDER BY don_date DESC','Ending Date','Please enter the last date to calculate total contributions for each member (i.e. YYYY-MM-DD).','enddate','1',1,0,'',0,0,0,0),(14,15,0,'','Search','Enter any part of the following: Name, City, State, Zip, Home Phone, Email, or Work Email.','searchstring','',1,0,'',0,0,0,0),(15,15,1,'','Field','Select field to search for.','searchwhat','1',1,0,'',0,0,0,0),(16,11,2,'SELECT distinct don_date as Value, don_date as Display FROM donations_don ORDER BY don_date ASC','Beginning Date','Please select the beginning date to calculate total contributions for each member (i.e. YYYY-MM-DD). NOTE: You can only choose dates that conatain donations.','startdate','1',1,0,'0',0,0,0,0),(17,11,2,'SELECT distinct don_date as Value, don_date as Display FROM donations_don\r\nORDER BY don_date DESC','Ending Date','Please enter the last date to calculate total contributions for each member (i.e. YYYY-MM-DD).','enddate','1',1,0,'',0,0,0,0),(18,18,0,'','Month','The birthday month for which you would like records returned.','birthmonth','1',1,0,'',12,1,1,2),(19,19,2,'SELECT grp_ID AS Value, grp_Name AS Display FROM group_grp ORDER BY grp_Type','Class','The sunday school class for which you would like records returned.','group','1',1,0,'',12,1,1,2),(20,20,2,'SELECT grp_ID AS Value, grp_Name AS Display FROM group_grp ORDER BY grp_Type','Class','The sunday school class for which you would like records returned.','group','1',1,0,'',12,1,1,2),(21,21,2,'SELECT grp_ID AS Value, grp_Name AS Display FROM group_grp ORDER BY grp_Type','Registered students','Group of registered students','group','1',1,0,'',12,1,1,2),(22,22,0,'','Month','The membership anniversary month for which you would like records returned.','membermonth','1',1,0,'',12,1,1,2),(25,25,2,'SELECT vol_ID AS Value, vol_Name AS Display FROM volunteeropportunity_vol ORDER BY vol_Name','Volunteer opportunities','Choose a volunteer opportunity','volopp','1',1,0,'',12,1,1,2),(26,26,0,'','Months','Number of months since becoming a friend','friendmonths','1',1,0,'',24,1,1,2),(27,28,1,'','First Fiscal Year','First fiscal year for comparison','fyid1','9',1,0,'',12,9,0,0),(28,28,1,'','Second Fiscal Year','Second fiscal year for comparison','fyid2','9',1,0,'',12,9,0,0),(30,30,1,'','First Fiscal Year','Pledged this year','fyid1','9',1,0,'',12,9,0,0),(31,30,1,'','Second Fiscal Year','but not this year','fyid2','9',1,0,'',12,9,0,0),(32,32,1,'','Fiscal Year','Fiscal Year.','fyid','9',1,0,'',12,9,0,0),(33,18,1,'','Classification','Member, Regular Attender, etc.','percls','1',1,0,'',12,1,1,2),(100,100,2,'SELECT vol_ID AS Value, vol_Name AS Display FROM volunteeropportunity_vol ORDER BY vol_Name','Volunteer opportunities','First volunteer opportunity choice','volopp1','1',1,0,'',12,1,1,2),(101,100,2,'SELECT vol_ID AS Value, vol_Name AS Display FROM volunteeropportunity_vol ORDER BY vol_Name','Volunteer opportunities','Second volunteer opportunity choice','volopp2','1',1,0,'',12,1,1,2),(200,200,2,'SELECT custom_field as Value, custom_Name as Display FROM person_custom_master','Custom field','Choose customer person field','custom','1',0,0,'',0,0,0,0),(201,200,0,'','Field value','Match custom field to this value','value','1',0,0,'',0,0,0,0),(202,201,3,'SELECT event_id as Value, event_title as Display FROM events_event ORDER BY event_start DESC','Event','Select the desired event','event','',1,0,'',0,0,0,0);
/*!40000 ALTER TABLE `queryparameters_qrp` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `queryparameters_qrp` with 30 row(s)
--

--
-- Table structure for table `query_qry`
--

DROP TABLE IF EXISTS `query_qry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `query_qry` (
  `qry_ID` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `qry_SQL` text COLLATE utf8_unicode_ci NOT NULL,
  `qry_Name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `qry_Description` text COLLATE utf8_unicode_ci NOT NULL,
  `qry_Count` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`qry_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_qry`
--

LOCK TABLES `query_qry` WRITE;
/*!40000 ALTER TABLE `query_qry` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `query_qry` VALUES (3,'SELECT CONCAT(\'<a href=v2/family/\',fam_ID,\'>\',fam_Name,\'</a>\') AS \'Family Name\', COUNT(*) AS \'No.\'\nFROM person_per\nINNER JOIN family_fam\nON fam_ID = per_fam_ID\nGROUP BY per_fam_ID\nORDER BY \'No.\' DESC','Family Member Count','Returns each family and the total number of people assigned to them.',0),(4,'SELECT per_ID as AddToCart,CONCAT(\'<a\r\nhref=PersonView.php?PersonID=\',per_ID,\'>\',per_FirstName,\'\r\n\',per_LastName,\'</a>\') AS Name,\r\nCONCAT(per_BirthMonth,\'/\',per_BirthDay,\'/\',per_BirthYear) AS \'Birth Date\',\r\nDATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(CONCAT(per_BirthYear,\'-\',per_BirthMonth,\'-\',per_BirthDay))),\'%Y\')+0 AS  \'Age\'\r\nFROM person_per\r\nWHERE\r\nDATE_ADD(CONCAT(per_BirthYear,\'-\',per_BirthMonth,\'-\',per_BirthDay),INTERVAL\r\n~min~ YEAR) <= CURDATE()\r\nAND\r\nDATE_ADD(CONCAT(per_BirthYear,\'-\',per_BirthMonth,\'-\',per_BirthDay),INTERVAL\r\n(~max~ + 1) YEAR) >= CURDATE()','Person by Age','Returns any person records with ages between two given ages.',1),(6,'SELECT COUNT(per_ID) AS Total FROM person_per WHERE per_Gender = ~gender~','Total By Gender','Total of records matching a given gender.',0),(7,'SELECT per_ID as AddToCart, CONCAT(per_FirstName,\' \',per_LastName) AS Name FROM person_per WHERE per_fmr_ID = ~role~ AND per_Gender = ~gender~','Person by Role and Gender','Selects person records with the family role and gender specified.',1),(9,'SELECT \r\nper_ID as AddToCart, \r\nCONCAT(per_FirstName,\' \',per_LastName) AS Name, \r\nCONCAT(r2p_Value,\' \') AS Value\r\nFROM person_per,record2property_r2p\r\nWHERE per_ID = r2p_record_ID\r\nAND r2p_pro_ID = ~PropertyID~\r\nORDER BY per_LastName','Person by Property','Returns person records which are assigned the given property.',1),(15,'SELECT per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',per_ID,\'>\',COALESCE(`per_FirstName`,\'\'),\' \',COALESCE(`per_MiddleName`,\'\'),\' \',COALESCE(`per_LastName`,\'\'),\'</a>\') AS Name, fam_City as City, fam_State as State, fam_Zip as ZIP, per_HomePhone as HomePhone, per_Email as Email, per_WorkEmail as WorkEmail FROM person_per RIGHT JOIN family_fam ON family_fam.fam_id = person_per.per_fam_id WHERE ~searchwhat~ LIKE \'%~searchstring~%\'','Advanced Search','Search by any part of Name, City, State, Zip, Home Phone, Email, or Work Email.',1),(18,'SELECT per_ID as AddToCart, per_BirthDay as Day, CONCAT(per_FirstName,\' \',per_LastName) AS Name FROM person_per WHERE per_cls_ID=~percls~ AND per_BirthMonth=~birthmonth~ ORDER BY per_BirthDay','Birthdays','People with birthdays in a particular month',0),(21,'SELECT per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',per_ID,\'>\',per_FirstName,\' \',per_LastName,\'</a>\') AS Name FROM person_per LEFT JOIN person2group2role_p2g2r ON per_id = p2g2r_per_ID WHERE p2g2r_grp_ID=~group~ ORDER BY per_LastName','Registered students','Find Registered students',1),(22,'SELECT per_ID as AddToCart, DAYOFMONTH(per_MembershipDate) as Day, per_MembershipDate AS DATE, CONCAT(per_FirstName,\' \',per_LastName) AS Name FROM person_per WHERE per_cls_ID=1 AND MONTH(per_MembershipDate)=~membermonth~ ORDER BY per_MembershipDate','Membership anniversaries','Members who joined in a particular month',0),(23,'SELECT usr_per_ID as AddToCart, CONCAT(a.per_FirstName,\' \',a.per_LastName) AS Name FROM user_usr LEFT JOIN person_per a ON per_ID=usr_per_ID ORDER BY per_LastName','Select database users','People who are registered as database users',0),(24,'SELECT per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',per_ID,\'>\',per_FirstName,\' \',per_LastName,\'</a>\') AS Name FROM person_per WHERE per_cls_id =1','Select all members','People who are members',0),(25,'SELECT per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',per_ID,\'>\',per_FirstName,\' \',per_LastName,\'</a>\') AS Name FROM person_per LEFT JOIN person2volunteeropp_p2vo ON per_id = p2vo_per_ID WHERE p2vo_vol_ID = ~volopp~ ORDER BY per_LastName','Volunteers','Find volunteers for a particular opportunity',1),(26,'SELECT per_ID as AddToCart, CONCAT(per_FirstName,\' \',per_LastName) AS Name FROM person_per WHERE DATE_SUB(NOW(),INTERVAL ~friendmonths~ MONTH)<per_FriendDate ORDER BY per_MembershipDate','Recent friends','Friends who signed up in previous months',0),(27,'SELECT per_ID as AddToCart, CONCAT(per_FirstName,\' \',per_LastName) AS Name FROM person_per inner join family_fam on per_fam_ID=fam_ID where per_fmr_ID<>3 AND fam_OkToCanvass=\"TRUE\" ORDER BY fam_Zip','Families to Canvass','People in families that are ok to canvass.',0),(28,'SELECT fam_Name, a.plg_amount as PlgFY1, b.plg_amount as PlgFY2 from family_fam left join pledge_plg a on a.plg_famID = fam_ID and a.plg_FYID=~fyid1~ and a.plg_PledgeOrPayment=\'Pledge\' left join pledge_plg b on b.plg_famID = fam_ID and b.plg_FYID=~fyid2~ and b.plg_PledgeOrPayment=\'Pledge\' order by fam_Name','Pledge comparison','Compare pledges between two fiscal years',1),(30,'SELECT per_ID as AddToCart, CONCAT(per_FirstName,\' \',per_LastName) AS Name, fam_address1, fam_city, fam_state, fam_zip FROM person_per join family_fam on per_fam_id=fam_id where per_fmr_id<>3 and per_fam_id in (select fam_id from family_fam inner join pledge_plg a on a.plg_famID=fam_ID and a.plg_FYID=~fyid1~ and a.plg_amount>0) and per_fam_id not in (select fam_id from family_fam inner join pledge_plg b on b.plg_famID=fam_ID and b.plg_FYID=~fyid2~ and b.plg_amount>0)','Missing pledges','Find people who pledged one year but not another',1),(32,'SELECT fam_Name, fam_Envelope, b.fun_Name as Fund_Name, a.plg_amount as Pledge from family_fam left join pledge_plg a on a.plg_famID = fam_ID and a.plg_FYID=~fyid~ and a.plg_PledgeOrPayment=\'Pledge\' and a.plg_amount>0 join donationfund_fun b on b.fun_ID = a.plg_fundID order by fam_Name, a.plg_fundID','Family Pledge by Fiscal Year','Pledge summary by family name for each fund for the selected fiscal year',1),(100,'SELECT a.per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',a.per_ID,\'>\',a.per_FirstName,\' \',a.per_LastName,\'</a>\') AS Name FROM person_per AS a LEFT JOIN person2volunteeropp_p2vo p2v1 ON (a.per_id = p2v1.p2vo_per_ID AND p2v1.p2vo_vol_ID = ~volopp1~) LEFT JOIN person2volunteeropp_p2vo p2v2 ON (a.per_id = p2v2.p2vo_per_ID AND p2v2.p2vo_vol_ID = ~volopp2~) WHERE p2v1.p2vo_per_ID=p2v2.p2vo_per_ID ORDER BY per_LastName','Volunteers','Find volunteers for who match two specific opportunity codes',1),(200,'SELECT a.per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',a.per_ID,\'>\',a.per_FirstName,\' \',a.per_LastName,\'</a>\') AS Name FROM person_per AS a LEFT JOIN person_custom pc ON a.per_id = pc.per_ID WHERE pc.~custom~=\'~value~\' ORDER BY per_LastName','CustomSearch','Find people with a custom field value',1),(201,'SELECT per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',per_ID,\'>\',per_FirstName,\',per_LastName,\'</a>\') AS Name, per_LastName AS Lastname FROM person_per LEFT OUTER JOIN (SELECT event_attend.attend_id, event_attend.person_id FROM event_attend WHERE event_attend.event_id IN (~event~)) a ON person_per.per_ID = a.person_id WHERE a.attend_id is NULL ORDER BY person_per.per_LastName, person_per.per_FirstName','Missing people','Find people who didn\'t attend an event',1);
/*!40000 ALTER TABLE `query_qry` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `query_qry` with 20 row(s)
--

--
-- Table structure for table `record2property_r2p`
--

DROP TABLE IF EXISTS `record2property_r2p`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `record2property_r2p` (
  `r2p_pro_ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `r2p_record_ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `r2p_Value` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `record2property_r2p`
--

LOCK TABLES `record2property_r2p` WRITE;
/*!40000 ALTER TABLE `record2property_r2p` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `record2property_r2p` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `record2property_r2p` with 0 row(s)
--

--
-- Table structure for table `result_res`
--

DROP TABLE IF EXISTS `result_res`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `result_res` (
  `res_ID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `res_echotype1` text COLLATE utf8_unicode_ci NOT NULL,
  `res_echotype2` text COLLATE utf8_unicode_ci NOT NULL,
  `res_echotype3` text COLLATE utf8_unicode_ci NOT NULL,
  `res_authorization` text COLLATE utf8_unicode_ci NOT NULL,
  `res_order_number` text COLLATE utf8_unicode_ci NOT NULL,
  `res_reference` text COLLATE utf8_unicode_ci NOT NULL,
  `res_status` text COLLATE utf8_unicode_ci NOT NULL,
  `res_avs_result` text COLLATE utf8_unicode_ci NOT NULL,
  `res_security_result` text COLLATE utf8_unicode_ci NOT NULL,
  `res_mac` text COLLATE utf8_unicode_ci NOT NULL,
  `res_decline_code` text COLLATE utf8_unicode_ci NOT NULL,
  `res_tran_date` text COLLATE utf8_unicode_ci NOT NULL,
  `res_merchant_name` text COLLATE utf8_unicode_ci NOT NULL,
  `res_version` text COLLATE utf8_unicode_ci NOT NULL,
  `res_EchoServer` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`res_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `result_res`
--

LOCK TABLES `result_res` WRITE;
/*!40000 ALTER TABLE `result_res` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `result_res` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `result_res` with 0 row(s)
--

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `role_desc` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `roles` VALUES (1,'Welcome Committee',NULL),(2,'Clergy',NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `roles` with 2 row(s)
--

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `token` varchar(99) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `reference_id` int(9) NOT NULL,
  `valid_until_date` datetime DEFAULT NULL,
  `remainingUses` int(2) DEFAULT NULL,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `tokens` with 0 row(s)
--

--
-- Table structure for table `userconfig_ucfg`
--

DROP TABLE IF EXISTS `userconfig_ucfg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userconfig_ucfg` (
  `ucfg_per_id` mediumint(9) unsigned NOT NULL,
  `ucfg_id` int(11) NOT NULL DEFAULT 0,
  `ucfg_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ucfg_value` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `ucfg_type` enum('text','number','date','boolean','textarea') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `ucfg_tooltip` text COLLATE utf8_unicode_ci NOT NULL,
  `ucfg_permission` enum('FALSE','TRUE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'FALSE',
  `ucfg_cat` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ucfg_per_id`,`ucfg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userconfig_ucfg`
--

LOCK TABLES `userconfig_ucfg` WRITE;
/*!40000 ALTER TABLE `userconfig_ucfg` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `userconfig_ucfg` VALUES (0,0,'bEmailMailto','1','boolean','User permission to send email via mailto: links','TRUE',''),(0,1,'sMailtoDelimiter',',','text','Delimiter to separate emails in mailto: links','TRUE',''),(0,5,'bCreateDirectory','0','boolean','User permission to create directories','FALSE','SECURITY'),(0,6,'bExportCSV','0','boolean','User permission to export CSV files','FALSE','SECURITY'),(0,7,'bUSAddressVerification','0','boolean','User permission to use IST Address Verification','FALSE',''),(0,10,'bAddEvent','0','boolean','Allow user to add new event','FALSE','SECURITY'),(1,0,'bEmailMailto','1','boolean','User permission to send email via mailto: links','TRUE',''),(1,1,'sMailtoDelimiter',',','text','user permission to send email via mailto: links','TRUE',''),(1,5,'bCreateDirectory','1','boolean','User permission to create directories','TRUE',''),(1,6,'bExportCSV','1','boolean','User permission to export CSV files','TRUE',''),(1,7,'bUSAddressVerification','1','boolean','User permission to use IST Address Verification','TRUE','');
/*!40000 ALTER TABLE `userconfig_ucfg` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `userconfig_ucfg` with 11 row(s)
--

--
-- Table structure for table `user_usr`
--

DROP TABLE IF EXISTS `user_usr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_usr` (
  `usr_per_ID` mediumint(9) unsigned NOT NULL DEFAULT 0,
  `usr_Password` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `usr_NeedPasswordChange` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `usr_LastLogin` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `usr_LoginCount` smallint(5) unsigned NOT NULL DEFAULT 0,
  `usr_FailedLogins` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `usr_AddRecords` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `usr_EditRecords` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `usr_DeleteRecords` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `usr_MenuOptions` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `usr_ManageGroups` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `usr_Finance` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `usr_Notes` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `usr_Admin` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `usr_SearchLimit` tinyint(4) DEFAULT 10,
  `usr_Style` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'Style.css',
  `usr_showPledges` tinyint(1) NOT NULL DEFAULT 0,
  `usr_showPayments` tinyint(1) NOT NULL DEFAULT 0,
  `usr_showSince` date NOT NULL DEFAULT '2016-01-01',
  `usr_defaultFY` mediumint(9) NOT NULL DEFAULT 10,
  `usr_currentDeposit` mediumint(9) NOT NULL DEFAULT 0,
  `usr_UserName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `usr_apiKey` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `usr_EditSelf` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `usr_CalStart` date DEFAULT NULL,
  `usr_CalEnd` date DEFAULT NULL,
  `usr_CalNoSchool1` date DEFAULT NULL,
  `usr_CalNoSchool2` date DEFAULT NULL,
  `usr_CalNoSchool3` date DEFAULT NULL,
  `usr_CalNoSchool4` date DEFAULT NULL,
  `usr_CalNoSchool5` date DEFAULT NULL,
  `usr_CalNoSchool6` date DEFAULT NULL,
  `usr_CalNoSchool7` date DEFAULT NULL,
  `usr_CalNoSchool8` date DEFAULT NULL,
  `usr_SearchFamily` tinyint(3) DEFAULT NULL,
  `usr_Canvasser` tinyint(1) NOT NULL DEFAULT 0,
  `usr_TwoFactorAuthSecret` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `usr_TwoFactorAuthLastKeyTimestamp` int(11) DEFAULT NULL,
  `usr_TwoFactorAuthRecoveryCodes` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`usr_per_ID`),
  UNIQUE KEY `usr_UserName` (`usr_UserName`),
  UNIQUE KEY `usr_apiKey` (`usr_apiKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_usr`
--

LOCK TABLES `user_usr` WRITE;
/*!40000 ALTER TABLE `user_usr` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `user_usr` VALUES (1,'5b11618c2e44027877d0cd0921ed166b9f176f50587fc91e7534dd2946db77d6',0,'2021-01-15 10:02:03',15,0,0,0,0,0,0,0,0,1,10,'skin-red',0,0,'2016-01-01',10,1,'Admin',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user_usr` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `user_usr` with 1 row(s)
--

--
-- Table structure for table `version_ver`
--

DROP TABLE IF EXISTS `version_ver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version_ver` (
  `ver_ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `ver_version` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ver_update_start` datetime DEFAULT NULL,
  `ver_update_end` datetime DEFAULT NULL,
  PRIMARY KEY (`ver_ID`),
  UNIQUE KEY `ver_version` (`ver_version`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version_ver`
--

LOCK TABLES `version_ver` WRITE;
/*!40000 ALTER TABLE `version_ver` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `version_ver` VALUES (1,'4.2.0','2021-01-07 18:06:57','2021-01-07 18:07:20');
/*!40000 ALTER TABLE `version_ver` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `version_ver` with 1 row(s)
--

--
-- Table structure for table `volunteeropportunity_vol`
--

DROP TABLE IF EXISTS `volunteeropportunity_vol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volunteeropportunity_vol` (
  `vol_ID` int(3) NOT NULL AUTO_INCREMENT,
  `vol_Order` int(3) NOT NULL DEFAULT 0,
  `vol_Active` enum('true','false') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'true',
  `vol_Name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vol_Description` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`vol_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volunteeropportunity_vol`
--

LOCK TABLES `volunteeropportunity_vol` WRITE;
/*!40000 ALTER TABLE `volunteeropportunity_vol` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `volunteeropportunity_vol` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `volunteeropportunity_vol` with 0 row(s)
--

--
-- Table structure for table `whycame_why`
--

DROP TABLE IF EXISTS `whycame_why`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whycame_why` (
  `why_ID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `why_per_ID` mediumint(9) NOT NULL DEFAULT 0,
  `why_join` text COLLATE utf8_unicode_ci NOT NULL,
  `why_come` text COLLATE utf8_unicode_ci NOT NULL,
  `why_suggest` text COLLATE utf8_unicode_ci NOT NULL,
  `why_hearOfUs` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`why_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `whycame_why`
--

LOCK TABLES `whycame_why` WRITE;
/*!40000 ALTER TABLE `whycame_why` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `whycame_why` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `whycame_why` with 0 row(s)
--

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on: Fri, 15 Jan 2021 11:29:02 +0300


-- 1st March 2021
