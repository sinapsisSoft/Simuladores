-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 10.1.2.127:3306
-- Tiempo de generación: 29-06-2019 a las 23:21:28
-- Versión del servidor: 10.2.24-MariaDB
-- Versión de PHP: 7.2.18
-- Autor: Laura Grisales

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `u645747626_sm`
--
CREATE DATABASE IF NOT EXISTS `u645747626_sm` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `u645747626_sm`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `sp_cond_insert`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_cond_insert` (IN `initial` INT, IN `final` INT, IN `percent` DECIMAL(4,2), IN `Simul` INT)  BEGIN 
INSERT INTO conditions(Cond_initial, Cond_final, Cond_percent, Sim_id) VALUES (initial,final,percent,Simul); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_cond_select_all`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_cond_select_all` ()  BEGIN 
SELECT Cond_id, Cond_initial, Cond_final, Cond_percent, Sim_id FROM conditions;
END$$

DROP PROCEDURE IF EXISTS `sp_cond_select_simu`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_cond_select_simu` (IN `simul` INT)  BEGIN 
SELECT Cond_id, Cond_initial, Cond_final, Cond_percent, Sim_id FROM conditions WHERE Sim_id = simul;
END$$

DROP PROCEDURE IF EXISTS `sp_cond_update`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_cond_update` (IN `id` INT, IN `initial` INT, IN `final` INT, IN `percent` DECIMAL(4,2), IN `simul` INT)  BEGIN 
UPDATE conditions SET Cond_initial=initial,Cond_final=final,Cond_percent=percent,Sim_id=simul WHERE Cond_id = id;
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_depart_insert`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_depart_insert` (IN `name` VARCHAR(100))  BEGIN 
INSERT INTO department(Dep_name) VALUES (name); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_depart_select_all`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_depart_select_all` ()  BEGIN 
SELECT Dep_id, Dep_name FROM department;
END$$

DROP PROCEDURE IF EXISTS `sp_depart_select_one`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_depart_select_one` (IN `id` INT)  BEGIN 
SELECT Dep_id, Dep_name FROM department WHERE Dep_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_depart_update`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_depart_update` (IN `id` INT, IN `name` VARCHAR(100))  BEGIN 
UPDATE department SET Dep_name=name WHERE Dep_id = id;
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_entry_insert`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_entry_insert` (IN `login` INT, IN `status` INT)  BEGIN 
INSERT INTO entry(Login_id, Stat_id) VALUES (login,status); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_entry_select_all`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_entry_select_all` ()  BEGIN 
SELECT Ent_id, Login_id, Stat_id FROM entry;
END$$

DROP PROCEDURE IF EXISTS `sp_entry_select_login`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_entry_select_login` (IN `login` INT)  BEGIN 
SELECT Ent_id, Login_id, Stat_id FROM entry WHERE Login_id = login;
END$$

DROP PROCEDURE IF EXISTS `sp_entry_select_status`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_entry_select_status` (IN `status` INT)  BEGIN 
SELECT Ent_id, Login_id, Stat_id FROM entry WHERE Stat_id = status;
END$$

