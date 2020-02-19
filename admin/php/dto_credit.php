<?php 
	
	class DtoCredit
	{
		private $credId;
		private $credName;
		private $credCondition;
		private $credDestination;
		private $credBenefits;
		private $credConditionList;
		
		public function __construct($credId,$credName,$credCondition,$credDestination,$credBenefits,$credConditionList)
		{
			$this->credId=$credId;
			$this->credName=$credName;
			$this->credCondition=$credCondition;
			$this->credDestination=$credDestination;
			$this->credBenefits=$credBenefits;
			$this->credConditionList=$credConditionList;
			
		}
		public function getCredName(){
			return $this->credName;
		}
		public function getCredCondition(){
			return $this->credCondition;
		}
		public function getCredDestination(){
			return $this->credDestination;
		}
		public function getCredBenefits(){
			return $this->credBenefits;
		}
		public function getCredId(){
			return $this->credId;
		}
		
		public function getCredConditionList(){
			return $this->credConditionList;
		}
		
		
		public function setCredConditionList($credConditionList){
			$this->credConditionList=$credConditionList;
		}
		public function setCredId($credId){
			$this->credId=$credId;
		}
		public function setCredName($credName){
			$this->credName=$credName;
		}
		public function setCredCondition($credCondition){
			$this->credCondition=$credCondition;
		}
		public function setCredDestination($credDestination){
			$this->credDestination=$credDestination;
		}
		public function setCredBenefits($credBenefits){
			$this->credBenefits=$credBenefits;
		}
	}
?>