<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>LiveStock Trading - Register Employee</title>
	<link rel="stylesheet" href="gen.css" />
		   <script type="text/javascript">
// <!CDATA[

function register_onclick() {
	console.log("register");
	if(document.myForm.username.value == ""){
	    alert("Username Can Not Be Null!");
	    return;
	}
	if(document.myForm.password.value == ""){
		alert("Password Can Not Be Null!");
		return;
	}
	if(document.myForm.first_name.value == ""){
		alert("First name Can Not Be Null!");
		return;
	}
	if(document.myForm.last_name.value == ""){
		alert("Last name Can Not Be Null!");
		return;
	}
	if(document.myForm.ssn.value == ""){
		alert("SSN Can Not Be Null!");
		return;
	}
	if(document.myForm.address.value == ""){
		alert("Address Can Not Be Null!");
		return;
	}
	if(document.myForm.city.value == ""){
		alert("City Can Not Be Null!");
		return;
	}
	if(document.myForm.state.value == ""){
		alert("State Can Not Be Null!");
		return;
	}
	if(document.myForm.zipcode.value == ""){
		alert("ZipCode Can Not Be Null!");
		return;
	}
	if(document.myForm.phone.value == ""){
		alert("Phone Can Not Be Null!");
		return;
	}
	console.log("register end");
	javascript:myForm.submit();
}

function cancel_onclick() {
	console.log("cancel!");
	window.open("home", "_self");
}

// ]]>
</script>
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	
	<div class="body" align="center">
		<h2>Employee - Register</h2>
		<form id="myForm" name="myForm" action="doRegisterEmployee" method="post">
			<table>
				<tr>
					<td><span class="formlabel">Username:</span></td>
					<td><input class="forminput" id="usrn" name="username" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">Password:</span></td>
					<td><input class="forminput" id="pw" name="password" type="password" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">First Name:</span></td>
					<td><input class="forminput" id="fname" name="first_name" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">Last Name:</span></td>
					<td><input class="forminput" id="lname" name="last_name" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">SSN:</span></td>
					<td><input class="forminput" id="ssn" name="ssn" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">Address:</span></td>
					<td><input class="forminput" id="addr" name="address" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">City:</span></td>
					<td><input class="forminput" id="city" name="city" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">State:</span></td>
					<td><input class="forminput" id="state" name="state" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">ZipCode:</span></td>
					<td><input class="forminput" id="zip" name="zipcode" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">Telephone:</span></td>
					<td><input class="forminput" id="phone" name="phone" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">Position:</span></td>
					<td><input id="pos_man" name="position" type="radio" value="manager" group="position"/><span class="formlabel">Manager</span><br />
					<input id="pos_rep" name="position" type="radio" value="cust_rep" checked="checked" group="position" /><span class="formlabel">Customer Rep</span></td>
				</tr>
			</table>
		</form>
		<button value="Register" class="btn-main" id="register" onclick="return register_onclick()">Register</button>
		<button class="btn-main" onclick="return cancel_onclick()">Cancel</button>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>