DROP PROCEDURE IF EXISTS `sp_entry_update`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_entry_update` (IN `id` INT, IN `login` INT, IN `status` INT)  BEGIN 
UPDATE entry SET Login_id=login, Stat_id=status WHERE Ent_id = id;
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_login`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_login` (IN `email` VARCHAR(200), IN `pass` VARCHAR(30))  BEGIN 
SET @mail = '';
SET @password = '';
#Verify if the email exists
SET @mail = (SELECT COUNT(u.User_email) FROM users u WHERE u.User_email LIKE email);
#Search the password that corresponds to the email
IF @mail > 0 THEN
	SET @password =(SELECT L.Login_password FROM login L 
	INNER JOIN users U ON u.User_id = l.User_id
	WHERE U.User_email like email); 
    #Verify if the password is correct
    IF @password LIKE pass THEN
    	SELECT U.User_id, U.User_name, U.User_email FROM users U 
		INNER JOIN login L ON U.User_id = L.User_id
		WHERE L.Login_password LIKE pass AND U.User_email like email;
    END IF;
END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_login_insert`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_login_insert` (IN `pass` VARCHAR(30), IN `user` INT)  BEGIN 
INSERT INTO login(Login_password, User_id) VALUES (pass,user);
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_login_select_all`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_login_select_all` ()  BEGIN 
SELECT Login_id, Login_password, User_id FROM login;
END$$

DROP PROCEDURE IF EXISTS `sp_login_select_one`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_login_select_one` (IN `id` INT)  BEGIN 
SELECT Login_id, Login_password, User_id FROM login WHERE Login_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_login_update`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_login_update` (IN `mail` VARCHAR(200), IN `pass` VARCHAR(30))  BEGIN 
SET @user_id = (SELECT User_id FROM users WHERE User_email LIKE mail); 
UPDATE login SET Login_password=pass WHERE User_id = @user_id; 
SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_simul_insert`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_simul_insert` (IN `name` VARCHAR(80), IN `descrip` VARCHAR(200), IN `initial` INT, IN `final` INT, IN `percent` DECIMAL(4,2))  BEGIN 
INSERT INTO simulators(Sim_name, Sim_description) VALUES (name,descrip); 
SET @id = LAST_INSERT_ID(); 
INSERT INTO conditions(Cond_initial,Cond_final,Cond_percent,Sim_id) VALUES (initial,final,percent,@id);
SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_simul_select_all`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_simul_select_all` ()  BEGIN 
SELECT * FROM simulators;
END$$

DROP PROCEDURE IF EXISTS `sp_simul_select_one`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_simul_select_one` (IN `id` INT)  BEGIN 
SELECT Sim_id, Sim_name, Sim_description, Sim_conditions, Sim_benefits FROM simulators WHERE Sim_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_simul_update`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_simul_update` (IN `id` INT, IN `name` VARCHAR(80), IN `descrip` VARCHAR(200))  BEGIN 
UPDATE simulators SET Sim_name=name,Sim_description=descrip WHERE Sim_id = id;
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_stattype_insert`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_stattype_insert` (IN `name` VARCHAR(30))  BEGIN 
INSERT INTO status_type(Type_name) VALUES (name); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_stattype_select_all`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_stattype_select_all` ()  BEGIN 
SELECT Type_id, Type_name FROM status_type;
END$$

DROP PROCEDURE IF EXISTS `sp_stattype_select_one`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_stattype_select_one` (IN `id` INT)  BEGIN 
SELECT Type_id, Type_name FROM status_type WHERE Type_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_stattype_update`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_stattype_update` (IN `id` INT, IN `name` VARCHAR(30))  BEGIN 
UPDATE status_type SET Type_name=name WHERE Type_id = id; 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_status_insert`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_status_insert` (IN `name` VARCHAR(30), IN `type` INT)  BEGIN 
INSERT INTO status(Stat_name, Type_id) VALUES (name, type); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_status_select_all`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_status_select_all` ()  BEGIN 
SELECT Stat_id, Stat_name, Type_id FROM status;
END$$

DROP PROCEDURE IF EXISTS `sp_status_select_one`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_status_select_one` (IN `id` INT)  BEGIN 
SELECT Stat_id, Stat_name, Type_id FROM status WHERE Stat_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_status_select_type`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_status_select_type` (IN `type` INT)  BEGIN 
SELECT Stat_id, Stat_name, Type_id FROM status WHERE Type_id = type;
END$$

DROP PROCEDURE IF EXISTS `sp_status_update`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_status_update` (IN `id` INT, IN `name` VARCHAR(30), IN `type` INT)  BEGIN 
UPDATE status SET Stat_name=name, Type_id = type WHERE Stat_id = id; 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_town_insert`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_town_insert` (IN `name` VARCHAR(100), IN `depart` INT)  BEGIN 
INSERT INTO township(Town_name, Dep_id) VALUES (name, depart); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_town_select_all`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_town_select_all` ()  BEGIN 
SELECT Town_id, Town_name, Dep_id FROM township;
END$$

