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


	$UserName = $_GET['GetU'];
	$Password = $_GET['GetP'];
	$ID = $_GET['GetID'];
	$Sex = $_GET['GetS'];
	$Date = $_GET['GetD'];
	$Last_Name = $_GET['GetL'];
	$First_Name = $_GET['GetF'];
	$Role = $_GET['GetR'];




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
if(isset($_POST['updateUser'])) {
	echo "Connecting to SQL server (" . $serverName . ")<br/>";
	echo "Database: " . $connectionOptions[Database] . ", SQL User: " . $connectionOptions[Uid] . "<br/>";
	//echo "Pass: " . $connectionOptions[PWD] . "<br/>";

	//Establishes the connection
	$conn = sqlsrv_connect($serverName, $connectionOptions);

 //Read Query
 $tsql = "{call Q1Edit(?,?,?,?,?,?,?,?,?)}";


  // Getting parameter from the http call and setting it for the SQL call
	 $params = array( array($_POST["password_Editq1"], SQLSRV_PARAM_IN),
	  array($_POST["username_Editq1"], SQLSRV_PARAM_IN),
		 array($_POST["id_Editq1"], SQLSRV_PARAM_IN),
		 array($_POST["sex_Editq1"], SQLSRV_PARAM_IN),
		 array(date('Y-m-d',strtotime($_POST["date_of_birth_Editq1"])), SQLSRV_PARAM_IN),
		  array($_POST["LName_Editq1"], SQLSRV_PARAM_IN),
		  array($_POST["FName_Editq1"], SQLSRV_PARAM_IN),
		  array($_POST["role_Editq1"], SQLSRV_PARAM_IN),
 		array($UserName, SQLSRV_PARAM_IN)

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
<body>

  <div class="Edit">
    <h2>Edit User</h2>


 <form method="post" >
	 <stong>Password: </stong> <input type="text" name="password_Editq1" maxlength="35" value="<?php echo $Password;?>" required><br>
		<stong>UserName:</stong>  <input type="text" name="username_Editq1" maxlength="20" value="<?php echo $UserName;?>" required><br>
		<stong>ID:</stong>  <input type="number" name="id_Editq1" value="<?php echo $ID;?>" required> <br>
		<stong>Sex:</stong>  <input type="text" name="sex_Editq1" pattern="[F,M]{1}" title="M for Male and F for Female" value="<?php echo $Sex;?>" pattern=required><br>
		<stong>Date_Of_Birth:</stong>  <input type="date" name="date_of_birth_Editq1" value="<?php echo $Date;?>"  required><br>
		<stong>Last Name:</stong>  <input type="text" name="LName_Editq1"  maxlength="40" value="<?php echo $Last_Name;?>"  required> <br>
		<stong>First Name:</stong>  <input type="text" name="FName_Editq1" maxlength="40" value="<?php echo $First_Name;?>" required> <br>
		<stong>Role</stong> ( 1:Admin, 2:LocationMap, 3:User): <input type="number" name="role_Editq1" value="<?php echo $Role;?>" min="1" max="3" title="Please enter a valid value. Only numbers 1,2,3 are allowed." required>&nbsp <br>

			 <br> <br><input type="submit" name="updateUser" value="Update"/>

		 </form>

	<hr>

<form method="post">
		<input type="submit" name="disconnect" value="Disconnect"/>
		<input type="submit" value="Menu" formaction="connect.php">
	</form>

</body>
</html>
