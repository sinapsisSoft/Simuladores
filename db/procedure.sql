/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Create a new user */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_user_insert //
CREATE PROCEDURE sp_user_insert
(IN name VARCHAR(80), 
IN identification INT, 
IN email VARCHAR(200), 
IN status INT, 
IN pass VARCHAR(30)) 
BEGIN 
  SET @exist = (SELECT COUNT(User_email)FROM users WHERE User_email LIKE email); 
  IF @exist = 0 THEN 
    INSERT INTO users (User_name, User_identification, User_email, Stat_id) VALUES (name, identification, email, status); 
    SET @user_id = LAST_INSERT_ID();
  END IF; 
  INSERT INTO login (Login_password, User_id) VALUES (pass, @user_id); 
  SELECT ROW_COUNT();
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Update the data of one user */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_user_update //
CREATE PROCEDURE sp_user_update
(IN id INT, 
IN name VARCHAR(80), 
IN status INT)
BEGIN 
  UPDATE users SET User_name=name, Stat_id = status WHERE User_id = id; 
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show all the users */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_user_select_all //
CREATE PROCEDURE sp_user_select_all () 
BEGIN 
  SELECT User_id, User_name, User_identification, User_email, Stat_id FROM users;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show an specific users */
DELIMITER //
DROP PROCEDURE sp_user_select_one //
CREATE PROCEDURE sp_user_select_one
(IN mail VARCHAR(200)) 
BEGIN 
  SELECT User_id, User_name, User_identification, User_email, Stat_id FROM users WHERE User_email = mail; 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Create the password of an specific user */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_login_insert //
CREATE PROCEDURE sp_login_insert 
(IN pass VARCHAR(30),
IN user INT) 
BEGIN 
  INSERT INTO login(Login_password, User_id) VALUES (pass,user); 
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Update the password of an specific user */
DELIMITER //
DROP PROCEDURE sp_login_update //
CREATE PROCEDURE sp_login_update
(IN mail VARCHAR(200), 
IN pass VARCHAR(30)) 
  BEGIN SET @user_id = (SELECT User_id FROM users WHERE User_email LIKE mail); 
  UPDATE login SET Login_password=pass WHERE User_id = @user_id; 
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show all the passwords in the system */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_login_select_all //
CREATE PROCEDURE sp_login_select_all ()
BEGIN 
  SELECT Login_id, Login_password, User_id FROM login;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show the password of and specific user */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_login_select_one //
CREATE PROCEDURE sp_login_select_one 
(IN id INT) 
BEGIN 
  SELECT Login_id, Login_password, User_id FROM login WHERE Login_id = id;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Create a department */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_depart_insert //
CREATE PROCEDURE sp_depart_insert 
(IN name VARCHAR(100)) 
BEGIN 
  INSERT INTO department(Dep_name) VALUES (name); 
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Update a department */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_depart_update //
CREATE PROCEDURE sp_depart_update 
(IN id INT, 
IN name VARCHAR(100)) 
BEGIN 
  UPDATE department SET Dep_name=name WHERE Dep_id = id;
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show all departments */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_depart_select_all //
CREATE PROCEDURE sp_depart_select_all ()
BEGIN 
  SELECT Dep_id, Dep_name FROM department;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show a department by id */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_depart_select_one //
CREATE PROCEDURE sp_depart_select_one 
(IN id INT) 
BEGIN 
  SELECT Dep_id, Dep_name FROM department WHERE Dep_id = id;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Create a twonship */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_town_insert //
CREATE PROCEDURE sp_town_insert 
(IN name VARCHAR(100), 
IN depart INT) 
BEGIN 
  INSERT INTO township(Town_name, Dep_id) VALUES (name, depart); 
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Update a twonship */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_town_update //
CREATE PROCEDURE sp_town_update 
(IN id INT, 
IN name VARCHAR(100), 
IN depart INT) 
BEGIN 
  UPDATE township SET Town_name=name,Dep_id=depart WHERE Town_id = id;
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show all the twonships */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_town_select_all //
CREATE PROCEDURE sp_town_select_all ()
BEGIN 
  SELECT Town_id, Town_name, Dep_id FROM township;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show an specific twonship */
