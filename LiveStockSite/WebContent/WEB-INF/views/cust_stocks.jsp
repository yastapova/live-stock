<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Stocks</title>
	<link rel="stylesheet" href="../gen.css" />
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_cust_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<h2>Login</h2>
		<a href="register_cus.html" class="btn-default">Register: Customer</a>
		<a href="register_emp.html"class="btn-default">Register: Employee</a>
		<form>
			<table>
				<tr>
					<td><span class="formlabel">Username:</span></td>
					<td><input class="forminput" id="usrn" name="username" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">Password:</span></td>
					<td><input class="forminput" id="pw" name="password" type="password" /></td>
				</tr>
			</table>
			<input type="submit" value="Login" class = "btn-main">
		</form>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>