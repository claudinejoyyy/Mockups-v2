-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 21, 2018 at 05:20 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `hms`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE IF NOT EXISTS `activity_logs` (
  `logs_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `type` text NOT NULL,
  `remarks` text NOT NULL,
  PRIMARY KEY (`logs_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=534 ;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`logs_id`, `account_id`, `time`, `type`, `remarks`) VALUES
(498, 3, '2018-02-21 22:05:27', 'log', 'Logged in'),
(499, 3, '2018-02-21 22:05:27', 'todo', 'Added to To Do List the following: General meeting at Lim Hall'),
(500, 3, '2018-02-21 22:05:27', 'add', 'Added: military dependent - Rachel Cruz'),
(501, 3, '2018-02-21 22:05:27', 'initialAssessment', 'assessment for 54'),
(502, 3, '2018-02-21 22:05:27', 'log', 'Logged out'),
(503, 4, '2018-02-21 22:05:27', 'log', 'Logged in'),
(504, 4, '2018-02-21 22:05:27', 'log', 'Logged out'),
(505, 5, '2018-02-21 22:05:27', 'log', 'Logged in'),
(506, 5, '2018-02-21 22:05:27', 'log', 'Logged out'),
(507, 4, '2018-02-21 22:05:27', 'log', 'Logged in'),
(508, 4, '2018-02-21 22:05:27', 'log', 'Logged out'),
(509, 1, '2018-02-21 22:05:27', 'log', 'Logged in'),
(510, 1, '2018-02-21 22:05:27', 'approvedPrescription', 'Approved prescription for: Rachel Cruz'),
(511, 1, '2018-02-21 22:05:27', 'log', 'Logged out'),
(512, 4, '2018-02-21 22:05:27', 'log', 'Logged in'),
(513, 4, '2018-02-21 22:05:27', 'todo', 'Added to To Do List the following: General meeting at Lime Hall'),
(514, 4, '2018-02-21 22:05:27', 'log', 'Logged out'),
(515, 3, '2018-02-21 22:05:27', 'log', 'Logged in'),
(516, 3, '2018-02-21 22:05:27', 'add', 'Added: military officer - Richard Ovidio'),
(517, 3, '2018-02-21 22:05:27', 'add', 'Added: authorized civilian - Andrea Fajardo'),
(518, 3, '2018-02-21 22:05:27', 'add', 'Added: cadet - Paul Canencia'),
(519, 3, '2018-02-21 22:05:27', 'add', 'Added: civilian - Phoebe Cerezo'),
(520, 3, '2018-02-21 22:05:27', 'log', 'Logged out'),
(521, 4, '2018-02-21 22:05:27', 'log', 'Logged in'),
(522, 4, '2018-02-21 22:05:27', 'appointment', 'Set Appointment with Richard Ovidio on 2018-02-23 10:00:00'),
(523, 4, '2018-02-21 22:05:27', 'log', 'Logged out'),
(524, 5, '2018-02-21 22:05:27', 'log', 'Logged in'),
(525, 5, '2018-02-21 22:05:27', 'log', 'Logged out'),
(526, 3, '2018-02-21 22:05:27', 'log', 'Logged in'),
(527, 3, '2018-02-21 22:05:27', 'initialAssessment', 'assessment for 58'),
(528, 3, '2018-02-21 22:05:27', 'log', 'Logged out'),
(529, 4, '2018-02-21 22:05:27', 'log', 'Logged in'),
(530, 4, '2018-02-21 22:05:27', 'log', 'Logged out'),
(531, 4, '2018-02-21 22:05:27', 'log', 'Logged in'),
(532, 4, '2018-02-21 22:05:27', 'bed', 'Alloted bed number: 1'),
(533, 4, '2018-02-21 22:05:27', 'log', 'Logged out');

-- --------------------------------------------------------

--
-- Table structure for table `admit`
--

