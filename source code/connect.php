<?php
	session_start();
?>
<html>
<body>
	<link rel="stylesheet" href="connect.css">
<?php
	if (isset($_POST['connect'])) {
		echo "<br/>Setting session variables!<br/>";
		// collect value of input field
		$sqlDBname = $_POST['dbName'];
		$sqlUser = $_POST['userName'];
		$sqlPass = $_POST['pswd'];

		if (empty($sqlDBname)) echo "Database name is empty!<br/>";
		if (empty($sqlUser)) echo "Username is empty!<br/>";
		if (empty($sqlPass)) echo "Password name is empty!<br/>";

		if (!(empty($sqlDBname) || empty($sqlUser) || empty($sqlPass))) {
			// Set session variables
			$_SESSION["serverName"] = "mssql.cs.ucy.ac.cy";
			$_SESSION["connectionOptions"] = array(
				"Database" => $sqlDBname,
				"Uid" => $sqlUser,
				"PWD" => $sqlPass
			);
		} else {
			session_unset();
			session_destroy();
			echo "<br/>Cannot setup the session variables! Redirecting back in 5 seconds<br/>";
			die('<meta http-equiv="refresh" content="5; url=index.php" />');
		}
	}
?>
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
<div class="bg">
	<form action="home.php" method="post">
		<div class="form-field">
			<input type="text" name="Username" placeholder=" Username" required />
		</div>
		<div class="form-field">
			<input type="password" name="Password"placeholder="Password" required /> </div>
			<div class="form-field">
				<button class="btn" name="con" type="submit">Log in</button>
			</div>
		</form>
		</div>
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
