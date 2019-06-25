<?php

include "dao_credit.php";
include "dto_credit.php";

if ( isset( $_POST[ 'select' ] ) ) {
	$dataSearch = $_POST[ 'dataSearch' ];
	$obj = new DaoCredit();
	$obj->selectCredit( $dataSearch, 0 );

} else if ( isset( $_POST[ 'insert' ] ) ) {
	$conditions=json_decode($_POST[ 'json' ], true);
	
	$text=$conditions['conditions'][0]['condTerm'];
	$longJson=count($conditions['conditions']);
	$condition=array();
	for($i=0;$i<$longJson;$i++){
		
		$result=array($conditions['conditions'][$i]['condTerm'],$conditions['conditions'][$i]['condRate'],$conditions['conditions'][$i]['cond_NMV']);
		$condition[$i]=$result;
	}
	$ObjDtoCredit=new DtoCredit($_POST[ 'credId' ],$_POST[ 'credName' ],$_POST[ 'credCondition' ],$_POST[ 'credDestination' ],$_POST[ 'credBenefits' ],$condition);

	$obj = new DaoCredit();
	$obj->insertUpdateCredit($ObjDtoCredit);

} else if ( isset( $_POST[ 'selectList' ] ) ) {

	$obj = new DaoCredit();

	$obj->selectLoanCondition($_POST[ 'credId' ]);
	//echo $_POST[ 'credId' ];
}
else if ( isset( $_POST['condition'] ) ) {

	$obj = new DaoCredit();
	$obj->selectCreditCondiction();
	//echo $_POST[ 'condition' ];
}
else if ( isset( $_POST['selectUser'] ) ) {

	$obj = new DaoCredit();
	$obj->selectUser($_POST['userEmail'],$_POST['userPassword']);

	//echo $_POST[ 'condition' ];
}
else if ( isset( $_POST['delete'] ) ) {

	$obj = new DaoCredit();
	$obj->selectDeleteCredit($_POST['credId']);
	//echo $_POST[ 'condition' ];
}
else if ( isset( $_POST['selectCondition'] ) ) {

	$obj = new DaoCredit();
	$obj->selectCondition();
	//echo $_POST[ 'condition' ];
}
/*

$obj = new DaoCredit();
$obj->createCredit("so",1);
//$obj->selectLoanCondition();*/
	
?>