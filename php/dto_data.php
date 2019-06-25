<?php 
	
	class DtoDataConnection
	{
		public $server;
		private $user;
		private $password;
		private $dataBase;
		
		public function __construct()
		{
			$this->server="mysql.hostinger.co";
			$this->user="u443779332_dhcv";
			$this->password="Cominobras_2017";
			$this->dataBase="u443779332_credi";
			
		}
		
		public function getData(){
			
			return array($this->server,$this->user,$this->password,$this->dataBase);
		}
	}
?>