DELIMITER //
DROP PROCEDURE IF EXISTS sp_town_select_one //
CREATE PROCEDURE sp_town_select_one 
(IN id INT) 
BEGIN 
  SELECT Town_id, Town_name, Dep_id FROM township WHERE Town_id = id;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show an specific twonship by department*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_town_select_Dep //
CREATE PROCEDURE sp_town_select_Dep 
(IN dept INT) 
BEGIN 
  SELECT Town_id, Town_name, Dep_id FROM township WHERE Dep_id = dept;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Create an status*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_status_insert //
CREATE PROCEDURE sp_status_insert
(IN name VARCHAR(30), 
IN type INT) 
BEGIN 
  INSERT INTO status(Stat_name, Type_id) VALUES (name, type); 
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Update a specific status*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_status_update //
CREATE PROCEDURE sp_status_update
(IN id INT, 
IN name VARCHAR(30), 
IN type INT) 
BEGIN 
  UPDATE status SET Stat_name=name, Type_id = type WHERE Stat_id = id; 
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show all the status*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_status_select_all //
CREATE PROCEDURE sp_status_select_all ()
BEGIN 
  SELECT Stat_id, Stat_name, type_id FROM status;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show a specific status*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_status_select_one //
CREATE PROCEDURE sp_status_select_one 
(IN id INT) 
BEGIN 
  SELECT Stat_id, Stat_name, type_id FROM status WHERE Stat_id = id;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show a specific status by type*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_status_select_type //
CREATE PROCEDURE sp_status_select_type 
(IN type INT) 
BEGIN 
  SELECT Stat_id, Stat_name, Type_id FROM status WHERE Type_id = type;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Create a status type*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_stattype_insert //
CREATE PROCEDURE sp_stattype_insert
(IN name VARCHAR(30)) 
BEGIN 
  INSERT INTO status_type(Type_name) VALUES (name); 
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Update a specific status type*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_stattype_update //
CREATE PROCEDURE sp_stattype_update
(IN id INT, 
IN name VARCHAR(30)) 
BEGIN 
  UPDATE status_type SET Type_name=name WHERE Type_id = id; 
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show all the status type*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_stattype_select_all //
CREATE PROCEDURE sp_stattype_select_all ()
BEGIN 
  SELECT Type_id, Type_name FROM status_type;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show a specific status type*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_stattype_select_one //
CREATE PROCEDURE sp_stattype_select_one 
(IN id INT) 
BEGIN 
  SELECT Type_id, Type_name FROM status_type WHERE Type_id = id;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Create a movement registry*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_entry_insert //
CREATE PROCEDURE sp_entry_insert 
(IN login INT, 
IN status INT) 
BEGIN 
  INSERT INTO entry(Login_id, Stat_id) VALUES (login,status); 
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Update a movement registry*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_entry_update //
CREATE PROCEDURE sp_entry_update 
(IN id INT, 
IN login INT, 
IN status INT) 
BEGIN 
  UPDATE entry SET Login_id=login, Stat_id=status WHERE Ent_id = id;
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show all the movements registry*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_entry_select_all
CREATE PROCEDURE sp_entry_select_all ()
BEGIN  
  SELECT Ent_id, Login_id, Stat_id FROM entry;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show an specific movement registry by user*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_entry_select_login //
CREATE PROCEDURE sp_entry_select_login 
(IN login INT) 
BEGIN 
  SELECT Ent_id, Login_id, Stat_id FROM entry WHERE Login_id = login;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show an specific movement registry by status*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_entry_select_status //
CREATE PROCEDURE sp_entry_select_status 
(IN status INT) 
BEGIN 
  SELECT Ent_id, Login_id, Stat_id FROM entry WHERE Stat_id = status;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Create a simulator*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_simul_insert //
