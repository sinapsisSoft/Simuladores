-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-07-2019 a las 20:35:31
-- Versión del servidor: 10.1.31-MariaDB
-- Versión de PHP: 7.2.4

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

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `sp_cond_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cond_insert` (IN `initial` INT, IN `final` INT, IN `percent` DECIMAL(4,2), IN `Simul` INT)  BEGIN 
INSERT INTO conditions(Cond_initial, Cond_final, Cond_percent, Sim_id) VALUES (initial,final,percent,Simul); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_cond_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cond_select_all` ()  BEGIN 
SELECT Cond_id, Cond_initial, Cond_final, Cond_percent, Sim_id FROM conditions;
END$$

DROP PROCEDURE IF EXISTS `sp_cond_select_simu`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cond_select_simu` (IN `simul` INT)  BEGIN 
SELECT Cond_id, Cond_initial, Cond_final, Cond_percent, Sim_id FROM conditions WHERE Sim_id = simul;
END$$

DROP PROCEDURE IF EXISTS `sp_cond_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cond_update` (IN `id` INT, IN `initial` INT, IN `final` INT, IN `percent` DECIMAL(4,2), IN `simul` INT)  BEGIN 
UPDATE conditions SET Cond_initial=initial,Cond_final=final,Cond_percent=percent,Sim_id=simul WHERE Cond_id = id;
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_depart_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_depart_insert` (IN `name` VARCHAR(100))  BEGIN 
INSERT INTO department(Dep_name) VALUES (name); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_depart_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_depart_select_all` ()  BEGIN 
SELECT Dep_id, Dep_name FROM department;
END$$

DROP PROCEDURE IF EXISTS `sp_depart_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_depart_select_one` (IN `id` INT)  BEGIN 
SELECT Dep_id, Dep_name FROM department WHERE Dep_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_depart_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_depart_update` (IN `id` INT, IN `name` VARCHAR(100))  BEGIN 
UPDATE department SET Dep_name=name WHERE Dep_id = id;
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_entry_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_entry_insert` (IN `login` INT, IN `status` INT)  BEGIN 
INSERT INTO entry(Login_id, Stat_id) VALUES (login,status); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_entry_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_entry_select_all` ()  BEGIN 
SELECT Ent_id, Login_id, Stat_id FROM entry;
END$$

DROP PROCEDURE IF EXISTS `sp_entry_select_login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_entry_select_login` (IN `login` INT)  BEGIN 
SELECT Ent_id, Login_id, Stat_id FROM entry WHERE Login_id = login;
END$$

DROP PROCEDURE IF EXISTS `sp_entry_select_status`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_entry_select_status` (IN `status` INT)  BEGIN 
SELECT Ent_id, Login_id, Stat_id FROM entry WHERE Stat_id = status;
END$$

DROP PROCEDURE IF EXISTS `sp_entry_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_entry_update` (IN `id` INT, IN `login` INT, IN `status` INT)  BEGIN 
UPDATE entry SET Login_id=login, Stat_id=status WHERE Ent_id = id;
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login` (IN `email` VARCHAR(200), IN `pass` VARCHAR(30))  BEGIN 
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_insert` (IN `pass` VARCHAR(30), IN `user` INT)  BEGIN 
INSERT INTO login(Login_password, User_id) VALUES (pass,user);
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_login_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_select_all` ()  BEGIN 
SELECT Login_id, Login_password, User_id FROM login;
END$$

DROP PROCEDURE IF EXISTS `sp_login_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_select_one` (IN `id` INT)  BEGIN 
SELECT Login_id, Login_password, User_id FROM login WHERE Login_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_login_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_update` (IN `mail` VARCHAR(200), IN `pass` VARCHAR(30))  BEGIN 
SET @user_id = (SELECT User_id FROM users WHERE User_email LIKE mail); 
UPDATE login SET Login_password=pass WHERE User_id = @user_id; 
SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_simul_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_simul_insert` (IN `name` VARCHAR(80), IN `descrip` VARCHAR(200), IN `initial` INT, IN `final` INT, IN `percent` DECIMAL(4,2))  BEGIN 
INSERT INTO simulators(Sim_name, Sim_description) VALUES (name,descrip); 
SET @id = LAST_INSERT_ID(); 
INSERT INTO conditions(Cond_initial,Cond_final,Cond_percent,Sim_id) VALUES (initial,final,percent,@id);
SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_simul_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_simul_select_all` ()  BEGIN 
SELECT * FROM simulators;
END$$

DROP PROCEDURE IF EXISTS `sp_simul_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_simul_select_one` (IN `id` INT)  BEGIN 
SELECT Sim_id, Sim_name, Sim_description, Sim_conditions, Sim_benefits FROM simulators WHERE Sim_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_simul_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_simul_update` (IN `id` INT, IN `name` VARCHAR(80), IN `descrip` VARCHAR(200))  BEGIN 
UPDATE simulators SET Sim_name=name,Sim_description=descrip WHERE Sim_id = id;
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_stattype_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_stattype_insert` (IN `name` VARCHAR(30))  BEGIN 
INSERT INTO status_type(Type_name) VALUES (name); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_stattype_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_stattype_select_all` ()  BEGIN 
SELECT Type_id, Type_name FROM status_type;
END$$

DROP PROCEDURE IF EXISTS `sp_stattype_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_stattype_select_one` (IN `id` INT)  BEGIN 
SELECT Type_id, Type_name FROM status_type WHERE Type_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_stattype_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_stattype_update` (IN `id` INT, IN `name` VARCHAR(30))  BEGIN 
UPDATE status_type SET Type_name=name WHERE Type_id = id; 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_status_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_status_insert` (IN `name` VARCHAR(30), IN `type` INT)  BEGIN 
INSERT INTO status(Stat_name, Type_id) VALUES (name, type); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_status_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_status_select_all` ()  BEGIN 
SELECT Stat_id, Stat_name, Type_id FROM status;
END$$

DROP PROCEDURE IF EXISTS `sp_status_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_status_select_one` (IN `id` INT)  BEGIN 
SELECT Stat_id, Stat_name, Type_id FROM status WHERE Stat_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_status_select_type`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_status_select_type` (IN `type` INT)  BEGIN 
SELECT Stat_id, Stat_name, Type_id FROM status WHERE Type_id = type;
END$$

DROP PROCEDURE IF EXISTS `sp_status_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_status_update` (IN `id` INT, IN `name` VARCHAR(30), IN `type` INT)  BEGIN 
UPDATE status SET Stat_name=name, Type_id = type WHERE Stat_id = id; 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_town_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_town_insert` (IN `name` VARCHAR(100), IN `depart` INT)  BEGIN 
INSERT INTO township(Town_name, Dep_id) VALUES (name, depart); 
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_town_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_town_select_all` ()  BEGIN 
SELECT Town_id, Town_name, Dep_id FROM township;
END$$

DROP PROCEDURE IF EXISTS `sp_town_select_Dep`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_town_select_Dep` (IN `dept` INT)  BEGIN 
SELECT Town_id, Town_name, Dep_id FROM township WHERE Dep_id = dept;
END$$

DROP PROCEDURE IF EXISTS `sp_town_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_town_select_one` (IN `id` INT)  BEGIN 
SELECT Town_id, Town_name, Dep_id FROM township WHERE Town_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_town_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_town_update` (IN `id` INT, IN `name` VARCHAR(100), IN `depart` INT)  BEGIN 
UPDATE township SET Town_name=name,Dep_id=depart WHERE Town_id = id;
SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_user_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_insert` (IN `name` VARCHAR(80), IN `identification` INT, IN `email` VARCHAR(200), IN `status` INT, IN `pass` VARCHAR(30))  BEGIN 
SET @exist = (SELECT COUNT(User_email)FROM users WHERE User_email LIKE email); 
IF @exist = 0 THEN 
INSERT INTO users (User_name, User_identification, User_email, Stat_id) VALUES (name, identification, email, status); 
SET @user_id = LAST_INSERT_ID();
END IF; 
INSERT INTO login (Login_password, User_id) VALUES (pass, @user_id); 
SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_user_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_select_all` ()  BEGIN 
SELECT User_id, User_name, User_identification, User_email, Stat_id FROM users; 
END$$

DROP PROCEDURE IF EXISTS `sp_user_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_select_one` (IN `mail` VARCHAR(200))  BEGIN 
SELECT User_id, User_name, User_identification, User_email, Stat_id FROM users WHERE User_email = mail; 
END$$

