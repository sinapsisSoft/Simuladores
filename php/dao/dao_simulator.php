<?php
#Author: LAURA GRISALES
#Date: 13/06/2019
#Description : Is DAO Simulator
include "../class/connectionDB.php";
header("Content-type: application/json; charset=utf-8");
class DaoSimulator
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
  #Description : Function for add one new simulator
  public function newSimulator($objSimulator)
  {
    try {
      $con = $this->objConntion->connect();
      if ($con != null) {
        $dataSimulator = "'" . $objSimulator->__getName() . "','" . $objSimulator->__getDescription() . "'," . $objSimulator->__getInitial() . "," . $objSimulator->__getFinal() . "," . $objSimulator->__getPercent();
        if ($con->query("CALL sp_simul_insert (" . $dataSimulator . ")")) {
          $this->intValidatio = 1;
        } 
        else {
          $this->intValidatio = 0;
        }
      }
      $con->close();
    } catch (Exception $e) {
        echo 'Exception captured: ', $e->getMessage(), "\n";
        $this->intValidatio = 0;
      }
    return $this->intValidatio;
  }
  #Description : Function for select all simulators
  public function selectSimulators()
  {
    try {
      $con = $this->objConntion->connect();    
      if ($con != null) {        
          if ($result = $con->query("CALL sp_simul_select_all()")) {         
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

  #Description : Function for select a simulator
  public function selectSimulator($dataId)
  {
    try {
      $con = $this->objConntion->connect();
      if ($con != null) {
        if ($result = $con->query("CALL sp_simul_select_one(". $dataId . ")")) {
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

  #Description : Function for select all conditions
  public function selectConditions()
  {
    try {
      $con = $this->objConntion->connect();    
      if ($con != null) {        
          if ($result = $con->query("CALL sp_cond_select_all()")) {         
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

  #Description : Function for select the simulator conditions 
  public function selectCondition($dataId)
  {
    try {
      $con = $this->objConntion->connect();
      if ($con != null) {
        if ($result = $con->query("CALL sp_cond_select_simu (". $dataId . ")")) {
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

  #Description: Function for update a simulator
  public function updateSimulator($dataId, $dataName, $dataDescription)
  {
    try{
      $con = $this->objConntion->connect();
      if($con != null){
        if($result = $con->query("CALL sp_simul_update (" . $dataId . ",'". $dataName . "','" . $dataDescription . "')")){
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

  #Description: Function for update a simulator conditions
  public function updateCondition($dataId, $dataInitial, $dataFinal, $dataPercent, $dataSimul)
  {
    try{
      $con = $this->objConntion->connect();
      if($con != null){
        if($result = $con->query("CALL sp_cond_update (" . $dataId . ",". $dataInitial . "," . $dataFinal . "," . $dataPercent . "," . $dataSimul . ")")){
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
}