
<?php
session_start();

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
	$conn = sqlsrv_connect($serverName, $connectionOptions);

	if (isset($_POST['con'])) {
		echo "<br/>Setting session variables!<br/>";
		// collect value of input field
		$name = $_POST['Username'];
		$pas = $_POST['Password'];


		if (empty($name)) echo "name is empty!<br/>";
		if (empty($pas)) echo "password is empty!<br/>";

		if (!(empty($name) || empty($pas))) {
			// Set session variables

			$_SESSION["name"] = $name;
			$_SESSION["pas"] = $pas;

			// $Username = $_SESSION["name"];
			// $Password = $_SESSION["pas"];
			$params1 = array( $Username );
			$params2 = array($Username, $Password);

			$login = FALSE;

			$login_check = "SELECT Username, Password
        FROM [User]
        WHERE Username= '$name' AND Password='$pas'";
					$stmt = sqlsrv_query( $conn, $login_check);
					$row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
						if( $stmt === false ) {
     			die( print_r( sqlsrv_errors(), true));
						}

						if(!$row){
							echo"<h1>The user does not exist</h1>";
								die('<meta http-equiv="refresh" content="5; url=connect.php" />');
						}

							// Make the first (and in this case, only) row of the result set available for reading.
							if( sqlsrv_fetch( $stmt ) === false) {
     					die( print_r( sqlsrv_errors(), true));
								}

// Get the row fields. Field indices start at 0 and must be retrieved in order.
// Retrieving row fields by name is not supported by sqlsrv_get_field.
					$name = sqlsrv_get_field( $stmt, 0);
					echo "$name: ";




			$Username = $_SESSION["name"];
			$params1 = array( $Username );
			$type = sqlsrv_query($conn,"SELECT U.Type FROM [User] U WHERE U.Username=?;",$params1);

			while ($row1 = sqlsrv_fetch_array($type, SQLSRV_FETCH_ASSOC)) {
				$type = $row1['Type'];
				}

					$_SESSION["Type"] = $type;


		} else {
			session_unset();
			session_destroy();
			echo "<br/>Cannot setup the session variables! Redirecting back in 5 seconds<br/>";
			die('<meta http-equiv="refresh" content="2; url=index.php" />');
		}
	}


	//echo $_SESSION["name"];
	//echo $_SESSION["pas"] ;
	//echo $_SESSION["Type"];
?>

