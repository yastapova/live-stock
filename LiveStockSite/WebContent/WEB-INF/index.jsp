<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading</title>
	<link rel="stylesheet" href="gen.css" />
</head>
<body>
	<jsp:include page="WEB-INF/views/_header.jsp"></jsp:include>
	
	<div class="body" align="center">
		<h1>Login</h1>
		<a href="register_cus.jsp" class="btn-default">Register: Customer</a>
		<a href="register_emp.jsp" class="btn-default">Register: Employee</a>
		<div class="clear-fix"></div>
		<div class = "form-class">
		<form>
			<table name="loginForm" action="login" method="get">
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
	</div>
	
	<jsp:include page="WEB-INF/views/_footer.jsp"></jsp:include>
</body>
</html>