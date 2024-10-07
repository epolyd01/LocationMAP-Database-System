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

	$sql = "SELECT * FROM USER";
	$get_info = 

	function getDate(){
		$data = array();
		$data[1] = $_POST['Password'];
		$data[2] = $_POST['UserName'];
		$data[3] = $_POST['ID'];
		$data[4] = $_POST['Sex'];
		$data[5] = $_POST['Date_Of_Birth'];
		$data[6] = $_POST['Name'];
		$data[7] = $_POST['Type'];
	}
?>
<!DOCTYPE html>
<html>
<body>

  <div class="Edit">
    <h1>Edit User</h1>
    <hr>

    <label for="username"><b>Username</b></label>
    <input type="text" placeholder="Enter Username" name="username" id="username"><br>
    <label for="password"><b>Password</b></label>
    <input type="text" placeholder="Enter password" name="password" id="password"><br>
    <label for="ID"><b>ID</b></label>
    <input type="number" placeholder="Enter ID" name="id" id="id"><br>
    <label for="Sex"><b>Sex</b></label>
    <input type="text" placeholder="Enter Sex" name="Sex" id="sex"><br>
    <label for="Date_of_Birth"><b>Date of Birth</b></label>
    <input type="date" placeholder="Enter Date of Birth" name="dateofbirth" id="dateofbirth"><br>
    <label for="name"><b>Name</b></label>
    <input type="text" placeholder="Enter Full Name" name="name" id="name"><br>
    <label for="type"><b>Type</b></label>
    <input type="number" placeholder="Enter Type" name="type" id="type" min="1" max="3"><br>

    <button type="submit" class="finish">Finish</button>
  </div>
 
</form>
<form method="post">
		<input type="submit" name="disconnect" value="Disconnect"/>
		<input type="submit" value="Menu" formaction="connect.php">
	</form>
</body>
</html>

<?php
	echo "Connecting to SQL server (" . $serverName . ")<br/>";
	echo "Database: " . $connectionOptions[Database] . ", SQL User: " . $connectionOptions[Uid] . "<br/>";
	//echo "Pass: " . $connectionOptions[PWD] . "<br/>";

	//Establishes the connection
	$conn = sqlsrv_connect($serverName, $connectionOptions);

	//Read Query
	$tsql= "EXEC Q1Edit";

	echo "Executing query: " . $tsql . ")<br/>";
	$getResults= sqlsrv_query($conn, $tsql);
	echo "Results:<br/>";
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
