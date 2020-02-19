<?php 
	
	class DtoDataConnection
	{
		public $server;
		private $user;
		private $password;
		private $dataBase;
		
		public function __construct()
		{
			$this->server="127.0.0.1";
			$this->user="root";
			$this->password="";
			$this->dataBase="credit_coominobras";
			
		}
		
		public function getData(){
			
			return array($this->server,$this->user,$this->password,$this->dataBase);
		}
	}
?>