<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Help</title>
	<link rel="stylesheet" href="gen.css" />
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
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_rep_menu.jsp"></jsp:include>
	<div class="body" align="Left">
		<h2>Help</h2>
		<p>Hello! You are currently logged in as a Customer Representative. If this is incorrect,
		please logout using the button on the top right. Otherwise, here is what
		you can do on this account:</p>
		<dl>
			<dt>Account Info</dt>
			<dd>View and update your account information.</dd>
			<dt>Utilities</dt>
			<dd>Manage customer accounts and associated tools.</dd>
			<dt>Customers</dt>
			<dd>Manage customer account information.</dd>
			<dt>Colleauges</dt>
			<dd>View Employee Directory.</dd>
			<dt>Orders</dt>
			<dd>View and record pending orders, or view completed orders.</dd>
			<dt>Stocks</dt>
			<dd>Search for stocks and place orders.</dd>
			<dt>Help</dt>
			<dd>Read this help page.</dd>
			<dt>Logout</dt>
			<dd>Logout of this account and end the session.</dd>
		</dl>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>