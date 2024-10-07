<?php
	session_start();
	// Get the DB connection info from the session
	if(isset($_SESSION["serverName"]) && isset($_SESSION["connectionOptions"])) {
		$serverName = $_SESSION["serverName"];
		$connectionOptions = $_SESSION["connectionOptions"];
	} else {
		// Session is not correctly set! Redirecting to start page
		session_unset();
		session_destroy();
		echo "Session is not correctly set! Clossing session and redirecting to start page in 3 seconds<br/>";
		die('<meta http-equiv="refresh" content="3; url=index.php" />');
		//header('Location: index.php');
		//die();
	}
  $F_ID = $_GET['GetID'];


?>


<html>
<head>
	<style>
		table th{background:grey}
		table tr:nth-child(odd){background:LightYellow}
		table tr:nth-child(even){background:LightGray}
	</style>
</head>
<body>
	<table cellSpacing=0 cellPadding=5 width="100%" border=0>
	<tr>
		<td vAlign=top width=170><img height=91 alt=UCY src="images/ucy.jpg" width=94>
			<h5>
				<a href="http://www.ucy.ac.cy/">University of Cyprus</a><BR/>
				<a href="http://www.cs.ucy.ac.cy/">Dept. of Computer Science</a>
			</h5>
		</td>
		<td vAlign=center align=middle><h2>Welcome to the EPL342 project test page</h2></td>
	</tr>
    </table>
	<hr>
  <h2>View Objects in FingerprintID = <?php echo $F_ID?></h2>

<?php

// if(isset($_POST['search_object']){
// $conn = sqlsrv_connect($serverName, $connectionOptions);
// 	$Object_ID = $_POST['oid'];
// $tsq2=   "SELECT O.Height,O.Width,O.ObjectID,O.FingerprintID,O.TypeID,O.Small_Description as [Description] , o.User_entry as [User Entry] FROM [Object] O INNER JOIN [FINGERPRINT] F ON O.FingerprintID=F.FingerprintID  WHERE $F_ID = F.FingerprintID AND $Object_ID=O.ObjectID ORDER BY O.ObjectID,O.TypeID" ;
//
//
// //echo "Executing query: " . $tsql . ") without any parameter<br/>";
// $getResults= sqlsrv_query($conn, $tsq2);
// echo "Results:<br/>";
// if ($getResults == FALSE)
// 	die(FormatErrors(sqlsrv_errors()));
//
// PrintResultSet($getResults);
//
// /* Free query  resources. */
// sqlsrv_free_stmt($getResults);
//
// /* Free connection resources. */
// sqlsrv_close( $conn);
//
// function PrintResultSet ($resultSet) {
// 	echo ("<table><tr >");
//
// 	foreach( sqlsrv_field_metadata($resultSet) as $fieldMetadata ) {
// 		echo ("<th>");
// 		echo $fieldMetadata["Name"];
// 		echo ("</th>");
// 	}
//
// 	echo("<th>View Objects</th>");
//
// 	echo ("</tr>");
//
//
// 	while ($row1 = sqlsrv_fetch_array($resultSet, SQLSRV_FETCH_ASSOC)) {
// 		echo ("<tr>");
//
// 		foreach($row1 as $col){
//
// 			echo ("<td>");
// 			echo (is_null($col) ? "Null" : $col);
// 			echo ("</td>");
// 		}
// 		//esu ta evales
//
// 	$OID2= $row1['ObjectID'];
//
// 					echo("<td><a href='q3_DeleteObject.php?GetID=$OID2' >Delete</a></td>");//esu to evales
//
//
// 	}
//
//
// 	echo ("</table>");
// 		echo("<br>");
//
// 	 $FID = $_GET['GetID'];
// 		echo("<a href='q3_InsertObject.php?GetFID=$FID&GetOID=$OID'>Insert new Object</a>");//esu to evales
// }
//
// function FormatErrors( $errors ){
// 	/* Display errors. */
// 	echo "Error information: ";
//
// 	foreach ( $errors as $error )
// 	{
// 		echo "SQLSTATE: ".$error['SQLSTATE']."";
// 		echo "Code: ".$error['code']."";
// 		echo "Message: ".$error['message']."";
// 	}
// }
// }//IF