DROP PROCEDURE IF EXISTS `sp_user_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_update` (IN `id` INT, IN `name` VARCHAR(80), IN `status` INT)  BEGIN 
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
  `Cond_percent_NMV` int(100) NOT NULL,
  `Sim_id` int(11) NOT NULL,
  PRIMARY KEY (`Cond_id`),
  KEY `Conditions_Simulators` (`Sim_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `conditions`
--

INSERT INTO `conditions` (`Cond_id`, `Cond_initial`, `Cond_final`, `Cond_percent`, `Cond_percent_NMV`, `Sim_id`) VALUES
(1, 1, 1, '1.50', 20, 4),
(2, 1, 12, '0.60', 7, 5),
(3, 13, 24, '0.70', 9, 5),
(4, 25, 36, '0.80', 10, 5),
(5, 1, 12, '1.00', 13, 6),
(6, 1, 12, '0.50', 6, 3),
(7, 13, 24, '0.75', 9, 3),
(8, 25, 36, '1.00', 13, 3),
(9, 1, 18, '1.00', 13, 7),
(10, 19, 36, '1.30', 17, 7),
(11, 37, 60, '1.50', 20, 7),
(12, 1, 18, '1.40', 18, 9),
(13, 19, 36, '1.50', 20, 9),
(14, 37, 60, '1.60', 21, 9),
(15, 1, 24, '1.78', 24, 1),
(16, 1, 60, '0.97', 12, 10),
(17, 1, 18, '0.80', 10, 11),
(18, 1, 5, '1.87', 24, 8),
(19, 1, 6, '0.80', 10, 2),
(20, 7, 12, '0.90', 11, 2),
(21, 13, 36, '1.00', 13, 2);

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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `department`
--

INSERT INTO `department` (`Dep_id`, `Dep_name`) VALUES
(1, 'AMAZONAS'),
(2, 'ANTIOQUIA'),
(4, 'ARAUCA'),
(3, 'ATLANTICO'),
(5, 'BOGOTÁ'),
(6, 'BOLIVAR'),
(7, 'BOYACA'),
(8, 'CALDAS'),
(9, 'CAQUETA'),
(10, 'CASANARE'),
(11, 'CAUCA'),
(12, 'CESAR'),
(13, 'CHOCO'),
(14, 'CORDOBA'),
(15, 'CUNDINAMARCA'),
(16, 'GUAINIA'),
(17, 'GUAVIARE'),
(18, 'HUILA'),
(19, 'LA GUAJIRA'),
(20, 'MAGDALENA'),
(21, 'META'),
(22, 'N. DE SANTANDER'),
(23, 'NARIÑO'),
(24, 'PUTUMAYO'),
(25, 'QUINDIO'),
(26, 'RISARALDA'),
(27, 'SAN ANDRES'),
(28, 'SANTANDER'),
(29, 'SUCRE'),
(30, 'TOLIMA'),
(31, 'VALLE DEL CAUCA'),
(32, 'VAUPES'),
(33, 'VICHADA');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `simulators`
--

DROP TABLE IF EXISTS `simulators`;
CREATE TABLE IF NOT EXISTS `simulators` (
  `Sim_id` int(11) NOT NULL AUTO_INCREMENT,
  `Sim_name` varchar(80) CHARACTER SET utf8 NOT NULL,
  `Sim_conditions` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  `Sim_benefits` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  `Sim_destination` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Sim_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `simulators`
--

INSERT INTO `simulators` (`Sim_id`, `Sim_name`, `Sim_conditions`, `Sim_benefits`, `Sim_destination`) VALUES
(1, 'TARJETA TAVA (ROTATIVO)', 'test', 'test', 'test'),
(2, 'EDUCACION', 'test', 'test', 'test'),
(3, 'SOBRE APORTES', 'test', 'test', 'test'),
(4, 'SOBREPRIMA', 'test', 'test', 'test'),
(5, 'FIDELIDAD', 'test', 'test', 'test'),
(6, 'COMPRAS', 'test', 'test', 'test'),
(7, 'COMPRA DE CARTERA', 'test', 'test', 'test'),
(8, 'CREDI YA', 'test', 'test', 'test'),
(9, 'ORDINARIO', 'test', 'test', 'test'),
(10, 'PROMOCIONAL', 'test', 'test', 'test'),
(11, 'TURISMO', 'test', 'test', 'test');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status_type`
--

DROP TABLE IF EXISTS `status_type`;
CREATE TABLE IF NOT EXISTS `status_type` (
  `Type_id` int(11) NOT NULL AUTO_INCREMENT,
  `Type_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `township`
--

DROP TABLE IF EXISTS `township`;
CREATE TABLE IF NOT EXISTS `township` (
  `Town_id` int(11) NOT NULL AUTO_INCREMENT,
  `Town_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Dep_id` int(11) NOT NULL,
  `Town_City` int(11) NOT NULL,
  PRIMARY KEY (`Town_id`),
  KEY `Township_Department` (`Dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1200 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `township`
--

INSERT INTO `township` (`Town_id`, `Town_name`, `Dep_id`, `Town_City`) VALUES
(1, 'LA VICTORIA', 1, 0),
(2, 'LETICIA', 1, 1),
(3, 'EL ENCANTO', 1, 0),
(4, 'LA CHORRERA', 1, 0),
(5, 'LA PEDRERA', 1, 0),
(6, 'MIRITI - PARANA', 1, 0),
(7, 'PUERTO ALEGRIA', 1, 0),
(8, 'PUERTO ARICA', 1, 0),
(9, 'PUERTO NARIÑO', 1, 0),
(10, 'PUERTO SANTANDER', 1, 0),
(11, 'TARAPACA', 1, 0),
(12, 'MEDELLÍN', 2, 1),
(13, 'ABEJORRAL', 2, 0),
(14, 'ABRIAQUI', 2, 0),
(15, 'ALEJANDRIA', 2, 0),
(16, 'AMAGA', 2, 0),
(17, 'AMALFI', 2, 0),
(18, 'ANDES', 2, 0),
(19, 'ANGELOPOLIS', 2, 0),
(20, 'ANGOSTURA', 2, 0),
(21, 'ANORI', 2, 0),
(22, 'SANTAFE DE ANTIOQUIA', 2, 0),
(23, 'ANZA', 2, 0),
(24, 'APARTADO', 2, 0),
(25, 'ARBOLETES', 2, 0),
(26, 'ARGELIA', 2, 0),
(27, 'ARMENIA', 2, 0),
(28, 'BARBOSA', 2, 0),
(29, 'BELMIRA', 2, 0),
(30, 'BELLO', 2, 0),
(31, 'BETANIA', 2, 0),
(32, 'BETULIA', 2, 0),
(33, 'CIUDAD BOLIVAR', 2, 0),
(34, 'BRICEÑO', 2, 0),
(35, 'BURITICA', 2, 0),
(36, 'CACERES', 2, 0),
(37, 'CAICEDO', 2, 0),
(38, 'CALDAS', 2, 0),
(39, 'CAMPAMENTO', 2, 0),
(40, 'CAÑASGORDAS', 2, 0),
(41, 'CARACOLI', 2, 0),
(42, 'CARAMANTA', 2, 0),
(43, 'CAREPA', 2, 0),
(44, 'EL CARMEN DE VIBORAL', 2, 0),
(45, 'CAROLINA', 2, 0),
(46, 'CAUCASIA', 2, 0),
(47, 'CHIGORODO', 2, 0),
(48, 'CISNEROS', 2, 0),
(49, 'COCORNA', 2, 0),
(50, 'CONCEPCION', 2, 0),
(51, 'CONCORDIA', 2, 0),
(52, 'COPACABANA', 2, 0),
(53, 'DABEIBA', 2, 0),
(54, 'DON MATIAS', 2, 0),
(55, 'EBEJICO', 2, 0),
(56, 'EL BAGRE', 2, 0),
(57, 'ENTRERRIOS', 2, 0),
(58, 'ENVIGADO', 2, 0),
(59, 'FREDONIA', 2, 0),
(60, 'FRONTINO', 2, 0),
(61, 'GIRALDO', 2, 0),
(62, 'GIRARDOTA', 2, 0),
(63, 'GOMEZ PLATA', 2, 0),
(64, 'GRANADA', 2, 0),
(65, 'GUADALUPE', 2, 0),
(66, 'GUARNE', 2, 0),
(67, 'GUATAPE', 2, 0),
(68, 'HELICONIA', 2, 0),
(69, 'HISPANIA', 2, 0),
(70, 'ITAGUI', 2, 0),
(71, 'ITUANGO', 2, 0),
(72, 'JARDIN', 2, 0),
(73, 'JERICO', 2, 0),
(74, 'LA CEJA', 2, 0),
(75, 'LA ESTRELLA', 2, 0),
(76, 'LA PINTADA', 2, 0),
(77, 'LA UNION', 2, 0),
(78, 'LIBORINA', 2, 0),
(79, 'MACEO', 2, 0),
(80, 'MARINILLA', 2, 0),
(81, 'MONTEBELLO', 2, 0),
(82, 'MURINDO', 2, 0),
(83, 'MUTATA', 2, 0),
(84, 'NARIÑO', 2, 0),
(85, 'NECOCLI', 2, 0),
(86, 'NECHI', 2, 0),
(87, 'OLAYA', 2, 0),
(88, 'PEÐOL', 2, 0),
(89, 'PEQUE', 2, 0),
(90, 'PUEBLORRICO', 2, 0),
(91, 'PUERTO BERRIO', 2, 0),
(92, 'PUERTO NARE', 2, 0),
(93, 'PUERTO TRIUNFO', 2, 0),
(94, 'REMEDIOS', 2, 0),
(95, 'RETIRO', 2, 0),
(96, 'RIONEGRO', 2, 0),
(97, 'SABANALARGA', 2, 0),
(98, 'SABANETA', 2, 0),
(99, 'SALGAR', 2, 0),
(100, 'SAN ANDRES DE CUERQUIA', 2, 0),
(101, 'SAN CARLOS', 2, 0),
(102, 'SAN FRANCISCO', 2, 0),
(103, 'SAN JERONIMO', 2, 0),
(104, 'SAN JOSE DE LA MONTAÑA', 2, 0),
(105, 'SAN JUAN DE URABA', 2, 0),
(106, 'SAN LUIS', 2, 0),
(107, 'SAN PEDRO', 2, 0),
(108, 'SAN PEDRO DE URABA', 2, 0),
(109, 'SAN RAFAEL', 2, 0),
(110, 'SAN ROQUE', 2, 0),
(111, 'SAN VICENTE', 2, 0),
(112, 'SANTA BARBARA', 2, 0),
(113, 'SANTA ROSA DE OSOS', 2, 0),
(114, 'SANTO DOMINGO', 2, 0),
(115, 'EL SANTUARIO', 2, 0),
(116, 'SEGOVIA', 2, 0),
(117, 'SONSON', 2, 0),
(118, 'SOPETRAN', 2, 0),
(119, 'TAMESIS', 2, 0),
(120, 'TARAZA', 2, 0),
(121, 'TARSO', 2, 0),
(122, 'TITIRIBI', 2, 0),
(123, 'TOLEDO', 2, 0),
(124, 'TURBO', 2, 0),
(125, 'URAMITA', 2, 0),
(126, 'URRAO', 2, 0),
(127, 'VALDIVIA', 2, 0),
(128, 'VALPARAISO', 2, 0),
(129, 'VEGACHI', 2, 0),
(130, 'VENECIA', 2, 0),
(131, 'VIGIA DEL FUERTE', 2, 0),
(132, 'YALI', 2, 0),
(133, 'YARUMAL', 2, 0),
(134, 'YOLOMBO', 2, 0),
(135, 'YONDO', 2, 0),
(136, 'ZARAGOZA', 2, 0),
(137, 'ARAUCA', 4, 1),
(138, 'ARAUQUITA', 4, 0),
(139, 'CRAVO NORTE', 4, 0),
(140, 'FORTUL', 4, 0),
(141, 'PUERTO RONDON', 4, 0),
(142, 'SARAVENA', 4, 0),
(143, 'TAME', 4, 0),
(144, 'BARRANQUILLA', 3, 1),
(145, 'BARANOA', 3, 0),
(146, 'CAMPO DE LA CRUZ', 3, 0),
(147, 'CANDELARIA', 3, 0),
(148, 'GALAPA', 3, 0),
(149, 'JUAN DE ACOSTA', 3, 0),
(150, 'LURUACO', 3, 0),
(151, 'MALAMBO', 3, 0),
(152, 'MANATI', 3, 0),
(153, 'PALMAR DE VARELA', 3, 0),
(154, 'PIOJO', 3, 0),
(155, 'POLONUEVO', 3, 0),
(156, 'PONEDERA', 3, 0),
(157, 'PUERTO COLOMBIA', 3, 0),
(158, 'REPELON', 3, 0),
(159, 'SABANAGRANDE', 3, 0),
(160, 'SABANALARGA', 3, 0),
(161, 'SANTA LUCIA', 3, 0),
(162, 'SANTO TOMAS', 3, 0),
(163, 'SOLEDAD', 3, 0),
(164, 'SUAN', 3, 0),
(165, 'TUBARA', 3, 0),
(166, 'USIACURI', 3, 0),
(167, 'BOGOTÁ, D.C', 5, 1),
(168, 'CARTAGENA', 6, 1),
(169, 'ACHI', 6, 0),
(170, 'ALTOS DEL ROSARIO', 6, 0),
(171, 'ARENAL', 6, 0),
(172, 'ARJONA', 6, 0),
(173, 'ARROYOHONDO', 6, 0),
(174, 'BARRANCO DE LOBA', 6, 0),
(175, 'CALAMAR', 6, 0),
(176, 'CANTAGALLO', 6, 0),
(177, 'CICUCO', 6, 0),
(178, 'CORDOBA', 6, 0),
(179, 'CLEMENCIA', 6, 0),
(180, 'EL CARMEN DE BOLIVAR', 6, 0),
(181, 'EL GUAMO', 6, 0),
(182, 'EL PEÑON', 6, 0),
(183, 'HATILLO DE LOBA', 6, 0),
(184, 'MAGANGUE', 6, 0),
(185, 'MAHATES', 6, 0),
(186, 'MARGARITA', 6, 0),
(187, 'MARIA LA BAJA', 6, 0),
(188, 'MONTECRISTO', 6, 0),
(189, 'MOMPOS', 6, 0),
(190, 'MORALES', 6, 0),
(191, 'NOROSI', 6, 0),
(192, 'PINILLOS', 6, 0),
(193, 'REGIDOR', 6, 0),
(194, 'RIO VIEJO', 6, 0),
(195, 'SAN CRISTOBAL', 6, 0),
(196, 'SAN ESTANISLAO', 6, 0),
(197, 'SAN FERNANDO', 6, 0),
(198, 'SAN JACINTO', 6, 0),
(199, 'SAN JACINTO DEL CAUCA', 6, 0),
(200, 'SAN JUAN NEPOMUCENO', 6, 0),
(201, 'SAN MARTIN DE LOBA', 6, 0),
(202, 'SAN PABLO', 6, 0),
(203, 'SANTA CATALINA', 6, 0),
(204, 'SANTA ROSA', 6, 0),
(205, 'SANTA ROSA DEL SUR', 6, 0),
(206, 'SIMITI', 6, 0),
(207, 'SOPLAVIENTO', 6, 0),
(208, 'TALAIGUA NUEVO', 6, 0),
(209, 'TIQUISIO', 6, 0),
(210, 'TURBACO', 6, 0),
(211, 'TURBANA', 6, 0),
(212, 'VILLANUEVA', 6, 0),
(213, 'ZAMBRANO', 6, 0),
(214, 'TUNJA', 7, 1),
(215, 'ALMEIDA', 7, 0),
(216, 'AQUITANIA', 7, 0),
(217, 'ARCABUCO', 7, 0),
(218, 'BELEN', 7, 0),
(219, 'BERBEO', 7, 0),
(220, 'BETEITIVA', 7, 0),
(221, 'BOAVITA', 7, 0),
(222, 'BOYACA', 7, 0),
(223, 'BRICEÑO', 7, 0),
(224, 'BUENAVISTA', 7, 0),
(225, 'BUSBANZA', 7, 0),
(226, 'CALDAS', 7, 0),
(227, 'CAMPOHERMOSO', 7, 0),
(228, 'CERINZA', 7, 0),
(229, 'CHINAVITA', 7, 0),
(230, 'CHIQUINQUIRA', 7, 0),
(231, 'CHISCAS', 7, 0),
(232, 'CHITA', 7, 0),
(233, 'CHITARAQUE', 7, 0),
(234, 'CHIVATA', 7, 0),
(235, 'CIENEGA', 7, 0),
(236, 'COMBITA', 7, 0),
(237, 'COPER', 7, 0),
(238, 'CORRALES', 7, 0),
(239, 'COVARACHIA', 7, 0),
(240, 'CUBARA', 7, 0),
(241, 'CUCAITA', 7, 0),
(242, 'CUITIVA', 7, 0),
(243, 'CHIQUIZA', 7, 0),
(244, 'CHIVOR', 7, 0),
(245, 'DUITAMA', 7, 0),
(246, 'EL COCUY', 7, 0),
(247, 'EL ESPINO', 7, 0),
(248, 'FIRAVITOBA', 7, 0),
(249, 'FLORESTA', 7, 0),
(250, 'GACHANTIVA', 7, 0),
(251, 'GAMEZA', 7, 0),
(252, 'GARAGOA', 7, 0),
(253, 'GUACAMAYAS', 7, 0),
(254, 'GUATEQUE', 7, 0),
(255, 'GUAYATA', 7, 0),
(256, 'GsICAN', 7, 0),
(257, 'IZA', 7, 0),
(258, 'JENESANO', 7, 0),
(259, 'JERICO', 7, 0),
(260, 'LABRANZAGRANDE', 7, 0),
(261, 'LA CAPILLA', 7, 0),
(262, 'LA VICTORIA', 7, 0),
(263, 'LA UVITA', 7, 0),
(264, 'VILLA DE LEYVA', 7, 0),
(265, 'MACANAL', 7, 0),
(266, 'MARIPI', 7, 0),
(267, 'MIRAFLORES', 7, 0),
(268, 'MONGUA', 7, 0),
(269, 'MONGUI', 7, 0),
(270, 'MONIQUIRA', 7, 0),
(271, 'MOTAVITA', 7, 0),
(272, 'MUZO', 7, 0),
(273, 'NOBSA', 7, 0),
(274, 'NUEVO COLON', 7, 0),
(275, 'OICATA', 7, 0),
(276, 'OTANCHE', 7, 0),
(277, 'PACHAVITA', 7, 0),
(278, 'PAEZ', 7, 0),
(279, 'PAIPA', 7, 0),
(280, 'PAJARITO', 7, 0),
(281, 'PANQUEBA', 7, 0),
(282, 'PAUNA', 7, 0),
(283, 'PAYA', 7, 0),
(284, 'PAZ DE RIO', 7, 0),
(285, 'PESCA', 7, 0),
(286, 'PISBA', 7, 0),
(287, 'PUERTO BOYACA', 7, 0),
(288, 'QUIPAMA', 7, 0),
(289, 'RAMIRIQUI', 7, 0),
(290, 'RAQUIRA', 7, 0),
(291, 'RONDON', 7, 0),
(292, 'SABOYA', 7, 0),
(293, 'SACHICA', 7, 0),
(294, 'SAMACA', 7, 0),
(295, 'SAN EDUARDO', 7, 0),
(296, 'SAN JOSE DE PARE', 7, 0),
(297, 'SAN LUIS DE GACENO', 7, 0),
(298, 'SAN MATEO', 7, 0),
(299, 'SAN MIGUEL DE SEMA', 7, 0),
(300, 'SAN PABLO DE BORBUR', 7, 0),
(301, 'SANTANA', 7, 0),
(302, 'SANTA MARIA', 7, 0),
(303, 'SANTA ROSA DE VITERBO', 7, 0),
(304, 'SANTA SOFIA', 7, 0),
(305, 'SATIVANORTE', 7, 0),
(306, 'SATIVASUR', 7, 0),
(307, 'SIACHOQUE', 7, 0),
(308, 'SOATA', 7, 0),
(309, 'SOCOTA', 7, 0),
(310, 'SOCHA', 7, 0),
(311, 'SOGAMOSO', 7, 0),
(312, 'SOMONDOCO', 7, 0),
(313, 'SORA', 7, 0),
(314, 'SOTAQUIRA', 7, 0),
(315, 'SORACA', 7, 0),
(316, 'SUSACON', 7, 0),
(317, 'SUTAMARCHAN', 7, 0),
(318, 'SUTATENZA', 7, 0),
(319, 'TASCO', 7, 0),
(320, 'TENZA', 7, 0),
(321, 'TIBANA', 7, 0),
(322, 'TIBASOSA', 7, 0),
(323, 'TINJACA', 7, 0),
(324, 'TIPACOQUE', 7, 0),
(325, 'TOCA', 7, 0),
(326, 'TOGsI', 7, 0),
(327, 'TOPAGA', 7, 0),
(328, 'TOTA', 7, 0),
(329, 'TUNUNGUA', 7, 0),
(330, 'TURMEQUE', 7, 0),
(331, 'TUTA', 7, 0),
(332, 'TUTAZA', 7, 0),
(333, 'UMBITA', 7, 0),
(334, 'VENTAQUEMADA', 7, 0),
(335, 'VIRACACHA', 7, 0),
(336, 'ZETAQUIRA', 7, 0),
(337, 'PENSILVANIA', 8, 0),
(338, 'RIOSUCIO', 8, 0),
(339, 'RISARALDA', 8, 0),
(340, 'SALAMINA', 8, 0),
(341, 'SAMANA', 8, 0),
(342, 'SAN JOSE', 8, 0),
(343, 'SUPIA', 8, 0),
(344, 'VICTORIA', 8, 0),
(345, 'VILLAMARIA', 8, 0),
(346, 'VITERBO', 8, 0),
(347, 'FLORENCIA', 9, 1),
(348, 'ALBANIA', 9, 0),
(349, 'BELEN DE LOS ANDAQUIES', 9, 0),
(350, 'CARTAGENA DEL CHAIRA', 9, 0),
(351, 'CURILLO', 9, 0),
(352, 'EL DONCELLO', 9, 0),
(353, 'EL PAUJIL', 9, 0),
(354, 'LA MONTAÑITA', 9, 0),
(355, 'MILAN', 9, 0),
(356, 'MORELIA', 9, 0),
(357, 'PUERTO RICO', 9, 0),
(358, 'SAN JOSE DEL FRAGUA', 9, 0),
(359, 'SAN VICENTE DEL CAGUAN', 9, 0),
(360, 'SOLANO', 9, 0),
(361, 'SOLITA', 9, 0),
(362, 'VALPARAISO', 9, 0),
(363, 'YOPAL', 10, 1),
(364, 'AGUAZUL', 10, 0),
(365, 'CHAMEZA', 10, 0),
(366, 'HATO COROZAL', 10, 0),
(367, 'LA SALINA', 10, 0),
(368, 'MANI', 10, 0),
(369, 'MONTERREY', 10, 0),
(370, 'NUNCHIA', 10, 0),
(371, 'OROCUE', 10, 0),
(372, 'PAZ DE ARIPORO', 10, 0),
(373, 'PORE', 10, 0),
(374, 'RECETOR', 10, 0),
(375, 'SABANALARGA', 10, 0),
(376, 'SACAMA', 10, 0),
(377, 'SAN LUIS DE PALENQUE', 10, 0),
(378, 'TAMARA', 10, 0),
(379, 'TAURAMENA', 10, 0),
(380, 'TRINIDAD', 10, 0),
(381, 'VILLANUEVA', 10, 0),
(382, 'GUACHENE', 11, 0),
(383, 'POPAYÁN', 11, 1),
(384, 'ALMAGUER', 11, 0),
(385, 'ARGELIA', 11, 0),
(386, 'BALBOA', 11, 0),
(387, 'BOLIVAR', 11, 0),
(388, 'BUENOS AIRES', 11, 0),
(389, 'CAJIBIO', 11, 0),
(390, 'CALDONO', 11, 0),
(391, 'CALOTO', 11, 0),
(392, 'CORINTO', 11, 0),
(393, 'EL TAMBO', 11, 0),
(394, 'FLORENCIA', 11, 0),
(395, 'GUAPI', 11, 0),
(396, 'INZA', 11, 0),
(397, 'JAMBALO', 11, 0),
(398, 'LA SIERRA', 11, 0),
(399, 'LA VEGA', 11, 0),
(400, 'LOPEZ', 11, 0),
(401, 'MERCADERES', 11, 0),
(402, 'MIRANDA', 11, 0),
(403, 'MORALES', 11, 0),
(404, 'PADILLA', 11, 0),
(405, 'PAEZ', 11, 0),
(406, 'PATIA', 11, 0),
(407, 'PIAMONTE', 11, 0),
(408, 'PIENDAMO', 11, 0),
(409, 'PUERTO TEJADA', 11, 0),
(410, 'PURACE', 11, 0),
(411, 'ROSAS', 11, 0),
(412, 'SAN SEBASTIAN', 11, 0),
(413, 'SANTANDER DE QUILICHAO', 11, 0),
(414, 'SANTA ROSA', 11, 0),
(415, 'SILVIA', 11, 0),
(416, 'SOTARA', 11, 0),
(417, 'SUAREZ', 11, 0),
(418, 'SUCRE', 11, 0),
(419, 'TIMBIO', 11, 0),
(420, 'TIMBIQUI', 11, 0),
(421, 'TORIBIO', 11, 0),
(422, 'TOTORO', 11, 0),
(423, 'VILLA RICA', 11, 0),
(424, 'VALLEDUPAR', 12, 1),
(425, 'AGUACHICA', 12, 0),
(426, 'AGUSTIN CODAZZI', 12, 0),
(427, 'ASTREA', 12, 0),
(428, 'BECERRIL', 12, 0),
(429, 'BOSCONIA', 12, 0),
(430, 'CHIMICHAGUA', 12, 0),
(431, 'CHIRIGUANA', 12, 0),
(432, 'CURUMANI', 12, 0),
(433, 'EL COPEY', 12, 0),
(434, 'EL PASO', 12, 0),
(435, 'GAMARRA', 12, 0),
(436, 'GONZALEZ', 12, 0),
(437, 'LA GLORIA', 12, 0),
(438, 'LA JAGUA DE IBIRICO', 12, 0),
(439, 'MANAURE', 12, 0),
(440, 'PAILITAS', 12, 0),
(441, 'PELAYA', 12, 0),
(442, 'PUEBLO BELLO', 12, 0),
(443, 'RIO DE ORO', 12, 0),
(444, 'LA PAZ', 12, 0),
(445, 'SAN ALBERTO', 12, 0),
(446, 'SAN DIEGO', 12, 0),
(447, 'SAN MARTIN', 12, 0),
(448, 'TAMALAMEQUE', 12, 0),
(449, 'QUIBDÓ', 13, 1),
(450, 'ACANDI', 13, 0),
(451, 'ALTO BAUDO', 13, 0),
(452, 'ATRATO', 13, 0),
(453, 'BAGADO', 13, 0),
(454, 'BAHIA SOLANO', 13, 0),
(455, 'BAJO BAUDO', 13, 0),
(456, 'BOJAYA', 13, 0),
(457, 'EL CANTON DEL SAN PABLO', 13, 0),
(458, 'CARMEN DEL DARIEN', 13, 0),
(459, 'CERTEGUI', 13, 0),
(460, 'CONDOTO', 13, 0),
(461, 'EL CARMEN DE ATRATO', 13, 0),
(462, 'EL LITORAL DEL SAN JUAN', 13, 0),
(463, 'ISTMINA', 13, 0),
(464, 'JURADO', 13, 0),
(465, 'LLORO', 13, 0),
(466, 'MEDIO ATRATO', 13, 0),
(467, 'MEDIO BAUDO', 13, 0),
(468, 'MEDIO SAN JUAN', 13, 0),
(469, 'NOVITA', 13, 0),
(470, 'NUQUI', 13, 0),
(471, 'RIO IRO', 13, 0),
(472, 'RIO QUITO', 13, 0),
(473, 'RIOSUCIO', 13, 0),
(474, 'SAN JOSE DEL PALMAR', 13, 0),
(475, 'SIPI', 13, 0),
(476, 'TADO', 13, 0),
(477, 'UNGUIA', 13, 0),
(478, 'UNION PANAMERICANA', 13, 0),
(479, 'MONTERÍA', 14, 1),
(480, 'AYAPEL', 14, 0),
(481, 'BUENAVISTA', 14, 0),
(482, 'CANALETE', 14, 0),
(483, 'CERETE', 14, 0),
(484, 'CHIMA', 14, 0),
(485, 'CHINU', 14, 0),
(486, 'CIENAGA DE ORO', 14, 0),
(487, 'COTORRA', 14, 0),
(488, 'LA APARTADA', 14, 0),
(489, 'LORICA', 14, 0),
(490, 'LOS CORDOBAS', 14, 0),
(491, 'MOMIL', 14, 0),
(492, 'MONTELIBANO', 14, 0),
(493, 'MOÑITOS', 14, 0),
(494, 'PLANETA RICA', 14, 0),
(495, 'PUEBLO NUEVO', 14, 0),
(496, 'PUERTO ESCONDIDO', 14, 0),
(497, 'PUERTO LIBERTADOR', 14, 0),
(498, 'PURISIMA', 14, 0),
(499, 'SAHAGUN', 14, 0),
(500, 'SAN ANDRES SOTAVENTO', 14, 0),
(501, 'SAN ANTERO', 14, 0),
(502, 'SAN BERNARDO DEL VIENTO', 14, 0),
(503, 'SAN CARLOS', 14, 0),
(504, 'SAN PELAYO', 14, 0),
(505, 'TIERRALTA', 14, 0),
(506, 'VALENCIA', 14, 0),
(507, 'AGUA DE DIOS', 15, 0),
(508, 'ALBAN', 15, 0),
(509, 'ANAPOIMA', 15, 0),
(510, 'ANOLAIMA', 15, 0),
(511, 'ARBELAEZ', 15, 0),
(512, 'BELTRAN', 15, 0),
(513, 'BITUIMA', 15, 0),
(514, 'BOJACA', 15, 0),
(515, 'CABRERA', 15, 0),
(516, 'CACHIPAY', 15, 0),
(517, 'CAJICA', 15, 0),
(518, 'CAPARRAPI', 15, 0),
(519, 'CAQUEZA', 15, 0),
(520, 'CARMEN DE CARUPA', 15, 0),
(521, 'CHAGUANI', 15, 0),
(522, 'CHIA', 15, 0),
(523, 'CHIPAQUE', 15, 0),
(524, 'CHOACHI', 15, 0),
(525, 'CHOCONTA', 15, 0),
(526, 'COGUA', 15, 0),
(527, 'COTA', 15, 0),
(528, 'CUCUNUBA', 15, 0),
(529, 'EL COLEGIO', 15, 0),
(530, 'EL PEÑON', 15, 0),
(531, 'EL ROSAL', 15, 0),
(532, 'FACATATIVA', 15, 0),
(533, 'FOMEQUE', 15, 0),
(534, 'FOSCA', 15, 0),
(535, 'FUNZA', 15, 0),
(536, 'FUQUENE', 15, 0),
(537, 'FUSAGASUGA', 15, 0),
(538, 'GACHALA', 15, 0),
(539, 'GACHANCIPA', 15, 0),
(540, 'GACHETA', 15, 0),
(541, 'GAMA', 15, 0),
(542, 'GIRARDOT', 15, 0),
(543, 'GRANADA', 15, 0),
(544, 'GUACHETA', 15, 0),
(545, 'GUADUAS', 15, 0),
(546, 'GUASCA', 15, 0),
(547, 'GUATAQUI', 15, 0),
(548, 'GUATAVITA', 15, 0),
(549, 'GUAYABAL DE SIQUIMA', 15, 0),
(550, 'GUAYABETAL', 15, 0),
(551, 'GUTIERREZ', 15, 0),
(552, 'JERUSALEN', 15, 0),
(553, 'JUNIN', 15, 0),
(554, 'LA CALERA', 15, 0),
(555, 'LA MESA', 15, 0),
(556, 'LA PALMA', 15, 0),
(557, 'LA PEÑA', 15, 0),
(558, 'LA VEGA', 15, 0),
(559, 'LENGUAZAQUE', 15, 0),
(560, 'MACHETA', 15, 0),
(561, 'MADRID', 15, 0),
(562, 'MANTA', 15, 0),
(563, 'MEDINA', 15, 0),
(564, 'MOSQUERA', 15, 0),
(565, 'NARIÑO', 15, 0),
(566, 'NEMOCON', 15, 0),
(567, 'NILO', 15, 0),
(568, 'NIMAIMA', 15, 0),
(569, 'NOCAIMA', 15, 0),
(570, 'VENECIA', 15, 0),
(571, 'PACHO', 15, 0),
(572, 'PAIME', 15, 0),
(573, 'PANDI', 15, 0),
(574, 'PARATEBUENO', 15, 0),
(575, 'PASCA', 15, 0),
(576, 'PUERTO SALGAR', 15, 0),
(577, 'PULI', 15, 0),
(578, 'QUEBRADANEGRA', 15, 0),
(579, 'QUETAME', 15, 0),
(580, 'QUIPILE', 15, 0),
(581, 'APULO', 15, 0),
(582, 'RICAURTE', 15, 0),
(583, 'SAN ANTONIO DEL TEQUENDAMA', 15, 0),
(584, 'SAN BERNARDO', 15, 0),
(585, 'SAN CAYETANO', 15, 0),
(586, 'SAN FRANCISCO', 15, 0),
(587, 'SAN JUAN DE RIO SECO', 15, 0),
(588, 'SASAIMA', 15, 0),
(589, 'SESQUILE', 15, 0),
(590, 'SIBATE', 15, 0),
(591, 'SILVANIA', 15, 0),
(592, 'SIMIJACA', 15, 0),
(593, 'SOACHA', 15, 0),
(594, 'SOPO', 15, 0),
(595, 'SUBACHOQUE', 15, 0),
(596, 'SUESCA', 15, 0),
(597, 'SUPATA', 15, 0),
(598, 'SUSA', 15, 0),
(599, 'SUTATAUSA', 15, 0),
(600, 'TABIO', 15, 0),
(601, 'TAUSA', 15, 0),
(602, 'TENA', 15, 0),
(603, 'TENJO', 15, 0),
(604, 'TIBACUY', 15, 0),
(605, 'TIBIRITA', 15, 0),
(606, 'TOCAIMA', 15, 0),
(607, 'TOCANCIPA', 15, 0),
(608, 'TOPAIPI', 15, 0),
(609, 'UBALA', 15, 0),
(610, 'UBAQUE', 15, 0),
(611, 'VILLA DE SAN DIEGO DE UBATE', 15, 0),
(612, 'UNE', 15, 0),
(613, 'UTICA', 15, 0),
(614, 'VERGARA', 15, 0),
(615, 'VIANI', 15, 0),
(616, 'VILLAGOMEZ', 15, 0),
(617, 'VILLAPINZON', 15, 0),
(618, 'VILLETA', 15, 0),
(619, 'VIOTA', 15, 0),
(620, 'YACOPI', 15, 0),
(621, 'ZIPACON', 15, 0),
(622, 'ZIPAQUIRA', 15, 0),
(623, 'MAPIRIPANA', 16, 0),
(624, 'PANA PANA', 16, 0),
(625, 'MORICHAL', 16, 0),
(626, 'PUERTO INÍRIDA', 16, 1),
(627, 'BARRANCO MINAS', 16, 0),
(628, 'SAN FELIPE', 16, 0),
(629, 'PUERTO COLOMBIA', 16, 0),
(630, 'LA GUADALUPE', 16, 0),
(631, 'CACAHUAL', 16, 0),
(632, 'SAN JOSÉ DEL GUAVIARE', 17, 1),
(633, 'CALAMAR', 17, 0),
(634, 'EL RETORNO', 17, 0),
(635, 'MIRAFLORES', 17, 0),
(636, 'ISNOS', 18, 0),
(637, 'LA ARGENTINA', 18, 0),
(638, 'LA PLATA', 18, 0),
(639, 'NATAGA', 18, 0),
(640, 'OPORAPA', 18, 0),
(641, 'PAICOL', 18, 0),
(642, 'PALERMO', 18, 0),
(643, 'PALESTINA', 18, 0),
(644, 'PITAL', 18, 0),
(645, 'PITALITO', 18, 0),
(646, 'RIVERA', 18, 0),
(647, 'SALADOBLANCO', 18, 0),
(648, 'SAN AGUSTIN', 18, 0),
(649, 'SANTA MARIA', 18, 0),
(650, 'SUAZA', 18, 0),
(651, 'TARQUI', 18, 0),
(652, 'TESALIA', 18, 0),
(653, 'TELLO', 18, 0),
(654, 'TERUEL', 18, 0),
(655, 'TIMANA', 18, 0),
(656, 'VILLAVIEJA', 18, 0),
(657, 'YAGUARA', 18, 0),
(658, 'BOJACA', 18, 0),
(659, 'CABRERA', 18, 0),
(660, 'CACHIPAY', 18, 0),
(661, 'CAJICA', 18, 0),
(662, 'CAPARRAPI', 18, 0),
(663, 'CAQUEZA', 18, 0),
(664, 'CARMEN DE CARUPA', 18, 0),
(665, 'CHAGUANI', 18, 0),
(666, 'CHIA', 18, 0),
(667, 'CHIPAQUE', 18, 0),
(668, 'CHOACHI', 18, 0),
(669, 'CHOCONTA', 18, 0),
(670, 'COGUA', 18, 0),
(671, 'COTA', 18, 0),
(672, 'CUCUNUBA', 18, 0),
(673, 'EL COLEGIO', 18, 0),
(674, 'EL PEÑON', 18, 0),
(675, 'EL ROSAL', 18, 0),
(676, 'FACATATIVA', 18, 0),
(677, 'FOMEQUE', 18, 0),
(678, 'FOSCA', 18, 0),
(679, 'FUNZA', 18, 0),
(680, 'FUQUENE', 18, 0),
(681, 'FUSAGASUGA', 18, 0),
(682, 'GACHALA', 18, 0),
(683, 'GACHANCIPA', 18, 0),
(684, 'GACHETA', 18, 0),
(685, 'GAMA', 18, 0),
(686, 'GIRARDOT', 18, 0),
(687, 'GRANADA', 18, 0),
(688, 'GUACHETA', 18, 0),
(689, 'GUADUAS', 18, 0),
(690, 'GUASCA', 18, 0),
(691, 'GUATAQUI', 18, 0),
(692, 'GUATAVITA', 18, 0),
(693, 'GUAYABAL DE SIQUIMA', 18, 0),
(694, 'GUAYABETAL', 18, 0),
(695, 'GUTIERREZ', 18, 0),
(696, 'JERUSALEN', 18, 0),
(697, 'JUNIN', 18, 0),
(698, 'LA CALERA', 18, 0),
(699, 'LA MESA', 18, 0),
(700, 'LA PALMA', 18, 0),
(701, 'LA PEÑA', 18, 0),
(702, 'LA VEGA', 18, 0),
(703, 'LENGUAZAQUE', 18, 0),
(704, 'MACHETA', 18, 0),
(705, 'MADRID', 18, 0),
(706, 'MANTA', 18, 0),
(707, 'MEDINA', 18, 0),
(708, 'MOSQUERA', 18, 0),
(709, 'NARIÑO', 18, 0),
(710, 'NEMOCON', 18, 0),
(711, 'NILO', 18, 0),
(712, 'NIMAIMA', 18, 0),
(713, 'NOCAIMA', 18, 0),
(714, 'VENECIA', 18, 0),
(715, 'PACHO', 18, 0),
(716, 'PAIME', 18, 0),
(717, 'PANDI', 18, 0),
(718, 'PARATEBUENO', 18, 0),
(719, 'PASCA', 18, 0),
(720, 'PUERTO SALGAR', 18, 0),
(721, 'PULI', 18, 0),
(722, 'QUEBRADANEGRA', 18, 0),
(723, 'QUETAME', 18, 0),
(724, 'QUIPILE', 18, 0),
(725, 'APULO', 18, 0),
(726, 'RICAURTE', 18, 0),
(727, 'SAN ANTONIO DEL TEQUENDAMA', 18, 0),
(728, 'SAN BERNARDO', 18, 0),
(729, 'SAN CAYETANO', 18, 0),
(730, 'SAN FRANCISCO', 18, 0),
(731, 'SAN JUAN DE RIO SECO', 18, 0),
(732, 'SASAIMA', 18, 0),
(733, 'SESQUILE', 18, 0),
(734, 'SIBATE', 18, 0),
(735, 'SILVANIA', 18, 0),
(736, 'SIMIJACA', 18, 0),
(737, 'SOACHA', 18, 0),
(738, 'SOPO', 18, 0),
(739, 'SUBACHOQUE', 18, 0),
(740, 'SUESCA', 18, 0),
(741, 'SUPATA', 18, 0),
(742, 'SUSA', 18, 0),
(743, 'SUTATAUSA', 18, 0),
(744, 'TABIO', 18, 0),
(745, 'TAUSA', 18, 0),
(746, 'TENA', 18, 0),
(747, 'TENJO', 18, 0),
(748, 'TIBACUY', 18, 0),
(749, 'TIBIRITA', 18, 0),
(750, 'TOCAIMA', 18, 0),
(751, 'TOCANCIPA', 18, 0),
(752, 'TOPAIPI', 18, 0),
(753, 'UBALA', 18, 0),
(754, 'UBAQUE', 18, 0),
(755, 'VILLA DE SAN DIEGO DE UBATE', 18, 0),
(756, 'UNE', 18, 0),
(757, 'UTICA', 18, 0),
(758, 'VERGARA', 18, 0),
(759, 'VIANI', 18, 0),
(760, 'VILLAGOMEZ', 18, 0),
(761, 'VILLAPINZON', 18, 0),
(762, 'VILLETA', 18, 0),
(763, 'VIOTA', 18, 0),
(764, 'YACOPI', 18, 0),
(765, 'ZIPACON', 18, 0),
(766, 'ZIPAQUIRA', 18, 0),
(767, 'RIOHACHA', 19, 1),
(768, 'ALBANIA', 19, 0),
(769, 'BARRANCAS', 19, 0),
(770, 'DIBULLA', 19, 0),
(771, 'DISTRACCION', 19, 0),
(772, 'EL MOLINO', 19, 0),
(773, 'FONSECA', 19, 0),
(774, 'HATONUEVO', 19, 0),
(775, 'LA JAGUA DEL PILAR', 19, 0),
(776, 'MAICAO', 19, 0),
(777, 'MANAURE', 19, 0),
(778, 'SAN JUAN DEL CESAR', 19, 0),
(779, 'URIBIA', 19, 0),
(780, 'URUMITA', 19, 0),
(781, 'VILLANUEVA', 19, 0),
(782, 'SANTA MARTA', 20, 1),
(783, 'ALGARROBO', 20, 0),
(784, 'ARACATACA', 20, 0),
(785, 'ARIGUANI', 20, 0),
(786, 'CERRO SAN ANTONIO', 20, 0),
(787, 'CHIBOLO', 20, 0),
(788, 'CIENAGA', 20, 0),
(789, 'CONCORDIA', 20, 0),
(790, 'EL BANCO', 20, 0),
(791, 'EL PIÑON', 20, 0),
(792, 'EL RETEN', 20, 0),
(793, 'FUNDACION', 20, 0),
(794, 'GUAMAL', 20, 0),
(795, 'NUEVA GRANADA', 20, 0),
(796, 'PEDRAZA', 20, 0),
(797, 'PIJIÑO DEL CARMEN', 20, 0),
(798, 'PIVIJAY', 20, 0),
(799, 'PLATO', 20, 0),
(800, 'PUEBLOVIEJO', 20, 0),
(801, 'REMOLINO', 20, 0),
(802, 'SABANAS DE SAN ANGEL', 20, 0),
(803, 'SALAMINA', 20, 0),
(804, 'SAN SEBASTIAN DE BUENAVISTA', 20, 0),
(805, 'SAN ZENON', 20, 0),
(806, 'SANTA ANA', 20, 0),
(807, 'SANTA BARBARA DE PINTO', 20, 0),
(808, 'SITIONUEVO', 20, 0),
(809, 'TENERIFE', 20, 0),
(810, 'ZAPAYAN', 20, 0),
(811, 'ZONA BANANERA', 20, 0),
(812, 'VILLAVICENCIO', 21, 1),
(813, 'ACACIAS', 21, 0),
(814, 'BARRANCA DE UPIA', 21, 0),
(815, 'CABUYARO', 21, 0),
(816, 'CASTILLA LA NUEVA', 21, 0),
(817, 'CUBARRAL', 21, 0),
(818, 'CUMARAL', 21, 0),
(819, 'EL CALVARIO', 21, 0),
(820, 'EL CASTILLO', 21, 0),
(821, 'EL DORADO', 21, 0),
(822, 'FUENTE DE ORO', 21, 0),
(823, 'GRANADA', 21, 0),
(824, 'GUAMAL', 21, 0),
(825, 'MAPIRIPAN', 21, 0),
(826, 'MESETAS', 21, 0),
(827, 'LA MACARENA', 21, 0),
(828, 'URIBE', 21, 0),
(829, 'LEJANIAS', 21, 0),
(830, 'PUERTO CONCORDIA', 21, 0),
(831, 'PUERTO GAITAN', 21, 0),
(832, 'PUERTO LOPEZ', 21, 0),
(833, 'PUERTO LLERAS', 21, 0),
(834, 'PUERTO RICO', 21, 0),
(835, 'RESTREPO', 21, 0),
(836, 'SAN CARLOS DE GUAROA', 21, 0),
(837, 'SAN JUAN DE ARAMA', 21, 0),
(838, 'SAN JUANITO', 21, 0),
(839, 'SAN MARTIN', 21, 0),
(840, 'VISTAHERMOSA', 21, 0),
(841, 'CÚCUTA', 22, 1),
(842, 'ABREGO', 22, 0),
(843, 'ARBOLEDAS', 22, 0),
(844, 'BOCHALEMA', 22, 0),
(845, 'BUCARASICA', 22, 0),
(846, 'CACOTA', 22, 0),
(847, 'CACHIRA', 22, 0),
(848, 'CHINACOTA', 22, 0),
(849, 'CHITAGA', 22, 0),
(850, 'CONVENCION', 22, 0),
(851, 'CUCUTILLA', 22, 0),
(852, 'DURANIA', 22, 0),
(853, 'EL CARMEN', 22, 0),
(854, 'EL TARRA', 22, 0),
(855, 'EL ZULIA', 22, 0),
(856, 'GRAMALOTE', 22, 0),
(857, 'HACARI', 22, 0),
(858, 'HERRAN', 22, 0),
(859, 'LABATECA', 22, 0),
(860, 'LA ESPERANZA', 22, 0),
(861, 'LA PLAYA', 22, 0),
(862, 'LOS PATIOS', 22, 0),
(863, 'LOURDES', 22, 0),
(864, 'MUTISCUA', 22, 0),
(865, 'OCAÑA', 22, 0),
(866, 'PAMPLONA', 22, 0),
(867, 'PAMPLONITA', 22, 0),
(868, 'PUERTO SANTANDER', 22, 0),
(869, 'RAGONVALIA', 22, 0),
(870, 'SALAZAR', 22, 0),
(871, 'SAN CALIXTO', 22, 0),
(872, 'SAN CAYETANO', 22, 0),
(873, 'SANTIAGO', 22, 0),
(874, 'SARDINATA', 22, 0),
(875, 'SILOS', 22, 0),
(876, 'TEORAMA', 22, 0),
(877, 'TIBU', 22, 0),
(878, 'TOLEDO', 22, 0),
(879, 'VILLA CARO', 22, 0),
(880, 'VILLA DEL ROSARIO', 22, 0),
(881, 'PASTO', 23, 1),
(882, 'ALBAN', 23, 0),
(883, 'ALDANA', 23, 0),
(884, 'ANCUYA', 23, 0),
(885, 'ARBOLEDA', 23, 0),
(886, 'BARBACOAS', 23, 0),
(887, 'BELEN', 23, 0),
(888, 'BUESACO', 23, 0),
(889, 'COLON', 23, 0),
(890, 'CONSACA', 23, 0),
(891, 'CONTADERO', 23, 0),
(892, 'CORDOBA', 23, 0),
(893, 'CUASPUD', 23, 0),
(894, 'CUMBAL', 23, 0),
(895, 'CUMBITARA', 23, 0),
(896, 'CHACHAGsI', 23, 0),
(897, 'EL CHARCO', 23, 0),
(898, 'EL PEÑOL', 23, 0),
(899, 'EL ROSARIO', 23, 0),
(900, 'EL TABLON DE GOMEZ', 23, 0),
(901, 'EL TAMBO', 23, 0),
(902, 'FUNES', 23, 0),
(903, 'GUACHUCAL', 23, 0),
(904, 'GUAITARILLA', 23, 0),
(905, 'GUALMATAN', 23, 0),
(906, 'ILES', 23, 0),
(907, 'IMUES', 23, 0),
(908, 'IPIALES', 23, 0),
(909, 'LA CRUZ', 23, 0),
(910, 'LA FLORIDA', 23, 0),
(911, 'LA LLANADA', 23, 0),
(912, 'LA TOLA', 23, 0),
(913, 'LA UNION', 23, 0),
(914, 'LEIVA', 23, 0),
(915, 'LINARES', 23, 0),
(916, 'LOS ANDES', 23, 0),
(917, 'MAGsI', 23, 0),
(918, 'MALLAMA', 23, 0),
(919, 'MOSQUERA', 23, 0),
(920, 'NARIÑO', 23, 0),
(921, 'OLAYA HERRERA', 23, 0),
(922, 'OSPINA', 23, 0),
(923, 'FRANCISCO PIZARRO', 23, 0),
(924, 'POLICARPA', 23, 0),
(925, 'POTOSI', 23, 0),
(926, 'PROVIDENCIA', 23, 0),
(927, 'PUERRES', 23, 0),
(928, 'PUPIALES', 23, 0),
(929, 'RICAURTE', 23, 0),
(930, 'ROBERTO PAYAN', 23, 0),
(931, 'SAMANIEGO', 23, 0),
(932, 'SANDONA', 23, 0),
(933, 'SAN BERNARDO', 23, 0),
(934, 'SAN LORENZO', 23, 0),
(935, 'SAN PABLO', 23, 0),
(936, 'SAN PEDRO DE CARTAGO', 23, 0),
(937, 'SANTA BARBARA', 23, 0),
(938, 'SANTACRUZ', 23, 0),
(939, 'SAPUYES', 23, 0),
(940, 'TAMINANGO', 23, 0),
(941, 'TANGUA', 23, 0),
(942, 'SAN ANDRES DE TUMACO', 23, 0),
(943, 'TUQUERRES', 23, 0),
(944, 'YACUANQUER', 23, 0),
(945, 'MOCOA', 24, 1),
(946, 'COLON', 24, 0),
(947, 'ORITO', 24, 0),
(948, 'PUERTO ASIS', 24, 0),
(949, 'PUERTO CAICEDO', 24, 0),
(950, 'PUERTO GUZMAN', 24, 0),
(951, 'LEGUIZAMO', 24, 0),
(952, 'SIBUNDOY', 24, 0),
(953, 'SAN FRANCISCO', 24, 0),
(954, 'SAN MIGUEL', 24, 0),
(955, 'SANTIAGO', 24, 0),
(956, 'VALLE DEL GUAMUEZ', 24, 0),
(957, 'VILLAGARZON', 24, 0),
(958, 'ARMENIA', 25, 1),
(959, 'BUENAVISTA', 25, 0),
(960, 'CALARCA', 25, 0),
(961, 'CIRCASIA', 25, 0),
(962, 'CORDOBA', 25, 0),
(963, 'FILANDIA', 25, 0),
(964, 'GENOVA', 25, 0),
(965, 'LA TEBAIDA', 25, 0),
(966, 'MONTENEGRO', 25, 0),
(967, 'PIJAO', 25, 0),
(968, 'QUIMBAYA', 25, 0),
(969, 'SALENTO', 25, 0),
(970, 'PEREIRA', 26, 1),
(971, 'APIA', 26, 0),
(972, 'BALBOA', 26, 0),
(973, 'BELEN DE UMBRIA', 26, 0),
(974, 'DOSQUEBRADAS', 26, 0),
(975, 'GUATICA', 26, 0),
(976, 'LA CELIA', 26, 0),
(977, 'LA VIRGINIA', 26, 0),
(978, 'MARSELLA', 26, 0),
(979, 'MISTRATO', 26, 0),
(980, 'PUEBLO RICO', 26, 0),
(981, 'QUINCHIA', 26, 0),
(982, 'SANTA ROSA DE CABAL', 26, 0),
(983, 'SANTUARIO', 26, 0),
(984, 'SAN ANDRES', 27, 1),
(985, 'PROVIDENCIA', 27, 0),
(986, 'BUCARAMANGA', 28, 1),
(987, 'AGUADA', 28, 0),
(988, 'ALBANIA', 28, 0),
(989, 'ARATOCA', 28, 0),
(990, 'BARBOSA', 28, 0),
(991, 'BARICHARA', 28, 0),
(992, 'BARRANCABERMEJA', 28, 0),
(993, 'BETULIA', 28, 0),
(994, 'BOLIVAR', 28, 0),
(995, 'CABRERA', 28, 0),
(996, 'CALIFORNIA', 28, 0),
(997, 'CAPITANEJO', 28, 0),
(998, 'CARCASI', 28, 0),
(999, 'CEPITA', 28, 0),
(1000, 'CERRITO', 28, 0),
(1001, 'CHARALA', 28, 0),
(1002, 'CHARTA', 28, 0),
(1003, 'CHIMA', 28, 0),
(1004, 'CHIPATA', 28, 0),
(1005, 'CIMITARRA', 28, 0),
(1006, 'CONCEPCION', 28, 0),
(1007, 'CONFINES', 28, 0),
(1008, 'CONTRATACION', 28, 0),
(1009, 'COROMORO', 28, 0),
(1010, 'CURITI', 28, 0),
(1011, 'EL CARMEN DE CHUCURI', 28, 0),
(1012, 'EL GUACAMAYO', 28, 0),
(1013, 'EL PEÑON', 28, 0),
(1014, 'EL PLAYON', 28, 0),
(1015, 'ENCINO', 28, 0),
(1016, 'ENCISO', 28, 0),
(1017, 'FLORIAN', 28, 0),
(1018, 'FLORIDABLANCA', 28, 0),
(1019, 'GALAN', 28, 0),
(1020, 'GAMBITA', 28, 0),
(1021, 'GIRON', 28, 0),
(1022, 'GUACA', 28, 0),
(1023, 'GUADALUPE', 28, 0),
(1024, 'GUAPOTA', 28, 0),
(1025, 'GUAVATA', 28, 0),
(1026, 'GsEPSA', 28, 0),
(1027, 'HATO', 28, 0),
(1028, 'JESUS MARIA', 28, 0),
(1029, 'JORDAN', 28, 0),
(1030, 'LA BELLEZA', 28, 0),
(1031, 'LANDAZURI', 28, 0),
(1032, 'LA PAZ', 28, 0),
(1033, 'LEBRIJA', 28, 0),
(1034, 'LOS SANTOS', 28, 0),
(1035, 'MACARAVITA', 28, 0),
(1036, 'MALAGA', 28, 0),
(1037, 'MATANZA', 28, 0),
(1038, 'MOGOTES', 28, 0),
(1039, 'MOLAGAVITA', 28, 0),
(1040, 'OCAMONTE', 28, 0),
(1041, 'OIBA', 28, 0),
(1042, 'ONZAGA', 28, 0),
(1043, 'PALMAR', 28, 0),
(1044, 'PALMAS DEL SOCORRO', 28, 0),
(1045, 'PARAMO', 28, 0),
(1046, 'PIEDECUESTA', 28, 0),
(1047, 'PINCHOTE', 28, 0),
(1048, 'PUENTE NACIONAL', 28, 0),
(1049, 'PUERTO PARRA', 28, 0),
(1050, 'PUERTO WILCHES', 28, 0),
(1051, 'RIONEGRO', 28, 0),
(1052, 'SABANA DE TORRES', 28, 0),
(1053, 'SAN ANDRES', 28, 0),
(1054, 'SAN BENITO', 28, 0),
(1055, 'SAN GIL', 28, 0),
(1056, 'SAN JOAQUIN', 28, 0),
(1057, 'SAN JOSE DE MIRANDA', 28, 0),
(1058, 'SAN MIGUEL', 28, 0),
(1059, 'SAN VICENTE DE CHUCURI', 28, 0),
(1060, 'SANTA BARBARA', 28, 0),
(1061, 'SANTA HELENA DEL OPON', 28, 0),
(1062, 'SIMACOTA', 28, 0),
(1063, 'SOCORRO', 28, 0),
(1064, 'SUAITA', 28, 0),
(1065, 'SUCRE', 28, 0),
(1066, 'SURATA', 28, 0),
(1067, 'TONA', 28, 0),
(1068, 'VALLE DE SAN JOSE', 28, 0),
(1069, 'VELEZ', 28, 0),
(1070, 'VETAS', 28, 0),
(1071, 'VILLANUEVA', 28, 0),
(1072, 'ZAPATOCA', 28, 0),
(1073, 'SINCELEJO', 29, 1),
(1074, 'BUENAVISTA', 29, 0),
(1075, 'CAIMITO', 29, 0),
(1076, 'COLOSO', 29, 0),
(1077, 'COROZAL', 29, 0),
(1078, 'COVEÑAS', 29, 0),
(1079, 'CHALAN', 29, 0),
(1080, 'EL ROBLE', 29, 0),
(1081, 'GALERAS', 29, 0),
(1082, 'GUARANDA', 29, 0),
(1083, 'LA UNION', 29, 0),
(1084, 'LOS PALMITOS', 29, 0),
(1085, 'MAJAGUAL', 29, 0),
(1086, 'MORROA', 29, 0),
(1087, 'OVEJAS', 29, 0),
(1088, 'PALMITO', 29, 0),
(1089, 'SAMPUES', 29, 0),
(1090, 'SAN BENITO ABAD', 29, 0),
(1091, 'SAN JUAN DE BETULIA', 29, 0),
(1092, 'SAN MARCOS', 29, 0),
(1093, 'SAN ONOFRE', 29, 0),
(1094, 'SAN PEDRO', 29, 0),
(1095, 'SAN LUIS DE SINCE', 29, 0),
(1096, 'SUCRE', 29, 0),
(1097, 'SANTIAGO DE TOLU', 29, 0),
(1098, 'TOLU VIEJO', 29, 0),
(1099, 'IBAGUÉ', 30, 1),
(1100, 'ALPUJARRA', 30, 0),
(1101, 'ALVARADO', 30, 0),
(1102, 'AMBALEMA', 30, 0),
(1103, 'ANZOATEGUI', 30, 0),
(1104, 'ARMERO', 30, 0),
(1105, 'ATACO', 30, 0),
(1106, 'CAJAMARCA', 30, 0),
(1107, 'CARMEN DE APICALA', 30, 0),
(1108, 'CASABIANCA', 30, 0),
(1109, 'CHAPARRAL', 30, 0),
(1110, 'COELLO', 30, 0),
(1111, 'COYAIMA', 30, 0),
(1112, 'CUNDAY', 30, 0),
(1113, 'DOLORES', 30, 0),
(1114, 'ESPINAL', 30, 0),
(1115, 'FALAN', 30, 0),
(1116, 'FLANDES', 30, 0),
(1117, 'FRESNO', 30, 0),
(1118, 'GUAMO', 30, 0),
(1119, 'HERVEO', 30, 0),
(1120, 'HONDA', 30, 0),
(1121, 'ICONONZO', 30, 0),
(1122, 'LERIDA', 30, 0),
(1123, 'LIBANO', 30, 0),
(1124, 'MARIQUITA', 30, 0),
(1125, 'MELGAR', 30, 0),
(1126, 'MURILLO', 30, 0),
(1127, 'NATAGAIMA', 30, 0),
(1128, 'ORTEGA', 30, 0),
(1129, 'PALOCABILDO', 30, 0),
(1130, 'PIEDRAS', 30, 0),
(1131, 'PLANADAS', 30, 0),
(1132, 'PRADO', 30, 0),
(1133, 'PURIFICACION', 30, 0),
(1134, 'RIOBLANCO', 30, 0),
(1135, 'RONCESVALLES', 30, 0),
(1136, 'ROVIRA', 30, 0),
(1137, 'SALDAÑA', 30, 0),
(1138, 'SAN ANTONIO', 30, 0),
(1139, 'SAN LUIS', 30, 0),
(1140, 'SANTA ISABEL', 30, 0),
(1141, 'SUAREZ', 30, 0),
(1142, 'VALLE DE SAN JUAN', 30, 0),
(1143, 'VENADILLO', 30, 0),
(1144, 'VILLAHERMOSA', 30, 0),
(1145, 'VILLARRICA', 30, 0),
(1146, 'CALI', 31, 1),
(1147, 'ALCALA', 31, 0),
(1148, 'ANDALUCIA', 31, 0),
(1149, 'ANSERMANUEVO', 31, 0),
(1150, 'ARGELIA', 31, 0),
(1151, 'BOLIVAR', 31, 0),
(1152, 'BUENAVENTURA', 31, 0),
(1153, 'GUADALAJARA DE BUGA', 31, 0),
(1154, 'BUGALAGRANDE', 31, 0),
(1155, 'CAICEDONIA', 31, 0),
(1156, 'CALIMA', 31, 0),
(1157, 'CANDELARIA', 31, 0),
(1158, 'CARTAGO', 31, 0),
(1159, 'DAGUA', 31, 0),
(1160, 'EL AGUILA', 31, 0),
(1161, 'EL CAIRO', 31, 0),
(1162, 'EL CERRITO', 31, 0),
(1163, 'EL DOVIO', 31, 0),
(1164, 'FLORIDA', 31, 0),
(1165, 'GINEBRA', 31, 0),
(1166, 'GUACARI', 31, 0),
(1167, 'JAMUNDI', 31, 0),
(1168, 'LA CUMBRE', 31, 0),
(1169, 'LA UNION', 31, 0),
(1170, 'LA VICTORIA', 31, 0),
(1171, 'OBANDO', 31, 0),
(1172, 'PALMIRA', 31, 0),
(1173, 'PRADERA', 31, 0),
(1174, 'RESTREPO', 31, 0),
(1175, 'RIOFRIO', 31, 0),
(1176, 'ROLDANILLO', 31, 0),
(1177, 'SAN PEDRO', 31, 0),
(1178, 'SEVILLA', 31, 0),
(1179, 'TORO', 31, 0),
(1180, 'TRUJILLO', 31, 0),
(1181, 'TULUA', 31, 0),
(1182, 'ULLOA', 31, 0),
(1183, 'VERSALLES', 31, 0),
(1184, 'VIJES', 31, 0),
(1185, 'YOTOCO', 31, 0),
(1186, 'YUMBO', 31, 0),
(1187, 'ZARZAL', 31, 0),
(1188, 'PACOA', 32, 0),
(1189, 'MITÚ', 32, 1),
(1190, 'CARURU', 32, 0),
(1191, 'TARAIRA', 32, 0),
(1192, 'PAPUNAUA', 32, 0),
(1193, 'YAVARATE', 32, 0),
(1194, 'PUERTO CARREÑO', 33, 1),
(1195, 'LA PRIMAVERA', 33, 0),
(1196, 'SANTA ROSALIA', 33, 0),
(1197, 'CUMARIBO', 33, 0),
(1198, 'MANIZALES', 8, 1),
(1199, 'NEIVA', 18, 1);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
