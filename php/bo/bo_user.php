<?php
#Author: LAURA GRISALES
#Date: 13/06/2019
#Description : Is BO User
include "../dto/dto_user.php";
include "../dao/dao_user.php";
class BoUser
{
  private $objUser;
  private $objDao;
  private $intValidate;

  function __construct()
  {
    $this->objUser = new DtoUser();
    $this->objDao = new DaoUser();
  }

  #Description: Function for create a new user
  function newUser($name, $identification, $email, $status, $password){
    try{
      $this->objUser->__setUser($name, $identification, $email, $status, $password);
      $intValidate = $this->objDao->newUser($this->objUser);
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }

  #Description: Function for select user
  function selectUser($mail){
    try{
      echo $this->objDao->selectUser($mail);
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
    }
  }

  #Description: Function for update an user
  function updateUser($id, $name, $status){
    try{
      echo $this->objDao->updateUser($id, $name, $status);
      $intValidate = 1;
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }

  #Description: Function for update an user password
  function updatePass($mail, $pass){
    try{
      echo $this->objDao->updatePass($mail,$pass);
      $intValidate = 'Ok';
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }

  #Description: Function for login 
  function loginUser($mail, $pass){
    try{
      echo $this->objDao->loginUser($mail,$pass);
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
    }
  }
}

$obj = new BoUser();
//echo $obj->newUser("Olga Lucia",52180373,"olgalugarcia@gmail.com",3,"lucias");
$obj->selectUser('lauramggarcia@hotmail.com');
//$obj->updateUser(10,"Julian Restrepo",3);
//$obj->updatePass('lauramggarcia@hotmail.com',"Lero1234");
//$obj->loginUser('lauramggarcia@hotmail.com',"Lero1234");

?>