-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 30, 2018 at 08:17 PM
-- Server version: 5.7.19
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hms`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
CREATE TABLE IF NOT EXISTS `activity_logs` (
  `logs_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `type` text NOT NULL,
  `remarks` text NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`logs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
CREATE TABLE IF NOT EXISTS `appointment` (
  `appointment_id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_timestamp` timestamp NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `remarks` text,
  PRIMARY KEY (`appointment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bed`
--

DROP TABLE IF EXISTS `bed`;
CREATE TABLE IF NOT EXISTS `bed` (
  `bed_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(11) NOT NULL,
  `allotment_timestamp` datetime DEFAULT NULL,
  `description` text,
  `patient_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`bed_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bed`
--

INSERT INTO `bed` (`bed_id`, `status`, `allotment_timestamp`, `description`, `patient_id`) VALUES
(1, 'Unoccupied', NULL, NULL, NULL),
(2, 'Unoccupied', NULL, NULL, NULL),
(3, 'Unoccupied', NULL, NULL, NULL),
(4, 'Unoccupied', NULL, NULL, NULL),
(5, 'Unoccupied', NULL, NULL, NULL),
(6, 'Unoccupied', NULL, NULL, NULL),
(7, 'Unoccupied', NULL, NULL, NULL),
(8, 'Unoccupied', NULL, NULL, NULL),
(9, 'Unoccupied', NULL, NULL, NULL),
(10, 'Unoccupied', NULL, NULL, NULL),
(11, 'Unoccupied', NULL, NULL, NULL),
(12, 'Unoccupied', NULL, NULL, NULL),
(13, 'Unoccupied', NULL, NULL, NULL),
(14, 'Unoccupied', NULL, NULL, NULL),
(15, 'Unoccupied', NULL, NULL, NULL),
(16, 'Unoccupied', NULL, NULL, NULL),
(17, 'Unoccupied', NULL, NULL, NULL),
(18, 'Unoccupied', NULL, NULL, NULL),
(19, 'Unoccupied', NULL, NULL, NULL),
(20, 'Unoccupied', NULL, NULL, NULL),
(21, 'Unoccupied', NULL, NULL, NULL),
(22, 'Unoccupied', NULL, NULL, NULL),
(23, 'Unoccupied', NULL, NULL, NULL),
(24, 'Unoccupied', NULL, NULL, NULL),
(25, 'Unoccupied', NULL, NULL, NULL),
(26, 'Unoccupied', NULL, NULL, NULL),
(27, 'Unoccupied', NULL, NULL, NULL),
(28, 'Unoccupied', NULL, NULL, NULL),
(29, 'Unoccupied', NULL, NULL, NULL),
(30, 'Unoccupied', NULL, NULL, NULL),
(31, 'Unoccupied', NULL, NULL, NULL),
(32, 'Unoccupied', NULL, NULL, NULL),
(33, 'Unoccupied', NULL, NULL, NULL),
(34, 'Unoccupied', NULL, NULL, NULL),
(35, 'Unoccupied', NULL, NULL, NULL),
(36, 'Unoccupied', NULL, NULL, NULL),
(37, 'Unoccupied', NULL, NULL, NULL),
(38, 'Unoccupied', NULL, NULL, NULL),
(39, 'Unoccupied', NULL, NULL, NULL),
(40, 'Unoccupied', NULL, NULL, NULL),
(41, 'Unoccupied', NULL, NULL, NULL),
(42, 'Unoccupied', NULL, NULL, NULL),
(43, 'Unoccupied', NULL, NULL, NULL),
(44, 'Unoccupied', NULL, NULL, NULL),
(45, 'Unoccupied', NULL, NULL, NULL),
(46, 'Unoccupied', NULL, NULL, NULL),
(47, 'Unoccupied', NULL, NULL, NULL),
(48, 'Unoccupied', NULL, NULL, NULL),
(49, 'Unoccupied', NULL, NULL, NULL),
(50, 'Unoccupied', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `diagnosis`
--

DROP TABLE IF EXISTS `diagnosis`;
CREATE TABLE IF NOT EXISTS `diagnosis` (
  `diag_id` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis` text NOT NULL,
  `date` timestamp NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  PRIMARY KEY (`diag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `family_history`
--

DROP TABLE IF EXISTS `family_history`;
CREATE TABLE IF NOT EXISTS `family_history` (
  `fh_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`fh_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `family_history`
--

INSERT INTO `family_history` (`fh_id`, `name`) VALUES
(1, NULL),
(2, 'DM'),
(3, 'CVD'),
(4, 'CA'),
(5, 'Mental Illness'),
(6, 'Asthma'),
(7, 'Hypertension');

-- --------------------------------------------------------

--
-- Table structure for table `immunization`
--

DROP TABLE IF EXISTS `immunization`;
CREATE TABLE IF NOT EXISTS `immunization` (
  `name` varchar(15) DEFAULT NULL,
  `immu_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`immu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `immunization`
--

INSERT INTO `immunization` (`name`, `immu_id`) VALUES
(NULL, 1),
('DFT', 2),
('Polio', 3),
('Measles', 4),
('MMR', 5),
('Hepatitis A', 6),
('Hepatitis B', 7),
('Tyroid', 8),
('Chicken Pox', 9),
('Meningcoccemia', 10),
('Rabies', 11),
('HIB', 12),
('Influenza', 13),
('Phenomia', 14),
('Tetanus Toxoid', 15),
('BCD', 16);

-- --------------------------------------------------------

--
-- Table structure for table `lab_counter`
--

DROP TABLE IF EXISTS `lab_counter`;
CREATE TABLE IF NOT EXISTS `lab_counter` (
  `lab_counter_id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL,
  `patient_id` int(11) NOT NULL,
  `type` text NOT NULL,
  `name` text NOT NULL,
  PRIMARY KEY (`lab_counter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lab_request`
--

DROP TABLE IF EXISTS `lab_request`;
CREATE TABLE IF NOT EXISTS `lab_request` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL,
  `remarks` text NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `lab_status` varchar(20) NOT NULL,
  PRIMARY KEY (`request_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `opd_count`
--

DROP TABLE IF EXISTS `opd_count`;
CREATE TABLE IF NOT EXISTS `opd_count` (
  `opd_count_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_stamp` timestamp NOT NULL,
  `patient_id` int(11) NOT NULL,
  PRIMARY KEY (`opd_count_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `patient_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_type` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `age` int(3) NOT NULL,
  `unit` text NOT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `status` varchar(7) NOT NULL,
  `birth_date` date NOT NULL,
  `address` varchar(30) NOT NULL,
  `religion` varchar(15) DEFAULT NULL,
  `blood_type` varchar(2) DEFAULT NULL,
  `allergies` text,
  `father` text,
  `mother` text,
  `birth_history` text,
  `rankORsn` varchar(20) DEFAULT NULL,
  `immunization` text,
  `family_history` text,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `patient_history`
--

DROP TABLE IF EXISTS `patient_history`;
CREATE TABLE IF NOT EXISTS `patient_history` (
  `histo_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_stamp` timestamp NOT NULL,
  `initial_assessment` text,
  `lab` text,
  `medicine` text,
  `diagnosis` text,
  `bed` text,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `vitals` text,
  `status` text NOT NULL,
  PRIMARY KEY (`histo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
CREATE TABLE IF NOT EXISTS `prescription` (
  `prescription_id` int(11) NOT NULL AUTO_INCREMENT,
  `creation_stamp` timestamp NOT NULL,
  `medicine` text NOT NULL,
  `quantity` text NOT NULL,
  `dosage` text NOT NULL,
  `timeframe` text NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `status` varchar(12) NOT NULL,
  PRIMARY KEY (`prescription_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `todo_list`
--

DROP TABLE IF EXISTS `todo_list`;
CREATE TABLE IF NOT EXISTS `todo_list` (
  `todo_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(10) NOT NULL,
  `description` text NOT NULL,
  `date` datetime NOT NULL,
  `account_id` int(11) NOT NULL,
  PRIMARY KEY (`todo_id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_accounts`
--

DROP TABLE IF EXISTS `user_accounts`;
CREATE TABLE IF NOT EXISTS `user_accounts` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `account_type` varchar(12) NOT NULL,
  `name` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `sex` varchar(1) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(11) NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_accounts`
--

INSERT INTO `user_accounts` (`account_id`, `username`, `password`, `account_type`, `name`, `age`, `sex`, `address`, `phone`) VALUES
(25, 'admin', '$2a$10$Ukc5O4P6sSV2ZnGbP.jeAOCU2LNzN2BSzIht7IMj.uwM7EeFr0J2m', 'admin', 'Grubaaaaat', 28, 'M', 'PMA baguio', '9718236712');

-- --------------------------------------------------------

--
-- Table structure for table `ward_count`
--

DROP TABLE IF EXISTS `ward_count`;
CREATE TABLE IF NOT EXISTS `ward_count` (
  `ward_count_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_stamp` timestamp NOT NULL,
  `patient_id` int(11) NOT NULL,
  PRIMARY KEY (`ward_count_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `prescription`
--
ALTER TABLE `prescription`
  ADD CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  ADD CONSTRAINT `prescription_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `user_accounts` (`account_id`);

--
-- Constraints for table `todo_list`
--
ALTER TABLE `todo_list`
  ADD CONSTRAINT `todo_list_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `user_accounts` (`account_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
