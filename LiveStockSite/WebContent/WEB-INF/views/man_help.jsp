<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Help</title>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

	// <!CDATA[
	$(document).ready(function(){
		console.log("help!");	
		$("#help").addClass('active');
	});

	// ]]>
	</script>
	<link rel="stylesheet" href="gen.css" />
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_man_menu.jsp"></jsp:include>
	<div class="body" align="Left">
		<h2>Help</h2>
		<p>Hello! You are currently logged in as a Manager. If this is incorrect,
		please logout using the button on the top right. Otherwise, here is what
		you can do on this account:</p>
		<dl>
			<dt>Account Info</dt>
			<dd>View your account information.</dd>
			<dt>Employees</dt>
			<dd>View, add, edit, and delete employees.</dd>
			<dt>Users</dt>
			<dd>View, add, and delete all the users of LiveStock.</dd>
			<dt>Finances</dt>
			<dd>View information about all completed transactions.<br />
				Generate sales reports by month. View customer and employee of the year (based on revenue).
			<br />View a summary of revenue by stock, stock type, or customer.</dd>
			<dt>Orders</dt>
			<dd>View information about orders and filter it by stock symbol or customer name.</dd>
			<dt>Stocks</dt>
			<dd>View current listing of stocks or bestseller list. Set prices of stocks.<br />
				Show the most actively traded stocks. Search by stock type or keywords.</dd>
			<dt>Utilities</dt>
			<dd>Back up and restore the database.</dd>
			<dt>Help</dt>
			<dd>Read this Manager help page.</dd>
			<dt>Logout</dt>
			<dd>Logout of this account and end the session.</dd>
		</dl>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>




