<?php
#Author: LAURA GRISALES
#Date: 13/06/2019
#Description : Is BO Simulator
include "../dto/dto_simulator.php";
include "../dao/dao_simulator.php";
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Origin: https://coominobras.coop");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Access-Control-Allow-Origin, X-Requested-With");

class BoSimulator
{
  private $objSimulator;
  private $objDao;
  private $intValidate;

  function __construct()
  {
    $this->objSimulator = new DtoSimulator();
    $this->objDao = new DaoSimulator();
  }

  #Description : Function for add one new simulator 
  function newSimulator($name, $description, $initial, $final, $percent){
    try{
      $this->objSimulator->__setSimulator($name, $description, $initial, $final, $percent); 
      $intValidate = $this->objDao->newSimulator($this->objSimulator);
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate=0;
    }
    return $intValidate;
  }  

  #Description : Function for show all simulators
  function selectSimulators(){
    try {        
     echo $this->objDao->selectSimulators();   
      
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
    }
  }

  #Description : Function for show a simulator
  function selectSimulator($dataId){
    try {        
      echo $this->objDao->selectSimulator($dataId);
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
    }
  }

  #Description : Function for show all conditions
  function selectConditions(){
    try {        
      echo $this->objDao->selectConditions();    
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
    }
  }

  #Description : Function for show simulator conditions
  function selectCondition($dataId){
    try {        
      echo $this->objDao->selectCondition($dataId);
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
    }
  }

  #Description: Function for update a simulator
  function updateSimulator($id, $name, $description){
    try{
      echo $this->objDao->updateSimulator($id, $name, $description);
      $intValidate = 1;
    }
    catch(Exception $e){
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }

}
$obj = new BoSimulator();
/// We get the json sent
$getData = file_get_contents('php://input');
$data = json_decode($getData);

/**********CREATE ************/
if(isset($data->POST)){
  if ($data->POST == "") {
    
  }
}
/**********READ AND CONSULT ************/
if (isset($data->GET)) {
  if ($data->GET == "GET_SIMULATOR") {
    echo $obj->selectSimulators();
  }
  else if($data->GET == "GET_CONDITIONS"){
    echo $obj->selectConditions();
  }
  else if($data->GET == "GET_ONE"){
    echo $obj->selectSimulator($data->creL_id);
  }
}

?>