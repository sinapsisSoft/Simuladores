<?php
#Author: LAURA GRISALES
#Date: 13/06/2019
#Description : Is DTO simulator
class DtoSimulator
{
  private $Sim_id;
  private $Sim_name;
  private $Sim_description;
  private $Cond_id;
  private $Cond_initial;
  private $Cond_final;
  private $Cond_percent;

  public function __construct()
  {

  }
  public function __setSimulator($name, $description, $initial, $final, $percent)
  {
    $this->Sim_name = $name;
    $this->Sim_description = $description;
    $this->Cond_initial = $initial;
    $this->Cond_final = $final;
    $this->Cond_percent = $percent;
  }
  public function __getSimulator()
  {
    $objSimulator = new DtoSimulator();
    $objSimulator->__getName();
    $objSimulator->__getDescription();
    $objSimulator->__getInitial();
    $objSimulator->__getFinal();
    $objSimulator->__getPercent();
    return $objSimulator;
  }
  public function __setId($id)
  {
    $this->Sim_id = $id;
  }
  public function __setName($name)
  {
    $this->Sim_name = $name;
  }
  public function __setDescription($description)
  {
    $this->Sim_description = $description;
  }
  public function __setInitial($initial)
  {
    $this->Cond_initial = $initial;
  }
  public function __setFinal($final)
  {
    $this->Cond_final = $final;
  }
  public function __setPercent($percent)
  {
    $this->Cond_percent = $percent;
  }
  public function __getId()
  {
    return $this->Sim_id;
  }
  public function __getName()
  {
    return $this->Sim_name;
  }
  public function __getDescription()
  {
    return $this->Sim_description;
  }
  public function __getInitial()
  {
    return $this->Cond_initial;
  }
  public function __getFinal()
  {
    return $this->Cond_final;
  }
  public function __getPercent()
  {
    return $this->Cond_percent;
  }
}