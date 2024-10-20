-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 20, 2024 at 10:45 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `client_file_management_system`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckUser` (IN `p_email` VARCHAR(100), IN `p_password` VARCHAR(255))   BEGIN
    DECLARE user_count INT;

    SELECT COUNT(*) INTO user_count
    FROM users
    WHERE email = p_email AND password = SHA2(p_password, 256);

    IF user_count > 0 THEN
        SELECT 'User found' AS message;
    ELSE
        SELECT 'User not found' AS message;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertUser` (IN `p_fullname` VARCHAR(100), IN `p_email` VARCHAR(100), IN `p_phone` VARCHAR(15), IN `p_address` VARCHAR(255), IN `p_password` VARCHAR(255))   BEGIN
    -- Insert user data and set status to 'client'
    INSERT INTO users (fullname, email, phonenumber, address, password, status)
    VALUES (p_fullname, p_email, p_phone, p_address, p_password, 'client');

    -- Return a success message
    SELECT 'User inserted successfully!' AS message;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phonenumber` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `phonenumber`, `address`, `status`, `password`) VALUES
(1, 'Dan Kibwika', 'dankibwika821@gmail.com', '0816486416', 'Namibia, Windheok, Khomas', '', '$2y$10$1qAStNUlASd6YhJKb68FoO9YYhUQJ1Ml3y.xMRcg2Ivs.BCf/lUP6');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
