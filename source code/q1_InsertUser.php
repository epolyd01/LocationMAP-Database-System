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
if(isset($_POST['Query1_Insert_User'])) {
	echo "Connecting to SQL server (" . $serverName . ")<br/>";
	echo "Database: " . $connectionOptions[Database] . ", SQL User: " . $connectionOptions[Uid] . "<br/>";
	//echo "Pass: " . $connectionOptions[PWD] . "<br/>";

	//Establishes the connection
	$conn = sqlsrv_connect($serverName, $connectionOptions);

 //Read Query
 $tsql = "{call Q1Insert(?,?,?,?,?,?,?,?)}";

  // Getting parameter from the http call and setting it for the SQL call
	 $params = array( array($_POST["password_Insertq1"], SQLSRV_PARAM_IN),
	  array($_POST["username_Insertq1"], SQLSRV_PARAM_IN),
		 array($_POST["id_Insertq1"], SQLSRV_PARAM_IN),
		 array($_POST["sex_Insertq1"], SQLSRV_PARAM_IN),
		 array(date('Y-m-d h:m:s',strtotime( $_POST["date_of_birth_Insertq1"])), SQLSRV_PARAM_IN),
		  array($_POST["LName_Insertq1"], SQLSRV_PARAM_IN),
			 array($_POST["FName_Insertq1"], SQLSRV_PARAM_IN),
		  array($_POST["type_Insertq1"], SQLSRV_PARAM_IN)

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

 <h2><b>Insert User</b></h2>
 <form method="post" >
	  Password: <input type="text" name="password_Insertq1" maxlength="35" required>&nbsp
		UserName: <input type="text" name="username_Insertq1" maxlength="20" required>&nbsp
		 ID: <input type="number" name="id_Insertq1" required>&nbsp <br>
		 Sex: <br>
		 <input type="radio" name="sex_Insertq1" value='M' required/>Male<br />
		 <input type="radio" name="sex_Insertq1" value='F' required/>Female<br />
		 Date_Of_Birth: <input type="date" name="date_of_birth_Insertq1" required>&nbsp
		 Last Name: <input type="text" name="LName_Insertq1"  maxlength="40" required> &nbsp
		 First Name: <input type="text" name="FName_Insertq1" maxlength="40" required> &nbsp
			Type: <select name="type_Insertq1" >
				<option value='3' selected="selected">User</option>
				 <option value='2'>LocationMap Admin</option>
				 <option value='1' >System Admin</option>
			 </select>

			 <br> <br><input type="submit" name="Query1_Insert_User"/>

		 </form>



 <hr>
	 	<form method="post">
	 		<input type="submit" name="disconnect" value="Disconnect"/>
	 		<input type="submit" value="Menu" formaction="connect.php">
	 	</form>

	 </body>
	 </html>