CREATE TABLE IF NOT EXISTS `admit` (
  `patient_id` int(11) NOT NULL,
  `department` varchar(12) NOT NULL,
  UNIQUE KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

CREATE TABLE IF NOT EXISTS `announcement` (
  `announcement_id` int(11) NOT NULL AUTO_INCREMENT,
  `announcement_title` text NOT NULL,
  `announcement` text NOT NULL,
  `timestamp` timestamp NOT NULL,
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE IF NOT EXISTS `appointment` (
  `appointment_id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_timestamp` timestamp NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `remarks` text,
  PRIMARY KEY (`appointment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointment_id`, `appointment_timestamp`, `doctor_id`, `patient_id`, `remarks`) VALUES
(4, '2018-02-23 02:00:00', 4, 56, 'Check-up');

-- --------------------------------------------------------

--
-- Table structure for table `bed`
--

CREATE TABLE IF NOT EXISTS `bed` (
  `bed_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(11) NOT NULL,
  `allotment_timestamp` datetime DEFAULT NULL,
  `description` text,
  `patient_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`bed_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=101 ;

--
-- Dumping data for table `bed`
--

INSERT INTO `bed` (`bed_id`, `status`, `allotment_timestamp`, `description`, `patient_id`) VALUES
(1, 'occupied', '2018-02-21 22:05:27', NULL, 58),
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
-- Table structure for table `family_history`
--

CREATE TABLE IF NOT EXISTS `family_history` (
  `fh_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`fh_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `family_history`
--

INSERT INTO `family_history` (`fh_id`, `name`) VALUES
(1, 'DM'),
(2, 'CVD'),
(3, 'CA'),
(4, 'Mental Illness'),
(5, 'Asthma'),
(6, 'Hypertension');

-- --------------------------------------------------------

--
-- Table structure for table `immunization`
--

CREATE TABLE IF NOT EXISTS `immunization` (
  `name` varchar(15) NOT NULL,
  `immu_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`immu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `immunization`
--

INSERT INTO `immunization` (`name`, `immu_id`) VALUES
('DFT', 1),
('Polio', 2),
('Measles', 3),
('MMR', 4),
('Hepatitis A', 5),
('Hepatitis B', 6),
('Tyroid', 7),
('Chicken Pox', 8),
('Meningcoccemia', 9),
('Rabies', 10),
('HIB', 11),
('Influenza', 12),
('Phenomia', 13),
('Tetanus Toxoid', 14),
('BCD', 15);

-- --------------------------------------------------------

--
-- Table structure for table `initial_assessment`
--

CREATE TABLE IF NOT EXISTS `initial_assessment` (
  `assessment_id` int(11) NOT NULL AUTO_INCREMENT,
  `assessment` text NOT NULL,
  `date` datetime NOT NULL,
  `patient_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `vital_signs` text NOT NULL,
  PRIMARY KEY (`assessment_id`),
  KEY `patient_id` (`patient_id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `initial_assessment`
--

INSERT INTO `initial_assessment` (`assessment_id`, `assessment`, `date`, `patient_id`, `account_id`, `vital_signs`) VALUES
(7, 'Stomach Ache', '2018-02-21 22:05:27', 54, 4, '120/70\n21\n83\n15\n37\n52\n23'),
(8, 'Extreme headache and chest pains', '2018-02-21 22:05:27', 58, 4, '100/80\n12\n68\n16\n37.5\n59\n35');

-- --------------------------------------------------------

--
-- Table structure for table `lab_request`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `lab_request`
--

INSERT INTO `lab_request` (`request_id`, `type`, `timestamp`, `remarks`, `doctor_id`, `patient_id`, `lab_status`) VALUES
(4, 'parasitology', '2018-02-21 14:05:27', '', 4, 54, 'pending'),
(5, 'bloodChemistry', '2018-02-21 14:05:27', '', 4, 54, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=59 ;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `patient_type`, `name`, `age`, `unit`, `sex`, `status`, `birth_date`, `address`, `religion`, `blood_type`, `allergies`, `father`, `mother`, `birth_history`, `rankORsn`, `immunization`, `family_history`) VALUES
(54, 'military dependent', 'Rachel Cruz', 23, '', 'F', 'Single', '1995-02-21', '25 Upper East, Purok 1, Camp 7', 'Roman Catholic', 'AB', 'Peanuts', 'Richard Cruz\n:Military Officer', 'Mae Ann Cruz\n:Chef', 'Cesarian Delivery', '', 'Polio:1995-02\nChicken Pox:1995-04\nInfluenza:1997-06\nMeasles:1995-02\n\n', '\n'),
(55, 'military officer', 'Richard Ovidio', 30, '32nd Infantry Battalion', 'M', 'Maried', '1998-11-08', '78 Green Valley, Marcos Highwa', 'Born Again', 'A', '', 'Ubaldo Ovidio\n:Farmer', 'Cynthia Ovidio\n:Nurse', 'Normal Delivery', 'O-98142', 'Chicken Pox:1990-05\nTyroid:1990-05\nHepatitis A:1989-05\nHepatitis B:1989-06\nBCD:1991-08\n\n', 'Asthma\n\n'),
(56, 'authorized civilian', 'Andrea Fajardo', 15, '', 'F', 'Single', '2002-09-05', '31 Lower General Luna, Baguio ', 'Roman Catholic', 'B', 'Chocolates', 'Miguel Fajardo\n:Carpenter', 'Maria Fajardo\n:Hair Stylist', 'Cesarian Delivery', '', 'Measles:2002-09\nBCD:2005-03\nInfluenza:2006-08\n\n', 'Asthma\n\n'),
(57, 'cadet', 'Paul Canencia', 21, '114th Infantry Battalion', 'M', 'Single', '1997-02-14', '56 San Vicente, Baguio City', 'Anglican', 'O', '', 'Joey Canencia\n:Reporter', 'Angelica Canencia\n:Housewife', 'Regular Delivery', '83512', 'Rabies:2005-09\nInfluenza:2001-07\nChicken Pox:1997-03\nTyroid:2003-04\n\n', '\n'),
(58, 'civilian', 'Phoebe Cerezo', 35, '', 'F', 'Maried', '1983-01-01', '45 Leonila Hill, Baguio City', 'Roman Catholic', 'A', 'Kiwi', 'Elmer Cerezo\n:Police Officer', 'Mae Cerezo\n:Police Officer', 'Cesarian Delivery', '', 'Hepatitis A:1996-03\nHepatitis B:1996-04\nChicken Pox:1990-06\nMeasles:1990-12\nPolio:1990-09\n\n', 'CA\nHypertension\n\n');

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

CREATE TABLE IF NOT EXISTS `prescription` (
  `prescription_id` int(11) NOT NULL AUTO_INCREMENT,
  `creation_stamp` timestamp NOT NULL,
  `medicine` text NOT NULL,
  `quantity` int(11) NOT NULL,
  `dosage` text NOT NULL,
  `timeframe` text NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `status` varchar(12) NOT NULL,
  PRIMARY KEY (`prescription_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `prescription`
--

INSERT INTO `prescription` (`prescription_id`, `creation_stamp`, `medicine`, `quantity`, `dosage`, `timeframe`, `doctor_id`, `patient_id`, `status`) VALUES
(4, '2018-02-21 14:05:27', 'Acetaminophen', 9, '', '3 times/day; 3 days', 4, 54, 'confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE IF NOT EXISTS `report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_type` text NOT NULL COMMENT 'operation,birth,death',
  `description` text NOT NULL,
  `timestamp` timestamp NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `todo_list`
--

CREATE TABLE IF NOT EXISTS `todo_list` (
  `todo_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `date` datetime NOT NULL,
  `account_id` int(11) NOT NULL,
  PRIMARY KEY (`todo_id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `todo_list`
--

INSERT INTO `todo_list` (`todo_id`, `description`, `date`, `account_id`) VALUES
(5, 'General meeting at Lim Hall', '2018-02-23 09:00:00', 3),
(6, 'General meeting at Lime Hall', '2018-02-23 09:00:00', 4);

-- --------------------------------------------------------

--
-- Table structure for table `user_accounts`
--

CREATE TABLE IF NOT EXISTS `user_accounts` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `account_type` varchar(12) NOT NULL,
  `name` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `sex` varchar(1) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(10) NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `user_accounts`
--

INSERT INTO `user_accounts` (`account_id`, `username`, `password`, `account_type`, `name`, `age`, `sex`, `address`, `phone`) VALUES
(1, 'pharmacist@pharmacist.com', 'pharmacist', 'pharmacist', 'Chasey Fernandez', 29, 'F', '52 Upper Bonifacio Street, Baguio City', '9163746523'),
(2, 'admin@admin.com', 'admin', 'admin', 'Albert Gonzaga', 35, 'M', '216 Woodsville Subdivision, Camp 7, Baguio City', '9178403451'),
(3, 'nurse@nurse.com', 'nurse', 'nurse', 'Christine Martinez', 25, 'F', '89 Gabriela Silang, Baguio City', '9063746123'),
(4, 'doctor@doctor.com', 'doctor', 'doctor', 'Joseph Zamoranos', 28, 'M', 'Unit 6, Golden Acres Compound, Trancoville, Baguio City', '9153787231'),
(5, 'laboratorist@laboratorist.com', 'laboratorist', 'laboratorist', '', 0, '', '', ''),
(6, 'nurse2@nurse.com', 'nurse', 'nurse', '', 0, '', '', '');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `initial_assessment`
--
ALTER TABLE `initial_assessment`
  ADD CONSTRAINT `initial_assessment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  ADD CONSTRAINT `initial_assessment_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `user_accounts` (`account_id`);

--
-- Constraints for table `lab_request`
--
ALTER TABLE `lab_request`
  ADD CONSTRAINT `lab_request_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `user_accounts` (`account_id`),
  ADD CONSTRAINT `lab_request_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`);

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
