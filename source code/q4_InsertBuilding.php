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
if(isset($_POST['Query4_Insert_B'])) {
	echo "Connecting to SQL server (" . $serverName . ")<br/>";
	echo "Database: " . $connectionOptions[Database] . ", SQL User: " . $connectionOptions[Uid] . "<br/>";
	//echo "Pass: " . $connectionOptions[PWD] . "<br/>";

	//Establishes the connection
	$conn = sqlsrv_connect($serverName, $connectionOptions);
 //Read Query
 $tsql = "{call Q5InsertBuilding(?,?,?,?,?,?,?,?)}";




  // Getting parameter from the http call and setting it for the SQL call
	 $params = array(
     		array($_POST["b1"], SQLSRV_PARAM_IN),
	  	 array($_POST["b2"], SQLSRV_PARAM_IN),
		 array($_POST["b3"], SQLSRV_PARAM_IN),
     		array($_POST["b4"], SQLSRV_PARAM_IN),
		 array(	$_POST["b5"], SQLSRV_PARAM_IN),
     		array(	$_POST["b6"], SQLSRV_PARAM_IN),
		array(	date('Y-m-d',strtotime($_POST["b7"])), SQLSRV_PARAM_IN),
		array(	$_POST["b8"], SQLSRV_PARAM_IN)


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

 <h2><b>Insert Bulding</h2><br>
<form method='post'>

   <strong>Building Code:</strong> <input type="text" name="b1" maxlength="10" required><br>
	  <strong>Build ID:</strong> <input type="number" name="b2" required><br>
		 <strong>X:</strong> <input type="text" name="b3"  required><br>
	 <strong>Y:</strong><input type="text" name="b4"  required><br>
   <strong>Address:</strong><input type="text" name="b5"  required><br>
 <strong>Small Description:</strong><input type="text" name="b6" maxlength="280" required><br>
<strong>Date of Register:</strong><input type="date" name="b7" required><br>
<strong>Owner:</strong><input type="text" name="b8" maxlength="50"><br>


			 <br><input type="submit" name="Query4_Insert_B"/>
		 </form>



 <hr>
	 	<form method="post">
	 		<input type="submit" name="disconnect" value="Disconnect"/>
	 		<input type="submit" value="Menu" formaction="connect.php">
	 	</form>

	 </body>
	 </html>
