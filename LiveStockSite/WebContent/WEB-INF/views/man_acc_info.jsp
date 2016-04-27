<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Manager Account</title>
	<link rel="stylesheet" href="gen.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("account info!");	
	$("#manAccInfo").addClass('active');
});

// ]]>
</script>
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_man_menu.jsp"></jsp:include>
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
				<td><span class="accinfo">${user.fname}</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">Last Name</span></td>
				<td><span class="accinfo">${user.lname}</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">Address</span></td>
				<td><span class="accinfo">${user.address}</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">City</span></td>
				<td><span class="accinfo">${user.city}</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">State</span></td>
				<td><span class="accinfo">${user.state}</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">ZipCode</span></td>
				<td><span class="accinfo">${user.zip}</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">Telephone</span></td>
				<td><span class="accinfo">${user.phone}</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">Position</span></td>
				<td><span class="accinfo">${user.pos}</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">Start Date</span></td>
				<td><span class="accinfo">${user.start}</span></td>
				
			</tr>
			<tr>
				<td><span class="formlabel">Hourly Rate</span></td>
				<td><span class="accinfo">${user.hourly}</span></td>
				
			</tr>
			<!-- TODO: SSN?
				 TODO: button to edit -->
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