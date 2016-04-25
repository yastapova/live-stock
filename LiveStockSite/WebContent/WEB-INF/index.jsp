<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
    <meta charset="UTF-8">
    <title>LiveStockTrading Login</title>
    <link rel="stylesheet" href="gen.css" />
    <script type="text/javascript">
// <!CDATA[

function login_onclick() {
	console.log("login");
	if(document.myForm.username.value == ""){
	    alert("Username Can Not Be Null!");
	    return;
	}
	if(document.myForm.password.value == ""){
		alert("Password Can Not Be Null!");
		return;
	}
	console.log("login end");
	javascript:myForm.submit();
}

function register_customer_onclick() {
    window.open("register_customer","_self");

}

function register_employee_onclick() {
    window.open("register_employee","_self");

}

// ]]>
</script>
 </head>

<body>
	<jsp:include page="_index_header.jsp"></jsp:include>
	
	<div class="body" align="center">
		<h1>Login</h1>
		<button class="btn-default" onclick="return register_customer_onclick()">Register: Customer</button>
		<button class="btn-default" onclick="return register_employee_onclick()">Register: Employee</button>
		<div class="clear-fix"></div>
		<div class = "form-class">
		<form id="myForm" name="myForm" action="doLogin" method="post">
			<table>
				<tr>
					<td><span class="formlabel">Username:</span></td>
					<td><input class="forminput" id="usrn" name="username" type="text" value="${user.username}"/></td>
				</tr>
				<tr>
					<td><span class="formlabel">Password:</span></td>
					<td><input class="forminput" id="pw" name="password" type="password" value="${user.password}"/></td>
				</tr>
			</table>
			<button value="Login" class="btn-main" id="login" onclick="return login_onclick()">Login</button>
			<button class="btn-main" onclick="return cancel_onclick()">Cancel</button>
		</form>
		</div>
	</div>
	
	<jsp:include page="WEB-INF/views/_footer.jsp"></jsp:include>
	<!-- SOMETIMES THIS IS NEEDED <jsp:include page="WEB-INF/views/_footer.jsp"></jsp:include>-->
</body>
</html>