<!DOCTYPE html>
<html>
  <body>
  	<table cellSpacing=0 cellPadding=5 width="100%" border=0>
  	<tr>
  		<td vAlign=top width=170><img height=91 alt=UCY src="download.png" width=94>
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
	if ( $type == 1 ){
	 echo("<a href='q1_InsertUser.php'>Query 1 (Insert User)</a><br>");
  	echo("<a href='q1_ViewUsers.php'>Query 1 (View Users)</a><br>");
	}
	?>
	<?php
		if ( $type == 2 || $type == 1){
		echo("<a href='q2_InsertType.php'>Query 2 (Insert Type)</a><br>");
		echo("<a href='q2_ViewTypes.php'>Query 2 (View Types)</a><br>");
		echo("<a href='q3_InsertFingerprint.php'>Query 3 (Insert Fingerprint)</a><br>");
	echo("<a href='q3_ViewFingerprints.php'>Query 3 (View Fingerprints)</a><br>");
  	echo("<a href='q4_ViewBuildings.php'>Query 4 (View Buildings) </a><br>");
	echo("<a href='q4_InsertBuilding.php'>Query 4 (Insert new Building)</a><br>");//esu to evales
  	echo("<a href='q5_ViewCampus.php'>Query 5 (View Campuses) </a><br>");
	echo("<a href='q5_InsertCampus.php'>Query 5 (Insert Campus) </a><br>");
	}
	?>

  	<a href="q6.php">Query 6 (List of fingerprints)</a><br>
  	<a href="q7.php">Query 7 (Find most popular item types)</a><br>
  	<a href="q8.php">Query 8 (Number of types of POIs per floor)</a><br>
  	<a href="q9.php">Query 9 (Average number of objects per type)</a><br>
  	<a href="q10.php">Query 10 (Finding high floors)</a><br>
  	<a href="q11.php">Query 11 (Finding smaller floors)</a><br>
  	<a href="q12.php">Query 12 (Finding fingerprints with common object types)</a><br><br>
  	<a>Query 13 </a>
	  <form action="q13.php" method="post">
  		</a>(Finding common object types)<br>
  		Fingerprint ID: <input type="number" name="fingerprint_q13" placeholder = "FINGERPRINT" required>
  		<input type="submit" name="Query 13">
  	</form><br>
  	<a>Query 14</a>
	  <form action="q14.php" method="post">
  		</a> (Finding the k object types with the fewest participants)<br>
  		Number k <input type="number" name="k_q14" placeholder = "NUMBER K" required>
  		<input type="submit" name="Query 14">
  	</form><br>
  	<a href="q15.php">Query 15 (Types of objects found in each fingerprint)</a><br><br>
  	<a>Query 16 </a>
	  <form action="q16.php" method="post">
  		</a>(Find multiple objects within a bounding box)<br>
  		Type ID: <input type="number" name="type_q16" placeholder = "TYPE">
		X1: <input type="text" name="x1_q16" placeholder = "X1" required>
		X2: <input type="text" name="x2_q16" placeholder = "X2" required>
		Y1: <input type="text" name="y1_q16" placeholder = "Y1" required>
		Y2: <input type="text" name="y2_q16" placeholder = "Y2" required>
  		<input type="submit" name="Query 16">
  	</form><br>
  	<a>Query 17 </a><br><br>
		<form action="q17.php" method="post">
  		</a>(Find building bounding box)<br>
  		Building ID: <input type="number" name="Building_Code_q17" placeholder = "Building Code" required>
			<input type="submit" name="Query 17">
  	</form><br>
  	<a>Query 18 </a>
	  <form action="q18.php" method="post">
  		</a>(Find nearest (Nearest Neighbor - NN) POI ( Point Of Interest))<br>
		X: <input type="text" name="x_q18" placeholder = "X" required>
		Y: <input type="text" name="y_q18" placeholder = "Y" required>
		Floor Number: <input type="number" name="floor_number_q18" placeholder = "Floor Number" required>
  		<input type="submit" name="Query 18">
		  </form><br><br>
  	<a>Query 19 </a><br>
	  <form action="q19.php" method="post">
  		</a>(Find k nearest (k Nearest Neighbor - kNN) POIs ( Points of Interest ))<br>
		Number k: <input type="number" name="k_q19" placeholder = "NUMBER K" required>
		X: <input type="text" name="x_q19" placeholder = "X" required>
		Y: <input type="text" name="y_q19" placeholder = "Y" required>
		Floor Number: <input type="number" name="floor_number_q19" placeholder = "Floor Number" required>
  		<input type="submit" name="Query 19">
		  </form><br><br>
  	<a>Query 20 </a><br>
	  <form action="q20.php" method="post">
  		</a>(Find all k nearest (All k Nearest Neighbor - AkNN) POIs of one floor)<br>
		Number K: <input type="number" name="k_q20" placeholder = "NUMBER K" required>
		Floor Number: <input type="number" name="floor_number_q20" placeholder = "Floor Number" required>
  		<input type="submit" name="Query 20" >
		  </form><br>
  	<a>Query 21 </a><br>
		<form action="q21.php" method="post">
  		</a>(Total number of fingerprint route objects)<br>
		Fingerprint ID: <input type="number" name="fid_q21" placeholder = "Fingerprint ID" required>
		X: <input type="text" name="x_q21" placeholder = "X" required>
  		<input type="submit" name="Query 21" >
		  </form><br>
<br>


  	<hr>
  	<?php
  		if(isset($_POST['disconnect'])) {
  			echo "Clossing session and redirecting to start page";
  			session_unset();
  			session_destroy();
  			die('<meta http-equiv="refresh" content="2; url=index.php" />');
  		}
  	?>

  	<form method="post">
  		<input type="submit" name="disconnect" value="Disconnect"/>
  	</form>

  </body>
  </html>
