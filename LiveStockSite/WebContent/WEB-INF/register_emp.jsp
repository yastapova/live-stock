<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>LiveStock Trading - Register</title>
	<link rel="stylesheet" href="gen.css" />
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	
	<div class="body" align="center">
		<h2>Register</h2>
		<form>
			<table>
				<tr>
					<td><span class="formlabel">Username:</span></td>
					<td><input id="usrn" name="username" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">Password:</span></td>
					<td><input id="pw" name="password" type="password" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">First Name:</span></td>
					<td><input id="fname" name="first_name" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">Last Name:</span></td>
					<td><input id="lname" name="last_name" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">SSN:</span></td>
					<td><input id="ssn" name="ssn" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">Address:</span></td>
					<td><input id="addr" name="address" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">City:</span></td>
					<td><input id="city" name="city" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">State:</span></td>
					<td><input id="state" name="state" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">ZipCode:</span></td>
					<td><input id="zip" name="zipcode" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">Telephone:</span></td>
					<td><input id="phone" name="phone" type="text" /></td>
				</tr>
				<tr>
					<td><span class="formlabel">Position:</span></td>
					<td><input id="pos_man" name="position" type="radio" value="manager"/><span class="formlabel">Manager</span><br />
					<input id="pos_rep" name="position" type="radio" value="cust_rep"/><span class="formlabel">Customer Rep</span></td>
				</tr>
			</table>
			<input type="submit" value="Register" class = "btn-main">
		</form>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>