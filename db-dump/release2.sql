-- Generation Time: Sep 30, 2021 at 10:36 AM

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
CREATE TABLE IF NOT EXISTS `assets` (
  `asset_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_name` varchar(255) NOT NULL,
  `asset_make` varchar(255) NOT NULL,
  `asset_condition` varchar(255) NOT NULL,
  `asset_description` mediumtext NOT NULL,
  `asset_category` varchar(255) NOT NULL,
  `asset_file` blob NOT NULL,
  `purchase_date` varchar(255) NOT NULL,
  `asset_deleted` enum('False','True') NOT NULL,
  PRIMARY KEY (`asset_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`asset_id`, `asset_name`, `asset_make`, `asset_condition`, `asset_description`, `asset_category`, `asset_file`, `purchase_date`, `asset_deleted`) VALUES
(1, 'Church Keyboard', 'Yamaha', 'New Keyboard', 'New Keyboard', 'Electronics', '', '2021-09-01', 'False');

-- --------------------------------------------------------

--
-- Table structure for table `asset_assignment`
--

DROP TABLE IF EXISTS `asset_assignment`;
CREATE TABLE IF NOT EXISTS `asset_assignment` (
  `assignment_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `assigned_to` varchar(255) NOT NULL,
  `assigned_by` varchar(255) NOT NULL,
  `asset_condition` varchar(255) NOT NULL,
  `assign_date` varchar(255) NOT NULL,
  `return_date` varchar(255) NOT NULL,
  `assign_deleted` enum('False','True') NOT NULL,
  `returned` enum('False','True') NOT NULL,
  PRIMARY KEY (`assignment_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `asset_assignment`
--

INSERT INTO `asset_assignment` (`assignment_id`, `asset_id`, `assigned_to`, `assigned_by`, `asset_condition`, `assign_date`, `return_date`, `assign_deleted`, `returned`) VALUES
(1, 1, 'Esther Otieno', 'Admin', 'New keyboard', '2021-09-11', '2022-05-21', 'False', 'False');

-- --------------------------------------------------------

--
-- Table structure for table `asset_category`
--

DROP TABLE IF EXISTS `asset_category`;
CREATE TABLE IF NOT EXISTS `asset_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `category_deleted` enum('False','True') NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `asset_category`
--

INSERT INTO `asset_category` (`category_id`, `category_name`, `category_deleted`) VALUES
(1, 'Electronics', 'False');

-- --------------------------------------------------------

--
-- Table structure for table `asset_inventory`
--

DROP TABLE IF EXISTS `asset_inventory`;
CREATE TABLE IF NOT EXISTS `asset_inventory` (
  `inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `serial_number` varchar(255) NOT NULL,
  `asset_quantity` int(11) NOT NULL,
  `unit_cost` int(11) NOT NULL,
  `total_cost` int(11) NOT NULL,
  `location_code` varchar(255) NOT NULL,
  `movement_type` enum('Incoming','Outgoing') NOT NULL,
  `movement_comment` varchar(255) NOT NULL,
  `inventory_deleted` enum('False','True') NOT NULL,
  PRIMARY KEY (`inventory_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `asset_inventory`
--

INSERT INTO `asset_inventory` (`inventory_id`, `asset_id`, `serial_number`, `asset_quantity`, `unit_cost`, `total_cost`, `location_code`, `movement_type`, `movement_comment`, `inventory_deleted`) VALUES
(1, 1, '12321', 4, 20000, 80000, 'KCC/SNH', 'Incoming', '', 'False');

-- --------------------------------------------------------

--
-- Table structure for table `asset_location`
--

DROP TABLE IF EXISTS `asset_location`;
CREATE TABLE IF NOT EXISTS `asset_location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_name` varchar(255) NOT NULL,
  `location_code` varchar(255) NOT NULL,
  `location_deleted` enum('False','True') NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `asset_location`
--

INSERT INTO `asset_location` (`location_id`, `location_name`, `location_code`, `location_deleted`) VALUES
(1, 'Senior Pastor', 'KCC/SNH', 'False');

-- --------------------------------------------------------
