-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-06-2019 a las 23:51:42
-- Versión del servidor: 10.1.37-MariaDB
-- Versión de PHP: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `simulator`
--
CREATE DATABASE IF NOT EXISTS `simulator` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `simulator`;

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
CREATE TABLE `conditions` (
  `Cond_id` int(11) NOT NULL,
  `Cond_initial` int(11) NOT NULL,
  `Cond_final` int(11) NOT NULL,
  `Cond_percent` decimal(4,2) NOT NULL,
  `Sim_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELACIONES PARA LA TABLA `conditions`:
--   `Sim_id`
--       `simulators` -> `Sim_id`
--

--
-- Truncar tablas antes de insertar `conditions`
--

TRUNCATE TABLE `conditions`;
--
-- Volcado de datos para la tabla `conditions`
--

INSERT INTO `conditions` (`Cond_id`, `Cond_initial`, `Cond_final`, `Cond_percent`, `Sim_id`) VALUES
(2, 1, 6, '2.50', 1),
(3, 7, 12, '2.30', 1),
(4, 13, 24, '2.00', 1),
(5, 1, 6, '2.20', 2),
(6, 7, 12, '2.00', 2),
(7, 13, 18, '1.80', 2),
(8, 19, 24, '1.50', 2),
(9, 1, 6, '2.10', 3),
(10, 1, 6, '3.10', 4),
(11, 1, 6, '3.10', 5),
(12, 1, 6, '3.10', 6),
(13, 1, 6, '3.10', 7),
(14, 1, 6, '3.10', 8),
(15, 1, 6, '3.10', 9),
(16, 7, 12, '2.10', 10),
(17, 7, 12, '2.10', 11),
(18, 7, 12, '2.10', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `Dep_id` int(11) NOT NULL,
  `Dep_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELACIONES PARA LA TABLA `department`:
--

--
-- Truncar tablas antes de insertar `department`
--

TRUNCATE TABLE `department`;
--
-- Volcado de datos para la tabla `department`
--

INSERT INTO `department` (`Dep_id`, `Dep_name`) VALUES
(2, 'Amazonas'),
(3, 'Antioquia'),
(4, 'Arauca'),
(5, 'Atlántico'),
(1, 'Cundinamarca');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entry`
--

DROP TABLE IF EXISTS `entry`;
CREATE TABLE `entry` (
  `Ent_id` int(11) NOT NULL,
  `Login_id` int(11) NOT NULL,
  `Stat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELACIONES PARA LA TABLA `entry`:
--   `Login_id`
--       `login` -> `Login_id`
--   `Stat_id`
--       `status` -> `Stat_id`
--

--
-- Truncar tablas antes de insertar `entry`
--

TRUNCATE TABLE `entry`;
--
-- Volcado de datos para la tabla `entry`
--

INSERT INTO `entry` (`Ent_id`, `Login_id`, `Stat_id`) VALUES
(1, 1, 2),
(2, 1, 4),
(3, 2, 1),
(4, 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

DROP TABLE IF EXISTS `login`;
CREATE TABLE `login` (
  `Login_id` int(11) NOT NULL,
  `Login_password` varchar(30) NOT NULL,
  `User_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELACIONES PARA LA TABLA `login`:
--   `User_id`
--       `users` -> `User_id`
--

--
-- Truncar tablas antes de insertar `login`
--

TRUNCATE TABLE `login`;
--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`Login_id`, `Login_password`, `User_id`) VALUES
(1, 'Lero1234', 1),
(2, 'dhcasallas*', 2),
(3, 'PASS123456', 4),
(4, 'juli1234', 11),
(5, 'lucia74', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `simulators`
--

DROP TABLE IF EXISTS `simulators`;
CREATE TABLE `simulators` (
  `Sim_id` int(11) NOT NULL,
  `Sim_name` varchar(80) CHARACTER SET utf8 NOT NULL,
  `Sim_description` varchar(200) CHARACTER SET utf8 NOT NULL,
  `Sim_conditions` varchar(200) CHARACTER SET utf8 NOT NULL,
  `Sim_benefits` varchar(200) CHARACTER SET utf8 NOT NULL,
  `Sim_destination` varchar(200) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELACIONES PARA LA TABLA `simulators`:
--

--
-- Truncar tablas antes de insertar `simulators`
--

TRUNCATE TABLE `simulators`;
--
-- Volcado de datos para la tabla `simulators`
--

INSERT INTO `simulators` (`Sim_id`, `Sim_name`, `Sim_description`, `Sim_conditions`, `Sim_benefits`, `Sim_destination`) VALUES
(1, 'Credito Libre inversion', 'Creditos disponibles para todas las peronas mayores de edad', 'Mayores de edad', 'Cuotas fijas', ''),
(2, 'Credito Vivienda', 'Descripcion', '', '', ''),
(3, 'Credito vehiculo', 'Credito para mayores de edad y tenga cuenta con el banco desde hace 6 meses', '', '', ''),
(4, 'Credito Prueba', 'Lero Prueba', '', '', ''),
(5, 'Credito Prueba', 'Lero Prueba', '', '', ''),
(6, 'Credito Prueba', 'Lero Prueba', '', '', ''),
(7, 'Credito Prueba', 'Lero Prueba', '', '', ''),
(8, 'Credito Prueba', 'Lero Prueba', '', '', ''),
(9, 'Credito Prueba', 'Lero Prueba', '', '', ''),
(10, 'Credito Prueba 2', 'Texto ', '', '', ''),
(11, 'Credito Prueba 2', 'Texto ', '', '', ''),
(12, 'Credito Prueba 2', 'Texto ', '', '', ''),
(13, 'Credito libranza', 'Descripcion', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `Stat_id` int(11) NOT NULL,
  `Stat_name` varchar(30) NOT NULL,
  `Type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELACIONES PARA LA TABLA `status`:
--   `Type_id`
--       `status_type` -> `Type_id`
--

--
-- Truncar tablas antes de insertar `status`
--

TRUNCATE TABLE `status`;
--
-- Volcado de datos para la tabla `status`
--

INSERT INTO `status` (`Stat_id`, `Stat_name`, `Type_id`) VALUES
(1, 'Logueado', 2),
(2, 'Inactivo', 1),
(3, 'Activo', 1),
(4, 'Cierre de sesión', 2),
(5, 'Bloqueado', 1),
(6, 'Mora', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status_type`
--

DROP TABLE IF EXISTS `status_type`;
CREATE TABLE `status_type` (
  `Type_id` int(11) NOT NULL,
  `Type_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELACIONES PARA LA TABLA `status_type`:
--

--
-- Truncar tablas antes de insertar `status_type`
--

TRUNCATE TABLE `status_type`;
--
-- Volcado de datos para la tabla `status_type`
--

INSERT INTO `status_type` (`Type_id`, `Type_name`) VALUES
(1, 'Usuario'),
(2, 'Sesión'),
(3, 'Crédito');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `township`
--

DROP TABLE IF EXISTS `township`;
CREATE TABLE `township` (
  `Town_id` int(11) NOT NULL,
  `Town_name` varchar(100) NOT NULL,
  `Dep_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELACIONES PARA LA TABLA `township`:
--   `Dep_id`
--       `department` -> `Dep_id`
--

--
-- Truncar tablas antes de insertar `township`
--

TRUNCATE TABLE `township`;
--
-- Volcado de datos para la tabla `township`
--

INSERT INTO `township` (`Town_id`, `Town_name`, `Dep_id`) VALUES
(2, 'Bogotá D.C.', 1),
(3, 'Leticia', 2),
(4, 'Medellín', 3),
(5, 'Arauca', 4),
(6, 'Barranquilla', 5),
(7, 'Soacha', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `User_id` int(11) NOT NULL,
  `User_name` varchar(80) NOT NULL,
  `User_identification` int(11) NOT NULL,
  `User_email` varchar(200) NOT NULL,
  `Stat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELACIONES PARA LA TABLA `users`:
--   `Stat_id`
--       `status` -> `Stat_id`
--

--
-- Truncar tablas antes de insertar `users`
--

TRUNCATE TABLE `users`;
--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`User_id`, `User_name`, `User_identification`, `User_email`, `Stat_id`) VALUES
(1, 'Laura Grisales', 1030633992, 'lauramggarcia@hotmail.com', 3),
(2, 'Lunita Ruiz', 0, '', 2),
(3, 'Melissa Roa', 1030654873, 'melroa@hotmail.com', 5),
(4, 'Martha Carrillo', 54234345, 'martha.carrillo@yahoo.com', 3),
(5, 'Luna Rosada', 123456789, 'lauramggarcia@gmail.com', 3),
(6, 'Lucia Camargo', 12345674, 'lcamargo@gmail.com', 3),
(7, 'Marcela Garcia', 2147483647, 'elmardecristal@gmail.com', 3),
(8, 'Lizeth Dominguez', 1044876542, 'dominguezl@hotmail.com', 3),
(9, 'Lina Miranda', 9874653, 'marianda@gmail.com', 3),
(10, 'Julian Restrepo', 1239874562, 'jrestrepop@hotmail.com', 3),
(11, 'Juliana Restrepo', 1230984567, 'julianarp@hotmail.com', 3),
(12, 'Olga Lucia Garcia', 52180373, 'olgalugarcia@yahoo.com', 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `conditions`
--
ALTER TABLE `conditions`
  ADD PRIMARY KEY (`Cond_id`),
  ADD KEY `Conditions_Simulators` (`Sim_id`);

--
-- Indices de la tabla `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`Dep_id`),
  ADD UNIQUE KEY `Dep_name` (`Dep_name`);

--
-- Indices de la tabla `entry`
--
ALTER TABLE `entry`
  ADD PRIMARY KEY (`Ent_id`),
  ADD KEY `Entry_Login` (`Login_id`),
  ADD KEY `Entry_Status` (`Stat_id`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`Login_id`),
  ADD UNIQUE KEY `User_id` (`User_id`);

--
-- Indices de la tabla `simulators`
--
ALTER TABLE `simulators`
  ADD PRIMARY KEY (`Sim_id`);

--
-- Indices de la tabla `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`Stat_id`),
  ADD UNIQUE KEY `Stat_name` (`Stat_name`),
  ADD KEY `Status_Type` (`Type_id`);

--
-- Indices de la tabla `status_type`
--
ALTER TABLE `status_type`
  ADD PRIMARY KEY (`Type_id`);

--
-- Indices de la tabla `township`
--
ALTER TABLE `township`
  ADD PRIMARY KEY (`Town_id`),
  ADD UNIQUE KEY `Town_name` (`Town_name`),
  ADD KEY `Township_Department` (`Dep_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`User_id`),
  ADD UNIQUE KEY `User_email` (`User_email`),
  ADD UNIQUE KEY `User_identification` (`User_identification`),
  ADD KEY `Users_Status` (`Stat_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `conditions`
--
ALTER TABLE `conditions`
  MODIFY `Cond_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `department`
--
ALTER TABLE `department`
  MODIFY `Dep_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `entry`
--
ALTER TABLE `entry`
  MODIFY `Ent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `login`
--
ALTER TABLE `login`
  MODIFY `Login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `simulators`
--
ALTER TABLE `simulators`
  MODIFY `Sim_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `status`
--
ALTER TABLE `status`
  MODIFY `Stat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `status_type`
--
ALTER TABLE `status_type`
  MODIFY `Type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `township`
--
ALTER TABLE `township`
  MODIFY `Town_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `User_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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


--
-- Metadatos
--
USE `phpmyadmin`;

--
-- Metadatos para la tabla conditions
--

--
-- Truncar tablas antes de insertar `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncar tablas antes de insertar `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncar tablas antes de insertar `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadatos para la tabla department
--

--
-- Truncar tablas antes de insertar `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncar tablas antes de insertar `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Volcado de datos para la tabla `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'simulator', 'department', '{\"sorted_col\":\"`department`.`Dep_id`  DESC\"}', '2019-06-07 17:46:01');

--
-- Truncar tablas antes de insertar `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadatos para la tabla entry
--

--
-- Truncar tablas antes de insertar `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncar tablas antes de insertar `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncar tablas antes de insertar `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadatos para la tabla login
--

--
-- Truncar tablas antes de insertar `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncar tablas antes de insertar `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Volcado de datos para la tabla `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'simulator', 'login', '{\"sorted_col\":\"`login`.`Login_id` ASC\"}', '2019-06-14 00:03:04');

--
-- Truncar tablas antes de insertar `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadatos para la tabla simulators
--

--
-- Truncar tablas antes de insertar `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncar tablas antes de insertar `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncar tablas antes de insertar `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadatos para la tabla status
--

--
-- Truncar tablas antes de insertar `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncar tablas antes de insertar `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncar tablas antes de insertar `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadatos para la tabla status_type
--

--
-- Truncar tablas antes de insertar `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncar tablas antes de insertar `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncar tablas antes de insertar `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadatos para la tabla township
--

--
-- Truncar tablas antes de insertar `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncar tablas antes de insertar `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncar tablas antes de insertar `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadatos para la tabla users
--

--
-- Truncar tablas antes de insertar `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncar tablas antes de insertar `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncar tablas antes de insertar `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadatos para la base de datos simulator
--

--
-- Truncar tablas antes de insertar `pma__bookmark`
--

TRUNCATE TABLE `pma__bookmark`;
--
-- Truncar tablas antes de insertar `pma__relation`
--

TRUNCATE TABLE `pma__relation`;
--
-- Truncar tablas antes de insertar `pma__savedsearches`
--

TRUNCATE TABLE `pma__savedsearches`;
--
-- Truncar tablas antes de insertar `pma__central_columns`
--

TRUNCATE TABLE `pma__central_columns`;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
