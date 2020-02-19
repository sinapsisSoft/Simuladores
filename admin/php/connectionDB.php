<?php
include "dto_data.php";
class Connection {
	private $mysqli;
	private $objDto;




	public function connect() {
		try {
			$objDto = new DtoDataConnection;
			$dataConnection = $objDto->getData();
			$mysqli = new mysqli( $dataConnection[ 0 ], $dataConnection[ 1 ], $dataConnection[ 2 ], $dataConnection[ 3 ] );

		} catch ( PDOException $e ) {
			die( "Error occurred:" . $e->getMessage() );
			
		}
		return $mysqli;
	}


}

?>