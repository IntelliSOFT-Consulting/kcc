-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 02, 2021 at 06:14 AM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `churchcrm`
--

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
CREATE TABLE IF NOT EXISTS `assets` (
  `asset_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_name` varchar(50) NOT NULL,
  `make` varchar(50) NOT NULL,
  `asset_condition` varchar(20) NOT NULL,
  `asset_description` longtext NOT NULL,
  `asset_category` varchar(20) NOT NULL,
  `asset_file` blob NOT NULL,
  `purchase_date` varchar(30) NOT NULL,
  `asset_deleted` enum('False','True') NOT NULL,
  PRIMARY KEY (`asset_id`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`asset_id`, `asset_name`, `make`, `asset_condition`, `asset_description`, `asset_category`, `asset_file`, `purchase_date`, `asset_deleted`) VALUES
(174, 'Bass Amplifier', 'CRATE BX160', 'New', 'New Amplifier', 'Bass Amplifier', '', '2021-05-09', 'False');

-- --------------------------------------------------------

--
-- Table structure for table `asset_category`
--

DROP TABLE IF EXISTS `asset_category`;
CREATE TABLE IF NOT EXISTS `asset_category` (
  `category_id` int(50) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `category_deleted` enum('False','True') NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `asset_category`
--

INSERT INTO `asset_category` (`category_id`, `category_name`, `category_deleted`) VALUES
(1, 'Powerful guitar', 'False'),
(2, 'Bass guitar', 'False'),
(5, 'Bass Amplifier', 'False');

-- --------------------------------------------------------

--
-- Table structure for table `asset_inventory`
--

DROP TABLE IF EXISTS `asset_inventory`;
CREATE TABLE IF NOT EXISTS `asset_inventory` (
  `asset_id` int(50) NOT NULL,
  `serialNumber` varchar(50) NOT NULL,
  `quantity` int(50) NOT NULL,
  `unitCost` varchar(50) NOT NULL,
  `totalCost` varchar(50) NOT NULL,
  `location_code` varchar(70) NOT NULL,
  `movementType` enum('Incoming','Outgoing') NOT NULL,
  `movementComment` mediumtext NOT NULL,
  `inventoryDeleted` enum('False','True') NOT NULL,
  KEY `asset_id` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `asset_location`
--

DROP TABLE IF EXISTS `asset_location`;
CREATE TABLE IF NOT EXISTS `asset_location` (
  `location_id` int(50) NOT NULL AUTO_INCREMENT,
  `location` varchar(70) NOT NULL,
  `location_code` varchar(50) NOT NULL,
  `locationDeleted` enum('False','True') NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `asset_location`
--

INSERT INTO `asset_location` (`location_id`, `location`, `location_code`, `locationDeleted`) VALUES
(5, 'Senior Pastor Office', 'KCC/SNP', 'False'),
(7, 'Youth Office', 'KCC/YTH', 'False');

-- --------------------------------------------------------

--
-- Table structure for table `calendars`
--

DROP TABLE IF EXISTS `calendars`;
CREATE TABLE IF NOT EXISTS `calendars` (
  `calendar_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `accesstoken` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `foregroundColor` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `backgroundColor` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`calendar_id`),
  UNIQUE KEY `accesstoken` (`accesstoken`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `calendars`
--

INSERT INTO `calendars` (`calendar_id`, `name`, `accesstoken`, `foregroundColor`, `backgroundColor`) VALUES
(1, 'Public Calendar', NULL, 'FFFFFF', '00AA00'),
(2, 'Private Calendar', NULL, 'FFFFFF', '0000AA');

-- --------------------------------------------------------

--
-- Table structure for table `calendar_events`
--

DROP TABLE IF EXISTS `calendar_events`;
CREATE TABLE IF NOT EXISTS `calendar_events` (
  `calendar_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  PRIMARY KEY (`calendar_id`,`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `calendar_events`
--

INSERT INTO `calendar_events` (`calendar_id`, `event_id`) VALUES
(1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `canvassdata_can`
--

DROP TABLE IF EXISTS `canvassdata_can`;
CREATE TABLE IF NOT EXISTS `canvassdata_can` (
  `can_ID` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT,
  `can_famID` mediumint(9) NOT NULL DEFAULT '0',
  `can_Canvasser` mediumint(9) NOT NULL DEFAULT '0',
  `can_FYID` mediumint(9) DEFAULT NULL,
  `can_date` date DEFAULT NULL,
  `can_Positive` text COLLATE utf8_unicode_ci,
  `can_Critical` text COLLATE utf8_unicode_ci,
  `can_Insightful` text COLLATE utf8_unicode_ci,
  `can_Financial` text COLLATE utf8_unicode_ci,
  `can_Suggestion` text COLLATE utf8_unicode_ci,
  `can_NotInterested` tinyint(1) NOT NULL DEFAULT '0',
  `can_WhyNotInterested` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`can_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `church_location_person`
--

DROP TABLE IF EXISTS `church_location_person`;
CREATE TABLE IF NOT EXISTS `church_location_person` (
  `location_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  `person_location_role_id` int(11) NOT NULL,
  PRIMARY KEY (`location_id`,`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `church_location_role`
--

DROP TABLE IF EXISTS `church_location_role`;
CREATE TABLE IF NOT EXISTS `church_location_role` (
  `location_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `role_order` int(11) NOT NULL,
  `role_title` int(11) NOT NULL,
  PRIMARY KEY (`location_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `config_cfg`
--

DROP TABLE IF EXISTS `config_cfg`;
CREATE TABLE IF NOT EXISTS `config_cfg` (
  `cfg_id` int(11) NOT NULL DEFAULT '0',
  `cfg_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cfg_value` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`cfg_id`),
  UNIQUE KEY `cfg_name` (`cfg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `config_cfg`
--

INSERT INTO `config_cfg` (`cfg_id`, `cfg_name`, `cfg_value`) VALUES
(16, 'iMaxFailedLogins', '0'),
(23, 'sDefaultCountry', 'Kenya'),
(28, 'bSMTPAuth', ''),
(30, 'sSMTPPass', 'changeme'),
(48, 'bHideFriendDate', ''),
(49, 'bHideFamilyNewsletter', ''),
(50, 'bHideWeddingDate', ''),
(51, 'bHideLatLon', ''),
(52, 'bUseDonationEnvelopes', ''),
(53, 'sHeader', 'Karen Community Church'),
(58, 'bUseScannedChecks', ''),
(64, 'sDistanceUnit', 'kilometers'),
(65, 'sTimeZone', 'Africa/Nairobi'),
(67, 'bForceUppercaseZip', ''),
(72, 'bEnableNonDeductible', ''),
(80, 'bEnableSelfRegistration', ''),
(100, 'sPhoneFormat', ''),
(102, 'sDateFormatLong', 'd/m/Y'),
(103, 'sDateFormatNoYear', 'd/m'),
(999, 'bRegistered', ''),
(1003, 'sChurchName', 'Karen Community Church'),
(1027, 'sPledgeSummary2', 'as of'),
(1028, 'sDirectoryDisclaimer1', 'Every effort was made to insure the accuracy of this directory.  If there are any errors or omissions, please contact the church office.This directory is for the use of the people of'),
(1035, 'bEnableGravatarPhotos', ''),
(1036, 'bEnableExternalBackupTarget', ''),
(1037, 'sExternalBackupType', 'WebDAV'),
(1046, 'sLastIntegrityCheckTimeStamp', '20210625-153652'),
(1047, 'sChurchCountry', 'Kenya'),
(2010, 'bAllowEmptyLastName', ''),
(2013, 'sChurchWebSite', 'https://www.karencommunitychurch.org/'),
(2015, 'sChurchTwitter', 'admin'),
(2017, 'bEnableExternalCalendarAPI', '1'),
(2045, 'bPHPMailerAutoTLS', ''),
(2046, 'sPHPMailerSMTPSecure', ''),
(2050, 'bEnabledMenuLinks', ''),
(2052, 'bEnabledFinance', ''),
(2055, 'bEnabledFundraiser', ''),
(2056, 'bEnabledEmail', ''),
(2060, 'IncludeDataInNewPersonNotifications', ''),
(2061, 'bSearchIncludeFamilyCustomProperties', ''),
(2062, 'bBackupExtraneousImages', ''),
(2064, 'sLastSoftwareUpdateCheckTimeStamp', '20210630-213606'),
(2065, 'bAllowPrereleaseUpgrade', ''),
(2069, 'bRequire2FA', ''),
(2071, 'bSendUserDeletedEmail', ''),
(2073, 'bEnabledDashboardV2', '1'),
(20142, 'bHSTSEnable', '');

-- --------------------------------------------------------

--
-- Table structure for table `deposit_dep`
--

DROP TABLE IF EXISTS `deposit_dep`;
CREATE TABLE IF NOT EXISTS `deposit_dep` (
  `dep_ID` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dep_Date` date DEFAULT NULL,
  `dep_Comment` text COLLATE utf8_unicode_ci,
  `dep_EnteredBy` mediumint(9) UNSIGNED DEFAULT NULL,
  `dep_Closed` tinyint(1) NOT NULL DEFAULT '0',
  `dep_Type` enum('Bank','CreditCard','BankDraft','eGive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Bank',
  PRIMARY KEY (`dep_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0;

--
-- Dumping data for table `deposit_dep`
--

INSERT INTO `deposit_dep` (`dep_ID`, `dep_Date`, `dep_Comment`, `dep_EnteredBy`, `dep_Closed`, `dep_Type`) VALUES
(1, '2021-01-12', 'Churches are businesses', NULL, 0, 'Bank');

-- --------------------------------------------------------

--
-- Table structure for table `donateditem_di`
--

DROP TABLE IF EXISTS `donateditem_di`;
CREATE TABLE IF NOT EXISTS `donateditem_di` (
  `di_ID` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT,
  `di_item` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `di_FR_ID` mediumint(9) UNSIGNED NOT NULL,
  `di_donor_ID` mediumint(9) NOT NULL DEFAULT '0',
  `di_buyer_ID` mediumint(9) NOT NULL DEFAULT '0',
  `di_multibuy` smallint(1) NOT NULL DEFAULT '0',
  `di_title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `di_description` text COLLATE utf8_unicode_ci,
  `di_sellprice` decimal(8,2) DEFAULT NULL,
  `di_estprice` decimal(8,2) DEFAULT NULL,
  `di_minimum` decimal(8,2) DEFAULT NULL,
  `di_materialvalue` decimal(8,2) DEFAULT NULL,
  `di_EnteredBy` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `di_EnteredDate` date NOT NULL,
  `di_picture` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`di_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `donateditem_di`
--

INSERT INTO `donateditem_di` (`di_ID`, `di_item`, `di_FR_ID`, `di_donor_ID`, `di_buyer_ID`, `di_multibuy`, `di_title`, `di_description`, `di_sellprice`, `di_estprice`, `di_minimum`, `di_materialvalue`, `di_EnteredBy`, `di_EnteredDate`, `di_picture`) VALUES
(1, 'Test_Item', 1, 0, 0, 0, 'Test_Fundraiser', '', '0.00', '0.00', '0.00', '0.00', 1, '2021-01-12', '');

-- --------------------------------------------------------

--
-- Table structure for table `donationfund_fun`
--

DROP TABLE IF EXISTS `donationfund_fun`;
CREATE TABLE IF NOT EXISTS `donationfund_fun` (
  `fun_ID` tinyint(3) NOT NULL AUTO_INCREMENT,
  `fun_Active` enum('true','false') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'true',
  `fun_Name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fun_Description` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fun_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `donationfund_fun`
--

INSERT INTO `donationfund_fun` (`fun_ID`, `fun_Active`, `fun_Name`, `fun_Description`) VALUES
(1, 'true', 'Pledges', 'Pledge income for the operating budget');

-- --------------------------------------------------------

--
-- Table structure for table `egive_egv`
--

DROP TABLE IF EXISTS `egive_egv`;
CREATE TABLE IF NOT EXISTS `egive_egv` (
  `egv_egiveID` varchar(16) CHARACTER SET utf8 NOT NULL,
  `egv_famID` int(11) NOT NULL,
  `egv_DateEntered` datetime NOT NULL,
  `egv_DateLastEdited` datetime NOT NULL,
  `egv_EnteredBy` smallint(6) NOT NULL DEFAULT '0',
  `egv_EditedBy` smallint(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_message_pending_emp`
--

DROP TABLE IF EXISTS `email_message_pending_emp`;
CREATE TABLE IF NOT EXISTS `email_message_pending_emp` (
  `emp_usr_id` mediumint(9) UNSIGNED NOT NULL DEFAULT '0',
  `emp_to_send` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `emp_subject` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `emp_message` text COLLATE utf8_unicode_ci NOT NULL,
  `emp_attach_name` text COLLATE utf8_unicode_ci,
  `emp_attach` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_recipient_pending_erp`
--

DROP TABLE IF EXISTS `email_recipient_pending_erp`;
CREATE TABLE IF NOT EXISTS `email_recipient_pending_erp` (
  `erp_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `erp_usr_id` mediumint(9) UNSIGNED NOT NULL DEFAULT '0',
  `erp_num_attempt` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `erp_failed_time` datetime DEFAULT NULL,
  `erp_email_address` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `eventcountnames_evctnm`
--

DROP TABLE IF EXISTS `eventcountnames_evctnm`;
CREATE TABLE IF NOT EXISTS `eventcountnames_evctnm` (
  `evctnm_countid` int(5) NOT NULL AUTO_INCREMENT,
  `evctnm_eventtypeid` smallint(5) NOT NULL DEFAULT '0',
  `evctnm_countname` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `evctnm_notes` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  UNIQUE KEY `evctnm_countid` (`evctnm_countid`),
  UNIQUE KEY `evctnm_eventtypeid` (`evctnm_eventtypeid`,`evctnm_countname`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `eventcountnames_evctnm`
--

INSERT INTO `eventcountnames_evctnm` (`evctnm_countid`, `evctnm_eventtypeid`, `evctnm_countname`, `evctnm_notes`) VALUES
(1, 1, 'Total', ''),
(2, 1, 'Members', ''),
(3, 1, 'Visitors', ''),
(4, 2, 'Total', ''),
(5, 2, 'Members', ''),
(6, 2, 'Visitors', ''),
(7, 3, '1', ''),
(8, 3, 'Total', ''),
(9, 4, 'Total', '');

-- --------------------------------------------------------

--
-- Table structure for table `eventcounts_evtcnt`
--

DROP TABLE IF EXISTS `eventcounts_evtcnt`;
CREATE TABLE IF NOT EXISTS `eventcounts_evtcnt` (
  `evtcnt_eventid` int(5) NOT NULL DEFAULT '0',
  `evtcnt_countid` int(5) NOT NULL DEFAULT '0',
  `evtcnt_countname` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `evtcnt_countcount` int(6) DEFAULT NULL,
  `evtcnt_notes` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`evtcnt_eventid`,`evtcnt_countid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `eventcounts_evtcnt`
--

INSERT INTO `eventcounts_evtcnt` (`evtcnt_eventid`, `evtcnt_countid`, `evtcnt_countname`, `evtcnt_countcount`, `evtcnt_notes`) VALUES
(1, 7, '1', 69, 'yeet'),
(1, 8, 'Total', 420, 'yeet');

-- --------------------------------------------------------

--
-- Table structure for table `events_event`
--

DROP TABLE IF EXISTS `events_event`;
CREATE TABLE IF NOT EXISTS `events_event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_type` int(11) NOT NULL DEFAULT '0',
  `event_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `event_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_text` text COLLATE utf8_unicode_ci,
  `event_start` datetime NOT NULL,
  `event_end` datetime NOT NULL,
  `inactive` int(1) NOT NULL DEFAULT '0',
  `event_typename` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `location_id` int(11) DEFAULT NULL,
  `primary_contact_person_id` int(11) DEFAULT NULL,
  `secondary_contact_person_id` int(11) DEFAULT NULL,
  `event_url` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `events_event`
--

INSERT INTO `events_event` (`event_id`, `event_type`, `event_title`, `event_desc`, `event_text`, `event_start`, `event_end`, `inactive`, `event_typename`, `location_id`, `primary_contact_person_id`, `secondary_contact_person_id`, `event_url`) VALUES
(1, 3, '2019-11-30-Annual Events', 'testing annual event. think birthday', '', '2019-11-30 07:00:00', '2019-11-30 08:00:00', 0, '', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `event_attend`
--

DROP TABLE IF EXISTS `event_attend`;
CREATE TABLE IF NOT EXISTS `event_attend` (
  `attend_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL DEFAULT '0',
  `person_id` int(11) NOT NULL DEFAULT '0',
  `checkin_date` datetime DEFAULT NULL,
  `checkin_id` int(11) DEFAULT NULL,
  `checkout_date` datetime DEFAULT NULL,
  `checkout_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`attend_id`),
  UNIQUE KEY `event_id` (`event_id`,`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_audience`
--

DROP TABLE IF EXISTS `event_audience`;
CREATE TABLE IF NOT EXISTS `event_audience` (
  `event_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`event_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_types`
--

DROP TABLE IF EXISTS `event_types`;
CREATE TABLE IF NOT EXISTS `event_types` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type_defstarttime` time NOT NULL DEFAULT '00:00:00',
  `type_defrecurtype` enum('none','weekly','monthly','yearly') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'none',
  `type_defrecurDOW` enum('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Sunday',
  `type_defrecurDOM` char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `type_defrecurDOY` date NOT NULL DEFAULT '2000-01-01',
  `type_active` int(1) NOT NULL DEFAULT '1',
  `type_grpid` mediumint(9) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `event_types`
--

INSERT INTO `event_types` (`type_id`, `type_name`, `type_defstarttime`, `type_defrecurtype`, `type_defrecurDOW`, `type_defrecurDOM`, `type_defrecurDOY`, `type_active`, `type_grpid`) VALUES
(1, 'Church Service', '10:30:00', 'weekly', 'Sunday', '', '2016-01-01', 1, NULL),
(2, 'Sunday School', '09:30:00', 'weekly', 'Sunday', '', '2016-01-01', 1, NULL),
(3, 'Annual Events', '07:00:00', 'yearly', 'Sunday', '0', '0000-00-00', 1, NULL),
(4, 'Youth service', '09:00:00', 'monthly', 'Sunday', '7', '2000-01-01', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `family_custom`
--

DROP TABLE IF EXISTS `family_custom`;
CREATE TABLE IF NOT EXISTS `family_custom` (
  `fam_ID` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`fam_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `family_custom`
--

INSERT INTO `family_custom` (`fam_ID`) VALUES
(2),
(5),
(6),
(18),
(19),
(20),
(21),
(22);

-- --------------------------------------------------------

--
-- Table structure for table `family_custom_master`
--

DROP TABLE IF EXISTS `family_custom_master`;
CREATE TABLE IF NOT EXISTS `family_custom_master` (
  `fam_custom_Order` smallint(6) NOT NULL DEFAULT '0',
  `fam_custom_Field` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `fam_custom_Name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `fam_custom_Special` mediumint(8) UNSIGNED DEFAULT NULL,
  `fam_custom_FieldSec` tinyint(4) NOT NULL DEFAULT '1',
  `type_ID` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `family_fam`
--

DROP TABLE IF EXISTS `family_fam`;
CREATE TABLE IF NOT EXISTS `family_fam` (
  `fam_ID` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT,
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
  `fam_EnteredBy` smallint(5) NOT NULL DEFAULT '0',
  `fam_EditedBy` smallint(5) UNSIGNED DEFAULT '0',
  `fam_scanCheck` text COLLATE utf8_unicode_ci,
  `fam_scanCredit` text COLLATE utf8_unicode_ci,
  `fam_SendNewsLetter` enum('FALSE','TRUE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'FALSE',
  `fam_DateDeactivated` date DEFAULT NULL,
  `fam_OkToCanvass` enum('FALSE','TRUE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'FALSE',
  `fam_Canvasser` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `fam_Latitude` double DEFAULT NULL,
  `fam_Longitude` double DEFAULT NULL,
  `fam_Envelope` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`fam_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `family_fam`
--

INSERT INTO `family_fam` (`fam_ID`, `fam_Name`, `fam_Address1`, `fam_Address2`, `fam_City`, `fam_State`, `fam_Zip`, `fam_Country`, `fam_HomePhone`, `fam_WorkPhone`, `fam_CellPhone`, `fam_Email`, `fam_WeddingDate`, `fam_DateEntered`, `fam_DateLastEdited`, `fam_EnteredBy`, `fam_EditedBy`, `fam_scanCheck`, `fam_scanCredit`, `fam_SendNewsLetter`, `fam_DateDeactivated`, `fam_OkToCanvass`, `fam_Canvasser`, `fam_Latitude`, `fam_Longitude`, `fam_Envelope`) VALUES
(1, 'Name', '', '', '', '', '', 'Afghanistan (‫افغانستان‬‎)', '(254) 123-4567', '', '', 'test@server.com', NULL, '2021-01-07 12:26:48', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(2, 'Otungulo', '1234-55655', '', 'Nairobi', '', '69420', 'Kenya', '(254) 123-4567', '', '', 'secondary@mailclient.com', '2021-01-08', '2021-01-08 12:58:35', NULL, 1, 0, NULL, NULL, 'TRUE', NULL, 'TRUE', 0, 69, 420, 0),
(3, 'Otieno', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-03-04 10:47:59', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(4, 'Doe', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-03-04 12:38:34', NULL, 6, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(5, 'Opiyo', '456', '', 'Kisumu', '', '', 'Kenya', '', '', '', '', '2021-03-18', '2021-03-18 08:13:44', NULL, 1, 0, NULL, NULL, 'TRUE', NULL, 'TRUE', 0, 0, 0, 0),
(6, 'Jomo\'s', '', '', '', '', '', 'Kenya', '', '', '', '', '2021-03-18', '2021-03-18 08:50:57', NULL, 1, 0, NULL, NULL, 'TRUE', NULL, 'TRUE', 0, 0, 0, 0),
(7, 'Gathirimu', '', '', '', '', '', 'Kenya', '', '0712398767', '0712398767', '', NULL, '2021-03-18 10:17:44', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(8, 'Mwanaidi', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-05-30 14:45:10', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(9, 'Wandera', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-05-30 14:53:42', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(10, 'Wandera', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-05-30 14:53:44', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(11, 'Mwaura', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-05-30 14:55:31', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(12, 'Musembi', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-05-30 15:08:36', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(13, 'Atieno', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-05-30 15:27:22', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(14, 'Albert', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-05-31 16:44:10', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(15, 'Albert', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-05-31 16:57:59', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(16, 'Albert', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-05-31 17:00:43', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(17, 'Omondi', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-06-17 16:07:31', NULL, 1, 0, NULL, NULL, 'FALSE', NULL, 'FALSE', 0, NULL, NULL, 0),
(18, 'Otieno', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-06-17 16:08:33', NULL, 1, 0, NULL, NULL, 'TRUE', NULL, 'TRUE', 0, 0, 0, 0),
(19, 'Mwaura\'s', '2782 Karen', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-06-17 16:10:25', NULL, 1, 0, NULL, NULL, 'TRUE', NULL, 'TRUE', 0, 0, 0, 0),
(20, 'Wanja', '230-00200', '', 'Karen', '', '', 'Kenya', '', '', '', '', NULL, '2021-06-18 14:10:58', NULL, 1, 0, NULL, NULL, 'TRUE', NULL, 'TRUE', 0, 0, 0, 0),
(21, 'Wamugunda', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-06-28 11:40:07', NULL, 1, 0, NULL, NULL, 'TRUE', NULL, 'TRUE', 0, 0, 0, 0),
(22, 'test1', '', '', '', '', '', 'Kenya', '', '', '', '', NULL, '2021-06-28 12:11:55', NULL, 1, 0, NULL, NULL, 'TRUE', NULL, 'TRUE', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fundraiser_fr`
--

DROP TABLE IF EXISTS `fundraiser_fr`;
CREATE TABLE IF NOT EXISTS `fundraiser_fr` (
  `fr_ID` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fr_date` date DEFAULT NULL,
  `fr_title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `fr_description` text COLLATE utf8_unicode_ci,
  `fr_EnteredBy` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `fr_EnteredDate` date NOT NULL,
  PRIMARY KEY (`fr_ID`),
  UNIQUE KEY `fr_ID` (`fr_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fundraiser_fr`
--

INSERT INTO `fundraiser_fr` (`fr_ID`, `fr_date`, `fr_title`, `fr_description`, `fr_EnteredBy`, `fr_EnteredDate`) VALUES
(1, '2021-01-12', 'Test_Fundraiser', 'Gimme moneys', 1, '2021-01-12');

-- --------------------------------------------------------

--
-- Table structure for table `groupprop_master`
--

DROP TABLE IF EXISTS `groupprop_master`;
CREATE TABLE IF NOT EXISTS `groupprop_master` (
  `grp_ID` mediumint(9) UNSIGNED NOT NULL DEFAULT '0',
  `prop_ID` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `prop_Field` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `prop_Name` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prop_Description` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_ID` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `prop_Special` mediumint(9) UNSIGNED DEFAULT NULL,
  `prop_PersonDisplay` enum('false','true') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'false'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Group-specific properties order, name, description, type';

-- --------------------------------------------------------

--
-- Table structure for table `group_grp`
--

DROP TABLE IF EXISTS `group_grp`;
CREATE TABLE IF NOT EXISTS `group_grp` (
  `grp_ID` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `grp_Type` tinyint(4) NOT NULL DEFAULT '0',
  `grp_RoleListID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `grp_DefaultRole` mediumint(9) NOT NULL DEFAULT '0',
  `grp_Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `grp_Description` text COLLATE utf8_unicode_ci,
  `grp_hasSpecialProps` tinyint(1) NOT NULL DEFAULT '0',
  `grp_active` tinyint(1) NOT NULL DEFAULT '1',
  `grp_include_email_export` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`grp_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `group_grp`
--

INSERT INTO `group_grp` (`grp_ID`, `grp_Type`, `grp_RoleListID`, `grp_DefaultRole`, `grp_Name`, `grp_Description`, `grp_hasSpecialProps`, `grp_active`, `grp_include_email_export`) VALUES
(1, 1, 13, 1, 'Test', 'test group', 0, 1, 1),
(6, 4, 27, 2, 'Highness Kids', NULL, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `istlookup_lu`
--

DROP TABLE IF EXISTS `istlookup_lu`;
CREATE TABLE IF NOT EXISTS `istlookup_lu` (
  `lu_fam_ID` mediumint(9) NOT NULL DEFAULT '0',
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

-- --------------------------------------------------------

--
-- Table structure for table `kioskassginment_kasm`
--

DROP TABLE IF EXISTS `kioskassginment_kasm`;
CREATE TABLE IF NOT EXISTS `kioskassginment_kasm` (
  `kasm_ID` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT,
  `kasm_kdevId` mediumint(9) DEFAULT NULL,
  `kasm_AssignmentType` mediumint(9) DEFAULT NULL,
  `kasm_EventId` mediumint(9) DEFAULT '0',
  PRIMARY KEY (`kasm_ID`),
  UNIQUE KEY `kasm_ID` (`kasm_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kioskdevice_kdev`
--

DROP TABLE IF EXISTS `kioskdevice_kdev`;
CREATE TABLE IF NOT EXISTS `kioskdevice_kdev` (
  `kdev_ID` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT,
  `kdev_GUIDHash` char(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kdev_Name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kdev_deviceType` mediumint(9) NOT NULL DEFAULT '0',
  `kdev_lastHeartbeat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `kdev_Accepted` tinyint(1) DEFAULT NULL,
  `kdev_PendingCommands` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`kdev_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `list_lst`
--

DROP TABLE IF EXISTS `list_lst`;
CREATE TABLE IF NOT EXISTS `list_lst` (
  `lst_ID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `lst_OptionID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `lst_OptionSequence` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `lst_OptionName` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `list_lst`
--

INSERT INTO `list_lst` (`lst_ID`, `lst_OptionID`, `lst_OptionSequence`, `lst_OptionName`) VALUES
(1, 1, 1, 'Member'),
(1, 2, 2, 'Regular Attender'),
(1, 3, 3, 'Guest'),
(1, 5, 4, 'Non-Attender'),
(1, 4, 5, 'Non-Attender (staff)'),
(2, 1, 1, 'Head of Household'),
(2, 2, 2, 'Spouse'),
(2, 3, 3, 'Child'),
(2, 4, 4, 'Other Relative'),
(2, 5, 5, 'Non Relative'),
(3, 1, 1, 'Ministry'),
(3, 2, 2, 'Team'),
(3, 3, 3, 'Bible Study'),
(3, 4, 4, 'Sunday School Class'),
(4, 1, 1, 'True / False'),
(4, 2, 2, 'Date'),
(4, 3, 3, 'Text Field (50 char)'),
(4, 4, 4, 'Text Field (100 char)'),
(4, 5, 5, 'Text Field (Long)'),
(4, 6, 6, 'Year'),
(4, 7, 7, 'Season'),
(4, 8, 8, 'Number'),
(4, 9, 9, 'Person from Group'),
(4, 10, 10, 'Money'),
(4, 11, 11, 'Phone Number'),
(4, 12, 12, 'Custom Drop-Down List'),
(5, 1, 1, 'bAll'),
(5, 2, 2, 'bAdmin'),
(5, 3, 3, 'bAddRecords'),
(5, 4, 4, 'bEditRecords'),
(5, 5, 5, 'bDeleteRecords'),
(5, 7, 7, 'bManageGroups'),
(5, 8, 8, 'bFinance'),
(5, 9, 9, 'bNotes'),
(5, 11, 11, 'bCanvasser'),
(10, 1, 1, 'Teacher'),
(10, 2, 2, 'Student'),
(11, 1, 1, 'Member'),
(12, 1, 1, 'Teacher'),
(12, 2, 2, 'Student'),
(13, 1, 1, 'Member'),
(1, 7, 6, 'Member(staff)'),
(1, 8, 7, 'Regular Attender(Staff)'),
(1, 9, 8, 'Guest(Staff)'),
(14, 1, 1, 'Teacher'),
(14, 2, 2, 'Student'),
(14, 3, 3, 'Support staff'),
(15, 2, 1, 'Resident'),
(15, 3, 2, 'Non-Resident'),
(16, 2, 1, 'Tertiary Level (university/college)'),
(16, 3, 2, 'Secondary Level (High School)'),
(16, 4, 3, 'Primary Level (Primary School)'),
(17, 2, 1, 'Single'),
(17, 3, 2, 'Married and living together'),
(17, 4, 3, 'Never married and living together'),
(17, 5, 4, 'Never married and not living together'),
(17, 6, 5, 'Widowed'),
(17, 7, 6, 'Separated'),
(17, 8, 7, 'Divorced'),
(17, 9, 8, 'Divorced and Remarried'),
(18, 2, 1, 'Pentecostal'),
(18, 3, 2, 'Roman Catholic'),
(18, 4, 3, 'Evangelical'),
(18, 5, 4, 'African Independent Churches'),
(18, 6, 5, 'Unchurched'),
(18, 7, 6, 'Other religion'),
(19, 2, 1, 'Yes'),
(19, 3, 2, 'No'),
(20, 2, 1, 'Yes'),
(20, 3, 2, 'No'),
(21, 2, 1, 'Through immersion'),
(21, 3, 2, 'Through sprinkling'),
(22, 2, 1, 'Yes'),
(22, 3, 2, 'No'),
(23, 2, 1, 'Worship'),
(23, 3, 2, 'Fellowship'),
(23, 4, 3, 'Discipleship'),
(23, 5, 4, 'Missions'),
(23, 6, 5, 'Church Administration'),
(24, 1, 1, 'Teacher'),
(24, 2, 2, 'Student'),
(25, 1, 1, 'Teacher'),
(25, 2, 2, 'Student'),
(25, 3, 3, 'Teaching Assistant'),
(26, 1, 1, 'Teacher'),
(26, 2, 2, 'Student'),
(27, 1, 1, 'Teacher'),
(27, 2, 2, 'Student'),
(28, 1, 1, 'Teacher'),
(28, 2, 2, 'Student'),
(29, 1, 1, 'Teacher'),
(29, 2, 2, 'Student'),
(30, 1, 1, 'Teacher'),
(30, 2, 2, 'Student'),
(31, 1, 1, 'Teacher'),
(31, 2, 2, 'Student'),
(32, 1, 1, 'Teacher'),
(32, 2, 2, 'Student'),
(33, 1, 1, 'Teacher'),
(33, 2, 2, 'Student'),
(34, 1, 1, 'Teacher'),
(34, 2, 2, 'Student');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
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

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `mediaID` int(11) NOT NULL AUTO_INCREMENT,
  `mediaFiles` blob NOT NULL,
  `mediaLinks` longtext NOT NULL,
  PRIMARY KEY (`mediaID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `menu_links`
--

DROP TABLE IF EXISTS `menu_links`;
CREATE TABLE IF NOT EXISTS `menu_links` (
  `linkId` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `linkName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkUri` text COLLATE utf8_unicode_ci NOT NULL,
  `linkOrder` int(11) NOT NULL,
  PRIMARY KEY (`linkId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `menu_links`
--

INSERT INTO `menu_links` (`linkId`, `linkName`, `linkUri`, `linkOrder`) VALUES
(1, 'Test', 'http://www.google.com', 0),
(5, 'Assets', 'https://kcc/AssetList.php', 0);

-- --------------------------------------------------------

--
-- Table structure for table `multibuy_mb`
--

DROP TABLE IF EXISTS `multibuy_mb`;
CREATE TABLE IF NOT EXISTS `multibuy_mb` (
  `mb_ID` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mb_per_ID` mediumint(9) NOT NULL DEFAULT '0',
  `mb_item_ID` mediumint(9) NOT NULL DEFAULT '0',
  `mb_count` decimal(8,0) DEFAULT NULL,
  PRIMARY KEY (`mb_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `note_nte`
--

DROP TABLE IF EXISTS `note_nte`;
CREATE TABLE IF NOT EXISTS `note_nte` (
  `nte_ID` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nte_per_ID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `nte_fam_ID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `nte_Private` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `nte_Text` text COLLATE utf8_unicode_ci,
  `nte_DateEntered` datetime NOT NULL,
  `nte_DateLastEdited` datetime DEFAULT NULL,
  `nte_EnteredBy` mediumint(8) NOT NULL DEFAULT '0',
  `nte_EditedBy` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `nte_Type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`nte_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `note_nte`
--

INSERT INTO `note_nte` (`nte_ID`, `nte_per_ID`, `nte_fam_ID`, `nte_Private`, `nte_Text`, `nte_DateEntered`, `nte_DateLastEdited`, `nte_EnteredBy`, `nte_EditedBy`, `nte_Type`) VALUES
(1, 1, 0, 0, 'system user changed password', '2021-01-07 12:09:34', NULL, 1, 0, 'user'),
(2, 2, 0, 0, 'Created', '2021-01-07 12:26:48', NULL, 1, 0, 'create'),
(3, 3, 0, 0, 'Created via Family', '2021-01-08 12:58:35', NULL, 1, 0, 'create'),
(4, 4, 0, 0, 'Created via Family', '2021-01-08 12:58:36', NULL, 1, 0, 'create'),
(5, 0, 2, 0, 'Created', '2021-01-08 12:58:35', NULL, 1, 0, 'create'),
(6, 5, 0, 0, 'Created', '2021-03-04 10:27:32', NULL, 1, 0, 'create'),
(7, 5, 0, 0, 'Added to group: Test', '2021-03-04 10:27:52', NULL, 1, 0, 'group'),
(8, 5, 0, 0, 'Updated', '2021-03-04 10:28:58', NULL, 1, 0, 'edit'),
(9, 5, 0, 0, 'system user created', '2021-03-04 10:29:49', NULL, 1, 0, 'user'),
(10, 6, 0, 0, 'Created', '2021-03-04 10:48:00', NULL, 1, 0, 'create'),
(11, 7, 0, 0, 'Created', '2021-03-04 10:48:45', NULL, 1, 0, 'create'),
(12, 8, 0, 0, 'Created', '2021-03-04 10:49:23', NULL, 1, 0, 'create'),
(13, 6, 0, 0, 'Updated', '2021-03-04 12:13:55', NULL, 1, 0, 'edit'),
(14, 6, 0, 0, 'Updated', '2021-03-04 12:17:02', NULL, 1, 0, 'edit'),
(15, 6, 0, 0, 'system user created', '2021-03-04 12:36:46', NULL, 1, 0, 'user'),
(16, 6, 0, 0, 'system user password changed by admin', '2021-03-04 12:37:10', NULL, 1, 0, 'user'),
(17, 9, 0, 0, 'Created', '2021-03-04 12:38:34', NULL, 6, 0, 'create'),
(18, 6, 0, 0, 'system user updated', '2021-03-04 12:40:33', NULL, 1, 0, 'user'),
(19, 6, 0, 0, 'Updated', '2021-03-04 16:55:20', NULL, 1, 0, 'edit'),
(20, 7, 0, 0, 'system user created', '2021-03-04 17:02:06', NULL, 1, 0, 'user'),
(21, 8, 0, 0, 'system user created', '2021-03-04 17:05:18', NULL, 1, 0, 'user'),
(22, 8, 0, 0, 'system user password changed by admin', '2021-03-04 17:06:21', NULL, 1, 0, 'user'),
(23, 1, 0, 0, 'system user updated', '2021-03-16 17:22:34', NULL, 1, 0, 'user'),
(24, 0, 5, 0, 'Created', '2021-03-18 08:13:44', NULL, 1, 0, 'create'),
(25, 0, 6, 0, 'Created', '2021-03-18 08:50:57', NULL, 1, 0, 'create'),
(26, 10, 0, 0, 'Created', '2021-03-18 10:17:45', NULL, 1, 0, 'create'),
(27, 10, 0, 0, 'Profile Image uploaded', '2021-03-30 11:21:49', NULL, 1, 0, 'photo'),
(28, 10, 0, 0, 'Updated', '2021-04-20 10:48:20', NULL, 1, 0, 'edit'),
(29, 5, 0, 0, 'Added to group: Deca-haddassar', '2021-05-30 14:40:53', NULL, 1, 0, 'group'),
(30, 11, 0, 0, 'Created', '2021-05-30 14:45:11', NULL, 1, 0, 'create'),
(31, 12, 0, 0, 'Created', '2021-05-30 14:53:42', NULL, 1, 0, 'create'),
(32, 13, 0, 0, 'Created', '2021-05-30 14:53:44', NULL, 1, 0, 'create'),
(33, 14, 0, 0, 'Created', '2021-05-30 14:55:32', NULL, 1, 0, 'create'),
(34, 15, 0, 0, 'Created', '2021-05-30 15:08:37', NULL, 1, 0, 'create'),
(35, 16, 0, 0, 'Created', '2021-05-30 15:27:23', NULL, 1, 0, 'create'),
(36, 17, 0, 0, 'Created', '2021-05-31 16:44:11', NULL, 1, 0, 'create'),
(37, 18, 0, 0, 'Created', '2021-05-31 16:57:59', NULL, 1, 0, 'create'),
(38, 19, 0, 0, 'Created', '2021-05-31 17:00:44', NULL, 1, 0, 'create'),
(39, 11, 0, 0, 'Added to group: Deca-haddassar', '2021-06-14 07:57:33', NULL, 1, 0, 'group'),
(40, 9, 0, 0, 'Added to group: Highness Kids', '2021-06-14 08:00:51', NULL, 1, 0, 'group'),
(41, 11, 0, 0, 'Added to group: Highness Kids', '2021-06-14 08:01:29', NULL, 1, 0, 'group'),
(42, 9, 0, 0, 'Added to group: Highness Kids', '2021-06-14 08:01:36', NULL, 1, 0, 'group'),
(43, 11, 0, 0, 'Added to group: Blessed Kids', '2021-06-15 11:06:08', NULL, 1, 0, 'group'),
(44, 5, 0, 0, 'Added to group: Blessed Kids', '2021-06-15 11:06:32', NULL, 1, 0, 'group'),
(45, 14, 0, 0, 'Added to group: Generation Z', '2021-06-15 11:07:27', NULL, 1, 0, 'group'),
(46, 10, 0, 0, 'Added to group: Generation Z', '2021-06-15 11:07:38', NULL, 1, 0, 'group'),
(47, 5, 0, 0, 'Added to group: Deca-haddassar 2', '2021-06-15 11:59:42', NULL, 1, 0, 'group'),
(48, 15, 0, 0, 'Added to group: Blessed generation', '2021-06-15 12:05:31', NULL, 1, 0, 'group'),
(49, 12, 0, 0, 'Added to group: Generation Z', '2021-06-17 12:32:11', NULL, 1, 0, 'group'),
(50, 13, 0, 0, 'Added to group: Generation Z', '2021-06-17 12:32:26', NULL, 1, 0, 'group'),
(51, 20, 0, 0, 'Created', '2021-06-17 16:07:31', NULL, 1, 0, 'create'),
(52, 21, 0, 0, 'Created via Family', '2021-06-17 16:08:34', NULL, 1, 0, 'create'),
(53, 0, 18, 0, 'Created', '2021-06-17 16:08:33', NULL, 1, 0, 'create'),
(54, 21, 0, 0, 'Updated', '2021-06-17 16:09:07', NULL, 1, 0, 'edit'),
(55, 22, 0, 0, 'Created via Family', '2021-06-17 16:10:26', NULL, 1, 0, 'create'),
(56, 0, 19, 0, 'Created', '2021-06-17 16:10:25', NULL, 1, 0, 'create'),
(57, 23, 0, 0, 'Created via Family', '2021-06-18 14:10:59', NULL, 1, 0, 'create'),
(58, 24, 0, 0, 'Created via Family', '2021-06-18 14:10:59', NULL, 1, 0, 'create'),
(59, 0, 20, 0, 'Created', '2021-06-18 14:10:58', NULL, 1, 0, 'create'),
(60, 24, 0, 0, 'Added to group: Blessed girls', '2021-06-18 16:46:02', NULL, 1, 0, 'group'),
(61, 21, 0, 0, 'Added to group: Deca-haddassar', '2021-06-18 16:47:40', NULL, 1, 0, 'group'),
(62, 25, 0, 0, 'Created', '2021-06-25 15:38:39', NULL, 1, 0, 'create'),
(63, 26, 0, 0, 'Created', '2021-06-25 15:39:11', NULL, 1, 0, 'create'),
(64, 27, 0, 0, 'Created', '2021-06-25 15:40:27', NULL, 1, 0, 'create'),
(65, 28, 0, 0, 'Created', '2021-06-25 15:44:55', NULL, 1, 0, 'create'),
(66, 29, 0, 0, 'Created', '2021-06-25 16:14:33', NULL, 1, 0, 'create'),
(67, 30, 0, 0, 'Created', '2021-06-25 16:15:36', NULL, 1, 0, 'create'),
(68, 31, 0, 0, 'Created', '2021-06-25 16:18:03', NULL, 1, 0, 'create'),
(69, 32, 0, 0, 'Created', '2021-06-25 16:32:16', NULL, 1, 0, 'create'),
(70, 33, 0, 0, 'Created', '2021-06-25 16:33:59', NULL, 1, 0, 'create'),
(71, 34, 0, 0, 'Created', '2021-06-25 16:37:11', NULL, 1, 0, 'create'),
(72, 35, 0, 0, 'Created', '2021-06-25 16:41:13', NULL, 1, 0, 'create'),
(73, 36, 0, 0, 'Created', '2021-06-25 16:42:38', NULL, 1, 0, 'create'),
(74, 37, 0, 0, 'Created', '2021-06-25 16:43:58', NULL, 1, 0, 'create'),
(75, 38, 0, 0, 'Created', '2021-06-25 16:45:22', NULL, 1, 0, 'create'),
(76, 39, 0, 0, 'Created', '2021-06-28 10:33:00', NULL, 1, 0, 'create'),
(77, 40, 0, 0, 'Created', '2021-06-28 10:33:32', NULL, 1, 0, 'create'),
(78, 41, 0, 0, 'Created', '2021-06-28 10:33:58', NULL, 1, 0, 'create'),
(79, 42, 0, 0, 'Created', '2021-06-28 10:53:30', NULL, 1, 0, 'create'),
(80, 43, 0, 0, 'Created', '2021-06-28 10:54:43', NULL, 1, 0, 'create'),
(81, 44, 0, 0, 'Created', '2021-06-28 10:55:52', NULL, 1, 0, 'create'),
(82, 45, 0, 0, 'Created', '2021-06-28 10:56:29', NULL, 1, 0, 'create'),
(83, 46, 0, 0, 'Created', '2021-06-28 11:03:55', NULL, 1, 0, 'create'),
(84, 47, 0, 0, 'Created', '2021-06-28 11:03:58', NULL, 1, 0, 'create'),
(85, 48, 0, 0, 'Created', '2021-06-28 11:04:31', NULL, 1, 0, 'create'),
(86, 49, 0, 0, 'Created', '2021-06-28 11:05:41', NULL, 1, 0, 'create'),
(87, 50, 0, 0, 'Created', '2021-06-28 11:08:54', NULL, 1, 0, 'create'),
(88, 51, 0, 0, 'Created', '2021-06-28 11:09:33', NULL, 1, 0, 'create'),
(89, 52, 0, 0, 'Created', '2021-06-28 11:11:08', NULL, 1, 0, 'create'),
(90, 53, 0, 0, 'Created', '2021-06-28 11:12:55', NULL, 1, 0, 'create'),
(91, 54, 0, 0, 'Created', '2021-06-28 11:18:52', NULL, 1, 0, 'create'),
(92, 55, 0, 0, 'Created', '2021-06-28 11:34:50', NULL, 1, 0, 'create'),
(93, 56, 0, 0, 'Created', '2021-06-28 11:35:53', NULL, 1, 0, 'create'),
(94, 0, 21, 0, 'Created', '2021-06-28 11:40:07', NULL, 1, 0, 'create'),
(95, 57, 0, 0, 'Created', '2021-06-28 11:53:57', NULL, 1, 0, 'create'),
(96, 0, 22, 0, 'Created', '2021-06-28 12:11:55', NULL, 1, 0, 'create'),
(97, 58, 0, 0, 'Created', '2021-06-29 12:07:11', NULL, 1, 0, 'create'),
(98, 59, 0, 0, 'Created', '2021-06-29 12:08:09', NULL, 1, 0, 'create');

-- --------------------------------------------------------

--
-- Table structure for table `paddlenum_pn`
--

DROP TABLE IF EXISTS `paddlenum_pn`;
CREATE TABLE IF NOT EXISTS `paddlenum_pn` (
  `pn_ID` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pn_fr_ID` mediumint(9) UNSIGNED DEFAULT NULL,
  `pn_Num` mediumint(9) UNSIGNED DEFAULT NULL,
  `pn_per_ID` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pn_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(50) NOT NULL,
  `permission_desc` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `permission_name` (`permission_name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permission_id`, `permission_name`, `permission_desc`) VALUES
(1, 'addPeople', 'Add People'),
(3, 'updatePeople', 'Update People'),
(4, 'deletePeopleRecords', 'Delete People Records'),
(5, 'curdProperties', 'Manage Properties '),
(6, 'crudClassifications', 'Manage Classifications'),
(7, 'crudGroups', 'Manage Groups'),
(8, 'crudRoles', 'Manage Roles'),
(9, 'crudDonations', 'Manage Donations'),
(10, 'curdFinance', 'Manage Finance'),
(11, 'curdNotes', 'Manage Notes'),
(12, 'canvasser', 'Canvasser volunteer'),
(13, 'editSelf', 'Edit own family only'),
(14, 'emailMailto', 'Allow to see Mailto Links'),
(15, 'createDirectory', 'Create Directories'),
(16, 'exportCSV', 'Export CSV files'),
(17, 'usAddressVerification', 'Use IST Address Verification'),
(18, 'crudEvent', 'Manage Events');

-- --------------------------------------------------------

--
-- Table structure for table `person2group2role_p2g2r`
--

DROP TABLE IF EXISTS `person2group2role_p2g2r`;
CREATE TABLE IF NOT EXISTS `person2group2role_p2g2r` (
  `p2g2r_per_ID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `p2g2r_grp_ID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `p2g2r_rle_ID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`p2g2r_per_ID`,`p2g2r_grp_ID`),
  KEY `p2g2r_per_ID` (`p2g2r_per_ID`,`p2g2r_grp_ID`,`p2g2r_rle_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `person2group2role_p2g2r`
--

INSERT INTO `person2group2role_p2g2r` (`p2g2r_per_ID`, `p2g2r_grp_ID`, `p2g2r_rle_ID`) VALUES
(5, 1, 1),
(5, 4, 2),
(5, 7, 2),
(5, 8, 1),
(9, 6, 1),
(10, 3, 2),
(11, 5, 1),
(11, 6, 2),
(11, 7, 1),
(12, 3, 2),
(13, 3, 2),
(14, 3, 2),
(15, 9, 1),
(21, 10, 2),
(24, 11, 2);

-- --------------------------------------------------------

--
-- Table structure for table `person2volunteeropp_p2vo`
--

DROP TABLE IF EXISTS `person2volunteeropp_p2vo`;
CREATE TABLE IF NOT EXISTS `person2volunteeropp_p2vo` (
  `p2vo_ID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `p2vo_per_ID` mediumint(9) DEFAULT NULL,
  `p2vo_vol_ID` mediumint(9) DEFAULT NULL,
  PRIMARY KEY (`p2vo_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `person_custom`
--

DROP TABLE IF EXISTS `person_custom`;
CREATE TABLE IF NOT EXISTS `person_custom` (
  `per_ID` mediumint(9) NOT NULL DEFAULT '0',
  `c3` date DEFAULT NULL,
  `c4` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c5` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c6` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c7` tinyint(4) DEFAULT NULL,
  `c8` tinyint(4) DEFAULT NULL,
  `c9` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c10` text COLLATE utf8_unicode_ci,
  `c11` text COLLATE utf8_unicode_ci,
  `c12` text COLLATE utf8_unicode_ci,
  `c13` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c14` text COLLATE utf8_unicode_ci,
  `c15` tinyint(4) DEFAULT NULL,
  `c16` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c17` date DEFAULT NULL,
  `c18` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c19` text COLLATE utf8_unicode_ci,
  `c20` text COLLATE utf8_unicode_ci,
  `c21` text COLLATE utf8_unicode_ci,
  `c22` text COLLATE utf8_unicode_ci,
  `c23` tinyint(4) DEFAULT NULL,
  `c24` text COLLATE utf8_unicode_ci,
  `c25` text COLLATE utf8_unicode_ci,
  `c26` tinyint(4) DEFAULT NULL,
  `c27` text COLLATE utf8_unicode_ci,
  `c28` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c29` tinyint(4) DEFAULT NULL,
  `c30` tinyint(4) DEFAULT NULL,
  `c31` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c32` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c33` tinyint(4) DEFAULT NULL,
  `c34` tinyint(4) DEFAULT NULL,
  `c35` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c36` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c37` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c38` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c39` text COLLATE utf8_unicode_ci,
  `c40` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`per_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `person_custom`
--

INSERT INTO `person_custom` (`per_ID`, `c3`, `c4`, `c5`, `c6`, `c7`, `c8`, `c9`, `c10`, `c11`, `c12`, `c13`, `c14`, `c15`, `c16`, `c17`, `c18`, `c19`, `c20`, `c21`, `c22`, `c23`, `c24`, `c25`, `c26`, `c27`, `c28`, `c29`, `c30`, `c31`, `c32`, `c33`, `c34`, `c35`, `c36`, `c37`, `c38`, `c39`, `c40`) VALUES
(2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(31, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(37, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(38, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(41, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(43, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(45, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(46, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(47, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(48, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(49, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(51, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(52, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(53, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(54, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(55, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(57, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(58, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(59, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `person_custom_master`
--

DROP TABLE IF EXISTS `person_custom_master`;
CREATE TABLE IF NOT EXISTS `person_custom_master` (
  `custom_Order` smallint(6) NOT NULL DEFAULT '0',
  `custom_Field` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `custom_Name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `custom_Special` mediumint(8) UNSIGNED DEFAULT NULL,
  `custom_FieldSec` tinyint(4) NOT NULL,
  `type_ID` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`custom_Field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `person_custom_master`
--

INSERT INTO `person_custom_master` (`custom_Order`, `custom_Field`, `custom_Name`, `custom_Special`, `custom_FieldSec`, `type_ID`) VALUES
(7, 'c10', 'Other Training', NULL, 1, 5),
(8, 'c11', 'Professional Qualifications', NULL, 1, 5),
(9, 'c12', 'Present Occupation', NULL, 1, 5),
(10, 'c13', 'Present Employer', NULL, 1, 4),
(11, 'c14', 'Type of work area and responsibility', NULL, 1, 5),
(12, 'c15', 'Relationship Status', 17, 1, 12),
(13, 'c16', 'If married, name of spouse', NULL, 1, 4),
(14, 'c17', 'When did you get married?', NULL, 1, 2),
(15, 'c18', 'Where did you get married?', NULL, 1, 4),
(16, 'c19', 'Names of children', NULL, 1, 5),
(17, 'c20', 'Testimony on how you received Jesus', NULL, 1, 5),
(18, 'c21', 'Why do you want to join KCC?', NULL, 1, 5),
(19, 'c22', 'Church attended before KCC?', NULL, 1, 5),
(20, 'c23', 'Tick denomination background', 18, 1, 12),
(21, 'c24', 'Specify on other religion', NULL, 1, 5),
(22, 'c25', 'Name and address of the previous church', NULL, 1, 5),
(23, 'c26', 'Registered member of another church?', 19, 1, 12),
(24, 'c27', 'What ministries were you involved in?', NULL, 1, 5),
(25, 'c28', 'How long have you attended KCC?', NULL, 1, 4),
(26, 'c29', 'Have you been baptized?', 20, 1, 12),
(0, 'c3', 'Date of Application', NULL, 1, 2),
(27, 'c30', 'If YES, then how were you baptised?', 21, 1, 12),
(28, 'c31', 'In which church were you baptised?', NULL, 1, 4),
(29, 'c32', 'Name of the pastor who baptized you', NULL, 1, 4),
(30, 'c33', 'Are you serving in any ministry at KCC?', 22, 1, 12),
(31, 'c34', 'Which ministry?', 23, 1, 12),
(32, 'c35', 'If not serving, which one will you join?', NULL, 1, 3),
(33, 'c36', 'Other areas of involvement?', NULL, 1, 4),
(34, 'c37', 'What\'s your spiritual gift?', NULL, 1, 4),
(35, 'c38', 'Trained in Christian service & witness?', NULL, 1, 3),
(37, 'c39', 'Do you have any talents or abilities?', NULL, 1, 5),
(1, 'c4', 'Nationality', NULL, 1, 3),
(38, 'c40', 'Recommended by?', NULL, 1, 4),
(2, 'c5', 'Postal Address', NULL, 1, 4),
(3, 'c6', 'Residential Address', NULL, 1, 4),
(4, 'c7', 'Type of Membership', 15, 1, 12),
(5, 'c8', 'Level of Education', 16, 1, 12),
(6, 'c9', 'Area of professional Training', NULL, 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `person_per`
--

DROP TABLE IF EXISTS `person_per`;
CREATE TABLE IF NOT EXISTS `person_per` (
  `per_ID` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT,
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
  `per_BirthMonth` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `per_BirthDay` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `per_BirthYear` year(4) DEFAULT NULL,
  `per_MembershipDate` date DEFAULT NULL,
  `per_Gender` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `per_fmr_ID` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `per_cls_ID` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `per_fam_ID` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `per_Envelope` smallint(5) UNSIGNED DEFAULT NULL,
  `per_DateLastEdited` datetime DEFAULT NULL,
  `per_DateEntered` datetime NOT NULL,
  `per_EnteredBy` smallint(5) NOT NULL DEFAULT '0',
  `per_EditedBy` smallint(5) UNSIGNED DEFAULT '0',
  `per_FriendDate` date DEFAULT NULL,
  `per_Flags` mediumint(9) NOT NULL DEFAULT '0',
  `per_FacebookID` bigint(20) UNSIGNED DEFAULT NULL,
  `per_Twitter` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `per_LinkedIn` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`per_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `person_per`
--

INSERT INTO `person_per` (`per_ID`, `per_Title`, `per_FirstName`, `per_MiddleName`, `per_LastName`, `per_Suffix`, `per_Address1`, `per_Address2`, `per_City`, `per_State`, `per_Zip`, `per_Country`, `per_HomePhone`, `per_WorkPhone`, `per_CellPhone`, `per_Email`, `per_WorkEmail`, `per_BirthMonth`, `per_BirthDay`, `per_BirthYear`, `per_MembershipDate`, `per_Gender`, `per_fmr_ID`, `per_cls_ID`, `per_fam_ID`, `per_Envelope`, `per_DateLastEdited`, `per_DateEntered`, `per_EnteredBy`, `per_EditedBy`, `per_FriendDate`, `per_Flags`, `per_FacebookID`, `per_Twitter`, `per_LinkedIn`) VALUES
(1, NULL, 'Church', NULL, 'Admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0000, NULL, 0, 0, 0, 0, NULL, NULL, '2004-08-25 18:00:00', 1, 0, NULL, 0, NULL, NULL, NULL),
(2, '', 'A', 'User', 'Name', 'Jr', '', '', '', '', '', 'Afghanistan (‫افغانستان‬‎)', '(254) 123-4567', '', '', 'test@server.com', '', 6, 15, 1993, NULL, 1, 3, 3, 1, 0, NULL, '2021-01-07 12:26:48', 1, 0, '2021-01-07', 0, 0, '', ''),
(3, NULL, 'A', 'Family', 'Member', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 18, 1997, NULL, 2, 3, 0, 2, NULL, NULL, '2021-01-08 12:58:35', 1, 0, NULL, 0, NULL, NULL, NULL),
(4, NULL, 'Another', 'Family', 'Member', 'Sr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 6, 1985, NULL, 1, 1, 0, 2, NULL, NULL, '2021-01-08 12:58:36', 1, 0, NULL, 0, NULL, NULL, NULL),
(5, 'Mr', 'Josh', 'Musee', 'Katuu', '', '', '', '', '', '', 'Kenya', '', '', '(079) 982-0321', 'josh@gmail.com', '', 11, 15, 1990, NULL, 1, 0, 7, 0, 0, '2021-03-04 10:28:58', '2021-03-04 10:27:31', 1, 1, '2021-03-04', 0, 0, '', ''),
(6, 'Mrs', 'Esther', '', 'Otieno', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 8, 11, 1995, NULL, 2, 2, 8, 3, 0, '2021-03-04 16:55:19', '2021-03-04 10:47:59', 1, 1, '2021-03-04', 0, 0, '', ''),
(7, 'Mrs', 'Doreen', 'Kerubo', 'Ongayo', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 9, 13, 1997, NULL, 2, 0, 9, 0, 0, NULL, '2021-03-04 10:48:45', 1, 0, '2021-03-04', 0, 0, '', ''),
(8, '', 'Mwangi', '', 'Kinuthia', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 1, 0, 4, 0, 0, NULL, '2021-03-04 10:49:23', 1, 0, '2021-03-04', 0, 0, '', ''),
(9, 'Mr', 'John', '', 'Doe', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 9, 4, 1987, '2021-02-09', 1, 2, 1, 4, 0, NULL, '2021-03-04 12:38:34', 6, 0, '2021-03-04', 0, 0, '', ''),
(10, '', 'Nduta', 'Kinyanjui', 'Mathu', '', '', '', '', '', '', 'Kenya', '', '(071) 239-8767 x_____', '(071) 239-8767', '', '', 3, 18, 1990, NULL, 1, 3, 2, 7, 0, '2021-04-20 10:48:19', '2021-03-18 10:17:44', 1, 1, '2021-03-18', 0, 0, '', ''),
(11, '', 'Aisha', '', 'Mwanaidi', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 9, 14, 2010, NULL, 1, 3, 1, 8, 0, NULL, '2021-05-30 14:45:10', 1, 0, '2021-05-30', 0, 0, '', ''),
(12, '', 'Ann', '', 'Wandera', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 6, 17, 2014, NULL, 2, 3, 0, 9, 0, NULL, '2021-05-30 14:53:42', 1, 0, '2021-05-30', 0, 0, '', ''),
(13, '', 'Ann', '', 'Wandera', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 6, 17, 2014, NULL, 2, 3, 0, 10, 0, NULL, '2021-05-30 14:53:44', 1, 0, '2021-05-30', 0, 0, '', ''),
(14, '', 'Victor', 'Aiden', 'Mwaura', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 5, 31, 2015, NULL, 1, 3, 0, 11, 0, NULL, '2021-05-30 14:55:31', 1, 0, '2021-05-30', 0, 0, '', ''),
(15, '', 'Mary', '', 'Musembi', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 5, 31, 2009, NULL, 2, 3, 0, 12, 0, NULL, '2021-05-30 15:08:36', 1, 0, '2021-05-30', 0, 0, '', ''),
(16, '', 'Getty', '', 'Atieno', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 5, 31, 2009, NULL, 2, 3, 0, 13, 0, NULL, '2021-05-30 15:27:22', 1, 0, '2021-05-30', 0, 0, '', ''),
(17, '', 'Einstein', '', 'Albert', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 10, 10, 1950, NULL, 1, 1, 0, 14, 0, NULL, '2021-05-31 16:44:10', 1, 0, '2021-05-31', 0, 0, '', ''),
(18, '', 'Einstein', '', 'Albert', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 10, 10, 1950, NULL, 1, 1, 0, 15, 0, NULL, '2021-05-31 16:57:59', 1, 0, '2021-05-31', 0, 0, '', ''),
(19, '', 'Einstein', '', 'Albert', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 10, 10, 1950, NULL, 1, 1, 0, 16, 0, NULL, '2021-05-31 17:00:43', 1, 0, '2021-05-31', 0, 0, '', ''),
(20, '', 'Rosie', '', 'Omondi', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 3, 4, 2015, NULL, 2, 0, 0, 17, 0, NULL, '2021-06-17 16:07:31', 1, 0, '2021-06-17', 0, 0, '', ''),
(21, '', 'Aiden', '', 'Otieno', '', '', '', '', '', '', '', '', '', '', '', '', 7, 8, 2020, NULL, 0, 0, 0, 18, NULL, '2021-06-17 16:09:06', '2021-06-17 16:08:33', 1, 1, NULL, 0, 0, '', ''),
(22, NULL, 'Jane', '', 'Mwaura', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 18, 2018, NULL, 2, 3, 0, 19, NULL, NULL, '2021-06-17 16:10:25', 1, 0, NULL, 0, NULL, NULL, NULL),
(23, NULL, 'Asia', 'Mwanadi', 'Wambui', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 10, 2013, NULL, 2, 3, 0, 20, NULL, NULL, '2021-06-18 14:10:58', 1, 0, NULL, 0, NULL, NULL, NULL),
(24, NULL, 'Travis', 'Mbugua', 'Wambui', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 13, 2017, NULL, 1, 3, 0, 20, NULL, NULL, '2021-06-18 14:10:58', 1, 0, NULL, 0, NULL, NULL, NULL),
(25, '', 'Ashley', '', 'Mwongela', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 15:38:39', 1, 0, '2021-06-25', 0, 0, '', ''),
(26, '', 'Omwenga', '', 'Warutere', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 15:39:11', 1, 0, '2021-06-25', 0, 0, '', ''),
(27, '', 'Brian', '', 'Wekesa', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 15:40:27', 1, 0, '2021-06-25', 0, 0, '', ''),
(28, '', 'Lucy', '', 'Kimani', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 15:44:55', 1, 0, '2021-06-25', 0, 0, '', ''),
(29, '', 'Mary', '', 'Njoga', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 16:14:32', 1, 0, '2021-06-25', 0, 0, '', ''),
(30, '', 'Grace', '', 'Kinuthia', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 16:15:35', 1, 0, '2021-06-25', 0, 0, '', ''),
(31, '', 'Mary', '', 'Nyumba', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 16:18:03', 1, 0, '2021-06-25', 0, 0, '', ''),
(32, '', 'Booker', '', 'Chemutai', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 16:32:15', 1, 0, '2021-06-25', 0, 0, '', ''),
(33, '', 'Dickens', '', 'Juma', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 16:33:59', 1, 0, '2021-06-25', 0, 0, '', ''),
(34, '', 'Wayne', '', 'Mbuvi', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 16:37:11', 1, 0, '2021-06-25', 0, 0, '', ''),
(35, '', 'Jane', '', 'Okumu', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 16:41:12', 1, 0, '2021-06-25', 0, 0, '', ''),
(36, '', 'Edwine', '', 'Okoth', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 16:42:38', 1, 0, '2021-06-25', 0, 0, '', ''),
(37, '', 'Dennis', '', 'Kiprop', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 16:43:57', 1, 0, '2021-06-25', 0, 0, '', ''),
(38, '', 'Jeff', '', 'Koinange', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-25 16:45:21', 1, 0, '2021-06-25', 0, 0, '', ''),
(39, '', 'Brian', '', 'Oketch', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 10:32:59', 1, 0, '2021-06-28', 0, 0, '', ''),
(40, '', 'Brian', '', 'Oketch', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 10:33:31', 1, 0, '2021-06-28', 0, 0, '', ''),
(41, '', 'Brian', '', 'Oketch', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 10:33:58', 1, 0, '2021-06-28', 0, 0, '', ''),
(42, '', 'Abel', '', 'Musembi', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 10:53:30', 1, 0, '2021-06-28', 0, 0, '', ''),
(43, '', 'Emily', '', 'Muthii', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 10:54:42', 1, 0, '2021-06-28', 0, 0, '', ''),
(44, '', 'Emily', '', 'Muthii', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 10:55:52', 1, 0, '2021-06-28', 0, 0, '', ''),
(45, '', 'Test', '', 'test2', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 10:56:29', 1, 0, '2021-06-28', 0, 0, '', ''),
(46, '', 'Test', '', 'test3', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:03:54', 1, 0, '2021-06-28', 0, 0, '', ''),
(47, '', 'Test', '', 'test3', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:03:57', 1, 0, '2021-06-28', 0, 0, '', ''),
(48, '', 'test', '', 'test4', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:04:30', 1, 0, '2021-06-28', 0, 0, '', ''),
(49, '', 'test', '', 'test5', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:05:41', 1, 0, '2021-06-28', 0, 0, '', ''),
(50, '', 'test', '', 'test6', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:08:54', 1, 0, '2021-06-28', 0, 0, '', ''),
(51, '', 'test', '', 'test7', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:09:33', 1, 0, '2021-06-28', 0, 0, '', ''),
(52, '', 'test', '', 'test8', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:11:08', 1, 0, '2021-06-28', 0, 0, '', ''),
(53, '', 'test', '', 'test9', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:12:54', 1, 0, '2021-06-28', 0, 0, '', ''),
(54, '', 'test', '', 'test9', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:18:51', 1, 0, '2021-06-28', 0, 0, '', ''),
(55, '', 'test', '', 'test11', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:34:49', 1, 0, '2021-06-28', 0, 0, '', ''),
(56, '', 'test', '', 'test12', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:35:53', 1, 0, '2021-06-28', 0, 0, '', ''),
(57, '', 'test', '', 'test13', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-28 11:53:56', 1, 0, '2021-06-28', 0, 0, '', ''),
(58, '', 'Test', '', 'test20', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-29 12:07:10', 1, 0, '2021-06-29', 0, 0, '', ''),
(59, '', 'test', '', 'test21', '', '', '', '', '', '', 'Kenya', '', '', '', '', '', 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, '2021-06-29 12:08:09', 1, 0, '2021-06-29', 0, 0, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `person_permission`
--

DROP TABLE IF EXISTS `person_permission`;
CREATE TABLE IF NOT EXISTS `person_permission` (
  `per_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`per_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `person_roles`
--

DROP TABLE IF EXISTS `person_roles`;
CREATE TABLE IF NOT EXISTS `person_roles` (
  `per_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`per_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pledge_plg`
--

DROP TABLE IF EXISTS `pledge_plg`;
CREATE TABLE IF NOT EXISTS `pledge_plg` (
  `plg_plgID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `plg_FamID` mediumint(9) DEFAULT NULL,
  `plg_FYID` mediumint(9) DEFAULT NULL,
  `plg_date` date DEFAULT NULL,
  `plg_amount` decimal(8,2) DEFAULT NULL,
  `plg_schedule` enum('Weekly','Monthly','Quarterly','Once','Other') COLLATE utf8_unicode_ci DEFAULT NULL,
  `plg_method` enum('CREDITCARD','CHECK','CASH','BANKDRAFT','EGIVE') COLLATE utf8_unicode_ci DEFAULT NULL,
  `plg_comment` text COLLATE utf8_unicode_ci,
  `plg_DateLastEdited` date NOT NULL DEFAULT '2016-01-01',
  `plg_EditedBy` mediumint(9) NOT NULL DEFAULT '0',
  `plg_PledgeOrPayment` enum('Pledge','Payment') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Pledge',
  `plg_fundID` tinyint(3) UNSIGNED DEFAULT NULL,
  `plg_depID` mediumint(9) UNSIGNED DEFAULT NULL,
  `plg_CheckNo` bigint(16) UNSIGNED DEFAULT NULL,
  `plg_Problem` tinyint(1) DEFAULT NULL,
  `plg_scanString` text COLLATE utf8_unicode_ci,
  `plg_aut_ID` mediumint(9) NOT NULL DEFAULT '0',
  `plg_aut_Cleared` tinyint(1) NOT NULL DEFAULT '0',
  `plg_aut_ResultID` mediumint(9) NOT NULL DEFAULT '0',
  `plg_NonDeductible` decimal(8,2) NOT NULL,
  `plg_GroupKey` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`plg_plgID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `preacher`
--

DROP TABLE IF EXISTS `preacher`;
CREATE TABLE IF NOT EXISTS `preacher` (
  `preacherID` int(11) NOT NULL AUTO_INCREMENT,
  `preacherName` varchar(50) NOT NULL,
  PRIMARY KEY (`preacherID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `propertytype_prt`
--

DROP TABLE IF EXISTS `propertytype_prt`;
CREATE TABLE IF NOT EXISTS `propertytype_prt` (
  `prt_ID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `prt_Class` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `prt_Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `prt_Description` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`prt_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `propertytype_prt`
--

INSERT INTO `propertytype_prt` (`prt_ID`, `prt_Class`, `prt_Name`, `prt_Description`) VALUES
(1, 'p', 'General', 'General Person Properties'),
(2, 'f', 'General', 'General Family Properties'),
(3, 'g', 'General', 'General Group Properties');

-- --------------------------------------------------------

--
-- Table structure for table `property_pro`
--

DROP TABLE IF EXISTS `property_pro`;
CREATE TABLE IF NOT EXISTS `property_pro` (
  `pro_ID` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pro_Class` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `pro_prt_ID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `pro_Name` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `pro_Description` text COLLATE utf8_unicode_ci NOT NULL,
  `pro_Prompt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pro_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `property_pro`
--

INSERT INTO `property_pro` (`pro_ID`, `pro_Class`, `pro_prt_ID`, `pro_Name`, `pro_Description`, `pro_Prompt`) VALUES
(1, 'p', 1, 'Disabled', 'has a disability.', 'What is the nature of the disability?'),
(2, 'f', 2, 'Single Parent', 'is a single-parent household.', ''),
(3, 'g', 3, 'Youth', 'is youth-oriented.', '');

-- --------------------------------------------------------

--
-- Table structure for table `queryparameteroptions_qpo`
--

DROP TABLE IF EXISTS `queryparameteroptions_qpo`;
CREATE TABLE IF NOT EXISTS `queryparameteroptions_qpo` (
  `qpo_ID` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `qpo_qrp_ID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `qpo_Display` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `qpo_Value` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`qpo_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `queryparameteroptions_qpo`
--

INSERT INTO `queryparameteroptions_qpo` (`qpo_ID`, `qpo_qrp_ID`, `qpo_Display`, `qpo_Value`) VALUES
(1, 4, 'Male', '1'),
(2, 4, 'Female', '2'),
(3, 6, 'Male', '1'),
(4, 6, 'Female', '2'),
(5, 15, 'Name', 'CONCAT(COALESCE(`per_FirstName`,\'\'),COALESCE(`per_MiddleName`,\'\'),COALESCE(`per_LastName`,\'\'))'),
(6, 15, 'Zip Code', 'fam_Zip'),
(7, 15, 'State', 'fam_State'),
(8, 15, 'City', 'fam_City'),
(9, 15, 'Home Phone', 'per_HomePhone'),
(10, 27, '2012/2013', '17'),
(11, 27, '2013/2014', '18'),
(12, 27, '2014/2015', '19'),
(13, 27, '2015/2016', '20'),
(14, 28, '2012/2013', '17'),
(15, 28, '2013/2014', '18'),
(16, 28, '2014/2015', '19'),
(17, 28, '2015/2016', '20'),
(18, 30, '2012/2013', '17'),
(19, 30, '2013/2014', '18'),
(20, 30, '2014/2015', '19'),
(21, 30, '2015/2016', '20'),
(22, 31, '2012/2013', '17'),
(23, 31, '2013/2014', '18'),
(24, 31, '2014/2015', '19'),
(25, 31, '2015/2016', '20'),
(26, 15, 'Email', 'per_Email'),
(27, 15, 'WorkEmail', 'per_WorkEmail'),
(28, 32, '2012/2013', '17'),
(29, 32, '2013/2014', '18'),
(30, 32, '2014/2015', '19'),
(31, 32, '2015/2016', '20'),
(32, 33, 'Member', '1'),
(33, 33, 'Regular Attender', '2'),
(34, 33, 'Guest', '3'),
(35, 33, 'Non-Attender', '4'),
(36, 33, 'Non-Attender (staff)', '5');

-- --------------------------------------------------------

--
-- Table structure for table `queryparameters_qrp`
--

DROP TABLE IF EXISTS `queryparameters_qrp`;
CREATE TABLE IF NOT EXISTS `queryparameters_qrp` (
  `qrp_ID` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `qrp_qry_ID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `qrp_Type` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `qrp_OptionSQL` text COLLATE utf8_unicode_ci,
  `qrp_Name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrp_Description` text COLLATE utf8_unicode_ci,
  `qrp_Alias` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrp_Default` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrp_Required` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `qrp_InputBoxSize` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `qrp_Validation` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `qrp_NumericMax` int(11) DEFAULT NULL,
  `qrp_NumericMin` int(11) DEFAULT NULL,
  `qrp_AlphaMinLength` int(11) DEFAULT NULL,
  `qrp_AlphaMaxLength` int(11) DEFAULT NULL,
  PRIMARY KEY (`qrp_ID`),
  KEY `qrp_qry_ID` (`qrp_qry_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `queryparameters_qrp`
--

INSERT INTO `queryparameters_qrp` (`qrp_ID`, `qrp_qry_ID`, `qrp_Type`, `qrp_OptionSQL`, `qrp_Name`, `qrp_Description`, `qrp_Alias`, `qrp_Default`, `qrp_Required`, `qrp_InputBoxSize`, `qrp_Validation`, `qrp_NumericMax`, `qrp_NumericMin`, `qrp_AlphaMinLength`, `qrp_AlphaMaxLength`) VALUES
(1, 4, 0, NULL, 'Minimum Age', 'The minimum age for which you want records returned.', 'min', '0', 0, 5, 'n', 120, 0, NULL, NULL),
(2, 4, 0, NULL, 'Maximum Age', 'The maximum age for which you want records returned.', 'max', '120', 1, 5, 'n', 120, 0, NULL, NULL),
(4, 6, 1, '', 'Gender', 'The desired gender to search the database for.', 'gender', '1', 1, 0, '', 0, 0, 0, 0),
(5, 7, 2, 'SELECT lst_OptionID as Value, lst_OptionName as Display FROM list_lst WHERE lst_ID=2 ORDER BY lst_OptionSequence', 'Family Role', 'Select the desired family role.', 'role', '1', 0, 0, '', 0, 0, 0, 0),
(6, 7, 1, '', 'Gender', 'The gender for which you would like records returned.', 'gender', '1', 1, 0, '', 0, 0, 0, 0),
(8, 9, 2, 'SELECT pro_ID AS Value, pro_Name as Display \r\nFROM property_pro\r\nWHERE pro_Class= \'p\' \r\nORDER BY pro_Name ', 'Property', 'The property for which you would like person records returned.', 'PropertyID', '0', 1, 0, '', 0, 0, 0, 0),
(9, 10, 2, 'SELECT distinct don_date as Value, don_date as Display FROM donations_don ORDER BY don_date ASC', 'Beginning Date', 'Please select the beginning date to calculate total contributions for each member (i.e. YYYY-MM-DD). NOTE: You can only choose dates that conatain donations.', 'startdate', '1', 1, 0, '0', 0, 0, 0, 0),
(10, 10, 2, 'SELECT distinct don_date as Value, don_date as Display FROM donations_don\r\nORDER BY don_date DESC', 'Ending Date', 'Please enter the last date to calculate total contributions for each member (i.e. YYYY-MM-DD).', 'enddate', '1', 1, 0, '', 0, 0, 0, 0),
(14, 15, 0, '', 'Search', 'Enter any part of the following: Name, City, State, Zip, Home Phone, Email, or Work Email.', 'searchstring', '', 1, 0, '', 0, 0, 0, 0),
(15, 15, 1, '', 'Field', 'Select field to search for.', 'searchwhat', '1', 1, 0, '', 0, 0, 0, 0),
(16, 11, 2, 'SELECT distinct don_date as Value, don_date as Display FROM donations_don ORDER BY don_date ASC', 'Beginning Date', 'Please select the beginning date to calculate total contributions for each member (i.e. YYYY-MM-DD). NOTE: You can only choose dates that conatain donations.', 'startdate', '1', 1, 0, '0', 0, 0, 0, 0),
(17, 11, 2, 'SELECT distinct don_date as Value, don_date as Display FROM donations_don\r\nORDER BY don_date DESC', 'Ending Date', 'Please enter the last date to calculate total contributions for each member (i.e. YYYY-MM-DD).', 'enddate', '1', 1, 0, '', 0, 0, 0, 0),
(18, 18, 0, '', 'Month', 'The birthday month for which you would like records returned.', 'birthmonth', '1', 1, 0, '', 12, 1, 1, 2),
(19, 19, 2, 'SELECT grp_ID AS Value, grp_Name AS Display FROM group_grp ORDER BY grp_Type', 'Class', 'The sunday school class for which you would like records returned.', 'group', '1', 1, 0, '', 12, 1, 1, 2),
(20, 20, 2, 'SELECT grp_ID AS Value, grp_Name AS Display FROM group_grp ORDER BY grp_Type', 'Class', 'The sunday school class for which you would like records returned.', 'group', '1', 1, 0, '', 12, 1, 1, 2),
(21, 21, 2, 'SELECT grp_ID AS Value, grp_Name AS Display FROM group_grp ORDER BY grp_Type', 'Registered students', 'Group of registered students', 'group', '1', 1, 0, '', 12, 1, 1, 2),
(22, 22, 0, '', 'Month', 'The membership anniversary month for which you would like records returned.', 'membermonth', '1', 1, 0, '', 12, 1, 1, 2),
(25, 25, 2, 'SELECT vol_ID AS Value, vol_Name AS Display FROM volunteeropportunity_vol ORDER BY vol_Name', 'Volunteer opportunities', 'Choose a volunteer opportunity', 'volopp', '1', 1, 0, '', 12, 1, 1, 2),
(26, 26, 0, '', 'Months', 'Number of months since becoming a friend', 'friendmonths', '1', 1, 0, '', 24, 1, 1, 2),
(27, 28, 1, '', 'First Fiscal Year', 'First fiscal year for comparison', 'fyid1', '9', 1, 0, '', 12, 9, 0, 0),
(28, 28, 1, '', 'Second Fiscal Year', 'Second fiscal year for comparison', 'fyid2', '9', 1, 0, '', 12, 9, 0, 0),
(30, 30, 1, '', 'First Fiscal Year', 'Pledged this year', 'fyid1', '9', 1, 0, '', 12, 9, 0, 0),
(31, 30, 1, '', 'Second Fiscal Year', 'but not this year', 'fyid2', '9', 1, 0, '', 12, 9, 0, 0),
(32, 32, 1, '', 'Fiscal Year', 'Fiscal Year.', 'fyid', '9', 1, 0, '', 12, 9, 0, 0),
(33, 18, 1, '', 'Classification', 'Member, Regular Attender, etc.', 'percls', '1', 1, 0, '', 12, 1, 1, 2),
(100, 100, 2, 'SELECT vol_ID AS Value, vol_Name AS Display FROM volunteeropportunity_vol ORDER BY vol_Name', 'Volunteer opportunities', 'First volunteer opportunity choice', 'volopp1', '1', 1, 0, '', 12, 1, 1, 2),
(101, 100, 2, 'SELECT vol_ID AS Value, vol_Name AS Display FROM volunteeropportunity_vol ORDER BY vol_Name', 'Volunteer opportunities', 'Second volunteer opportunity choice', 'volopp2', '1', 1, 0, '', 12, 1, 1, 2),
(200, 200, 2, 'SELECT custom_field as Value, custom_Name as Display FROM person_custom_master', 'Custom field', 'Choose customer person field', 'custom', '1', 0, 0, '', 0, 0, 0, 0),
(201, 200, 0, '', 'Field value', 'Match custom field to this value', 'value', '1', 0, 0, '', 0, 0, 0, 0),
(202, 201, 3, 'SELECT event_id as Value, event_title as Display FROM events_event ORDER BY event_start DESC', 'Event', 'Select the desired event', 'event', '', 1, 0, '', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `query_qry`
--

DROP TABLE IF EXISTS `query_qry`;
CREATE TABLE IF NOT EXISTS `query_qry` (
  `qry_ID` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `qry_SQL` text COLLATE utf8_unicode_ci NOT NULL,
  `qry_Name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `qry_Description` text COLLATE utf8_unicode_ci NOT NULL,
  `qry_Count` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`qry_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `query_qry`
--

INSERT INTO `query_qry` (`qry_ID`, `qry_SQL`, `qry_Name`, `qry_Description`, `qry_Count`) VALUES
(3, 'SELECT CONCAT(\'<a href=v2/family/\',fam_ID,\'>\',fam_Name,\'</a>\') AS \'Family Name\', COUNT(*) AS \'No.\'\nFROM person_per\nINNER JOIN family_fam\nON fam_ID = per_fam_ID\nGROUP BY per_fam_ID\nORDER BY \'No.\' DESC', 'Family Member Count', 'Returns each family and the total number of people assigned to them.', 0),
(4, 'SELECT per_ID as AddToCart,CONCAT(\'<a\r\nhref=PersonView.php?PersonID=\',per_ID,\'>\',per_FirstName,\'\r\n\',per_LastName,\'</a>\') AS Name,\r\nCONCAT(per_BirthMonth,\'/\',per_BirthDay,\'/\',per_BirthYear) AS \'Birth Date\',\r\nDATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(CONCAT(per_BirthYear,\'-\',per_BirthMonth,\'-\',per_BirthDay))),\'%Y\')+0 AS  \'Age\'\r\nFROM person_per\r\nWHERE\r\nDATE_ADD(CONCAT(per_BirthYear,\'-\',per_BirthMonth,\'-\',per_BirthDay),INTERVAL\r\n~min~ YEAR) <= CURDATE()\r\nAND\r\nDATE_ADD(CONCAT(per_BirthYear,\'-\',per_BirthMonth,\'-\',per_BirthDay),INTERVAL\r\n(~max~ + 1) YEAR) >= CURDATE()', 'Person by Age', 'Returns any person records with ages between two given ages.', 1),
(6, 'SELECT COUNT(per_ID) AS Total FROM person_per WHERE per_Gender = ~gender~', 'Total By Gender', 'Total of records matching a given gender.', 0),
(7, 'SELECT per_ID as AddToCart, CONCAT(per_FirstName,\' \',per_LastName) AS Name FROM person_per WHERE per_fmr_ID = ~role~ AND per_Gender = ~gender~', 'Person by Role and Gender', 'Selects person records with the family role and gender specified.', 1),
(9, 'SELECT \r\nper_ID as AddToCart, \r\nCONCAT(per_FirstName,\' \',per_LastName) AS Name, \r\nCONCAT(r2p_Value,\' \') AS Value\r\nFROM person_per,record2property_r2p\r\nWHERE per_ID = r2p_record_ID\r\nAND r2p_pro_ID = ~PropertyID~\r\nORDER BY per_LastName', 'Person by Property', 'Returns person records which are assigned the given property.', 1),
(15, 'SELECT per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',per_ID,\'>\',COALESCE(`per_FirstName`,\'\'),\' \',COALESCE(`per_MiddleName`,\'\'),\' \',COALESCE(`per_LastName`,\'\'),\'</a>\') AS Name, fam_City as City, fam_State as State, fam_Zip as ZIP, per_HomePhone as HomePhone, per_Email as Email, per_WorkEmail as WorkEmail FROM person_per RIGHT JOIN family_fam ON family_fam.fam_id = person_per.per_fam_id WHERE ~searchwhat~ LIKE \'%~searchstring~%\'', 'Advanced Search', 'Search by any part of Name, City, State, Zip, Home Phone, Email, or Work Email.', 1),
(18, 'SELECT per_ID as AddToCart, per_BirthDay as Day, CONCAT(per_FirstName,\' \',per_LastName) AS Name FROM person_per WHERE per_cls_ID=~percls~ AND per_BirthMonth=~birthmonth~ ORDER BY per_BirthDay', 'Birthdays', 'People with birthdays in a particular month', 0),
(21, 'SELECT per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',per_ID,\'>\',per_FirstName,\' \',per_LastName,\'</a>\') AS Name FROM person_per LEFT JOIN person2group2role_p2g2r ON per_id = p2g2r_per_ID WHERE p2g2r_grp_ID=~group~ ORDER BY per_LastName', 'Registered students', 'Find Registered students', 1),
(22, 'SELECT per_ID as AddToCart, DAYOFMONTH(per_MembershipDate) as Day, per_MembershipDate AS DATE, CONCAT(per_FirstName,\' \',per_LastName) AS Name FROM person_per WHERE per_cls_ID=1 AND MONTH(per_MembershipDate)=~membermonth~ ORDER BY per_MembershipDate', 'Membership anniversaries', 'Members who joined in a particular month', 0),
(23, 'SELECT usr_per_ID as AddToCart, CONCAT(a.per_FirstName,\' \',a.per_LastName) AS Name FROM user_usr LEFT JOIN person_per a ON per_ID=usr_per_ID ORDER BY per_LastName', 'Select database users', 'People who are registered as database users', 0),
(24, 'SELECT per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',per_ID,\'>\',per_FirstName,\' \',per_LastName,\'</a>\') AS Name FROM person_per WHERE per_cls_id =1', 'Select all members', 'People who are members', 0),
(25, 'SELECT per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',per_ID,\'>\',per_FirstName,\' \',per_LastName,\'</a>\') AS Name FROM person_per LEFT JOIN person2volunteeropp_p2vo ON per_id = p2vo_per_ID WHERE p2vo_vol_ID = ~volopp~ ORDER BY per_LastName', 'Volunteers', 'Find volunteers for a particular opportunity', 1),
(26, 'SELECT per_ID as AddToCart, CONCAT(per_FirstName,\' \',per_LastName) AS Name FROM person_per WHERE DATE_SUB(NOW(),INTERVAL ~friendmonths~ MONTH)<per_FriendDate ORDER BY per_MembershipDate', 'Recent friends', 'Friends who signed up in previous months', 0),
(27, 'SELECT per_ID as AddToCart, CONCAT(per_FirstName,\' \',per_LastName) AS Name FROM person_per inner join family_fam on per_fam_ID=fam_ID where per_fmr_ID<>3 AND fam_OkToCanvass=\"TRUE\" ORDER BY fam_Zip', 'Families to Canvass', 'People in families that are ok to canvass.', 0),
(28, 'SELECT fam_Name, a.plg_amount as PlgFY1, b.plg_amount as PlgFY2 from family_fam left join pledge_plg a on a.plg_famID = fam_ID and a.plg_FYID=~fyid1~ and a.plg_PledgeOrPayment=\'Pledge\' left join pledge_plg b on b.plg_famID = fam_ID and b.plg_FYID=~fyid2~ and b.plg_PledgeOrPayment=\'Pledge\' order by fam_Name', 'Pledge comparison', 'Compare pledges between two fiscal years', 1),
(30, 'SELECT per_ID as AddToCart, CONCAT(per_FirstName,\' \',per_LastName) AS Name, fam_address1, fam_city, fam_state, fam_zip FROM person_per join family_fam on per_fam_id=fam_id where per_fmr_id<>3 and per_fam_id in (select fam_id from family_fam inner join pledge_plg a on a.plg_famID=fam_ID and a.plg_FYID=~fyid1~ and a.plg_amount>0) and per_fam_id not in (select fam_id from family_fam inner join pledge_plg b on b.plg_famID=fam_ID and b.plg_FYID=~fyid2~ and b.plg_amount>0)', 'Missing pledges', 'Find people who pledged one year but not another', 1),
(32, 'SELECT fam_Name, fam_Envelope, b.fun_Name as Fund_Name, a.plg_amount as Pledge from family_fam left join pledge_plg a on a.plg_famID = fam_ID and a.plg_FYID=~fyid~ and a.plg_PledgeOrPayment=\'Pledge\' and a.plg_amount>0 join donationfund_fun b on b.fun_ID = a.plg_fundID order by fam_Name, a.plg_fundID', 'Family Pledge by Fiscal Year', 'Pledge summary by family name for each fund for the selected fiscal year', 1),
(100, 'SELECT a.per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',a.per_ID,\'>\',a.per_FirstName,\' \',a.per_LastName,\'</a>\') AS Name FROM person_per AS a LEFT JOIN person2volunteeropp_p2vo p2v1 ON (a.per_id = p2v1.p2vo_per_ID AND p2v1.p2vo_vol_ID = ~volopp1~) LEFT JOIN person2volunteeropp_p2vo p2v2 ON (a.per_id = p2v2.p2vo_per_ID AND p2v2.p2vo_vol_ID = ~volopp2~) WHERE p2v1.p2vo_per_ID=p2v2.p2vo_per_ID ORDER BY per_LastName', 'Volunteers', 'Find volunteers for who match two specific opportunity codes', 1),
(200, 'SELECT a.per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',a.per_ID,\'>\',a.per_FirstName,\' \',a.per_LastName,\'</a>\') AS Name FROM person_per AS a LEFT JOIN person_custom pc ON a.per_id = pc.per_ID WHERE pc.~custom~=\'~value~\' ORDER BY per_LastName', 'CustomSearch', 'Find people with a custom field value', 1),
(201, 'SELECT per_ID as AddToCart, CONCAT(\'<a href=PersonView.php?PersonID=\',per_ID,\'>\',per_FirstName,\',per_LastName,\'</a>\') AS Name, per_LastName AS Lastname FROM person_per LEFT OUTER JOIN (SELECT event_attend.attend_id, event_attend.person_id FROM event_attend WHERE event_attend.event_id IN (~event~)) a ON person_per.per_ID = a.person_id WHERE a.attend_id is NULL ORDER BY person_per.per_LastName, person_per.per_FirstName', 'Missing people', 'Find people who didn\'t attend an event', 1);

-- --------------------------------------------------------

--
-- Table structure for table `record2property_r2p`
--

DROP TABLE IF EXISTS `record2property_r2p`;
CREATE TABLE IF NOT EXISTS `record2property_r2p` (
  `r2p_pro_ID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `r2p_record_ID` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `r2p_Value` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `result_res`
--

DROP TABLE IF EXISTS `result_res`;
CREATE TABLE IF NOT EXISTS `result_res` (
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

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `role_desc` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `role_desc`) VALUES
(1, 'Welcome Committee', NULL),
(2, 'Clergy', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sermon`
--

DROP TABLE IF EXISTS `sermon`;
CREATE TABLE IF NOT EXISTS `sermon` (
  `serviceTypes` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sermon`
--

INSERT INTO `sermon` (`serviceTypes`) VALUES
('Church Service'),
('Sunday School'),
('Annual Events'),
('Youth service');

-- --------------------------------------------------------

--
-- Table structure for table `sermoncategory`
--

DROP TABLE IF EXISTS `sermoncategory`;
CREATE TABLE IF NOT EXISTS `sermoncategory` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryType` varchar(50) NOT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sermons`
--

DROP TABLE IF EXISTS `sermons`;
CREATE TABLE IF NOT EXISTS `sermons` (
  `sermonID` int(11) NOT NULL AUTO_INCREMENT,
  `sermonTitle` longtext NOT NULL,
  `preacherName` varchar(50) NOT NULL,
  `serviceType` varchar(50) NOT NULL,
  `bibleVerses` mediumtext NOT NULL,
  `sermonContent` longtext NOT NULL,
  `youtubeLink` longtext NOT NULL,
  `sermonImage` blob NOT NULL,
  `categoryType` varchar(50) NOT NULL,
  `uploadedBy` varchar(50) NOT NULL,
  `serviceDate` varchar(30) NOT NULL,
  `createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sermonID`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sermons`
--

INSERT INTO `sermons` (`sermonID`, `sermonTitle`, `preacherName`, `serviceType`, `bibleVerses`, `sermonContent`, `youtubeLink`, `sermonImage`, `categoryType`, `uploadedBy`, `serviceDate`, `createDate`) VALUES
(1, 'Fasting and prayer', 'Pastor Joe', '', '1 Peter 4:10', 'It breeds self-righteousness and intolerance. It uses guilt and shame to control people. It\'s what is wrong with the world. And Jesus hates it. For the message of religion—\"I obey, therefore I\'m accepted\"—is the opposite of the gospel: \"I\'m accepted in Jesus, therefore I obey.\"', 'https://www.youtube.com/embed/8iEsCHC4JXI', '', 'Prayer', 'Admin', '2021-04-04', '2021-04-07 12:37:40'),
(6, 'Christian Life', 'Pastor Rose', '', '1st Corinthians 15:20, John 5:10,', 'Create a named anchorAnchor names must be unique within a document.Anchor names are case-sensitive.The following symbols can be included in an anchor name.hyphen(-), underscore(_), colon(:), period(.)name=&quot;anchor_name&quot;Anchor names must start in the alphabet.name=&quot;a001&quot;', 'https://youtu.be/C0l25rkIndA', '', 'modern Life', 'Admin', '2021-04-11', '2021-04-15 14:10:06'),
(4, 'Living truth', 'Pastor Lucy', '', '1 Peter 4:10', 'In the second&nbsp;&lt;textarea &gt;&nbsp;define CKEditor with default configuration. For example purpose, I have added&nbsp;width&nbsp;and&nbsp;height&nbsp;options which you can remove if you don&rsquo;t want.', 'https://www.youtube.com/embed/8iEsCHC4JXI', '', 'Prayer', 'Admin', '2021-04-11', '2021-04-12 11:29:02'),
(12, 'Christian Life', 'Pastor Rose', '3', '1st Corinthians 15:20', '<ul><li>lesdxfjwrs</li><li>sdjfwrkwjfsd</li></ul><h2 style=\"font-style:italic\">qPOW3RRO;</h2>', 'https://www.youtube.com/embed/8aEznmj40sc', '', 'Modern Life', 'Admin', '2021-04-18', '2021-04-20 14:12:58'),
(13, 'Love and Marriage', 'Pastor Rose', '1', 'Leviticus 19:18, Deuteronomy 6:5, John 13:34-35, John 14:21, 1 Corinthians 13:1-13, 1 Corinthians 16:14, 1 John 4:7-21, Mark 12:29-31, Colossians 3:14, 1 Peter 4:8, Romans 12:9', '<h3>45. Love</h3><p><a href=\"https://www.biblegateway.com/passage/?search=Leviticus+19%3A18&amp;version=NIV\">Leviticus 19:18</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Deuteronomy+6%3A5&amp;version=NIV\">Deuteronomy 6:5</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=John+13%3A34-35&amp;version=NIV\">John 13:34-35</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=John+14%3A21&amp;version=NIV\">John 14:21</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=1+Corinthians+13%3A1-13&amp;version=NIV\">1 Corinthians 13:1-13</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=1+Corinthians+16%3A14&amp;version=NIV\">1 Corinthians 16:14</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=1+John+4%3A7-21&amp;version=NIV\">1 John 4:7-21</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Mark+12%3A29-31&amp;version=NIV\">Mark 12:29-31</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Colossians+3%3A14&amp;version=NIV\">Colossians 3:14</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=1+Peter+4%3A8&amp;version=NIV\">1 Peter 4:8</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Romans+12%3A9&amp;version=NIV\">Romans 12:9</a></p><h3>46. Marriage</h3><p><a href=\"https://www.biblegateway.com/passage/?search=Genesis+1%3A27-28&amp;version=NIV\">Genesis 1:27-28</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Genesis+2%3A20-24&amp;version=NIV\">Genesis 2:20-24</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Matthew+19%3A6&amp;version=NIV\">Matthew 19:6</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Ephesians+5%3A21-33&amp;version=NIV\">Ephesians 5:21-33</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Colossians+3%3A18-19&amp;version=NIV\">Colossians 3:18-19</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Hebrews+13%3A4&amp;version=NIV\">Hebrews 13:4</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=1+Peter+3%3A1-7&amp;version=NIV\">1 Peter 3:1-7</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=1+Corinthians+7%3A1-40&amp;version=NIV\">1 Corinthians 7:1-40</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Proverbs+18%3A22&amp;version=NIV\">Proverbs 18:22</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Proverbs+21%3A9&amp;version=NIV\">Proverbs 21:9</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=2+Corinthians+6%3A14&amp;version=NIV\">2 Corinthians 6:14</a></p>', 'https://www.youtube.com/embed/pIbYvFtKQ44', '', 'Modern Life', 'Admin', '2021-05-02', '2021-05-07 07:00:56'),
(8, 'Christian Life', 'Pastor Rose', '2', '1st Corinthians 15:20', '<ul><li>wsaurrheu</li><li>kasjDuwqhs</li></ul><p><a href=\"https://www.youtube.com/watch?v=C0l25rkIndA\">Click here</a></p>', 'https://youtu.be/C0l25rkIndA', '', 'Modern Life', 'Admin', '2021-04-16', '2021-04-15 18:28:33'),
(9, 'Assault Against The Faithful', 'Pastor Joe Muthengi', '1', '1 Peter 4:10, 1 John 1', '<h2>Called to Serve Him</h2><ul><li><span style=\"font-family:Arial,Helvetica,sans-serif\">Summary</span>:&nbsp;Paul&#39;s assessment of himself was that he was unworthy of God&#39;s grace. However, Christ is merciful; He will receive anyone who comes to Him in faith, even those who are full of themselves.</li></ul><p>&ldquo;Look out for the dogs, look out for the evildoers, look out for those who mutilate the flesh. For we are the circumcision, who worship by the Spirit of God and glory in Christ Jesus and put no confidence in the flesh&mdash;though I myself have reason for confidence in the flesh also. If anyone else thinks he has reason for confidence in the flesh, I have more: circumcised on the eighth day, of the people of Israel, of the tribe of Benjamin, a Hebrew of Hebrews; as to the law, a Pharisee; as to zeal, a persecutor of the church; as to righteousness under the law, blameless.&rdquo; [1]</p><p>&nbsp;</p>', 'https://youtu.be/C0l25rkIndA', '', 'Christian Life', 'Admin', '2021-03-28', '2021-04-15 18:40:11'),
(14, 'Name of God', 'Pastor Rose', '1', 'Genesis 16:13-14, Genesis 17:1, Exodus 3:13-15, Deuteronomy 32:4, Daniel 7:22-25, Revelation 1:8, Isaiah 44:6, Exodus 15:6, Jeremiah 23:6, Judges 6:24', '<h3>52. Names Of God</h3><p><a href=\"https://www.biblegateway.com/passage/?search=Genesis+16%3A13-14&amp;version=NIV\">Genesis 16:13-14</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Genesis+17%3A1&amp;version=NIV\">Genesis 17:1</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Exodus+3%3A13-15&amp;version=NIV\">Exodus 3:13-15</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Deuteronomy+32%3A4&amp;version=NIV\">Deuteronomy 32:4</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Daniel+7%3A22-25&amp;version=NIV\">Daniel 7:22-25</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Revelation+1%3A8&amp;version=NIV\">Revelation 1:8</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Isaiah+44%3A6&amp;version=NIV\">Isaiah 44:6</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Exodus+15%3A6&amp;version=NIV\">Exodus 15:6</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Jeremiah+23%3A6&amp;version=NIV\">Jeremiah 23:6</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Judges+6%3A24&amp;version=NIV\">Judges 6:24</a></p><h3>53. Names Of Jesus</h3><p><a href=\"https://www.biblegateway.com/passage/?search=Isaiah+9%3A6&amp;version=NIV\">Isaiah 9:6</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Matthew+1%3A23&amp;version=NIV\">Matthew 1:23</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=John+1%3A1&amp;version=NIV\">John 1:1</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=John+8%3A58&amp;version=NIV\">John 8:58</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=John+10%3A11&amp;version=NIV\">John 10:11</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=John+8%3A12&amp;version=NIV\">John 8:12</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=John+1%3A29&amp;version=NIV\">John 1:29</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Revelation+19%3A16&amp;version=NIV\">Revelation 19:16</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=John+11%3A25&amp;version=NIV\">John 11:25</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Revelation+19%3A13&amp;version=NIV\">Revelation 19:13</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Revelation+22%3A16&amp;version=NIV\">Revelation 22:16</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Revelation+5%3A5&amp;version=NIV\">Revelation 5:5</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Colossians+1%3A15&amp;version=NIV\">Colossians 1:15</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=1+Corinthians+15%3A45&amp;version=NIV\">1 Corinthians 15:45</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Luke+1%3A32&amp;version=NIV\">Luke 1:32</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Matthew+1%3A21&amp;version=NIV\">Matthew 1:21</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Isaiah+7%3A14&amp;version=NIV\">Isaiah 7:14</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=1+Peter+5%3A4&amp;version=NIV\">1 Peter 5:4</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=1+Timothy+2%3A5&amp;version=NIV\">1 Timothy 2:5</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=1+Corinthians+5%3A7&amp;version=NIV\">1 Corinthians 5:7</a></p>', 'https://www.youtube.com/embed/BcZtFgQo0ac', '', 'Christian Life', 'Admin', '2021-05-02', '2021-05-07 07:12:37'),
(15, 'Fasting and prayer', 'Pastor Joe', '4', '1 Peter 4:10', '<p>It breeds self-righteousness and intolerance. It uses guilt and shame to control people. It&#39;s what is wrong with the world. And Jesus hates it. For the message of religion&mdash;&quot;I obey, therefore I&#39;m accepted&quot;&mdash;is the opposite of the gospel: &quot;I&#39;m accepted in Jesus, therefore I obey.&quot;</p><p>&nbsp;</p><h3>58. Patience</h3><p><a href=\"https://www.biblegateway.com/passage/?search=Numbers+14%3A18&amp;version=NIV\">Numbers 14:18</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Galatians+5%3A22&amp;version=NIV\">Galatians 5:22</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=James+1%3A19&amp;version=NIV\">James 1:19</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=James+5%3A7&amp;version=NIV\">James 5:7</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Romans+8%3A25&amp;version=NIV\">Romans 8:25</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Romans+12%3A12&amp;version=NIV\">Romans 12:12</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Galatians+6%3A9&amp;version=NIV\">Galatians 6:9</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Psalm+37%3A7-9&amp;version=NIV\">Psalm 37:7-9</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Philippians+4%3A6&amp;version=NIV\">Philippians 4:6</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=Ephesians+4%3A3&amp;version=NIV\">Ephesians 4:3</a>,&nbsp;<a href=\"https://www.biblegateway.com/passage/?search=+Isaiah+40%3A31&amp;version=NIV\">Isaiah 40:31</a></p>', '', '', 'Fasting and Prayer', 'Admin', '2021-03-28', '2021-05-07 07:14:18');

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
CREATE TABLE IF NOT EXISTS `tokens` (
  `token` varchar(99) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `reference_id` int(9) NOT NULL,
  `valid_until_date` datetime DEFAULT NULL,
  `remainingUses` int(2) DEFAULT NULL,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userconfig_ucfg`
--

DROP TABLE IF EXISTS `userconfig_ucfg`;
CREATE TABLE IF NOT EXISTS `userconfig_ucfg` (
  `ucfg_per_id` mediumint(9) UNSIGNED NOT NULL,
  `ucfg_id` int(11) NOT NULL DEFAULT '0',
  `ucfg_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ucfg_value` text COLLATE utf8_unicode_ci,
  `ucfg_type` enum('text','number','date','boolean','textarea') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `ucfg_tooltip` text COLLATE utf8_unicode_ci NOT NULL,
  `ucfg_permission` enum('FALSE','TRUE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'FALSE',
  `ucfg_cat` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ucfg_per_id`,`ucfg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `userconfig_ucfg`
--

INSERT INTO `userconfig_ucfg` (`ucfg_per_id`, `ucfg_id`, `ucfg_name`, `ucfg_value`, `ucfg_type`, `ucfg_tooltip`, `ucfg_permission`, `ucfg_cat`) VALUES
(0, 0, 'bEmailMailto', '1', 'boolean', 'User permission to send email via mailto: links', 'TRUE', ''),
(0, 1, 'sMailtoDelimiter', ',', 'text', 'Delimiter to separate emails in mailto: links', 'TRUE', ''),
(0, 5, 'bCreateDirectory', '0', 'boolean', 'User permission to create directories', 'FALSE', 'SECURITY'),
(0, 6, 'bExportCSV', '0', 'boolean', 'User permission to export CSV files', 'FALSE', 'SECURITY'),
(0, 7, 'bUSAddressVerification', '0', 'boolean', 'User permission to use IST Address Verification', 'FALSE', ''),
(0, 10, 'bAddEvent', '0', 'boolean', 'Allow user to add new event', 'FALSE', 'SECURITY'),
(1, 0, 'bEmailMailto', '1', 'boolean', 'User permission to send email via mailto: links', 'TRUE', ''),
(1, 1, 'sMailtoDelimiter', ',', 'text', 'user permission to send email via mailto: links', 'TRUE', ''),
(1, 5, 'bCreateDirectory', '1', 'boolean', 'User permission to create directories', 'TRUE', ''),
(1, 6, 'bExportCSV', '1', 'boolean', 'User permission to export CSV files', 'TRUE', ''),
(1, 7, 'bUSAddressVerification', '1', 'boolean', 'User permission to use IST Address Verification', 'TRUE', ''),
(1, 10, 'bAddEvent', '', 'boolean', 'Allow user to add new event', 'FALSE', 'SECURITY'),
(5, 0, 'bEmailMailto', '1', 'boolean', 'User permission to send email via mailto: links', 'TRUE', ''),
(5, 1, 'sMailtoDelimiter', ',', 'text', 'Delimiter to separate emails in mailto: links', 'TRUE', ''),
(5, 5, 'bCreateDirectory', '', 'boolean', 'User permission to create directories', 'FALSE', 'SECURITY'),
(5, 6, 'bExportCSV', '', 'boolean', 'User permission to export CSV files', 'FALSE', 'SECURITY'),
(5, 7, 'bUSAddressVerification', '', 'boolean', 'User permission to use IST Address Verification', 'FALSE', ''),
(5, 10, 'bAddEvent', '', 'boolean', 'Allow user to add new event', 'FALSE', 'SECURITY'),
(6, 0, 'bEmailMailto', '1', 'boolean', 'User permission to send email via mailto: links', 'TRUE', ''),
(6, 1, 'sMailtoDelimiter', ',', 'text', 'Delimiter to separate emails in mailto: links', 'TRUE', ''),
(6, 5, 'bCreateDirectory', '', 'boolean', 'User permission to create directories', 'FALSE', 'SECURITY'),
(6, 6, 'bExportCSV', '', 'boolean', 'User permission to export CSV files', 'FALSE', 'SECURITY'),
(6, 7, 'bUSAddressVerification', '', 'boolean', 'User permission to use IST Address Verification', 'FALSE', ''),
(6, 10, 'bAddEvent', '', 'boolean', 'Allow user to add new event', 'FALSE', 'SECURITY'),
(7, 0, 'bEmailMailto', '1', 'boolean', 'User permission to send email via mailto: links', 'TRUE', ''),
(7, 1, 'sMailtoDelimiter', ',', 'text', 'Delimiter to separate emails in mailto: links', 'TRUE', ''),
(7, 5, 'bCreateDirectory', '', 'boolean', 'User permission to create directories', 'FALSE', 'SECURITY'),
(7, 6, 'bExportCSV', '', 'boolean', 'User permission to export CSV files', 'FALSE', 'SECURITY'),
(7, 7, 'bUSAddressVerification', '', 'boolean', 'User permission to use IST Address Verification', 'FALSE', ''),
(7, 10, 'bAddEvent', '1', 'boolean', 'Allow user to add new event', 'FALSE', 'SECURITY'),
(8, 0, 'bEmailMailto', '', 'boolean', 'User permission to send email via mailto: links', 'FALSE', ''),
(8, 1, 'sMailtoDelimiter', ',', 'text', 'Delimiter to separate emails in mailto: links', 'FALSE', ''),
(8, 5, 'bCreateDirectory', '', 'boolean', 'User permission to create directories', 'FALSE', 'SECURITY'),
(8, 6, 'bExportCSV', '', 'boolean', 'User permission to export CSV files', 'FALSE', 'SECURITY'),
(8, 7, 'bUSAddressVerification', '', 'boolean', 'User permission to use IST Address Verification', 'FALSE', ''),
(8, 10, 'bAddEvent', '1', 'boolean', 'Allow user to add new event', 'TRUE', 'SECURITY');

-- --------------------------------------------------------

--
-- Table structure for table `user_usr`
--

DROP TABLE IF EXISTS `user_usr`;
CREATE TABLE IF NOT EXISTS `user_usr` (
  `usr_per_ID` mediumint(9) UNSIGNED NOT NULL DEFAULT '0',
  `usr_Password` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `usr_NeedPasswordChange` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `usr_LastLogin` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `usr_LoginCount` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `usr_FailedLogins` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `usr_AddRecords` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `usr_EditRecords` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `usr_DeleteRecords` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `usr_MenuOptions` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `usr_ManageGroups` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `usr_Finance` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `usr_Notes` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `usr_Admin` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `usr_SearchLimit` tinyint(4) DEFAULT '10',
  `usr_Style` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'Style.css',
  `usr_showPledges` tinyint(1) NOT NULL DEFAULT '0',
  `usr_showPayments` tinyint(1) NOT NULL DEFAULT '0',
  `usr_showSince` date NOT NULL DEFAULT '2016-01-01',
  `usr_defaultFY` mediumint(9) NOT NULL DEFAULT '10',
  `usr_currentDeposit` mediumint(9) NOT NULL DEFAULT '0',
  `usr_UserName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `usr_apiKey` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `usr_EditSelf` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
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
  `usr_Canvasser` tinyint(1) NOT NULL DEFAULT '0',
  `usr_TwoFactorAuthSecret` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `usr_TwoFactorAuthLastKeyTimestamp` int(11) DEFAULT NULL,
  `usr_TwoFactorAuthRecoveryCodes` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`usr_per_ID`),
  UNIQUE KEY `usr_UserName` (`usr_UserName`),
  UNIQUE KEY `usr_apiKey` (`usr_apiKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_usr`
--

INSERT INTO `user_usr` (`usr_per_ID`, `usr_Password`, `usr_NeedPasswordChange`, `usr_LastLogin`, `usr_LoginCount`, `usr_FailedLogins`, `usr_AddRecords`, `usr_EditRecords`, `usr_DeleteRecords`, `usr_MenuOptions`, `usr_ManageGroups`, `usr_Finance`, `usr_Notes`, `usr_Admin`, `usr_SearchLimit`, `usr_Style`, `usr_showPledges`, `usr_showPayments`, `usr_showSince`, `usr_defaultFY`, `usr_currentDeposit`, `usr_UserName`, `usr_apiKey`, `usr_EditSelf`, `usr_CalStart`, `usr_CalEnd`, `usr_CalNoSchool1`, `usr_CalNoSchool2`, `usr_CalNoSchool3`, `usr_CalNoSchool4`, `usr_CalNoSchool5`, `usr_CalNoSchool6`, `usr_CalNoSchool7`, `usr_CalNoSchool8`, `usr_SearchFamily`, `usr_Canvasser`, `usr_TwoFactorAuthSecret`, `usr_TwoFactorAuthLastKeyTimestamp`, `usr_TwoFactorAuthRecoveryCodes`) VALUES
(1, '4bdf3fba58c956fc3991a1fde84929223f968e2853de596e49ae80a91499609b', 0, '2021-07-01 15:22:07', 260, 0, 0, 0, 0, 0, 0, 0, 0, 1, 10, 'skin-yellow', 0, 0, '2016-01-01', 10, 1, 'Admin', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL),
(5, '838ac1e7b2438383c09600045b209fe0d99aa879f5d0b891d5a6ec3a9a729cfa', 1, '2021-03-04 10:29:48', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 10, 'skin-blue', 0, 0, '2016-01-01', 25, 0, 'josh', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(6, '27aa5a1aa12a5beaf389fd864fd7cedc422f22a56c6f4c7391ee411cd44bf30f', 0, '2021-03-04 12:40:44', 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 10, 'skin-blue', 0, 0, '2016-01-01', 25, 0, 'Esther', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(7, '2cdbd80cff5563960b75c3af5083b507f985469e0e4524d1b8fcfaeda51bcda0', 1, '2021-03-04 17:02:05', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 'skin-blue', 0, 0, '2016-01-01', 25, 0, 'Doreen', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(8, 'ecb2ce0afc07b1205000886fe0a909045392acf32f96049a096692017bd25183', 0, '2021-03-04 17:06:41', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 'skin-blue', 0, 0, '2016-01-01', 25, 0, 'Kinuthia', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `version_ver`
--

DROP TABLE IF EXISTS `version_ver`;
CREATE TABLE IF NOT EXISTS `version_ver` (
  `ver_ID` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ver_version` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ver_update_start` datetime DEFAULT NULL,
  `ver_update_end` datetime DEFAULT NULL,
  PRIMARY KEY (`ver_ID`),
  UNIQUE KEY `ver_version` (`ver_version`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `version_ver`
--

INSERT INTO `version_ver` (`ver_ID`, `ver_version`, `ver_update_start`, `ver_update_end`) VALUES
(1, '4.2.0', '2021-01-07 18:06:57', '2021-01-07 18:07:20');

-- --------------------------------------------------------

--
-- Table structure for table `volunteeropportunity_vol`
--

DROP TABLE IF EXISTS `volunteeropportunity_vol`;
CREATE TABLE IF NOT EXISTS `volunteeropportunity_vol` (
  `vol_ID` int(3) NOT NULL AUTO_INCREMENT,
  `vol_Order` int(3) NOT NULL DEFAULT '0',
  `vol_Active` enum('true','false') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'true',
  `vol_Name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vol_Description` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`vol_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `whycame_why`
--

DROP TABLE IF EXISTS `whycame_why`;
CREATE TABLE IF NOT EXISTS `whycame_why` (
  `why_ID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `why_per_ID` mediumint(9) NOT NULL DEFAULT '0',
  `why_join` text COLLATE utf8_unicode_ci NOT NULL,
  `why_come` text COLLATE utf8_unicode_ci NOT NULL,
  `why_suggest` text COLLATE utf8_unicode_ci NOT NULL,
  `why_hearOfUs` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`why_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `asset_inventory`
--
ALTER TABLE `asset_inventory`
  ADD CONSTRAINT `asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