DROP PROCEDURE IF EXISTS `sp_town_select_Dep`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_town_select_Dep` (IN `dept` INT)  BEGIN 
SELECT Town_id, Town_name, Dep_id FROM township WHERE Dep_id = dept;
END$$

DROP PROCEDURE IF EXISTS `sp_town_select_one`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_town_select_one` (IN `id` INT)  BEGIN 
SELECT Town_id, Town_name, Dep_id FROM township WHERE Town_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_town_update`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_town_update` (IN `id` INT, IN `name` VARCHAR(100), IN `depart` INT)  BEGIN 
UPDATE township SET Town_name=name,Dep_id=depart WHERE Town_id = id;
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_user_insert`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_user_insert` (IN `name` VARCHAR(80), IN `identification` INT, IN `email` VARCHAR(200), IN `status` INT, IN `pass` VARCHAR(30))  BEGIN 
SET @exist = (SELECT COUNT(User_email)FROM users WHERE User_email LIKE email); 
IF @exist = 0 THEN 
INSERT INTO users (User_name, User_identification, User_email, Stat_id) VALUES (name, identification, email, status); 
SET @user_id = LAST_INSERT_ID();
END IF; 
INSERT INTO login (Login_password, User_id) VALUES (pass, @user_id); 
SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_user_select_all`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_user_select_all` ()  BEGIN 
SELECT User_id, User_name, User_identification, User_email, Stat_id FROM users; 
END$$

DROP PROCEDURE IF EXISTS `sp_user_select_one`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_user_select_one` (IN `mail` VARCHAR(200))  BEGIN 
SELECT User_id, User_name, User_identification, User_email, Stat_id FROM users WHERE User_email = mail; 
END$$

DROP PROCEDURE IF EXISTS `sp_user_update`$$
CREATE DEFINER=`u645747626_st`@`10.1.2.54` PROCEDURE `sp_user_update` (IN `id` INT, IN `name` VARCHAR(80), IN `status` INT)  BEGIN 
UPDATE users SET User_name=name, Stat_id = status WHERE User_id = id; 
SELECT ROW_COUNT(); 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conditions`
--

