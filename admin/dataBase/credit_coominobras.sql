-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 19-07-2017 a las 19:40:58
-- Versión del servidor: 10.1.24-MariaDB
-- Versión de PHP: 7.0.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `u443779332_credi`
--
CREATE DATABASE IF NOT EXISTS `u443779332_credi` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `u443779332_credi`;

DELIMITER $$
--
-- Procedimientos
--
$$

$$

$$

$$

$$

$$

$$

$$

$$

$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `credit`
--

ALTER TABLE loan_condition DROP FOREIGN KEY loan_condition_ibfk_1;
DROP TABLE IF EXISTS credit;
DROP TABLE IF EXISTS loan_condition;
DROP TABLE IF EXISTS user;

CREATE TABLE IF NOT EXISTS `credit` (
  `credId` int(11) NOT NULL AUTO_INCREMENT,
  `credName` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  `credCondition` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  `credDestination` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  `credBenefits` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`credId`)
) ;

--
-- Truncar tablas antes de insertar `credit`
--

TRUNCATE TABLE `credit`;
--
-- Volcado de datos para la tabla `credit`
--

INSERT INTO `credit` (`credId`, `credName`, `credCondition`, `credDestination`, `credBenefits`) VALUES
(1, 'ORDINARIO', 'Asociados nombrados en carrera administrativa, provisionalidad y  pensionados, hasta 6 veces el valor de los aportes. Asociados de Libre nombramiento y remoción, e independientes hasta 3 veces el valor de los aportes. No obstante lo anterior, el monto máximo no podrá superar los 110 SMMLV.', 'Destinado para cualquier tipo de consumo o libre inversión.', 'Mejoramiento de calidad de vida<br>Adquisición de elementos para el hogar<br>Bienestar familiar.'),
(3, 'COMPRA DE CARTERA', 'Carrera, provisionalidad, pensionados, empleados hasta 6 veces el valor de los aportes.<br><br>Libre nombramiento y remoción, independientes hasta 3 veces el valor de los aportes', 'Compra de obligaciones financieras.', 'Tasa preferencial<br>Mejoramiento de ingresos<br>Liberación capacidad de pago');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `loan_condition`
--

CREATE TABLE IF NOT EXISTS `loan_condition` (
  `condId` int(11) NOT NULL AUTO_INCREMENT,
  `condTerm` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `condRate` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `cond_NMV` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `idCredit` int(11) NOT NULL,
  PRIMARY KEY (`condId`),
  KEY `idCredit` (`idCredit`)
) ;

--
-- Truncar tablas antes de insertar `loan_condition`
--

TRUNCATE TABLE `loan_condition`;
--
-- Volcado de datos para la tabla `loan_condition`
--

INSERT INTO `loan_condition` (`condId`, `condTerm`, `condRate`, `cond_NMV`, `idCredit`) VALUES
(5, '1-18', '1', '12.68', 3),
(6, '19-36', '1.3', '16.77', 3),
(7, '37-60', '1.5', '19.56', 3),
(10, '1-18', '1.4', '18.16', 1),
(11, '19-36', '1.5', '19.56', 1),
(12, '37-60', '1.6', '20.98', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `userSurname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `userEmail` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `userPassword` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`userId`)
) ;

--
-- Truncar tablas antes de insertar `user`
--

TRUNCATE TABLE `user`;
--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`userId`, `userName`, `userSurname`, `userEmail`, `userPassword`) VALUES
(1, 'Diego', 'Casallas', 'diehercasvan@gmail.com', '80859867Dc');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `loan_condition`
--
ALTER TABLE `loan_condition`
  ADD CONSTRAINT `loan_condition_ibfk_1` FOREIGN KEY (`idCredit`) REFERENCES `credit` (`credId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
