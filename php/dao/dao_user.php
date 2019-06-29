<?php
#Author: LAURA GRISALES
#Date: 13/06/2019
#Description : Is DAO User
include "../class/connectionDB.php";
class DaoUser
{
  private $objConntion;
  private $arrayResult;
  private $intValidatio;

  public function __construct()
  {
    $this->objConntion = new Connection();
    $this->arrayResult = array();
    $this->intValidatio;
  }
  #Description: Function for create a new user
  public function newUser($objUser)
  {
    try{
      $con = $this->objConntion->connect();
      if($con != null){
        $dataUser = "'" . $objUser->__getName() . "','" . $objUser->__getIdentification() . "','" . $objUser->__getEmail() . "','" . $objUser->__getStatus() .  "','" .$objUser->__getPassword() . "'";
        if($con->query("CALL sp_user_insert (" . $dataUser . ")")){
            $this->intValidatio = 1;
        }     
        else{
          $this->intValidatio = 0;
        }        
      }
      $con->close();
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return $this->intValidatio;
  }

  #Description : Function for select user
  public function selectUser($dataMail)
  {
    try {
      $con = $this->objConntion->connect();
      if ($con != null) {
        if ($result = $con->query("CALL sp_user_select_one('" . $dataMail . "')")) {
          while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $this->arrayResult[] = $row;
          };
          mysqli_free_result($result);
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
    }
    return json_encode($this->arrayResult);
  }

  #Description: Function for update an user
  public function updateUser($dataId, $dataName, $dataStatus)
  {
    try{
      $con = $this->objConntion->connect();
      if($con != null){
        if($result = $con->query("CALL sp_user_update (" . $dataId . ",'". $dataName . "'," . $dataStatus . ")")){
            $this->intValidatio = 1;
        }     
        else{
          $this->intValidatio = 0;
        }        
      }
      $con->close();
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return $this->intValidatio;
  }

  #Description: Function for update an user password
  public function updatePass($dataMail, $dataPass)
  {
    try{
      $con = $this->objConntion->connect();
      if($con != null){
        if($result = $con->query("CALL sp_login_update ('" . $dataMail . "','". $dataPass . "')")){ 
          $this->intValidatio = 1;         
        }     
        else{
          $this->intValidatio = 0;
        }        
      }
      $con->close();
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return $this->intValidatio;
  }

  #Description: Function for login
  public function loginUser($dataMail, $dataPass)
  {
    try{
      $con = $this->objConntion->connect();
      if($con != null){
        if($result = $con->query("CALL sp_login ('" . $dataMail . "','". $dataPass . "')")){ 
          while($row = $result->fetch_array(MYSQLI_ASSOC)){
            $this->arrayResult[] = $row;
          };
          mysqli_free_result($result);
        }       
      }
      $con->close();
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
    }
    return json_encode($this->arrayResult);
  }
}