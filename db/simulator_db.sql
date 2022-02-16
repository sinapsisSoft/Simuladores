CREATE DATABASE IF NOT EXISTS simulator;

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
  `creL_id` int(11) NOT NULL,
  PRIMARY KEY (`Cond_id`),
  KEY `Conditions_CreditLines` (`creL_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Estructura de tabla para la tabla CreditLines`
--

DROP TABLE IF EXISTS `creditLines`;
CREATE TABLE IF NOT EXISTS `creditLines` (
  `creL_id` int(11) NOT NULL AUTO_INCREMENT,
  `creL_name` varchar(80) CHARACTER SET utf8 NOT NULL,
  `creL_conditions` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  `creL_benefits` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  `creL_destination` varchar(800) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`creL_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Filtros para la tabla `conditions`
--
ALTER TABLE `conditions`
  ADD CONSTRAINT `Conditions_CreditLines` FOREIGN KEY (`creL_id`) REFERENCES `creditLines` (`creL_id`);

  --
-- Volcado de datos para la tabla `creditLines`
--

INSERT INTO `creditLines` (`creL_id`, `creL_name`, `creL_conditions`, `creL_benefits`, `creL_destination`) VALUES
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

--
-- Volcado de datos para la tabla `conditions`
--

INSERT INTO `conditions` (`Cond_id`, `Cond_initial`, `Cond_final`, `Cond_percent`, `Cond_percent_NMV`, `creL_id`) VALUES
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


DELIMITER //
DROP PROCEDURE IF EXISTS sp_cond_insert //
CREATE PROCEDURE sp_cond_insert 
(IN initial INT, 
IN final INT, 
IN percent DECIMAL(4,2), 
IN Simul INT) 
BEGIN 
  INSERT INTO conditions(Cond_initial, Cond_final, Cond_percent, creL_id) VALUES (initial,final,percent,Simul); 
  SELECT ROW_COUNT(); 
END //


DELIMITER //
DROP PROCEDURE IF EXISTS sp_cond_update //
CREATE PROCEDURE sp_cond_update 
(IN id INT, 
IN initial INT, 
IN final INT, 
IN percent DECIMAL(4,2), 
IN simul INT) 
BEGIN 
  UPDATE conditions SET Cond_initial=initial,Cond_final=final,Cond_percent=percent,creL_id=simul WHERE Cond_id = id;
  SELECT ROW_COUNT(); 
END //

DELIMITER //
DROP PROCEDURE IF EXISTS sp_cond_select_all //
CREATE PROCEDURE sp_cond_select_all ()
BEGIN 
  SELECT Cond_id, Cond_initial, Cond_final, Cond_percent, creL_id FROM conditions;
END //


DELIMITER //
DROP PROCEDURE IF EXISTS sp_credlines_insert //
CREATE PROCEDURE sp_credlines_insert
(IN name VARCHAR(80),
IN descriptions VARCHAR(200), 
IN conditions VARCHAR(200), 
IN benefits VARCHAR(200), 
IN destination VARCHAR(200), 
IN initial INT, 
IN final INT, 
IN percent DECIMAL(4,2))
BEGIN 
  INSERT INTO creditlines(creL_name, creL_descriptions, creL_conditions, creL_benefits,creL_destination) VALUES (name, conditions,benefits,destination); 
  SET @id = LAST_INSERT_ID(); 
  INSERT INTO conditions(Cond_initial,Cond_final,Cond_percent,creL_id) VALUES (initial,final,percent,@id);
  SELECT ROW_COUNT();
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS sp_credlines_update //
CREATE PROCEDURE sp_credlines_update 
(IN id INT, 
IN name VARCHAR(80),
IN conditions VARCHAR(200), 
IN benefits VARCHAR(200), 
IN destination VARCHAR(200)) 
BEGIN 
  UPDATE creditlines SET creL_name=name,creL_conditions=conditions,creL_benefits=benefits,creL_destination=destination WHERE creL_id = id;
  SELECT ROW_COUNT(); 
END //

DELIMITER //
DROP PROCEDURE IF EXISTS sp_credlines_select_all //
CREATE PROCEDURE sp_credlines_select_all ()
BEGIN 
  SELECT creL_id, creL_name,creL_conditions,creL_benefits,creL_destination FROM creditlines;
END //

DELIMITER //
DROP PROCEDURE IF EXISTS sp_simul_select_one //
CREATE PROCEDURE sp_simul_select_one 
(IN id INT) 
BEGIN 
  SELECT creL_id, creL_name, creL_conditions,creL_benefits,creL_destination  FROM creditlines WHERE creL_id = id;
END //