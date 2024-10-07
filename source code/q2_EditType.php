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


	$title = $_GET['GetT'];
	$model = $_GET['GetM'];
  $UID=$_GET['GetU'];
	$ID = $_GET['GetID'];
  $selected_type =$title;




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
if(isset($_POST['updateType'])) {
	echo "Connecting to SQL server (" . $serverName . ")<br/>";
	echo "Database: " . $connectionOptions[Database] . ", SQL User: " . $connectionOptions[Uid] . "<br/>";
	//echo "Pass: " . $connectionOptions[PWD] . "<br/>";

	//Establishes the connection
	$conn = sqlsrv_connect($serverName, $connectionOptions);


  $tsql = "{call Q2EditType(?,?,?,?,?)}";

//vres to id tou user sumfwna me to password
	$pass= $_SESSION["pas"];
	$params1 = array( $pass );
	$user_entry = sqlsrv_query($conn,"SELECT U.Seq_Num FROM [User] U WHERE U.Password=?;",$params1);

	while ($row1 = sqlsrv_fetch_array($user_entry, SQLSRV_FETCH_ASSOC)) {
		$Seq_num = $row1['Seq_Num'];
	}


   // Getting parameter from the http call and setting it for the SQL call
 	 $params = array(
      array($_POST["title_q2edit"], SQLSRV_PARAM_IN),
 	   array($_POST["model_q2edit"], SQLSRV_PARAM_IN),
 		 array($_POST["id_q2edit"], SQLSRV_PARAM_IN),
     array($Seq_num,SQLSRV_PARAM_IN),
		 array($selected_type,SQLSRV_PARAM_IN)


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


    <h2><b>Edit Type</b></h2>
    <form method="post" >
      <strong>Type ID:</strong> <input type="number" name="id_q2edit"value="<?php echo $ID;?>"required><br>
   	  <strong>Title:</strong> <input type="text" name="title_q2edit" maxlength="20" value="<?php echo $title;?>" required><br>
   		 <strong>Model of Origin:</strong> <input type="text" name="model_q2edit" maxlength="30" value= "<?php echo $model;?>" required><br>
   		  <!-- <strong>User entry</strong>: <input type="number" name="user_id_q2edit" value="<?php echo $UID;?>" required> <br> -->
   			 <br><input type="submit" name="updateType"/>
   		 </form>


		 </form>

	<hr>

<form method="post">
		<input type="submit" name="disconnect" value="Disconnect"/>
		<input type="submit" value="Menu" formaction="connect.php">
	</form>

</body>
</html>
