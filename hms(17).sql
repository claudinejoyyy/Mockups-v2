-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 12, 2018 at 11:47 AM
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
) ENGINE=InnoDB AUTO_INCREMENT=782 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`logs_id`, `account_id`, `time`, `type`, `remarks`, `patient_id`) VALUES
(5, 4, '2018-02-23 02:25:44', 'bed', 'Alloted bed number: 1', 42),
(6, 4, '2018-02-23 02:25:44', 'bed', 'Alloted bed number: 2', 48),
(7, 4, '2018-02-23 02:25:44', 'bed', 'Alloted bed number: 3', 45),
(8, 4, '2018-02-23 02:25:44', 'bed', 'Alloted bed number: 4', 46),
(9, 4, '2018-02-23 02:25:44', 'bedDischarge', 'Discharged a patient from bed number : 4', NULL),
(10, 4, '2018-02-23 02:25:44', 'bedDischarge', 'Discharged a patient from bed number : 3', NULL),
(11, 4, '2018-02-23 02:25:44', 'bedDischarge', 'Discharged a patient from bed number : 2', NULL),
(12, 4, '2018-02-23 02:25:44', 'bedDischarge', 'Discharged a patient from bed number : 1', NULL),
(13, 4, '2018-02-23 02:25:44', 'bed', 'Alloted bed number: 1', 42),
(14, 4, '2018-02-23 02:25:44', 'bed', 'Alloted bed number: 2', 48),
(15, 4, '2018-02-23 02:25:44', 'bed', 'Alloted bed number: 3', 45),
(16, 4, '2018-02-23 02:25:44', 'bed', 'Alloted bed number: 4', 46),
(17, 4, '2018-02-23 02:25:44', 'appointment', 'Set Appointment with Paul Je on 2018-02-01 01:00:00', NULL),
(18, 4, '2018-02-23 02:46:49', 'log', 'Logged in', NULL),
(19, 4, '2018-02-23 02:46:49', 'log', 'Logged out', NULL),
(20, 3, '2018-02-23 02:46:49', 'log', 'Logged in', NULL),
(21, 3, '2018-02-23 02:46:49', 'initialAssessment', 'assessment for 47', NULL),
(22, 3, '2018-02-23 02:46:49', 'log', 'Logged out', NULL),
(23, 4, '2018-02-23 02:46:49', 'log', 'Logged in', NULL),
(24, 3, '2018-02-23 02:54:58', 'log', 'Logged in', NULL),
(25, 3, '2018-02-23 02:59:21', 'log', 'Logged in', NULL),
(26, 3, '2018-02-23 03:02:44', 'log', 'Logged in', NULL),
(27, 3, '2018-02-23 03:02:44', 'initialAssessment', 'assessment for undefined', 50),
(28, 3, '2018-02-23 03:04:30', 'log', 'Logged in', NULL),
(29, 3, '2018-02-23 03:04:30', 'add', 'Added: cadet - z', NULL),
(30, 3, '2018-02-23 03:04:30', 'log', 'Logged out', NULL),
(31, 4, '2018-02-23 03:04:30', 'log', 'Logged in', NULL),
(32, 4, '2018-02-23 03:04:30', 'cancelPrescription', 'Canceled prescription for: ma mon', NULL),
(33, 4, '2018-02-23 03:04:30', 'cancelPrescription', 'Canceled prescription for: ma mon', NULL),
(34, 4, '2018-02-23 03:21:01', 'log', 'Logged in', NULL),
(35, 4, '2018-02-23 03:21:51', 'log', 'Logged in', NULL),
(36, 4, '2018-02-23 03:23:41', 'log', 'Logged in', NULL),
(37, 3, '2018-02-23 03:28:50', 'log', 'Logged in', NULL),
(38, 4, '2018-02-23 03:23:41', 'log', 'Logged in', NULL),
(39, 4, '2018-02-23 03:38:27', 'log', 'Logged in', NULL),
(40, 4, '2018-02-23 03:38:27', 'bed', 'Alloted bed number: 21', 50),
(41, 4, '2018-02-23 03:40:28', 'log', 'Logged in', NULL),
(42, 4, '2018-02-23 03:50:54', 'log', 'Logged in', NULL),
(43, 4, '2018-02-23 03:52:14', 'log', 'Logged in', NULL),
(44, 4, '2018-02-23 03:53:58', 'log', 'Logged in', NULL),
(45, 4, '2018-02-23 03:54:17', 'log', 'Logged in', NULL),
(46, 4, '2018-02-23 03:54:58', 'log', 'Logged in', NULL),
(47, 4, '2018-02-23 03:56:05', 'log', 'Logged in', NULL),
(48, 4, '2018-02-23 03:57:11', 'log', 'Logged in', NULL),
(49, 4, '2018-02-23 04:13:54', 'log', 'Logged in', NULL),
(50, 4, '2018-02-23 04:16:00', 'log', 'Logged in', NULL),
(51, 4, '2018-02-23 04:26:35', 'log', 'Logged in', NULL),
(52, 4, '2018-02-23 04:38:47', 'log', 'Logged in', NULL),
(53, 4, '2018-02-23 04:38:47', 'bed', 'Alloted bed number: 10', 49),
(54, 4, '2018-02-23 04:38:47', 'bed', 'Alloted bed number: 6', 47),
(55, 4, '2018-02-23 04:38:47', 'bedDischarge', 'Discharged a patient from bed number : 10', NULL),
(56, 4, '2018-02-23 04:38:47', 'bedDischarge', 'Discharged a patient from bed number : 6', NULL),
(57, 4, '2018-02-23 04:38:47', 'bed', 'Alloted bed number: 5', 47),
(58, 4, '2018-02-23 04:38:47', 'bed', 'Alloted bed number: 6', 49),
(59, 4, '2018-02-23 04:38:47', 'bedDischarge', 'Discharged a patient from bed number : 5', NULL),
(60, 4, '2018-02-23 04:38:47', 'bedDischarge', 'Discharged a patient from bed number : 6', NULL),
(61, 4, '2018-02-23 04:42:25', 'log', 'Logged in', NULL),
(62, 4, '2018-02-23 04:42:40', 'log', 'Logged in', NULL),
(63, 4, '2018-02-23 04:42:40', 'bed', 'Alloted bed number: 16', 47),
(64, 4, '2018-02-23 04:42:40', 'bed', 'Alloted bed number: 5', 49),
(65, 4, '2018-02-23 04:42:40', 'bedDischarge', 'Discharged a patient from bed number : 1', NULL),
(66, 4, '2018-02-23 04:42:40', 'bedDischarge', 'Discharged a patient from bed number : 2', NULL),
(67, 4, '2018-02-23 04:42:40', 'bedDischarge', 'Discharged a patient from bed number : 3', NULL),
(68, 4, '2018-02-23 04:42:40', 'bedDischarge', 'Discharged a patient from bed number : 4', NULL),
(69, 4, '2018-02-23 04:42:40', 'bedDischarge', 'Discharged a patient from bed number : 5', NULL),
(70, 4, '2018-02-23 04:42:40', 'bedDischarge', 'Discharged a patient from bed number : 16', NULL),
(71, 4, '2018-02-23 04:42:40', 'bedDischarge', 'Discharged a patient from bed number : 21', NULL),
(72, 4, '2018-02-23 04:42:40', 'bed', 'Alloted bed number: 1', 46),
(73, 4, '2018-02-23 04:44:17', 'log', 'Logged in', NULL),
(74, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 2', 42),
(75, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 3', 49),
(76, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 16', 47),
(77, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 50', 50),
(78, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 43', 45),
(79, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 5', 48),
(80, 4, '2018-02-23 04:44:17', 'bedDischarge', 'Discharged a patient from bed number : 1', NULL),
(81, 4, '2018-02-23 04:44:17', 'bedDischarge', 'Discharged a patient from bed number : 2', NULL),
(82, 4, '2018-02-23 04:44:17', 'bedDischarge', 'Discharged a patient from bed number : 3', NULL),
(83, 4, '2018-02-23 04:44:17', 'bedDischarge', 'Discharged a patient from bed number : 5', NULL),
(84, 4, '2018-02-23 04:44:17', 'bedDischarge', 'Discharged a patient from bed number : 16', NULL),
(85, 4, '2018-02-23 04:44:17', 'bedDischarge', 'Discharged a patient from bed number : 43', NULL),
(86, 4, '2018-02-23 04:44:17', 'bedDischarge', 'Discharged a patient from bed number : 50', NULL),
(87, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 1', 42),
(88, 4, '2018-02-23 04:44:17', 'bedDischarge', 'Discharged a patient from bed number : 1', NULL),
(89, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 1', 42),
(90, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 2', 45),
(91, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 3', 49),
(92, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 4', 47),
(93, 4, '2018-02-23 04:44:17', 'bed', 'Alloted bed number: 21', 50),
(94, 4, '2018-02-23 05:07:12', 'log', 'Logged in', NULL),
(95, 4, '2018-02-23 05:07:12', 'bed', 'Alloted bed number: 5 to patient:Paul Je', 46),
(96, 4, '2018-02-23 12:18:01', 'log', 'Logged in', NULL),
(97, 4, '2018-02-23 12:18:01', 'labRequest', 'Lab request for : ma mon', NULL),
(98, 4, '2018-02-23 12:28:19', 'log', 'Logged in', NULL),
(99, 4, '2018-02-23 12:28:19', 'labRequest', 'Lab request for : Ikaw Na Nga', NULL),
(100, 4, '2018-02-23 12:45:50', 'log', 'Logged in', NULL),
(101, 4, '2018-02-23 17:27:14', 'log', 'Logged in', NULL),
(102, 4, '2018-02-23 17:36:14', 'log', 'Logged in', NULL),
(103, 4, '2018-02-23 17:36:44', 'log', 'Logged in', NULL),
(104, 4, '2018-02-23 17:36:44', 'bed', 'Alloted bed number: 6 to patient:Mon Joel Dela Rosa', 48),
(105, 4, '2018-02-23 17:36:44', 'labRequest', 'Lab request for : Paul Je', NULL),
(106, 4, '2018-02-23 17:36:44', 'labRequest', 'Lab request for : rweewasqews', NULL),
(107, 4, '2018-02-23 17:36:44', 'labRequest', 'Lab request for : ma mon', NULL),
(108, 4, '2018-02-23 17:36:44', 'labRequest', 'Lab request for : ma mon', NULL),
(109, 4, '2018-02-23 17:36:44', 'labRequest', 'Lab request for : Mon Joel Dela Rosa', NULL),
(110, 4, '2018-02-23 17:36:44', 'labRequest', 'Lab request for : Mon Joel Dela Rosa', NULL),
(111, 4, '2018-02-23 17:36:44', 'cancelLabRequest', 'Canceled lab request for: ma mon', NULL),
(112, 4, '2018-02-23 17:36:44', 'cancelLabRequest', 'Canceled lab request for: ma mon', NULL),
(113, 4, '2018-02-23 17:36:44', 'cancelLabRequest', 'Canceled lab request for: Ikaw Na Nga', NULL),
(114, 4, '2018-02-23 17:36:44', 'cancelLabRequest', 'Canceled lab request for: Paul Je', NULL),
(115, 4, '2018-02-23 17:36:44', 'cancelLabRequest', 'Canceled lab request for: rweewasqews', NULL),
(116, 4, '2018-02-23 17:36:44', 'cancelLabRequest', 'Canceled lab request for: ma mon', NULL),
(117, 4, '2018-02-23 17:36:44', 'cancelLabRequest', 'Canceled lab request for: ma mon', NULL),
(118, 4, '2018-02-23 17:36:44', 'cancelLabRequest', 'Canceled lab request for: Mon Joel Dela Rosa', NULL),
(119, 4, '2018-02-23 17:36:44', 'cancelLabRequest', 'Canceled lab request for: Mon Joel Dela Rosa', NULL),
(120, 4, '2018-02-23 18:05:02', 'log', 'Logged in', NULL),
(121, 4, '2018-02-23 18:05:02', 'labRequest', 'Lab request for : ma mon', NULL),
(122, 4, '2018-02-23 18:05:02', 'labRequest', 'Lab request for : ma mon', NULL),
(123, 4, '2018-02-23 18:05:02', 'labRequest', 'Lab request for : Ikaw Na Nga', NULL),
(124, 4, '2018-02-23 18:05:02', 'cancelLabRequest', 'Canceled lab request for: ma mon', NULL),
(125, 4, '2018-02-23 18:05:02', 'cancelLabRequest', 'Canceled lab request for: ma mon', NULL),
(126, 4, '2018-02-23 18:05:02', 'cancelLabRequest', 'Canceled lab request for: Ikaw Na Nga', NULL),
(127, 4, '2018-02-23 18:15:15', 'log', 'Logged in', NULL),
(128, 4, '2018-02-23 18:17:31', 'log', 'Logged in', NULL),
(129, 4, '2018-02-23 18:19:30', 'log', 'Logged in', NULL),
(130, 4, '2018-02-23 18:19:30', 'labRequest', 'Lab request for : ma mon', NULL),
(131, 4, '2018-02-23 18:19:30', 'labRequest', 'Lab request for : ma mon', NULL),
(132, 4, '2018-02-23 18:19:30', 'labRequest', 'Lab request for : Ikaw Na Nga', NULL),
(133, 4, '2018-02-23 18:38:19', 'log', 'Logged in', NULL),
(134, 4, '2018-02-23 18:39:13', 'log', 'Logged in', NULL),
(135, 4, '2018-02-23 18:40:04', 'log', 'Logged in', NULL),
(136, 4, '2018-02-23 18:40:32', 'log', 'Logged in', NULL),
(137, 4, '2018-02-23 18:42:41', 'log', 'Logged in', NULL),
(138, 4, '2018-02-23 18:42:41', 'log', 'Logged in', NULL),
(139, 4, '2018-02-23 18:52:34', 'log', 'Logged in', NULL),
(140, 4, '2018-02-23 18:52:40', 'log', 'Logged in', NULL),
(141, 4, '2018-02-23 18:55:12', 'log', 'Logged in', NULL),
(142, 4, '2018-02-23 18:55:12', 'labRequest', 'Lab request for : qwe', NULL),
(143, 4, '2018-02-23 18:58:16', 'log', 'Logged in', NULL),
(144, 4, '2018-02-23 18:58:52', 'log', 'Logged in', NULL),
(145, 4, '2018-02-23 18:58:52', 'labRequest', 'Lab request for : asd', NULL),
(146, 4, '2018-02-23 19:00:09', 'log', 'Logged in', NULL),
(147, 4, '2018-02-23 19:00:09', 'labRequest', 'Lab request for : Paul Je', NULL),
(148, 4, '2018-02-23 19:00:33', 'log', 'Logged in', NULL),
(149, 4, '2018-02-23 19:00:46', 'log', 'Logged in', NULL),
(150, 4, '2018-02-23 19:00:46', 'labRequest', 'Lab request for : rweewasqews', NULL),
(151, 4, '2018-02-23 19:00:46', 'cancelLabRequest', 'Canceled lab request for: ma mon', NULL),
(152, 4, '2018-02-23 19:00:46', 'cancelLabRequest', 'Canceled lab request for: ma mon', NULL),
(153, 4, '2018-02-23 19:00:46', 'cancelLabRequest', 'Canceled lab request for: Ikaw Na Nga', NULL),
(154, 4, '2018-02-23 19:00:46', 'cancelLabRequest', 'Canceled lab request for: qwe', NULL),
(155, 4, '2018-02-23 19:00:46', 'cancelLabRequest', 'Canceled lab request for: asd', NULL),
(156, 4, '2018-02-23 19:00:46', 'cancelLabRequest', 'Canceled lab request for: Paul Je', NULL),
(157, 4, '2018-02-23 19:00:46', 'cancelLabRequest', 'Canceled lab request for: rweewasqews', NULL),
(158, 4, '2018-02-23 19:57:58', 'log', 'Logged in', NULL),
(159, 4, '2018-02-23 19:58:27', 'log', 'Logged in', NULL),
(160, 4, '2018-02-23 20:04:33', 'log', 'Logged in', NULL),
(161, 4, '2018-02-23 20:04:33', 'labRequest', 'Lab request for : ma mon', NULL),
(162, 4, '2018-02-23 20:20:58', 'log', 'Logged in', NULL),
(163, 4, '2018-02-23 20:21:17', 'log', 'Logged in', NULL),
(164, 4, '2018-02-23 20:21:37', 'log', 'Logged in', NULL),
(165, 4, '2018-02-23 20:23:20', 'log', 'Logged in', NULL),
(166, 4, '2018-02-23 20:23:29', 'log', 'Logged in', NULL),
(167, 4, '2018-02-23 20:23:47', 'log', 'Logged in', NULL),
(168, 4, '2018-02-23 20:25:08', 'log', 'Logged in', NULL),
(169, 4, '2018-02-23 20:25:22', 'log', 'Logged in', NULL),
(170, 4, '2018-02-23 20:26:06', 'log', 'Logged in', NULL),
(171, 4, '2018-02-23 20:26:38', 'log', 'Logged in', NULL),
(172, 4, '2018-02-23 20:27:46', 'log', 'Logged in', NULL),
(173, 4, '2018-02-23 20:28:27', 'log', 'Logged in', NULL),
(174, 4, '2018-02-23 20:29:36', 'log', 'Logged in', NULL),
(175, 4, '2018-02-23 20:29:36', 'bedDischarge', 'Discharged a patient from bed number : 4', NULL),
(176, 4, '2018-02-23 20:39:33', 'log', 'Logged in', NULL),
(177, 4, '2018-02-23 20:39:52', 'log', 'Logged in', NULL),
(178, 4, '2018-02-23 20:46:16', 'log', 'Logged in', NULL),
(179, 4, '2018-02-23 20:46:16', 'log', 'Logged in', NULL),
(180, 4, '2018-02-23 22:27:22', 'log', 'Logged in', NULL),
(181, 4, '2018-02-23 22:27:39', 'log', 'Logged in', NULL),
(182, 4, '2018-02-23 22:31:04', 'log', 'Logged in', NULL),
(183, 4, '2018-02-23 22:31:04', 'log', 'Logged out', NULL),
(184, 3, '2018-02-23 22:31:04', 'log', 'Logged in', NULL),
(185, 3, '2018-02-23 22:38:40', 'log', 'Logged in', NULL),
(186, 3, '2018-02-23 22:38:40', 'initialAssessment', 'assessment for undefined', 42),
(187, 3, '2018-02-23 22:38:40', 'log', 'Logged out', NULL),
(188, 4, '2018-02-23 22:38:40', 'log', 'Logged in', NULL),
(189, 4, '2018-02-23 22:49:46', 'log', 'Logged in', NULL),
(190, 4, '2018-02-23 22:49:46', 'bedDischarge', 'Discharged a patient from bed number : 1', NULL),
(191, 4, '2018-02-23 23:01:13', 'log', 'Logged in', NULL),
(192, 4, '2018-02-23 23:01:35', 'log', 'Logged in', NULL),
(193, 4, '2018-02-23 23:02:27', 'log', 'Logged in', NULL),
(194, 4, '2018-02-23 23:03:14', 'log', 'Logged in', NULL),
(195, 4, '2018-02-23 23:03:14', 'diagnosis', 'diagnosis for : ma mon', NULL),
(196, 4, '2018-02-23 23:03:14', 'diagnosis', 'diagnosis for : ma mon', NULL),
(197, 4, '2018-02-23 23:03:14', 'diagnosis', 'diagnosis for : ma mon', NULL),
(198, 4, '2018-02-23 23:03:14', 'diagnosis', 'diagnosis for : ma mon', NULL),
(199, 4, '2018-02-23 23:03:14', 'diagnosis', 'diagnosis for : ma mon', NULL),
(200, 4, '2018-02-23 23:03:14', 'diagnosis', 'diagnosis for : ma mon', NULL),
(201, 4, '2018-02-23 23:03:14', 'diagnosis', 'diagnosis for : ma mon', NULL),
(202, 4, '2018-02-23 23:03:14', 'diagnosis', 'diagnosis for : Ikaw Na Nga', NULL),
(203, 4, '2018-02-23 23:03:14', 'diagnosis', 'diagnosis for : ma mon', NULL),
(204, 4, '2018-02-23 23:03:14', 'diagnosis', 'diagnosis for : ma mon', NULL),
(205, 3, '2018-02-23 23:36:36', 'log', 'Logged in', NULL),
(206, 3, '2018-02-24 00:49:36', 'log', 'Logged in', NULL),
(207, 3, '2018-02-24 00:49:36', 'log', 'Logged out', NULL),
(208, 4, '2018-02-24 00:49:36', 'log', 'Logged in', NULL),
(209, 4, '2018-02-24 00:49:36', 'log', 'Logged out', NULL),
(210, 1, '2018-02-24 00:49:36', 'log', 'Logged in', NULL),
(211, 3, '2018-02-24 00:57:35', 'log', 'Logged in', NULL),
(212, 3, '2018-02-24 00:57:35', 'log', 'Logged out', NULL),
(213, 4, '2018-02-24 00:57:35', 'log', 'Logged in', NULL),
(214, 4, '2018-02-24 00:57:35', 'log', 'Logged out', NULL),
(215, 5, '2018-02-24 00:57:35', 'log', 'Logged in', NULL),
(216, 5, '2018-02-24 00:57:35', 'log', 'Logged out', NULL),
(217, 3, '2018-02-24 00:57:35', 'log', 'Logged in', NULL),
(218, 3, '2018-02-24 01:06:20', 'log', 'Logged in', NULL),
(219, 3, '2018-02-24 01:07:50', 'log', 'Logged in', NULL),
(220, 3, '2018-02-24 01:18:11', 'log', 'Logged in', NULL),
(221, 4, '2018-02-24 14:34:44', 'log', 'Logged in', NULL),
(222, 4, '2018-02-24 14:48:40', 'log', 'Logged in', NULL),
(223, 4, '2018-02-24 14:48:53', 'log', 'Logged in', NULL),
(224, 4, '2018-02-24 14:49:51', 'log', 'Logged in', NULL),
(225, 4, '2018-02-24 14:49:51', 'bed', 'Alloted bed number: 1 to patient:ma mon', 42),
(226, 4, '2018-02-24 14:49:51', 'bed', 'Alloted bed number: 25 to patient:rweewasqews', 47),
(227, 4, '2018-02-24 14:49:51', 'bedDischarge', 'Discharged a patient from bed number : 1', NULL),
(228, 4, '2018-02-24 14:49:51', 'bedDischarge', 'Discharged a patient from bed number : 1', NULL),
(229, 4, '2018-02-24 14:49:51', 'bedDischarge', 'Discharged a patient from bed number : 25', NULL),
(230, 4, '2018-02-24 16:51:55', 'log', 'Logged in', NULL),
(231, 4, '2018-02-24 16:58:26', 'log', 'Logged in', NULL),
(232, 4, '2018-02-24 17:07:07', 'log', 'Logged in', NULL),
(233, 1, '2018-02-24 17:12:31', 'log', 'Logged in', NULL),
(234, 1, '2018-02-24 17:16:12', 'log', 'Logged in', NULL),
(235, 4, '2018-02-24 17:08:52', 'log', 'Logged in', NULL),
(236, 4, '2018-02-24 17:54:11', 'log', 'Logged in', NULL),
(237, 4, '2018-02-24 17:54:43', 'log', 'Logged in', NULL),
(238, 4, '2018-02-24 17:56:09', 'log', 'Logged in', NULL),
(239, 4, '2018-02-24 17:56:20', 'log', 'Logged in', NULL),
(240, 4, '2018-02-24 18:02:10', 'log', 'Logged in', NULL),
(241, 4, '2018-02-24 18:02:34', 'log', 'Logged in', NULL),
(242, 4, '2018-02-24 18:04:55', 'log', 'Logged in', NULL),
(243, 4, '2018-02-24 18:09:28', 'log', 'Logged in', NULL),
(244, 4, '2018-02-24 18:18:57', 'log', 'Logged in', NULL),
(245, 4, '2018-02-24 18:24:56', 'log', 'Logged in', NULL),
(246, 4, '2018-02-24 20:30:05', 'log', 'Logged in', NULL),
(247, 4, '2018-02-24 20:45:58', 'log', 'Logged in', NULL),
(248, 4, '2018-02-24 20:51:10', 'log', 'Logged in', NULL),
(249, 4, '2018-02-24 20:52:07', 'log', 'Logged in', NULL),
(250, 4, '2018-02-24 21:15:17', 'log', 'Logged in', NULL),
(251, 4, '2018-02-24 21:15:40', 'log', 'Logged in', NULL),
(252, 4, '2018-02-24 21:18:03', 'log', 'Logged in', NULL),
(253, 4, '2018-02-24 21:21:52', 'log', 'Logged in', NULL),
(254, 1, '2018-02-25 01:58:35', 'log', 'Logged in', NULL),
(255, 1, '2018-02-25 01:58:35', 'log', 'Logged out', NULL),
(256, 3, '2018-02-25 01:58:35', 'log', 'Logged in', NULL),
(257, 3, '2018-02-25 01:58:35', 'log', 'Logged out', NULL),
(258, 1, '2018-02-25 01:58:35', 'log', 'Logged in', NULL),
(259, 1, '2018-02-25 01:58:35', 'log', 'Logged out', NULL),
(260, 3, '2018-02-25 01:58:35', 'log', 'Logged in', NULL),
(261, 3, '2018-02-25 02:03:34', 'log', 'Logged in', NULL),
(262, 3, '2018-02-25 02:06:33', 'log', 'Logged in', NULL),
(263, 3, '2018-02-25 02:22:45', 'log', 'Logged in', NULL),
(264, 4, '2018-02-25 12:38:03', 'log', 'Logged in', NULL),
(265, 4, '2018-02-25 12:52:40', 'log', 'Logged in', NULL),
(266, 4, '2018-02-25 12:54:42', 'log', 'Logged in', NULL),
(267, 4, '2018-02-25 12:58:49', 'log', 'Logged in', NULL),
(268, 4, '2018-02-25 13:04:25', 'log', 'Logged in', NULL),
(269, 4, '2018-02-25 13:05:49', 'log', 'Logged in', NULL),
(270, 4, '2018-02-25 13:06:25', 'log', 'Logged in', NULL),
(271, 4, '2018-02-25 13:06:58', 'log', 'Logged in', NULL),
(272, 4, '2018-02-25 13:11:04', 'log', 'Logged in', NULL),
(273, 4, '2018-02-25 13:12:14', 'log', 'Logged in', NULL),
(274, 4, '2018-02-25 13:12:44', 'log', 'Logged in', NULL),
(275, 4, '2018-02-25 13:13:59', 'log', 'Logged in', NULL),
(276, 4, '2018-02-25 13:14:47', 'log', 'Logged in', NULL),
(277, 3, '2018-02-25 13:27:51', 'log', 'Logged in', NULL),
(278, 3, '2018-02-25 13:28:24', 'log', 'Logged in', NULL),
(279, 3, '2018-02-25 13:29:41', 'log', 'Logged in', NULL),
(280, 3, '2018-02-25 13:29:41', 'log', 'Logged out', NULL),
(281, 4, '2018-02-25 13:29:41', 'log', 'Logged in', NULL),
(282, 4, '2018-02-25 13:35:45', 'log', 'Logged in', NULL),
(283, 3, '2018-02-25 13:36:39', 'log', 'Logged in', NULL),
(284, 3, '2018-02-25 13:38:47', 'log', 'Logged in', NULL),
(285, 3, '2018-02-25 13:38:47', 'log', 'Logged out', NULL),
(286, 4, '2018-02-25 13:38:47', 'log', 'Logged in', NULL),
(287, 4, '2018-02-25 19:25:09', 'log', 'Logged in', NULL),
(288, 4, '2018-02-25 19:25:09', 'diagnosis', 'diagnosis for : Ikaw Na Nga', NULL),
(289, 4, '2018-02-25 19:25:09', 'log', 'Logged out', NULL),
(290, 1, '2018-02-25 19:25:09', 'log', 'Logged in', NULL),
(291, 1, '2018-02-25 19:25:09', 'log', 'Logged out', NULL),
(292, 5, '2018-02-25 19:25:09', 'log', 'Logged in', NULL),
(293, 5, '2018-02-25 19:36:14', 'log', 'Logged in', NULL),
(294, 5, '2018-02-25 19:44:08', 'log', 'Logged in', NULL),
(295, 5, '2018-02-25 19:44:38', 'log', 'Logged in', NULL),
(296, 5, '2018-02-25 19:47:42', 'log', 'Logged in', NULL),
(297, 5, '2018-02-25 19:49:32', 'log', 'Logged in', NULL),
(298, 5, '2018-02-25 19:50:28', 'log', 'Logged in', NULL),
(299, 5, '2018-02-25 19:51:11', 'log', 'Logged in', NULL),
(300, 5, '2018-02-25 19:51:49', 'log', 'Logged in', NULL),
(301, 5, '2018-02-25 19:51:49', 'confirmedLabRequest', 'Confirmed lab request for: ma mon', NULL),
(302, 5, '2018-02-25 19:52:22', 'log', 'Logged in', NULL),
(303, 5, '2018-02-25 19:52:22', 'confirmedLabRequest', 'Confirmed lab request for: ma mon', NULL),
(304, 4, '2018-02-25 20:18:44', 'log', 'Logged in', NULL),
(305, 4, '2018-02-25 20:18:44', 'labRequest', 'Lab request for : ma mon', NULL),
(306, 4, '2018-02-25 20:18:44', 'labRequest', 'Lab request for : ma mon', NULL),
(307, 4, '2018-02-25 20:18:44', 'labRequest', 'Lab request for : ma mon', NULL),
(308, 4, '2018-02-25 20:18:44', 'labRequest', 'Lab request for : ma mon', NULL),
(309, 4, '2018-02-25 20:18:44', 'labRequest', 'Lab request for : ma mon', NULL),
(310, 4, '2018-02-25 20:18:44', 'labRequest', 'Lab request for : ma mon', NULL),
(311, 4, '2018-02-25 20:18:44', 'log', 'Logged out', NULL),
(312, 5, '2018-02-25 20:18:44', 'log', 'Logged in', NULL),
(313, 5, '2018-02-25 20:20:59', 'log', 'Logged in', NULL),
(314, 5, '2018-02-25 20:20:59', 'log', 'Logged out', NULL),
(315, 4, '2018-02-25 20:20:59', 'log', 'Logged in', NULL),
(316, 4, '2018-02-25 20:20:59', 'labRequest', 'Lab request for : Paul Je', NULL),
(317, 4, '2018-02-25 20:20:59', 'log', 'Logged out', NULL),
(318, 1, '2018-02-25 20:20:59', 'log', 'Logged in', NULL),
(319, 1, '2018-02-25 20:20:59', 'log', 'Logged out', NULL),
(320, 5, '2018-02-25 20:20:59', 'log', 'Logged in', NULL),
(321, 5, '2018-02-25 20:20:59', 'confirmedLabRequest', 'Confirmed lab request for: ma mon', NULL),
(322, 5, '2018-02-25 20:20:59', 'confirmedLabRequest', 'Confirmed lab request for: Paul Je', NULL),
(323, 5, '2018-02-25 20:28:45', 'log', 'Logged in', NULL),
(324, 4, '2018-02-25 20:34:29', 'log', 'Logged in', NULL),
(325, 4, '2018-02-25 20:35:02', 'log', 'Logged in', NULL),
(326, 4, '2018-02-25 20:35:29', 'log', 'Logged in', NULL),
(327, 4, '2018-02-25 20:36:08', 'log', 'Logged in', NULL),
(328, 4, '2018-02-25 20:36:59', 'log', 'Logged in', NULL),
(329, 4, '2018-02-25 20:39:25', 'log', 'Logged in', NULL),
(330, 1, '2018-02-25 20:42:28', 'log', 'Logged in', NULL),
(331, 1, '2018-02-25 20:42:28', 'approvedPrescription', 'Approved prescription for: ma mon', NULL),
(332, 1, '2018-02-25 20:42:28', 'log', 'Logged out', NULL),
(333, 5, '2018-02-25 20:42:28', 'log', 'Logged in', NULL),
(334, 5, '2018-02-25 20:42:28', 'log', 'Logged out', NULL),
(335, 4, '2018-02-25 20:42:28', 'log', 'Logged in', NULL),
(336, 4, '2018-02-25 20:49:20', 'log', 'Logged in', NULL),
(337, 4, '2018-02-25 20:49:20', 'log', 'Logged out', NULL),
(338, 5, '2018-02-25 20:49:20', 'log', 'Logged in', NULL),
(339, 5, '2018-02-25 20:49:20', 'log', 'Logged out', NULL),
(340, 3, '2018-02-25 20:49:20', 'log', 'Logged in', NULL),
(341, 3, '2018-02-25 20:49:20', 'log', 'Logged out', NULL),
(342, 5, '2018-02-25 20:49:20', 'log', 'Logged in', NULL),
(343, 5, '2018-02-25 20:49:20', 'log', 'Logged out', NULL),
(344, 2, '2018-02-25 20:49:20', 'log', 'Logged in', NULL),
(345, 2, '2018-02-25 21:01:55', 'log', 'Logged in', NULL),
(346, 2, '2018-02-25 21:01:55', 'todo', 'Added to To Do List the following: asd', NULL),
(347, 2, '2018-02-25 21:08:10', 'log', 'Logged in', NULL),
(348, 2, '2018-02-25 21:08:39', 'log', 'Logged in', NULL),
(349, 2, '2018-02-25 21:22:50', 'log', 'Logged in', NULL),
(350, 2, '2018-02-25 21:31:13', 'log', 'Logged in', NULL),
(351, 2, '2018-02-25 21:48:18', 'log', 'Logged in', NULL),
(352, 4, '2018-02-25 21:49:57', 'log', 'Logged in', NULL),
(353, 4, '2018-02-25 21:49:57', 'log', 'Logged out', NULL),
(354, 2, '2018-02-25 21:49:57', 'log', 'Logged in', NULL),
(355, 2, '2018-02-25 21:49:57', 'addUser', 'Added user: sam', NULL),
(356, 4, '2018-02-25 21:52:52', 'log', 'Logged in', NULL),
(357, 4, '2018-02-25 21:52:52', 'log', 'Logged out', NULL),
(358, 2, '2018-02-25 21:52:52', 'log', 'Logged in', NULL),
(359, 2, '2018-02-25 21:52:52', 'removedUser', 'removed user: ', NULL),
(360, 2, '2018-02-25 21:52:52', 'addUser', 'Added user: zxcasdqwe', NULL),
(361, 2, '2018-02-25 22:00:00', 'log', 'Logged in', NULL),
(362, 4, '2018-02-26 12:23:55', 'log', 'Logged in', NULL),
(363, 4, '2018-02-26 12:23:55', 'labRequest', 'Lab request for : qwe', NULL),
(364, 4, '2018-02-26 12:23:55', 'bed', 'Alloted bed number: 25 to patient:rweewasqews', 47),
(365, 4, '2018-02-26 12:23:55', 'bed', 'Alloted bed number: 1 to patient:ma mon', 42),
(366, 3, '2018-02-26 12:23:55', 'log', 'Logged in', NULL),
(367, 3, '2018-02-26 12:23:55', 'log', 'Logged out', NULL),
(368, 4, '2018-02-26 12:23:55', 'log', 'Logged in', NULL),
(369, 3, '2018-03-04 16:58:05', 'log', 'Logged in', NULL),
(370, 3, '2018-03-04 23:59:15', 'log', 'Logged in', NULL),
(371, 3, '2018-03-05 00:02:32', 'log', 'Logged in', NULL),
(372, 3, '2018-03-05 00:04:05', 'log', 'Logged in', NULL),
(373, 3, '2018-03-05 00:04:55', 'log', 'Logged in', NULL),
(374, 3, '2018-03-05 00:06:13', 'log', 'Logged in', NULL),
(375, 3, '2018-03-05 00:06:32', 'log', 'Logged in', NULL),
(376, 3, '2018-03-05 00:07:27', 'log', 'Logged in', NULL),
(377, 3, '2018-03-05 00:07:27', 'add', 'Added: cadet - zxc', NULL),
(378, 3, '2018-03-05 00:08:22', 'log', 'Logged in', NULL),
(379, 3, '2018-03-05 00:08:22', 'add', 'Added: cadet - asd', NULL),
(380, 3, '2018-03-05 03:14:04', 'log', 'Logged in', NULL),
(381, 3, '2018-03-05 03:14:04', 'add', 'Added: cadet - asd', NULL),
(382, 3, '2018-03-05 14:36:16', 'log', 'Logged in', NULL),
(383, 4, '2018-03-05 14:49:32', 'log', 'Logged in', NULL),
(384, 4, '2018-03-05 14:49:32', 'log', 'Logged out', NULL),
(385, 3, '2018-03-05 14:49:32', 'log', 'Logged in', NULL),
(386, 3, '2018-03-05 14:50:43', 'log', 'Logged in', NULL),
(387, 3, '2018-03-05 14:57:51', 'log', 'Logged in', NULL),
(388, 3, '2018-03-05 14:59:42', 'log', 'Logged in', NULL),
(389, 3, '2018-03-05 15:03:11', 'log', 'Logged in', NULL),
(390, 3, '2018-03-05 15:03:41', 'log', 'Logged in', NULL),
(391, 3, '2018-03-05 15:04:48', 'log', 'Logged in', NULL),
(392, 3, '2018-03-05 15:07:31', 'log', 'Logged in', NULL),
(393, 3, '2018-03-05 15:08:03', 'log', 'Logged in', NULL),
(394, 3, '2018-03-05 15:08:40', 'log', 'Logged in', NULL),
(395, 3, '2018-03-05 15:09:03', 'log', 'Logged in', NULL),
(396, 3, '2018-03-05 15:09:30', 'log', 'Logged in', NULL),
(397, 3, '2018-03-05 15:11:48', 'log', 'Logged in', NULL),
(398, 3, '2018-03-05 15:12:28', 'log', 'Logged in', NULL),
(399, 4, '2018-03-05 15:12:50', 'log', 'Logged in', NULL),
(400, 4, '2018-03-05 15:12:50', 'log', 'Logged out', NULL),
(401, 3, '2018-03-05 15:12:50', 'log', 'Logged in', NULL),
(402, 3, '2018-03-05 15:17:54', 'log', 'Logged in', NULL),
(403, 3, '2018-03-05 15:20:00', 'log', 'Logged in', NULL),
(404, 3, '2018-03-05 15:21:17', 'log', 'Logged in', NULL),
(405, 3, '2018-03-05 15:25:11', 'log', 'Logged in', NULL),
(406, 3, '2018-03-05 15:25:58', 'log', 'Logged in', NULL),
(407, 3, '2018-03-05 15:26:43', 'log', 'Logged in', NULL),
(408, 3, '2018-03-05 15:30:19', 'log', 'Logged in', NULL),
(409, 3, '2018-03-05 15:30:46', 'log', 'Logged in', NULL),
(410, 3, '2018-03-05 15:34:01', 'log', 'Logged in', NULL),
(411, 3, '2018-03-05 15:34:24', 'log', 'Logged in', NULL),
(412, 3, '2018-03-05 15:35:52', 'log', 'Logged in', NULL),
(413, 3, '2018-03-05 15:39:46', 'log', 'Logged in', NULL),
(414, 3, '2018-03-05 15:41:05', 'log', 'Logged in', NULL),
(415, 4, '2018-03-05 15:44:17', 'log', 'Logged in', NULL),
(416, 4, '2018-03-05 15:46:05', 'log', 'Logged in', NULL),
(417, 3, '2018-03-05 15:52:45', 'log', 'Logged in', NULL),
(418, 3, '2018-03-05 15:53:50', 'log', 'Logged in', NULL),
(419, 3, '2018-03-05 16:12:08', 'log', 'Logged in', NULL),
(420, 3, '2018-03-05 17:11:43', 'log', 'Logged in', NULL),
(421, 3, '2018-03-05 17:11:43', 'log', 'Logged out', NULL),
(422, 4, '2018-03-05 17:11:43', 'log', 'Logged in', NULL),
(423, 4, '2018-03-05 17:11:43', 'log', 'Logged out', NULL),
(424, 2, '2018-03-05 17:11:43', 'log', 'Logged in', NULL),
(425, 2, '2018-03-05 17:13:57', 'log', 'Logged in', NULL),
(426, 2, '2018-03-05 17:15:53', 'log', 'Logged in', NULL),
(427, 2, '2018-03-05 17:17:02', 'log', 'Logged in', NULL),
(428, 2, '2018-03-05 17:18:52', 'log', 'Logged in', NULL),
(429, 2, '2018-03-05 17:18:52', 'addUser', 'Added user: asd2', NULL),
(430, 2, '2018-03-05 17:18:52', 'addUser', 'Added user: qweasd', NULL),
(431, 2, '2018-03-05 17:18:52', 'addUser', 'Added user: sdasd', NULL),
(432, 2, '2018-03-05 17:18:52', 'addUser', 'Added user: asdzxc', NULL),
(433, 2, '2018-03-05 17:18:52', 'addUser', 'Added user: qweasd', NULL),
(434, 2, '2018-03-05 17:25:16', 'log', 'Logged in', NULL),
(435, 2, '2018-03-05 17:26:08', 'log', 'Logged in', NULL),
(436, 2, '2018-03-05 17:31:53', 'log', 'Logged in', NULL),
(437, 2, '2018-03-05 17:34:20', 'log', 'Logged in', NULL),
(438, 4, '2018-03-05 17:36:23', 'log', 'Logged in', NULL),
(439, 4, '2018-03-05 17:36:23', 'log', 'Logged out', NULL),
(440, 2, '2018-03-05 17:36:23', 'log', 'Logged in', NULL),
(441, 2, '2018-03-05 17:36:23', 'addUser', 'Added user: zxcasd', NULL),
(442, 4, '2018-03-08 00:00:59', 'log', 'Logged in', NULL),
(443, 3, '2018-03-07 01:03:29', 'log', 'Logged in', NULL),
(444, 3, '2018-03-07 01:06:35', 'log', 'Logged in', NULL),
(445, 3, '2018-03-07 01:06:35', 'add', 'Added: cadet - Testing patient management', NULL),
(446, 3, '2018-03-07 01:10:33', 'log', 'Logged in', NULL),
(447, 3, '2018-03-07 01:11:07', 'log', 'Logged in', NULL),
(448, 3, '2018-03-07 01:11:36', 'log', 'Logged in', NULL),
(449, 3, '2018-03-07 01:11:36', 'add', 'Added: cadet - testing p2', NULL),
(450, 3, '2018-03-07 01:18:46', 'log', 'Logged in', NULL),
(451, 3, '2018-03-07 01:22:48', 'log', 'Logged in', NULL),
(452, 3, '2018-03-07 01:23:55', 'log', 'Logged in', NULL),
(453, 3, '2018-03-07 01:30:55', 'log', 'Logged in', NULL),
(454, 3, '2018-03-07 01:38:50', 'log', 'Logged in', NULL),
(455, 3, '2018-03-07 01:39:40', 'log', 'Logged in', NULL),
(456, 4, '2018-03-07 01:38:50', 'log', 'Logged in', NULL),
(457, 4, '2018-03-07 01:38:50', 'bedDischarge', 'Discharged a patient from bed number : 1', NULL),
(458, 4, '2018-03-07 01:38:50', 'log', 'Logged out', NULL),
(459, 3, '2018-03-07 01:38:50', 'log', 'Logged in', NULL),
(460, 3, '2018-03-07 01:44:38', 'log', 'Logged in', NULL),
(461, 3, '2018-03-07 01:44:38', 'log', 'Logged out', NULL),
(462, 4, '2018-03-07 01:44:38', 'log', 'Logged in', NULL),
(463, 4, '2018-03-07 18:36:48', 'log', 'Logged in', NULL),
(464, 4, '2018-03-07 18:36:48', 'log', 'Logged out', NULL),
(465, 2, '2018-03-07 18:50:49', 'log', 'Logged in', NULL),
(466, 2, '2018-03-07 18:59:07', 'log', 'Logged in', NULL),
(467, 2, '2018-03-07 19:00:28', 'log', 'Logged in', NULL),
(468, 2, '2018-03-07 19:01:31', 'log', 'Logged in', NULL),
(469, 2, '2018-03-07 19:05:04', 'log', 'Logged in', NULL),
(470, 2, '2018-03-07 19:06:14', 'log', 'Logged in', NULL),
(471, 2, '2018-03-07 19:06:14', 'addUser', 'Added user: asdasd', NULL),
(472, 2, '2018-03-07 19:07:36', 'log', 'Logged in', NULL),
(473, 2, '2018-03-07 19:07:36', 'addUser', 'Added user: azxc', NULL),
(474, 2, '2018-03-07 19:07:36', 'log', 'Logged out', NULL),
(475, 4, '2018-03-07 19:07:36', 'log', 'Logged in', NULL),
(476, 2, '2018-03-07 19:45:31', 'log', 'Logged in', NULL),
(477, 2, '2018-03-07 19:45:31', 'addUser', 'Added user: monjoel', NULL),
(478, 2, '2018-03-07 19:49:33', 'log', 'Logged in', NULL),
(479, 2, '2018-03-07 19:49:33', 'addUser', 'Added user: mon', NULL),
(480, 2, '2018-03-07 19:53:18', 'log', 'Logged in', NULL),
(481, 2, '2018-03-07 19:53:18', 'addUser', 'Added user: raphael', NULL),
(482, 2, '2018-03-07 21:43:26', 'log', 'Logged in', NULL),
(483, 2, '2018-03-07 21:43:26', 'addUser', 'Added user: dikonalam', NULL),
(484, 2, '2018-03-07 21:45:31', 'log', 'Logged in', NULL),
(485, 2, '2018-03-07 21:45:31', 'addUser', 'Added user: qwe', NULL),
(486, 2, '2018-03-07 21:46:26', 'log', 'Logged in', NULL),
(487, 2, '2018-03-07 21:46:26', 'addUser', 'Added user: qwe', NULL),
(488, 2, '2018-03-07 21:46:58', 'log', 'Logged in', NULL),
(489, 2, '2018-03-07 21:46:58', 'addUser', 'Added user: 789', NULL),
(490, 2, '2018-03-07 21:48:34', 'log', 'Logged in', NULL),
(491, 2, '2018-03-07 21:48:34', 'addUser', 'Added user: joel', NULL),
(492, 2, '2018-03-07 21:48:34', 'log', 'Logged out', NULL),
(493, 24, '2018-03-07 21:50:01', 'log', 'Logged in', NULL),
(494, 24, '2018-03-07 21:50:01', 'log', 'Logged out', NULL),
(495, 24, '2018-03-07 21:50:01', 'log', 'Logged in', NULL),
(496, 24, '2018-03-07 21:50:01', 'log', 'Logged out', NULL),
(497, 24, '2018-03-07 21:50:01', 'log', 'Logged in', NULL),
(498, 24, '2018-03-07 21:50:01', 'addUser', 'Added user: Grubat', NULL),
(499, 25, '2018-03-07 22:15:45', 'log', 'Logged in', NULL),
(500, 25, '2018-03-07 22:15:45', 'addUser', 'Added user: Quack', NULL),
(501, 25, '2018-03-07 22:15:45', 'log', 'Logged out', NULL),
(502, 26, '2018-03-07 22:15:45', 'log', 'Logged in', NULL),
(503, 26, '2018-03-07 22:51:15', 'log', 'Logged in', NULL),
(504, 26, '2018-03-07 22:52:20', 'log', 'Logged in', NULL),
(505, 26, '2018-03-07 22:52:20', 'log', 'Logged out', NULL),
(506, 25, '2018-03-07 23:12:45', 'log', 'Logged in', NULL),
(507, 25, '2018-03-07 23:12:45', 'addUser', 'Added user: Narsie', NULL),
(508, 25, '2018-03-07 23:12:45', 'log', 'Logged out', NULL),
(509, 27, '2018-03-07 23:12:45', 'log', 'Logged in', NULL),
(510, 27, '2018-03-07 23:21:52', 'log', 'Logged in', NULL),
(511, 27, '2018-03-07 23:21:52', 'initialAssessment', 'assessment for undefined', 42),
(512, 27, '2018-03-07 23:21:52', 'log', 'Logged out', NULL),
(513, 26, '2018-03-07 23:21:52', 'log', 'Logged in', NULL),
(514, 26, '2018-03-07 23:21:52', 'log', 'Logged out', NULL),
(515, 27, '2018-03-07 23:21:52', 'log', 'Logged in', NULL),
(516, 27, '2018-03-07 23:21:52', 'initialAssessment', 'assessment for undefined', 43),
(517, 27, '2018-03-07 23:21:52', 'log', 'Logged out', NULL),
(518, 26, '2018-03-07 23:21:52', 'log', 'Logged in', NULL),
(519, 26, '2018-03-07 23:21:52', 'log', 'Logged out', NULL),
(520, 27, '2018-03-07 23:21:52', 'log', 'Logged in', NULL),
(521, 27, '2018-03-07 23:21:52', 'initialAssessment', 'assessment for undefined', 48),
(522, 27, '2018-03-07 23:21:52', 'log', 'Logged out', NULL),
(523, 26, '2018-03-07 23:21:52', 'log', 'Logged in', NULL),
(524, 26, '2018-03-07 23:21:52', 'log', 'Logged out', NULL),
(525, 27, '2018-03-07 23:21:52', 'log', 'Logged in', NULL),
(526, 27, '2018-03-07 23:35:14', 'log', 'Logged in', NULL),
(527, 27, '2018-03-07 23:35:14', 'add', 'Added: authorized civilian - NYEEEEEEEEAM', NULL),
(528, 27, '2018-03-07 23:36:24', 'log', 'Logged in', NULL),
(529, 27, '2018-03-07 23:36:24', 'add', 'Added: civilian - monicuuuuuuuuuh', NULL),
(530, 27, '2018-03-07 23:36:24', 'add', 'Added: military dependent - racheeeeel', NULL),
(531, 27, '2018-03-07 23:36:24', 'add', 'Added: cadet - chandleeeeer', NULL),
(532, 27, '2018-03-07 23:36:24', 'add', 'Added: military officer - phoeeeeeeeeeeeebe', NULL),
(533, 27, '2018-03-07 23:36:24', 'log', 'Logged out', NULL),
(534, 26, '2018-03-07 23:36:24', 'log', 'Logged in', NULL),
(535, 26, '2018-03-07 23:36:24', 'log', 'Logged out', NULL),
(536, 27, '2018-03-07 23:36:24', 'log', 'Logged in', NULL),
(537, 27, '2018-03-07 23:36:24', 'add', 'Added: cadet - joeeeeeeeeey', NULL),
(538, 27, '2018-03-07 23:36:24', 'add', 'Added: military dependent - rrrrroooooooooooooossss', NULL),
(539, 27, '2018-03-07 23:36:24', 'add', 'Added: authorized civilian - teeeeeeeeeeed', NULL),
(540, 27, '2018-03-08 00:17:17', 'log', 'Logged in', NULL),
(541, 26, '2018-03-08 00:18:25', 'log', 'Logged in', NULL),
(542, 26, '2018-03-08 00:18:25', 'log', 'Logged out', NULL),
(543, 25, '2018-03-08 00:18:25', 'log', 'Logged in', NULL),
(544, 27, '2018-03-08 00:25:54', 'log', 'Logged in', NULL),
(545, 27, '2018-03-08 00:25:54', 'todo', 'Added to To Do List the following: General meeting at Lim Hall', NULL),
(546, 27, '2018-03-08 00:30:06', 'log', 'Logged in', NULL),
(547, 27, '2018-03-08 10:34:12', 'log', 'Logged in', NULL),
(548, 26, '2018-03-08 11:00:55', 'log', 'Logged in', NULL),
(549, 26, '2018-03-08 11:00:55', 'log', 'Logged out', NULL),
(550, 27, '2018-03-08 11:00:55', 'log', 'Logged in', NULL),
(551, 27, '2018-03-08 11:00:55', 'initialAssessment', 'assessment for undefined', 46),
(552, 27, '2018-03-08 11:00:55', 'log', 'Logged out', NULL),
(553, 25, '2018-03-08 11:00:55', 'log', 'Logged in', NULL),
(554, 25, '2018-03-08 11:00:55', 'log', 'Logged out', NULL),
(555, 27, '2018-03-08 11:00:55', 'log', 'Logged in', NULL),
(556, 27, '2018-03-08 11:00:55', 'log', 'Logged out', NULL),
(557, 25, '2018-03-08 11:00:55', 'log', 'Logged in', NULL),
(558, 25, '2018-03-08 11:00:55', 'settingsProfileManagement', 'Edited personal info.', NULL),
(559, 25, '2018-03-08 11:00:55', 'log', 'Logged out', NULL),
(560, 26, '2018-03-08 11:00:55', 'log', 'Logged in', NULL),
(561, 26, '2018-03-08 11:00:55', 'settingsProfileManagement', 'Edited personal info.', NULL),
(562, 26, '2018-03-08 11:00:55', 'log', 'Logged out', NULL),
(563, 25, '2018-03-08 11:00:55', 'log', 'Logged in', NULL),
(564, 25, '2018-03-08 11:00:55', 'log', 'Logged out', NULL),
(565, 27, '2018-03-11 13:23:20', 'log', 'Logged in', NULL),
(566, 27, '2018-03-11 13:34:17', 'log', 'Logged in', NULL),
(567, 27, '2018-03-11 13:34:17', 'add', 'Added: civilian - magellaaaaaaaaaaaaaaaan', NULL),
(568, 27, '2018-03-11 13:34:17', 'log', 'Logged out', NULL),
(569, 25, '2018-03-11 13:34:17', 'log', 'Logged in', NULL),
(570, 25, '2018-03-11 13:34:17', 'settingsProfileManagement', 'Edited personal info.', NULL),
(571, 25, '2018-03-11 13:34:17', 'settingsProfileManagement', 'Edited personal info.', NULL),
(572, 25, '2018-03-11 13:34:17', 'settingsProfileManagement', 'Edited personal info.', NULL),
(573, 25, '2018-03-11 13:34:17', 'log', 'Logged out', NULL),
(574, 27, '2018-03-11 13:34:17', 'log', 'Logged in', NULL),
(575, 27, '2018-03-11 13:54:17', 'log', 'Logged in', NULL),
(576, 27, '2018-03-11 13:54:17', 'log', 'Logged out', NULL),
(577, 27, '2018-03-11 13:58:16', 'log', 'Logged in', NULL),
(578, 27, '2018-03-11 13:58:16', 'add', 'Added: military officer - lowkey', NULL),
(579, 27, '2018-03-11 13:58:16', 'log', 'Logged out', NULL),
(580, 27, '2018-03-11 14:11:14', 'log', 'Logged in', NULL),
(581, 27, '2018-03-11 14:11:14', 'log', 'Logged out', NULL),
(582, 27, '2018-03-11 14:11:14', 'log', 'Logged in', NULL),
(583, 27, '2018-03-11 14:11:14', 'add', 'Added: cadet - wewe', NULL),
(584, 27, '2018-03-11 14:11:14', 'add', 'Added: authorized civilian - HUEHUE', NULL),
(585, 27, '2018-03-11 14:11:14', 'add', 'Added: authorized civilian - NINE', NULL),
(586, 27, '2018-03-11 14:11:14', 'add', 'Added: cadet - EIGHTjnb hjb', NULL),
(587, 27, '2018-03-11 14:11:14', 'add', 'Added: military dependent - SIBIN', NULL),
(588, 27, '2018-03-11 14:11:14', 'add', 'Added: military dependent - nyameten', NULL),
(589, 27, '2018-03-11 14:11:14', 'add', 'Added: authorized civilian - queuqeuuequeuqeuqqe', NULL),
(590, 27, '2018-03-11 14:11:14', 'log', 'Logged out', NULL),
(591, 25, '2018-03-11 14:11:14', 'log', 'Logged in', NULL),
(592, 25, '2018-03-11 14:11:14', 'settingsProfileManagement', 'Edited personal info.', NULL),
(593, 25, '2018-03-11 14:11:14', 'log', 'Logged out', NULL),
(594, 27, '2018-03-11 14:11:14', 'log', 'Logged in', NULL),
(595, 27, '2018-03-11 16:15:23', 'log', 'Logged in', NULL),
(596, 27, '2018-03-11 16:17:17', 'log', 'Logged in', NULL),
(597, 27, '2018-03-11 16:17:17', 'add', 'Added: authorized civilian - tope', NULL),
(598, 27, '2018-03-11 16:17:17', 'add', 'Added: authorized civilian - nyets', NULL),
(599, 27, '2018-03-11 16:43:33', 'log', 'Logged in', NULL),
(600, 27, '2018-03-11 16:44:31', 'log', 'Logged in', NULL),
(601, 27, '2018-03-11 16:44:31', 'add', 'Added: authorized civilian - wewewewewe', NULL),
(602, 27, '2018-03-11 16:51:14', 'log', 'Logged in', NULL),
(603, 27, '2018-03-11 16:51:14', 'add', 'Added: authorized civilian - kope', NULL),
(604, 27, '2018-03-11 16:51:14', 'log', 'Logged in', NULL),
(605, 27, '2018-03-11 16:51:14', 'log', 'Logged in', NULL),
(606, 27, '2018-03-11 16:51:14', 'log', 'Logged in', NULL),
(607, 27, '2018-03-11 16:51:14', 'log', 'Logged in', NULL),
(608, 27, '2018-03-11 16:51:14', 'log', 'Logged out', NULL),
(609, 25, '2018-03-11 16:51:14', 'log', 'Logged in', NULL),
(610, 25, '2018-03-11 16:51:14', 'settingsProfileManagement', 'Edited personal info.', NULL),
(611, 25, '2018-03-11 16:51:14', 'log', 'Logged out', NULL),
(612, 26, '2018-03-11 16:51:14', 'log', 'Logged in', NULL),
(613, 26, '2018-03-11 16:51:14', 'log', 'Logged out', NULL),
(614, 27, '2018-03-11 23:27:14', 'log', 'Logged in', NULL),
(615, 27, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(616, 27, '2018-03-12 10:26:37', 'add', 'Added: military dependent - Jenmar R. Pogi', NULL),
(617, 27, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(618, 25, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(619, 25, '2018-03-12 10:26:37', 'settingsProfileManagement', 'Edited personal info.', NULL),
(620, 25, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(621, 25, '2018-03-12 10:26:37', 'settingsProfileManagement', 'Edited personal info.', NULL),
(622, 25, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(623, 25, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(624, 27, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(625, 27, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(626, 25, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(627, 25, '2018-03-12 10:26:37', 'settingsProfileManagement', 'Edited personal info.', NULL),
(628, 25, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(629, 27, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(630, 27, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(631, 27, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(632, 27, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(633, 25, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(634, 25, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(635, 27, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(636, 27, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(637, 25, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(638, 25, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(639, 27, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(640, 27, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(641, 27, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(642, 25, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(643, 25, '2018-03-12 10:26:37', 'settingsProfileManagement', 'Edited personal info.', NULL),
(644, 25, '2018-03-12 10:26:37', 'settingsProfileManagement', 'Edited personal info.', NULL),
(645, 25, '2018-03-12 10:26:37', 'settingsProfileManagement', 'Edited personal info.', NULL),
(646, 25, '2018-03-12 10:26:37', 'settingsProfileManagement', 'Edited personal info.', NULL),
(647, 25, '2018-03-12 10:26:37', 'settingsProfileManagement', 'Edited personal info.', NULL),
(648, 25, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(649, 27, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(650, 27, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(651, 26, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(652, 26, '2018-03-12 10:26:37', 'labRequest', 'Lab request for : Paul Je', NULL),
(653, 27, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(654, 26, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(655, 26, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(656, 27, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(657, 27, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(658, 26, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(659, 26, '2018-03-12 10:26:37', 'log', 'Logged out', NULL),
(660, 27, '2018-03-12 10:26:37', 'log', 'Logged in', NULL),
(661, 27, '2018-03-12 12:13:04', 'log', 'Logged in', NULL),
(662, 27, '2018-03-12 12:13:04', 'settingsProfileManagement', 'Edited personal info.', NULL),
(663, 27, '2018-03-12 12:13:04', 'log', 'Logged out', NULL),
(664, 26, '2018-03-12 12:13:04', 'log', 'Logged in', NULL),
(665, 26, '2018-03-12 12:13:04', 'log', 'Logged out', NULL),
(666, 27, '2018-03-12 12:13:04', 'log', 'Logged in', NULL),
(667, 27, '2018-03-12 12:13:04', 'initialAssessment', 'assessment for undefined', 44),
(668, 27, '2018-03-12 12:13:04', 'initialAssessment', 'assessment for undefined', 45),
(669, 27, '2018-03-12 12:13:04', 'log', 'Logged out', NULL),
(670, 26, '2018-03-12 12:13:04', 'log', 'Logged in', NULL),
(671, 26, '2018-03-12 12:13:04', 'log', 'Logged out', NULL),
(672, 27, '2018-03-12 12:13:04', 'log', 'Logged in', NULL),
(673, 27, '2018-03-12 12:13:04', 'settingsProfileManagement', 'Edited personal info.', NULL),
(674, 26, '2018-03-12 12:47:22', 'log', 'Logged in', NULL),
(675, 26, '2018-03-12 12:47:22', 'bed', 'Alloted bed number: 1 to patient:ma mon', 42),
(676, 26, '2018-03-12 12:47:22', 'log', 'Logged out', NULL),
(677, 27, '2018-03-12 12:47:22', 'log', 'Logged in', NULL),
(678, 27, '2018-03-12 12:47:22', 'log', 'Logged out', NULL),
(679, 26, '2018-03-12 12:47:22', 'log', 'Logged in', NULL),
(680, 25, '2018-03-12 14:06:50', 'log', 'Logged in', NULL),
(681, 25, '2018-03-12 14:06:50', 'log', 'Logged out', NULL),
(682, 27, '2018-03-12 14:06:50', 'log', 'Logged in', NULL),
(683, 27, '2018-03-12 14:06:50', 'log', 'Logged out', NULL),
(684, 26, '2018-03-12 14:06:50', 'log', 'Logged in', NULL),
(685, 26, '2018-03-12 14:38:22', 'log', 'Logged in', NULL),
(686, 26, '2018-03-12 14:56:01', 'log', 'Logged in', NULL),
(687, 26, '2018-03-12 14:38:22', 'log', 'Logged in', NULL),
(688, 26, '2018-03-12 14:38:22', 'bed', 'Alloted bed number: 2 to patient:Ikaw Na Nga', 45),
(689, 26, '2018-03-12 14:38:22', 'log', 'Logged out', NULL),
(690, 25, '2018-03-12 14:38:22', 'log', 'Logged in', NULL),
(691, 25, '2018-03-12 14:38:22', 'log', 'Logged out', NULL),
(692, 26, '2018-03-12 14:38:22', 'log', 'Logged in', NULL),
(693, 26, '2018-03-12 14:38:22', 'log', 'Logged out', NULL),
(694, 27, '2018-03-12 14:38:22', 'log', 'Logged in', NULL),
(695, 27, '2018-03-12 14:38:22', 'log', 'Logged out', NULL),
(696, 26, '2018-03-12 14:38:22', 'log', 'Logged in', NULL),
(697, 26, '2018-03-12 14:38:22', 'log', 'Logged out', NULL),
(698, 27, '2018-03-12 16:22:34', 'log', 'Logged in', NULL),
(699, 27, '2018-03-12 16:22:34', 'log', 'Logged out', NULL),
(700, 25, '2018-03-12 16:32:01', 'log', 'Logged in', NULL),
(701, 25, '2018-03-12 16:32:01', 'addUser', 'Added user: Joshua Laban', NULL),
(702, 25, '2018-03-12 16:32:01', 'removedUser', 'removed user: Joshua Laban', NULL),
(703, 25, '2018-03-12 16:32:01', 'addUser', 'Added user: Joshua N. Laban', NULL),
(704, 25, '2018-03-12 16:32:01', 'log', 'Logged out', NULL),
(705, 29, '2018-03-12 16:32:01', 'log', 'Logged in', NULL),
(706, 29, '2018-03-12 16:32:01', 'settingsProfileManagement', 'Edited personal info.', NULL),
(707, 29, '2018-03-12 16:32:01', 'settingsProfileManagement', 'Edited personal info.', NULL),
(708, 25, '2018-03-12 16:44:52', 'log', 'Logged in', NULL),
(709, 25, '2018-03-12 16:44:52', 'log', 'Logged out', NULL),
(710, 29, '2018-03-12 16:44:52', 'log', 'Logged in', NULL),
(711, 29, '2018-03-12 16:44:52', 'log', 'Logged out', NULL),
(712, 27, '2018-03-12 16:44:52', 'log', 'Logged in', NULL),
(713, 27, '2018-03-12 16:47:06', 'log', 'Logged in', NULL),
(714, 27, '2018-03-12 16:47:06', 'log', 'Logged out', NULL),
(715, 29, '2018-03-12 16:47:06', 'log', 'Logged in', NULL),
(716, 29, '2018-03-12 16:47:06', 'settingsProfileManagement', 'Edited personal info.', NULL),
(717, 29, '2018-03-12 16:47:06', 'confirmedLabRequest', 'Confirmed lab request for: Paul Je', NULL),
(718, 29, '2018-03-12 16:47:06', 'log', 'Logged out', NULL),
(719, 25, '2018-03-12 16:47:06', 'log', 'Logged in', NULL),
(720, 25, '2018-03-12 16:47:06', 'addUser', 'Added user: jennieboy', NULL),
(721, 25, '2018-03-12 16:47:06', 'log', 'Logged out', NULL),
(722, 30, '2018-03-12 16:47:06', 'log', 'Logged in', NULL),
(723, 30, '2018-03-12 16:47:06', 'log', 'Logged out', NULL),
(724, 30, '2018-03-12 16:47:06', 'log', 'Logged in', NULL),
(725, 30, '2018-03-12 17:26:43', 'log', 'Logged in', NULL),
(726, 30, '2018-03-12 17:26:43', 'log', 'Logged out', NULL),
(727, 29, '2018-03-12 17:26:43', 'log', 'Logged in', NULL),
(728, 29, '2018-03-12 17:35:28', 'log', 'Logged in', NULL),
(729, 27, '2018-03-12 17:39:08', 'log', 'Logged in', NULL),
(730, 27, '2018-03-12 17:39:08', 'todo', 'Added to To Do List the following: sadhbuihbnfasiukbnsfcauhb', NULL),
(731, 27, '2018-03-12 17:39:08', 'todo', 'Added to To Do List the following: huehuiyehgaueghbuyhbe', NULL),
(732, 27, '2018-03-12 17:42:53', 'delTodo', 'Deleted data from todo List', NULL),
(733, 27, '2018-03-12 17:49:18', 'log', 'Logged in', NULL),
(734, 27, '2018-03-12 17:49:18', 'log', 'Logged out', NULL),
(735, 27, '2018-03-12 17:49:18', 'log', 'Logged in', NULL),
(736, 27, '2018-03-12 17:49:18', 'log', 'Logged out', NULL),
(737, 29, '2018-03-12 17:49:18', 'log', 'Logged in', NULL),
(738, 29, '2018-03-12 17:49:18', 'log', 'Logged out', NULL),
(739, 26, '2018-03-12 17:49:18', 'log', 'Logged in', NULL),
(740, 26, '2018-03-12 17:49:18', 'labRequest', 'Lab request for : ma mon', NULL),
(741, 26, '2018-03-12 17:49:18', 'log', 'Logged out', NULL),
(742, 29, '2018-03-12 17:49:18', 'log', 'Logged in', NULL),
(743, 29, '2018-03-12 17:49:18', 'log', 'Logged out', NULL),
(744, 25, '2018-03-12 18:09:35', 'log', 'Logged in', NULL),
(745, 25, '2018-03-12 18:22:57', 'log', 'Logged in', NULL),
(746, 25, '2018-03-12 18:24:27', 'log', 'Logged in', NULL),
(747, 25, '2018-03-12 18:30:54', 'log', 'Logged in', NULL),
(748, 27, '2018-03-12 18:39:18', 'log', 'Logged in', NULL),
(749, 27, '2018-03-12 18:39:18', 'log', 'Logged out', NULL),
(750, 25, '2018-03-12 18:39:18', 'log', 'Logged in', NULL),
(751, 25, '2018-03-12 18:45:34', 'log', 'Logged in', NULL),
(752, 25, '2018-03-12 18:47:48', 'log', 'Logged in', NULL),
(753, 25, '2018-03-12 18:49:41', 'log', 'Logged in', NULL),
(754, 27, '2018-03-12 18:56:36', 'log', 'Logged in', NULL),
(755, 27, '2018-03-12 18:56:36', 'log', 'Logged out', NULL),
(756, 25, '2018-03-12 18:56:36', 'log', 'Logged in', NULL),
(757, 27, '2018-03-12 18:59:14', 'log', 'Logged in', NULL),
(758, 27, '2018-03-12 18:59:14', 'log', 'Logged out', NULL),
(759, 25, '2018-03-12 18:59:14', 'log', 'Logged in', NULL),
(760, 25, '2018-03-12 19:00:51', 'log', 'Logged in', NULL),
(761, 25, '2018-03-12 19:03:57', 'log', 'Logged in', NULL),
(762, 25, '2018-03-12 19:09:50', 'log', 'Logged in', NULL),
(763, 25, '2018-03-12 19:11:06', 'log', 'Logged in', NULL),
(764, 25, '2018-03-12 19:13:17', 'log', 'Logged in', NULL),
(765, 25, '2018-03-12 19:13:17', 'addUser', 'Added user: qwe', NULL),
(766, 25, '2018-03-12 19:15:31', 'log', 'Logged in', NULL),
(767, 25, '2018-03-12 19:15:31', 'addUser', 'Added user: qweqwe', NULL),
(768, 27, '2018-03-12 19:22:57', 'log', 'Logged in', NULL),
(769, 27, '2018-03-12 19:28:06', 'log', 'Logged in', NULL),
(770, 27, '2018-03-12 19:29:23', 'log', 'Logged in', NULL),
(771, 27, '2018-03-12 19:30:44', 'log', 'Logged in', NULL);
INSERT INTO `activity_logs` (`logs_id`, `account_id`, `time`, `type`, `remarks`, `patient_id`) VALUES
(772, 27, '2018-03-12 19:32:33', 'log', 'Logged in', NULL),
(773, 27, '2018-03-12 19:34:16', 'log', 'Logged in', NULL),
(774, 27, '2018-03-12 19:34:16', 'generalTodo', 'Added to To Do List the following: asdxzc', NULL),
(775, 27, '2018-03-12 19:35:31', 'log', 'Logged in', NULL),
(776, 27, '2018-03-12 19:36:23', 'log', 'Logged in', NULL),
(777, 27, '2018-03-12 19:36:23', 'generalTodo', 'Todo added general: xczxase', NULL),
(778, 27, '2018-03-12 19:36:23', 'log', 'Logged out', NULL),
(779, 27, '2018-03-12 19:36:23', 'log', 'Logged in', NULL),
(780, 27, '2018-03-12 19:36:23', 'generalTodo', 'Todo added general: asdxzc', NULL),
(781, 27, '2018-03-12 19:46:43', 'log', 'Logged in', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admit`
--

DROP TABLE IF EXISTS `admit`;
CREATE TABLE IF NOT EXISTS `admit` (
  `patient_id` int(11) NOT NULL,
  `department` varchar(12) NOT NULL,
  UNIQUE KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
CREATE TABLE IF NOT EXISTS `announcement` (
  `announcement_id` int(11) NOT NULL AUTO_INCREMENT,
  `announcement_title` text NOT NULL,
  `announcement` text NOT NULL,
  `timestamp` timestamp NOT NULL,
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `announcement`
--

INSERT INTO `announcement` (`announcement_id`, `announcement_title`, `announcement`, `timestamp`) VALUES
(1, 'Greetings !!', 'Good Morning Everyone !!', '2017-11-29 19:23:59');

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointment_id`, `appointment_timestamp`, `doctor_id`, `patient_id`, `remarks`) VALUES
(5, '2018-02-08 07:00:00', 4, 42, 'asczxcqweasd'),
(6, '2018-02-08 08:02:00', 4, 42, 'asczxczxcasdqwe'),
(7, '2018-03-24 05:00:00', 4, 42, 'zxcadasdzxc'),
(8, '2018-01-31 17:00:00', 4, 42, 'zxcasd');

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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bed`
--

INSERT INTO `bed` (`bed_id`, `status`, `allotment_timestamp`, `description`, `patient_id`) VALUES
(1, 'occupied', '2018-03-12 12:47:22', NULL, 42),
(2, 'occupied', '2018-03-12 14:38:22', NULL, 45),
(3, 'Unoccupied', NULL, NULL, NULL),
(4, 'Unoccupied', NULL, NULL, NULL),
(5, 'occupied', '2018-02-23 05:07:12', NULL, 46),
(6, 'occupied', '2018-02-23 17:36:44', NULL, 48),
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
(25, 'occupied', '2018-02-26 12:23:55', NULL, 47),
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
-- Table structure for table `billing_transactions`
--

DROP TABLE IF EXISTS `billing_transactions`;
CREATE TABLE IF NOT EXISTS `billing_transactions` (
  `receipt_no` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `accountant_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `medicine_name` varchar(30) NOT NULL,
  PRIMARY KEY (`receipt_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `billing_transactions`
--

INSERT INTO `billing_transactions` (`receipt_no`, `amount`, `accountant_id`, `patient_id`, `medicine_name`) VALUES
(1, 49.99, 1, 1, 'Paracetamol');

-- --------------------------------------------------------

--
-- Table structure for table `daily_consumption_report`
--

DROP TABLE IF EXISTS `daily_consumption_report`;
CREATE TABLE IF NOT EXISTS `daily_consumption_report` (
  `dcr_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `medicine_id` int(11) NOT NULL,
  `medicine_quantity` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `pharmacist_id` int(11) NOT NULL,
  PRIMARY KEY (`dcr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `daily_consumption_report`
--

INSERT INTO `daily_consumption_report` (`dcr_id`, `date`, `medicine_id`, `medicine_quantity`, `patient_id`, `pharmacist_id`) VALUES
(1, '2017-11-30', 1, 5, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `dep_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(12) NOT NULL,
  PRIMARY KEY (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dep_id`, `name`) VALUES
(1, 'OPD'),
(2, 'ER'),
(3, 'Ward');

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
-- Table structure for table `hospital_equipment`
--

DROP TABLE IF EXISTS `hospital_equipment`;
CREATE TABLE IF NOT EXISTS `hospital_equipment` (
  `equipment_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `category` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `price` double NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`equipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hospital_equipment`
--

INSERT INTO `hospital_equipment` (`equipment_id`, `name`, `category`, `description`, `price`, `quantity`) VALUES
(1, 'ballpen', 'tools', 'This pen is a pen !!', 20, 5);

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
-- Table structure for table `initial_assessment`
--

DROP TABLE IF EXISTS `initial_assessment`;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `initial_assessment`
--

INSERT INTO `initial_assessment` (`assessment_id`, `assessment`, `date`, `patient_id`, `account_id`, `vital_signs`) VALUES
(12, 'gyuhjkvhn', '2018-03-07 23:21:52', 42, 26, 'BP: 890\nCR: 67\nPR: 678\nRR: 6\n TEMP: 6786\nWT: 786'),
(13, '78', '2018-03-07 23:21:52', 43, 26, 'BP: 7987\nCR: 78\nPR: y89\nRR: 7987\n TEMP: 8u\nWT: i8'),
(14, '7guy', '2018-03-07 23:21:52', 48, 26, 'BP: 8797\nCR: 897\nPR: 897\nRR: 98\n TEMP: 798\nWT: 789'),
(15, '', '2018-03-08 11:00:55', 46, 26, 'BP: 120/75\nCR: 215\nPR: 21/45\nRR: 564\n TEMP: 47\nWT: 99'),
(16, '1', '2018-03-12 12:13:04', 44, 26, 'BP: 120/90\nCR: 1\nPR: 1\nRR: 1\n TEMP: 1\nWT: 1'),
(17, '2', '2018-03-12 12:13:04', 45, 26, 'BP: 120/90\nCR: 2\nPR: 2\nRR: 2\n TEMP: 2\nWT: 2');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lab_request`
--

INSERT INTO `lab_request` (`request_id`, `type`, `timestamp`, `remarks`, `doctor_id`, `patient_id`, `lab_status`) VALUES
(1, 'serotology', '2018-03-12 02:26:37', 'sdbgsfdgs', 26, 46, 'confirmed'),
(2, 'bloodChemistry', '2018-03-12 09:49:18', 'Need % of while blood cells and glucose', 26, 42, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

DROP TABLE IF EXISTS `medicine`;
CREATE TABLE IF NOT EXISTS `medicine` (
  `medicine_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `medicine_category_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `price` double NOT NULL,
  `manufacturing_company` varchar(30) NOT NULL,
  `medicine_quantity` int(11) NOT NULL,
  PRIMARY KEY (`medicine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`medicine_id`, `name`, `medicine_category_id`, `description`, `price`, `manufacturing_company`, `medicine_quantity`) VALUES
(1, 'solmux', 1, 'Vitamin C 500gm', 25, 'Generica', 50);

-- --------------------------------------------------------

--
-- Table structure for table `medicine_category`
--

DROP TABLE IF EXISTS `medicine_category`;
CREATE TABLE IF NOT EXISTS `medicine_category` (
  `medicine_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`medicine_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medicine_category`
--

INSERT INTO `medicine_category` (`medicine_category_id`, `name`, `description`) VALUES
(1, 'Allergy liquids', 'Allergic medicines'),
(2, 'Vitamins Tablets ', 'Vitamins tablets only');

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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `patient_type`, `name`, `age`, `unit`, `sex`, `status`, `birth_date`, `address`, `religion`, `blood_type`, `allergies`, `father`, `mother`, `birth_history`, `rankORsn`, `immunization`, `family_history`) VALUES
(42, 'cadet', 'ma mon', 202, '', 'M', 'Maried', '2018-01-04', '#123 asd', '', '', '', '\n:', '\n:', '', '456', '\n', '\n'),
(43, 'military officer', 'sampul sam', 202, '', 'M', 'Maried', '2018-01-04', '#789 qwe', '', '', '', '\n:', '\n:', '', '123', '\n', '\n'),
(44, 'military dependent', 'Pul sam', 38, '', 'F', 'Maried', '2018-01-05', 'asd', '', '', '', '\n:', '\n:', '', '678', '\n', '\n'),
(45, 'civilian', 'Ikaw Na Nga', 24, '', 'F', 'Maried', '2018-01-06', 'asdqwe', '', '', '', '\n:', '\n:', '', '657', '\n', '\n'),
(46, 'authorized civilian', 'Paul Je', 20, '', 'F', 'Single', '2018-01-20', 'zxc', '', '', '', '\n:', '\n:', '', '678', '\n', '\n'),
(47, 'civilian', 'rweewasqews', 19, '', 'M', 'Single', '2018-02-01', 'asdasda', '', '', '', '\n:', '\n:', '', 'wqedasd', 'Phenomia:\n\n', 'DM\n\n'),
(48, 'cadet', 'Mon Joel Dela Rosa', 21, '', 'M', 'Maried', '2018-01-31', 'asd', '', '', '', '\n:', '\n:', '', 'qwe', 'Meningcoccemia:2018-02\nPhenomia:\n\n', 'DM\nCVD\n\n'),
(49, 'military officer', 'asd', 14, '', 'M', 'Maried', '2018-01-30', 'asd', '', '', '', '\n:', '\n:', '', 'asd', 'Influenza:\n\n', 'CVD\n\n'),
(50, 'military officer', 'qwe', 20, '', 'M', 'Maried', '2018-02-09', 'asd', '', '', '', '\n:', '\n:', '', '', 'Influenza:\n\n', 'DM\n\n'),
(51, 'military officer', 'asdqweq', 25, '', 'M', 'Maried', '2018-02-13', 'asdasdqwe', '', '', '', '\n:', '\n:', '', '', 'Tetanus Toxoid:\n\n', 'DM\n\n'),
(52, 'military officer', 'zxcweqe', 29, '', 'M', 'Maried', '2018-02-01', 'asdazxc', '', '', '', '\n:', '\n:', '', '', 'Tyroid:\n\n', '\n\nCVD\n\n'),
(53, 'cadet', 'asdqwe', 15, '', 'M', 'Maried', '2018-02-08', 'asdqwe', '', '', '', '\n:', '\n:', '', '', '\n', '\n'),
(54, 'military officer', 'asdqwe', 17, '', 'M', 'Single', '2018-02-01', 'zxcasd', '', '', '', '\n:', '\n:', '', '', 'Phenomia:2018-02\n\n', 'DM\nCVD\n\n'),
(55, 'cadet', 'z', 2, '', 'M', 'Maried', '2018-02-01', 'a', '', '', '', '\n:', '\n:', '', '', '\n', '\n'),
(56, 'cadet', 'zxc', 20, '', 'M', 'Maried', '1997-12-19', 'qwe', '', '', '', '\n:', '\n:', '', '', '\n', '\n'),
(57, 'cadet', 'asd', 20, '', 'M', 'Maried', '1997-12-19', 'qwe', '', '', '', '\n:', '\n:', '', '', '\n', '\n'),
(58, 'cadet', 'asd', 20, '', 'M', 'Maried', '1997-12-19', 'asd', '', '', '', '\n:', '\n:', '', '', '\n', '\n'),
(59, 'cadet', 'Testing patient management', 20, '', 'M', 'Maried', '1997-12-01', 'asdqwe', '', '', '', '\n:', '\n:', '', '', '\n', '\n'),
(60, 'cadet', 'testing p2', 0, '', 'M', 'Maried', '2018-02-03', 'asd', '', 'A', '', '\n:', '\n:', '', '', 'DFT:2018-03\n\n', 'DM\nCVD\n\n'),
(61, 'authorized civilian', 'NYEEEEEEEEAM', 0, 'ghyjb ', 'F', 'Single', '2018-03-02', 'jhb', 'hjb', 'B', 'bhj', 'hjb\n:hj', 'bhj\n:bhj', 'bh', '5634789', 'Influenza:2018-03\n\n', 'Mental Illness\n\n'),
(62, 'civilian', 'monicuuuuuuuuuh', 0, 'ghyjbhj', 'F', 'Single', '2018-03-06', 'b', 'hjb', 'AB', 'bhj', 'hjb\n:jhb', 'jhbjh\n:bjh', 'bhj', '456', 'Hepatitis B:2018-03\n\n', 'Asthma\n\n'),
(63, 'military dependent', 'racheeeeel', -1, 'gbyhj', 'F', 'Single', '2018-12-31', 'bjh', 'b gh', 'A', 'bhj', 'vgh\n:vbhj', 'bjh\n:bhj', 'bh', '678', 'DFT:2018-12\n\n', 'DM\n\n'),
(64, 'cadet', 'chandleeeeer', 0, 'bhj', 'M', 'Maried', '2018-02-28', 'b hj', 'bhj', 'AB', 'bhj', 'bhj\n:bjh', 'bhj\n:bhj', 'b', '345', 'Phenomia:2018-03\n\n', 'CVD\n\n'),
(65, 'military officer', 'phoeeeeeeeeeeeebe', -1, 'hjbb', 'F', 'Single', '2018-12-31', 'hj', 'bhj', 'A', 'bjh', 'bhj\n:bhj', 'bjh\n:bh', 'bjh', '435', 'DFT:2018-12\n\n', 'CVD\n\n'),
(66, 'cadet', 'joeeeeeeeeey', -1, 'bhjk', 'F', 'Maried', '2018-12-31', 'hjvb', 'vbhjvb ', 'A', 'vhjgvb', 'ghv\n:ghv', 'g\n:vg', 'vgh', '34', 'DFT:2018-12\n\n', 'DM\n\n'),
(67, 'military dependent', 'rrrrroooooooooooooossss', -1, 'hnkj', 'M', 'Maried', '2018-12-31', 'bv jh', 'hgjvbn', 'A', 'bjh', 'vbjh\n:vh', 'v\n:hgv', 'vbhj', '7', 'Polio:2018-12\n\n', 'CVD\n\n'),
(68, 'authorized civilian', 'teeeeeeeeeeed', 0, 'hnjkn', 'M', 'Single', '2018-02-27', 'jhb', 'ihujkbn', 'B', 'bbh', 'hjb\n:hj', 'bjh\n:bjh', 'bhj', '789', 'Measles:2018-12\n\n', 'CA\n\n'),
(69, 'civilian', 'magellaaaaaaaaaaaaaaaan', -1, '', 'M', 'Single', '2018-12-31', 'hjvhgv', 'dnsjkvbnhjdsbv', 'A', 'hjbhj', 'hbv\n:hjb', 'hv\n:hgv', 'hvb', '90787789', 'HIB:2018-03\n\n', 'Mental Illness\n\n'),
(70, 'military officer', 'lowkey', -1, 'gj', 'M', 'Single', '2018-12-31', 'bjhb', 'jhb', 'B', 'bhj', 'hjb\n:hjvb', 'hjb\n:vhj', 'bhj', '78998', 'DFT:2018-12\n\n', 'DM\n\n'),
(71, 'cadet', 'wewe', -1, 'bhj', 'F', 'Single', '2018-12-31', 'bhnmb h', 'vgtyyhjvnb', 'B', 'bj', 'jbhj\n:bj', 'bgjh\n:bjh', 'bhj', 'bhmb hj', 'Rabies:2018-03\n\n', 'DM\n\n'),
(72, 'authorized civilian', 'HUEHUE', -1, 'hjbn', 'F', 'Single', '2018-12-31', 'huhjbhjvbg', 'bhjdsvnkc', 'A', 'vhjv', 'vg\n:vghv', 'hg\n:vhg', 'vghv', '6786y789', 'DFT:2017-12\n\n', 'DM\n\n'),
(73, 'authorized civilian', 'NINE', -1, 'bhjb', 'F', 'Maried', '2018-12-31', 'jhb hjbhj', 'djiknksvm', 'B', 'vc ghvghgvh', 'bhj\n:bhjb', 'hjb\n:jh', 'bvghjjvb hvbhgvghvbghjvghjgvhg', '6789', 'DFT:2018-12\n\n', 'DM\n\n'),
(74, 'cadet', 'EIGHTjnb hjb', -1, 'bhj', 'M', 'Single', '2018-12-01', 'bhjbjhm', 'dbhskj', 'B', 'bhjb', 'bhj\n:bjh', 'bj\n:bhj', 'bjh', 'hjbhj', 'Polio:2018-12\n\n', 'DM\n\n'),
(75, 'military dependent', 'SIBIN', -1, 'bhjb', 'M', 'Single', '2018-12-31', 'gvhbnm', 'fdbns', 'B', 'vgbhnv', 'vhbjn \n:b hjn', 'vb \n:hjbn', 'vhjbn ', 'jukjb', 'Polio:2018-01\n\n', 'CVD\n\n'),
(76, 'military dependent', 'nyameten', -1, '', 'F', 'Single', '2018-12-01', 'bhj', 'dsbhj', 'A', 'bhj', 'b hmb\n:hjb', 'hjb\n:hjb', 'hj', '', 'DFT:2018-12\n\n', 'DM\n\n'),
(77, 'authorized civilian', 'queuqeuuequeuqeuqqe', 0, '', 'M', 'Single', '2018-01-01', 'ghbjnm', 'njkdsv', 'B', 'bhj', 'bhj\n:bhj', 'bhjb\n:hj', 'bhj', '', 'Measles:2018-12\n\n', 'CVD\n\n'),
(78, 'authorized civilian', 'tope', 0, '', 'M', 'Single', '2018-02-01', 'jhbn ', 'bsdjkv', 'A', 'hjb', 'vhj\n:vbhj', 'gj\n:ghj', 'b', '', 'Polio:2018-12\n\n', 'CA\n\n'),
(79, 'authorized civilian', 'nyets', 0, '', 'M', 'Single', '2018-03-01', 'vhjbjh', 'nhfdjkbg', 'B', 'vbhj', 'bhjb\n:hj', 'bhjb\n:h', 'bhj', '', 'Measles:2018-12\n\n', 'CVD\n\n'),
(80, 'authorized civilian', 'wewewewewe', 0, '', 'M', 'Single', '2018-02-01', 'bhjbjk', 'vghj', 'B', 'bhj', 'bhj\n:bhj', 'bhj\n:bhj', 'bhj', '', 'DFT:2018-12\n\n', 'DM\n\n'),
(81, 'authorized civilian', 'kope', 0, '', 'M', 'Single', '2018-01-01', 'bhjnbhj', 'djkvb', 'B', 'bhj', 'bhj\n:bhj', 'bhj\n:bhj', 'bhj', '', 'DFT:2018-12\n\n', 'DM\n\n'),
(82, 'military dependent', 'Jenmar R. Pogi', 0, '', 'M', 'Single', '2018-03-01', 'bghbghv', 'ghvbhjgvyt', 'A', 'bvghj', 'ghv\n:ghvgh', 'vgh\n:vgh', 'ghvghv', '', 'DFT:2018-12\n\n', 'DM\n\n');

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
CREATE TABLE IF NOT EXISTS `report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_type` text NOT NULL COMMENT 'operation,birth,death',
  `description` text NOT NULL,
  `timestamp` timestamp NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`report_id`, `report_type`, `description`, `timestamp`, `doctor_id`, `patient_id`) VALUES
(1, 'birth', 'Normal blah blah Birth', '2017-11-21 16:00:00', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `supply_sergeant`
--

DROP TABLE IF EXISTS `supply_sergeant`;
CREATE TABLE IF NOT EXISTS `supply_sergeant` (
  `ss_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(10) NOT NULL,
  PRIMARY KEY (`ss_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supply_sergeant`
--

INSERT INTO `supply_sergeant` (`ss_id`, `name`, `username`, `password`, `address`, `phone`) VALUES
(1, 'Supply Sergeant', 'supplysergeant123', 'supplysergeant', '#456 upper baguio city', '9178623872');

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `todo_list`
--

INSERT INTO `todo_list` (`todo_id`, `status`, `description`, `date`, `account_id`) VALUES
(13, 'urgent', 'General meeting at Lim Hall', '2018-03-08 10:00:00', 27),
(15, 'general', 'huehuiyehgaueghbuyhbe', '2018-12-31 12:59:00', 27),
(16, 'general', 'asdxzc', '2018-03-01 01:02:00', 27),
(17, 'general', 'xczxase', '2007-01-02 15:02:00', 27),
(18, 'general', 'asdxzc', '2018-03-17 14:01:00', 27);

-- --------------------------------------------------------

--
-- Table structure for table `treatment`
--

DROP TABLE IF EXISTS `treatment`;
CREATE TABLE IF NOT EXISTS `treatment` (
  `treatment_id` int(11) NOT NULL AUTO_INCREMENT,
  `treatment_name` varchar(30) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`treatment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `treatment`
--

INSERT INTO `treatment` (`treatment_id`, `treatment_name`, `description`) VALUES
(1, 'Treatment #1 (IDK)', 'This treatment is a treatment !!');

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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_accounts`
--

INSERT INTO `user_accounts` (`account_id`, `username`, `password`, `account_type`, `name`, `age`, `sex`, `address`, `phone`) VALUES
(25, 'admin', '$2a$10$0dfj2ecTqv12hAruqj/pE.wlY/eyeIRszgub3r0K3GVjlrfEZdbAS', 'admin', 'Grubat', 28, 'M', 'PMA baguio', '9718236712'),
(26, 'doctor', '$2a$10$UrYF/CWYC9cycpjWLbUYc.J7l9KUq4u7SPsD93o9zbcrkgTB48ZoS', 'doctor', 'Mr. Quickie', 20, 'M', 'lower liwanag loakan.', '9182763517'),
(27, 'nurse', '$2a$10$lz1mxLO4SAp8zei.I5OZieyooGGOYnJTfTZL.Rv9l1lerOjxhVVB.', 'nurse', 'narshieeeee', 20, 'F', 'camp 7, Bakakeng Global City', '917825314'),
(29, 'lab', '$2a$10$awjy102z3vACI1RdzIID0u2P6gIkRRIcNyfCwV2fzXJ0SPNtkr93a', 'laboratorist', 'Joshua N. Laban', 28, 'M', 'Leonila Hill Baguio City', '9087821365'),
(30, 'pharm', '$2a$10$Z7yWUGCqgsruNYfjZWW95e.cQ/VvvUAWtDZ0Hh1LLZOVft6VgfoJm', 'pharmacist', 'jennieboy', 0, 'M', 'dsnjkgbsfdhbfs', '09234562311'),
(31, 'qweasd', '$2a$10$NJ0tGO0R2sLfs1aYCqcOhOCUSEj2bZ0f8h7ZVYXkcPIMCHgOhMCRe', 'admin', 'qwe', 15, 'M', 'asldkasjdaddress', '9123781263'),
(32, 'asd,mnzxchj', '$2a$10$GNkoRF6Ht0X8XDv2l..pt.R4USsxRY2p6wmRiF2KNjLn9A28c53/W', 'nurse', 'qweqwe', 0, 'M', 'asjdhcxihc', '9087821362');

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
