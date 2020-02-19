<?php
include "connectionDB.php";
header("Content-type: application/json; charset=utf-8");


class DaoCredit {
	private $mysqli;
	private $objCon;


	public function __construct() {
		$objCon = new Connection;
		$this->mysqli = $objCon->connect();
	}

	public function selectCredit($dataSearch, $typeSelection) {
		try {
			if ( $this->mysqli->connect_errno ) {
				echo "Is null";
			} else {
				$result = $this->mysqli->query('CALL select_credit("'.$dataSearch.'",'.$typeSelection.')');
				$rows=array();
				while($r=$result->fetch_assoc()){
					if($typeSelection==0){
						$rows[]=array(
						'credId'=>utf8_encode($r['credId']),
						'credName'=>utf8_encode($r['credName']),
						'credCondition'=>utf8_encode($r['credCondition']),
						'credDestination'=>utf8_encode($r['credDestination']),
						'credBenefits'=>utf8_encode($r['credBenefits']));
					}
					else{
						$rows[]=$r;
					}
				}
				//var_dump($rows[0]);
				echo json_encode($rows,JSON_UNESCAPED_UNICODE);
			}

		} catch ( PDOException $e ) {
			die( "Error occurred:" . $e->getMessage() );
		}
		$this->mysqli->close();
	}
	public function selectLoanCondition($idCred) {
		try {
			if ( $this->mysqli->connect_errno ) {
				echo "Is null";
			} else {
				$mysqlConsult=$idCred;
				$result  = $this->mysqli->query( 'CALL select_loan_condition('.$mysqlConsult.')' );
				$rows;
				while($r=$result->fetch_assoc()){
					$rows[]=$r;				
				}
				//echo json_encode($rows,JSON_UNESCAPED_UNICODE);
				echo utf8_encode(json_encode($rows,true));
				
			}

		} catch ( PDOException $e ) {
			die( "Error occurred:" . $e->getMessage() );

		}
		$this->mysqli->close();

	}
	public function insertUpdateCredit($object){
		$data;
		try {
			
			if ( $this->mysqli->connect_errno ) {
				echo "Is null";
			} else {
				$mysqlConsult=
					$object->getCredId().",'".
					utf8_decode($object->getCredName())."','".
					utf8_decode($object->getCredCondition())."','".
					utf8_decode($object->getCredDestination())."','".
					utf8_decode($object->getCredBenefits())."'";
				$result  = $this->mysqli->query( 'CALL insertUpdate_credit('.$mysqlConsult.')');
				if($result){
					
					while ($r=$result->fetch_row()) {
			
						$data=$r[0];
					}
					
					if(!$this->insertUpdate_condition($data,$object->getCredConditionList())){
						$result=false;
					}else{
						$result=true;
					}
					
				}else{
					$result=false;	
				}
				
				
				echo utf8_encode(json_encode($result,true));
				
			}

		} catch ( PDOException $e ) {
			die( "Error occurred:" . $e->getMessage() );

		}
		$this->mysqli->close();

		//echo utf8_encode(json_encode($object->getCredCondition(),true));
	} 
	public function selectCreditCondiction(){
		try {
			if ( $this->mysqli->connect_errno ) {
				echo "Is null";
			} else {
				
				$result  = $this->mysqli->query( 'CALL select_usert()' );
				$rows;
				while($r=$result->fetch_assoc()){
					$rows[]=$r;				
				}
				//echo json_encode($rows,JSON_UNESCAPED_UNICODE);
				echo utf8_encode(json_encode($rows,true));
				
			}

		} catch ( PDOException $e ) {
			die( "Error occurred:" . $e->getMessage() );

		}
		$this->mysqli->close();

	}
	public function insertUpdate_condition($dataId,$dataConditionLIst){

		try {
				$objCon = new Connection;
				$mysqli_ = $objCon->connect();
			if ( $mysqli_->connect_errno ) {
				echo "Is null";
			} else {
				$list=$dataConditionLIst;
			
				for($i=0;$i<count($list);$i++)
				{
				
					$mysqlConsult=$dataId.",'".$list[$i][0]."','".$list[$i][1]."','".$list[$i][2]."'";
					$resultList = $mysqli_->query( 'CALL insertUpdate_condition('.$mysqlConsult.')');	
					
				}
				//echo("Diego".$mysqlConsult);
				
				if($resultList){
					
					return(true);		
				}else{
					return(false);	
				}
				$resultList->close();
		
			}
			return true;

		} catch ( PDOException $e ) {
			die( "Error occurred:" . $e->getMessage() );

		}
		$mysqli_->close();


	} 
	public function selectUser($user,$password){
		try {
			if ( $this->mysqli->connect_errno ) {
				echo "Is null";
			} else {
				
				$result  = $this->mysqli->query( 'CALL select_usert("'.$user.'","'.$password.'")' );
				$rows;
				while($r=$result->fetch_assoc()){
					$rows[]=$r;				
				}
				//echo json_encode($rows,JSON_UNESCAPED_UNICODE);
				echo utf8_encode(json_encode($rows,true));
				
			}

		} catch ( PDOException $e ) {
			die( "Error occurred:" . $e->getMessage() );

		}
		$this->mysqli->close();

	}
	public function selectDeleteCredit($id){
		try {
			if ( $this->mysqli->connect_errno ) {
				echo "Is null";
			} else {
				
				$result  = $this->mysqli->query( 'CALL delete_credit('.$id.')' );
				$rows;
				while($r=$result->fetch_assoc()){
					$rows[]=$r;				
				}
				//echo json_encode($rows,JSON_UNESCAPED_UNICODE);
				echo utf8_encode(json_encode($rows,true));
				
			}

		} catch ( PDOException $e ) {
			die( "Error occurred:" . $e->getMessage() );

		}
		$this->mysqli->close();
	}
}

?>