DROP TABLE IF EXISTS `conditions`;
CREATE TABLE IF NOT EXISTS `conditions` (
  `Cond_id` int(11) NOT NULL AUTO_INCREMENT,
  `Cond_initial` int(11) NOT NULL,
  `Cond_final` int(11) NOT NULL,
  `Cond_percent` decimal(4,2) NOT NULL,
  `Sim_id` int(11) NOT NULL,
  PRIMARY KEY (`Cond_id`),
  KEY `Conditions_Simulators` (`Sim_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Truncar tablas antes de insertar `conditions`
--

TRUNCATE TABLE `conditions`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `Dep_id` int(11) NOT NULL AUTO_INCREMENT,
  `Dep_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Dep_id`),
  UNIQUE KEY `Dep_name` (`Dep_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Truncar tablas antes de insertar `department`
--

TRUNCATE TABLE `department`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entry`
--

DROP TABLE IF EXISTS `entry`;
CREATE TABLE IF NOT EXISTS `entry` (
  `Ent_id` int(11) NOT NULL AUTO_INCREMENT,
  `Login_id` int(11) NOT NULL,
  `Stat_id` int(11) NOT NULL,
  PRIMARY KEY (`Ent_id`),
  KEY `Entry_Login` (`Login_id`),
  KEY `Entry_Status` (`Stat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Truncar tablas antes de insertar `entry`
--

TRUNCATE TABLE `entry`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

DROP TABLE IF EXISTS `login`;
CREATE TABLE IF NOT EXISTS `login` (
  `Login_id` int(11) NOT NULL AUTO_INCREMENT,
  `Login_password` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `User_id` int(11) NOT NULL,
  PRIMARY KEY (`Login_id`),
  UNIQUE KEY `User_id` (`User_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Truncar tablas antes de insertar `login`
--

TRUNCATE TABLE `login`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `simulators`
--

DROP TABLE IF EXISTS `simulators`;
CREATE TABLE IF NOT EXISTS `simulators` (
  `Sim_id` int(11) NOT NULL AUTO_INCREMENT,
  `Sim_name` varchar(80) CHARACTER SET utf8 NOT NULL,
  `Sim_description` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  `Sim_conditions` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  `Sim_benefits` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  `Sim_destination` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Sim_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Truncar tablas antes de insertar `simulators`
--

TRUNCATE TABLE `simulators`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `Stat_id` int(11) NOT NULL AUTO_INCREMENT,
  `Stat_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Type_id` int(11) NOT NULL,
  PRIMARY KEY (`Stat_id`),
  UNIQUE KEY `Stat_name` (`Stat_name`),
  KEY `Status_Type` (`Type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Truncar tablas antes de insertar `status`
--

TRUNCATE TABLE `status`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status_type`
--

DROP TABLE IF EXISTS `status_type`;
CREATE TABLE IF NOT EXISTS `status_type` (
  `Type_id` int(11) NOT NULL AUTO_INCREMENT,
  `Type_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Truncar tablas antes de insertar `status_type`
--

TRUNCATE TABLE `status_type`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `township`
--

DROP TABLE IF EXISTS `township`;
CREATE TABLE IF NOT EXISTS `township` (
  `Town_id` int(11) NOT NULL AUTO_INCREMENT,
  `Town_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Dep_id` int(11) NOT NULL,
  PRIMARY KEY (`Town_id`),
  UNIQUE KEY `Town_name` (`Town_name`),
  KEY `Township_Department` (`Dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Truncar tablas antes de insertar `township`
--

TRUNCATE TABLE `township`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `User_id` int(11) NOT NULL AUTO_INCREMENT,
  `User_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `User_identification` int(11) NOT NULL,
  `User_email` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `Stat_id` int(11) NOT NULL,
  PRIMARY KEY (`User_id`),
  UNIQUE KEY `User_email` (`User_email`),
  UNIQUE KEY `User_identification` (`User_identification`),
  KEY `Users_Status` (`Stat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Truncar tablas antes de insertar `users`
--

TRUNCATE TABLE `users`;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `conditions`
--
ALTER TABLE `conditions`
  ADD CONSTRAINT `Conditions_Simulators` FOREIGN KEY (`Sim_id`) REFERENCES `simulators` (`Sim_id`);

--
-- Filtros para la tabla `entry`
--
ALTER TABLE `entry`
  ADD CONSTRAINT `Entry_Login` FOREIGN KEY (`Login_id`) REFERENCES `login` (`Login_id`),
  ADD CONSTRAINT `Entry_Status` FOREIGN KEY (`Stat_id`) REFERENCES `status` (`Stat_id`);

--
-- Filtros para la tabla `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `Users_Login` FOREIGN KEY (`User_id`) REFERENCES `users` (`User_id`);

--
-- Filtros para la tabla `status`
--
ALTER TABLE `status`
  ADD CONSTRAINT `Status_Type` FOREIGN KEY (`Type_id`) REFERENCES `status_type` (`Type_id`);

--
-- Filtros para la tabla `township`
--
ALTER TABLE `township`
  ADD CONSTRAINT `Township_Department` FOREIGN KEY (`Dep_id`) REFERENCES `department` (`Dep_id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `Users_Status` FOREIGN KEY (`Stat_id`) REFERENCES `status` (`Stat_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