CREATE PROCEDURE sp_simul_insert
(IN name VARCHAR(80),
IN descrip VARCHAR(200), 
IN initial INT, 
IN final INT, 
IN percent DECIMAL(4,2))
BEGIN 
  INSERT INTO simulators(Sim_name, Sim_description) VALUES (name,descrip); 
  SET @id = LAST_INSERT_ID(); 
  INSERT INTO conditions(Cond_initial,Cond_final,Cond_percent,Sim_id) VALUES (initial,final,percent,@id);
  SELECT ROW_COUNT();
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Update a simulator*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_simul_update //
CREATE PROCEDURE sp_simul_update 
(IN id INT, 
IN name VARCHAR(80), 
IN descrip VARCHAR(200)) 
BEGIN 
  UPDATE simulators SET Sim_name=name,Sim_description=descrip WHERE Sim_id = id;
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show all the simulators*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_simul_select_all //
CREATE PROCEDURE sp_simul_select_all ()
BEGIN 
  SELECT Sim_id, Sim_name, Sim_description FROM simulators;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show a specific simulator*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_simul_select_one //
CREATE PROCEDURE sp_simul_select_one 
(IN id INT) 
BEGIN 
  SELECT Sim_id, Sim_name, Sim_description FROM simulators WHERE Sim_id = id;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Create a condition of a simulator*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_cond_insert //
CREATE PROCEDURE sp_cond_insert 
(IN initial INT, 
IN final INT, 
IN percent DECIMAL(4,2), 
IN Simul INT) 
BEGIN 
  INSERT INTO conditions(Cond_initial, Cond_final, Cond_percent, Sim_id) VALUES (initial,final,percent,Simul); 
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Update a condition of a simulator*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_cond_update //
CREATE PROCEDURE sp_cond_update 
(IN id INT, 
IN initial INT, 
IN final INT, 
IN percent DECIMAL(4,2), 
IN simul INT) 
BEGIN 
  UPDATE conditions SET Cond_initial=initial,Cond_final=final,Cond_percent=percent,Sim_id=simul WHERE Cond_id = id;
  SELECT ROW_COUNT(); 
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show all the conditions*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_cond_select_all //
CREATE PROCEDURE sp_cond_select_all ()
BEGIN 
  SELECT Cond_id, Cond_initial, Cond_final, Cond_percent, Sim_id FROM conditions;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Show a condition by simulator*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_cond_select_simu //
CREATE PROCEDURE sp_cond_select_simu 
(IN simul INT)
BEGIN 
  SELECT Cond_id, Cond_initial, Cond_final, Cond_percent, Sim_id FROM conditions WHERE Sim_id = simul;
END //
DELIMITER ;
/*
Author: LAURA GRISALES
Date: 05/06/2019
Description : Verify if the user and password are correct and show all the info of the user*/
DELIMITER //
DROP PROCEDURE IF EXISTS sp_login //
CREATE PROCEDURE sp_login 
(IN email VARCHAR(200),
IN pass VARCHAR(30)) 
BEGIN 
  SET @mail = '';
  SET @password = '';
  /*Verify if the email exists*/
  SET @mail = (SELECT COUNT(u.User_email) FROM users u WHERE u.User_email LIKE email);
  /*Search the password that corresponds to the email */
  IF @mail > 0 THEN
	  SET @password =(SELECT L.Login_password FROM login L 
	  INNER JOIN users U ON u.User_id = l.User_id
	  WHERE U.User_email like email); 
      /*Verify if the password is correct */
      IF @password LIKE pass THEN
    	  SELECT U.User_id, U.User_name, U.User_email FROM users U 
		    INNER JOIN login L ON U.User_id = L.User_id
		    WHERE L.Login_password LIKE pass AND U.User_email like email;
      END IF;
  END IF;
END //
DELIMITER ;
