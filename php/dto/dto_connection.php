<?php
#Author: DIEGO  CASALLAS
#Date: 21/03/2019
#Description : Is connection data 
    class DtoConnection {
    private $user;
    private $password;
    private $server;
    private $database;

    function __construct(){ 
        $this->user="root";
        $this->password="";
        $this->server="localhost";
        $this->database="simulator";
        }
        public function getUser()
        {
            return $this->user;
        }
        public function getPassword()
        {
            return $this->password;
        }
        public function getServer()
        {
            return $this->server;
        }
        public function getDataase()
        {
            return $this->database;
        }
        public function getData(){
                
            return array($this->server,$this->user,$this->password,$this->database);
        }
    }
?> 