///////////////////////////////////////////////////////////////
?>

<form method="post">
<input type="number" placeholder="Search by Object Id"  name="oid">
<input type="submit"   name="search_object" value="Search"/>
</form>

	<?php
	echo "Connecting to SQL server (" . $serverName . ")<br/>";
	echo "Database: " . $connectionOptions[Database] . ", SQL User: " . $connectionOptions[Uid] . "<br/>";
	//echo "Pass: " . $connectionOptions[PWD] . "<br/>";

	//Establishes the connection
	$conn = sqlsrv_connect($serverName, $connectionOptions);

	//Read Query

	$tsql=   "SELECT O.Height,O.Width,O.ObjectID,O.FingerprintID,O.TypeID,O.Small_Description as [Description] , o.User_entry as [User Entry] FROM [Object] O INNER JOIN [FINGERPRINT] F ON O.FingerprintID=F.FingerprintID  WHERE $F_ID = F.FingerprintID   ORDER BY O.ObjectID,O.TypeID" ;


	//echo "Executing query: " . $tsql . ") without any parameter<br/>";
	$getResults= sqlsrv_query($conn, $tsql);
	echo "Results:<br/>";
	if ($getResults == FALSE)
		die(FormatErrors(sqlsrv_errors()));

	PrintResultSet($getResults);

	/* Free query  resources. */
	sqlsrv_free_stmt($getResults);

	/* Free connection resources. */
	sqlsrv_close( $conn);

	/*
	function PrintResultSet ($resultSet) {
		while ($row = sqlsrv_fetch_array($resultSet, SQLSRV_FETCH_ASSOC)) {
			$newRow = true;
			foreach($row as $col){
				if ($newRow) {
					$newRow = false;
					echo (is_null($col) ? "Null" : $col);
				} else {
					echo (", ".(is_null($col) ? "Null" : $col));
				}
			}
			echo("<br/>");
		}
		echo ("<table><tr><td>---</td></tr></table>");
	}
	*/

	function PrintResultSet ($resultSet) {
		echo ("<table><tr >");

		foreach( sqlsrv_field_metadata($resultSet) as $fieldMetadata ) {
			echo ("<th>");
			echo $fieldMetadata["Name"];
			echo ("</th>");
		}

		echo("<th>Delete</th>");

		echo ("</tr>");


		while ($row = sqlsrv_fetch_array($resultSet, SQLSRV_FETCH_ASSOC)) {
			echo ("<tr>");

			foreach($row as $col){

				echo ("<td>");
				echo (is_null($col) ? "Null" : $col);
				echo ("</td>");
			}
			//esu ta evales

		$OID= $row['ObjectID'];

           	echo("<td><a href='q3_DeleteObject.php?GetID=$OID' >Delete</a></td>");//esu to evales


		}


		echo ("</table>");
      echo("<br>");

  	 $FID = $_GET['GetID'];
      echo("<a href='q3_InsertObject.php?GetFID=$FID&GetOID=$OID'>Insert new Object</a>");//esu to evales
	}

	function FormatErrors( $errors ){
		/* Display errors. */
		echo "Error information: ";

		foreach ( $errors as $error )
		{
			echo "SQLSTATE: ".$error['SQLSTATE']."";
			echo "Code: ".$error['code']."";
			echo "Message: ".$error['message']."";
		}
	}




	?>


	<hr>

	<?php
		if(isset($_POST['disconnect'])) {
			echo "Clossing session and redirecting to start page";
			session_unset();
			session_destroy();
			die('<meta http-equiv="refresh" content="1; url=index.php" />');
		}
	?>

	<form method="post">
		<input type="submit" name="disconnect" value="Disconnect"/>
		<input type="submit" value="Menu" formaction="connect.php">
	</form>

</body>
</html>
