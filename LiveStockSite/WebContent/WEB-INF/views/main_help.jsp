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
				<dd>Read the Manager help page.</dd>
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
				<dd>Create a mailing list of customers and create stock suggestion lists for them.</dd>
				<dt>Customers</dt>
				<dd>View customer account information. Add, edit, and delete customers.</dd>
				<dt>Colleagues</dt>
				<dd>View Employee Directory.</dd>
				<dt>Orders</dt>
				<dd>View order information and record pending orders.</dd>
				<dt>Stocks</dt>
				<dd>View current listing of stocks and bestseller list. Place orders on behalf of a customer.<br />
				Also search for a stock by type or keyword.</dd>
				<dt>Help</dt>
				<dd>Read the Customer Representative help page.</dd>
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
				<dd>View information about your accounts and the stocks that you currently own.</dd>
				<dt>Orders</dt>
				<dd>View your pending and completed orders. View the conditional price history for each order.</dd>
				<dt>Stocks</dt>
				<dd>View current stock listings, a list of bestsellers, and a personalized suggestion list.<br />
					Also search for stocks by type or keyword, and view their stock price history.</dd>
				<dt>Help</dt>
				<dd>Read the Customer help page.</dd>
				<dt>Logout</dt>
				<dd>Logout of this account and end the session.</dd>
			</dl>
		</div>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>