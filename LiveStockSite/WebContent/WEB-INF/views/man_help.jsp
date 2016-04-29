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
			<dd>View and update your account information.</dd>
			<dt>Stocks</dt>
			<dd>Search for stocks and place orders.</dd>
			<dt>Employees</dt>
			<dd>View and manage your employees.</dd>
			<dt>Finances</dt>
			<dd>View and manage your employees.</dd>
			<dt>Orders</dt>
			<dd>View and sort orders based on stock symbols or by customer name.</dd>
			<dt>Back Up</dt>
			<dd>Back up the database.</dd>
			<dt>Help</dt>
			<dd>Read the help page of the Manager.</dd>
			<dt>Logout</dt>
			<dd>Logout of this account and end the session.</dd>
		</dl>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>




