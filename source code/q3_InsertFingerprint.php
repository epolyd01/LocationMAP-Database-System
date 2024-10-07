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

<?php
if(isset($_POST['Query3_Insert_Fingerprint'])) {
	echo "Connecting to SQL server (" . $serverName . ")<br/>";
	echo "Database: " . $connectionOptions[Database] . ", SQL User: " . $connectionOptions[Uid] . "<br/>";
	//echo "Pass: " . $connectionOptions[PWD] . "<br/>";

	//Establishes the connection
	$conn = sqlsrv_connect($serverName, $connectionOptions);
//find id of user that wants to insert the fingeprint
$pass= $_SESSION["pas"];
$params1 = array( $pass );
$user_entry = sqlsrv_query($conn,"SELECT U.Seq_Num FROM [User] U WHERE U.Password=?;",$params1);

while ($row1 = sqlsrv_fetch_array($user_entry, SQLSRV_FETCH_ASSOC)) {
	$Seq_num = $row1['Seq_Num'];
}



 //Read Query
 $tsql = "{call Q3InsertFingerprint(?,?,?,?,?,?)}";


$X=floatval($_POST["x_InsertF"]);
$Y=floatval($_POST["y_InsertF"]);


  // Getting parameter from the http call and setting it for the SQL call
	 $params = array( array(date('Y-m-d h:m:s.n',strtotime( $_POST["date_InsertF"])), SQLSRV_PARAM_IN),
	  array($X, SQLSRV_PARAM_IN),
		 array($Y ,SQLSRV_PARAM_IN),
		 array($_POST["floor_InsertF"], SQLSRV_PARAM_IN),
  		array($_POST["id_InsertF"], SQLSRV_PARAM_IN),
		array($Seq_num, SQLSRV_PARAM_IN)
		  

		);

	echo "Executing query: " . $tsql . ")<br/>";
	 $getResults= sqlsrv_query($conn, $tsql, $params);

	if ($getResults == FALSE)
		die(FormatErrors(sqlsrv_errors()));


	PrintResultSet($getResults);

	/* Free query  resources. */
	sqlsrv_free_stmt($getResults);

	/* Free connection resources. */
	sqlsrv_close( $conn);



	function PrintResultSet ($resultSet) {
		echo ("<table><tr >");

		foreach( sqlsrv_field_metadata($resultSet) as $fieldMetadata ) {
			echo ("<th>");
			echo $fieldMetadata["Name"];
			echo ("</th>");
		}
		echo ("</tr>");

		while ($row = sqlsrv_fetch_array($resultSet, SQLSRV_FETCH_ASSOC)) {
			echo ("<tr>");
			foreach($row as $col){
				echo ("<td>");
				echo (is_null($col) ? "Null" : $col);
				echo ("</td>");
			}
			echo ("</tr>");
		}
		echo ("</table>");
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
}//to if p evales
	?>

	<?php
		if(isset($_POST['disconnect'])) {
			echo "Clossing session and redirecting to start page";
			session_unset();
			session_destroy();
			die('<meta http-equiv="refresh" content="1; url=index.php" />');
		}
	?>

 <h2><b>Insert Fingerprint</b></h2><br>
 <form method="post" >
	<strong>  Date Of Register:</strong> <input type="datetime-local" name="date_InsertF"  required>&nbsp
    <br><strong>Position:</strong><br>
		X: <input type="text" name="x_InsertF"  required>&nbsp
		 Y: <input type="text" name="y_InsertF" required>&nbsp
		 Floor number: <input type="number" name="floor_InsertF" required> <br>
		<strong>FingerprintID:</strong><input type="number" name="id_InsertF" required> <br>

			 <br> <br><input type="submit" name="Query3_Insert_Fingerprint"/>

		 </form>



 <hr>
	 	<form method="post">
	 		<input type="submit" name="disconnect" value="Disconnect"/>
	 		<input type="submit" value="Menu" formaction="connect.php">
	 	</form>

	 </body>
	 </html>
