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

  $FID =$_GET['GetFID'];
  $OID =$_GET['GetOID'];

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
if(isset($_POST['Query3_Insert_Obj'])) {
	echo "Connecting to SQL server (" . $serverName . ")<br/>";
	echo "Database: " . $connectionOptions[Database] . ", SQL User: " . $connectionOptions[Uid] . "<br/>";
	//echo "Pass: " . $connectionOptions[PWD] . "<br/>";

	//Establishes the connection
	$conn = sqlsrv_connect($serverName, $connectionOptions);
 //Read Query
 $tsql = "{call Q3InsertObject(?,?,?,?,?,?,?)}";


$pass= $_SESSION["pas"];
$params1 = array( $pass );
$user_entry = sqlsrv_query($conn,"SELECT U.Seq_Num FROM [User] U WHERE U.Password=?;",$params1);

while ($row1 = sqlsrv_fetch_array($user_entry, SQLSRV_FETCH_ASSOC)) {
	$Seq_num = $row1['Seq_Num'];
}


  // Getting parameter from the http call and setting it for the SQL call
	 $params = array(
     array($_POST["height_q3"], SQLSRV_PARAM_IN),
	   array($_POST["width_q3"], SQLSRV_PARAM_IN),
		 array($_POST["id_q3"], SQLSRV_PARAM_IN),
     	array($FID, SQLSRV_PARAM_IN),
		 array(	$_POST["type_q3"], SQLSRV_PARAM_IN),
     array(	$_POST["description_q3"], SQLSRV_PARAM_IN),
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

 <h2><b>Insert Object in Fingerprint = <?php echo $FID?></h2><br>
<form method='post'>

   <strong>Height:</strong> <input type="number" name="height_q3" required><br>
	  <strong>Width:</strong> <input type="number" name="width_q3" required><br>
		 <strong>ObjectID:</strong> <input type="number" name="id_q3"  required><br>
	 <strong>Small Description:</strong><input type="text" name="description_q3" maxlength="150" required><br>
   <strong>TypeID:</strong><input type="number" name="type_q3"  required><br>

			 <br><input type="submit" name="Query3_Insert_Obj"/>
		 </form>



 <hr>
	 	<form method="post">
	 		<input type="submit" name="disconnect" value="Disconnect"/>
	 		<input type="submit" value="Menu" formaction="connect.php">
	 	</form>

	 </body>
	 </html>
