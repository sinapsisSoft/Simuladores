<?php
#Author: LAURA GRISALES
#Date: 12/03/2019
#Description : Is DTO User
class DtoUser 
{
  private $User_id;
  private $User_name;
  private $User_identification;
  private $User_email;
  private $Stat_id;
  private $Login_id;
  private $Login_password;
  
  public function __construct(){

  }

  public function __setUser($name, $identification, $email, $status, $password)
  {
    $this->User_name = $name;
    $this->User_identification = $identification;
    $this->User_email = $email;
    $this->Stat_id = $status;
    $this->Login_password = $password;
  }

  public function __getUser()
  {
    $objUser = new DtoUser();
    $objUser->__getId();
    $objUser->__getName();
    $objUser->__getIdentification();
    $objUser->__getEmail();
    $objUser->__getStatus();
    $objUser->__getPassword();
    return $objUser;
  }

  public function __setId($id)
  {
    $this->User_id = $id;
  }
  public function __setName($name)
  {
    $this->User_name = $name;
  }
  public function __setIdentification($identification)
  {
    $this->User_identificacion = $identification;
  }
  public function __setEmail($email)
  {
    $this->User_email = $email;
  }
  public function __setStatus($status)
  {
    $this->Stat_id = $status;
  }
  public function __setPassword($password)
  {
    $this->Login_password = $password;
  }
  public function __getName()
  {
    return $this->User_name;
  }
  public function __getIdentification()
  {
    return $this->User_identification;
  }
  public function __getEmail()
  {
    return $this->User_email;
  }
  public function __getStatus()
  {
    return $this->Stat_id;
  }
  public function __getPassword()
  {
    return $this->Login_password;
  }
  public function __getId()
  {
    return $this->User_id;
  }
}