<?php
#Author: LAURA GRISALES
#Date: 13/06/2019
#Description : Is BO Simulator
include "../dto/dto_simulator.php";
include "../dao/dao_simulator.php";

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

if(isset ($_POST['select'])){
  $obj = new BoSimulator();
  $obj->selectSimulators();
} else if (isset ($_POST['selectCondition'])){
  $obj = new BoSimulator();
  $obj->selectConditions();
}
//$obj=new BoSimulator();
//echo $obj->newSimulator("Credito Prueba 2","Texto ",7,12,2.1);
//$obj->selectSimulators();
//$obj->selectSimulator(1);
//$obj->selectCondition(1);
//$obj->updateSimulator(2,"Credito Vivienda","Descripcion");
?>