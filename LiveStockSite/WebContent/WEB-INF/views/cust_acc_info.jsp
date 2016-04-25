<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Customer Account</title>
	<link rel="stylesheet" href="gen.css" />
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_cust_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<h2>Account Information</h2>
		<form>
		<table>
			<tr>
			<!-- NEED A SEPARATE PAGE FOR UPDATING -->
				<td><span class="formlabel">Username</span></td>
				<td><span class="accinfo">${user.username}</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">First Name</span></td>
				<td><span class="accinfo">Danaerys</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">Last Name</span></td>
				<td><span class="accinfo">Targararara</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">Address</span></td>
				<td><span class="accinfo">123 Fara Way</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">City</span></td>
				<td><span class="accinfo">Something</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">State</span></td>
				<td><span class="accinfo">WE</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">ZipCode</span></td>
				<td><span class="accinfo">11111</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">Telephone</span></td>
				<td><span class="accinfo">(123)123-1234</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">Email</span></td>
				<td><span class="accinfo">mother_of_dragons@queen.gov</span></td>
				
			</tr>
			<!--
			<tr>
				<td><span class="formlabel">Old Password</span><br />
				<input class="forminput" id="pw" name="password" type="password" /></td>
				<td><span class="formlabel">New Password</span><br />
				<input class="forminput" id="pw1" name="password1" type="password" /></td>
				<td><span class="formlabel">Verify New Password</span><br />
				<input class="forminput" id="pw2" name="password2" type="password" /></td>
			</tr>
			-->
		</table>
		<!--<input type="submit" value="Update" class = "btn-main" /><input type="reset" value="Clear" class = "btn-main" />-->
		</form>
		<br>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>