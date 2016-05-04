<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Main Help</title>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
	<script type="text/javascript">

	// <!CDATA[
	$(document).ready(function(){
		$('#managerBtn').click(function() {
			var element = document.getElementById("manager");
			element.scrollIntoView();
		});
		$('#cusRepBtn').click(function() {
			var element = document.getElementById("customerRepresentative");
			element.scrollIntoView();
		});
		$('#cusBtn').click(function() {
			var element = document.getElementById("customer");
			element.scrollIntoView();
		});
	});

	// ]]>
	</script>
	<link rel="stylesheet" href="gen.css" />
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<div class="menu" align="right">
		<a href="login">Login</a>		
	</div>
	<div class="body" align="Left">
		<div class="btn-group">
		  <button type="button" class="btn btn-danger" id="help_main">Help</button>
		  <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">		    
		  </button>
		  <div class="dropdown-menu">
		    <span class="dropdown-item" href="#" id="managerBtn">Manager</span>
		    <div class="dropdown-divider"></div>
		    <span class="dropdown-item" href="#" id="cusRepBtn">Customer Representative</span>
		    <div class="dropdown-divider"></div>
		    <span class="dropdown-item" href="#" id="cusBtn">Customer</span>
		  </div>
		</div>
		<div id="manager">
			<h3>MANAGER</h3>
			<dt>Account Info</dt>
			<dd>View your account information.</dd>
			<dt>Stocks</dt>
			<dd>Search for stocks and place orders.</dd>
			<dt>Employees</dt>
			<dd>View and manage your employees.</dd>
			<dt>Users</dt>
			<dd>View and manage the users of LiveStock.</dd>
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
		<div id="customerRepresentative">
			<h3>CUSTOMER REPRESENTATIVE</h3>
			<dl>
				<dt>Account Info</dt>
				<dd>View your account information.</dd>
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
				<dd>Read the help page of the manager.</dd>
				<dt>Logout</dt>
				<dd>Logout of this account and end the session.</dd>
			</dl>
		</div>
		<div id="customer">
			<h3>CUSTOMER</h3>
			<dl>
				<dt>Account Info</dt>
				<dd>View your account information.</dd>
				<dt>Portfolio</dt>
				<dd>View information about the stocks that you currently own.</dd>
				<dt>Orders</dt>
				<dd>View your pending and completed orders.</dd>
				<dt>Stocks</dt>
				<dd>Search for stocks and place orders.</dd>
				<dt>Conditional Price History</dt>
				<dd>View Conditonal Price History for conditional orders.</dd>
				<dt>Help</dt>
				<dd>Read the help page of the Customer.</dd>
				<dt>Logout</dt>
				<dd>Logout of this account and end the session.</dd>
			</dl>
		</div>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>