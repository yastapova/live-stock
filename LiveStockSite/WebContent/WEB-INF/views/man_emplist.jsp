<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Employee List</title>
	<link rel="stylesheet" href="gen.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("employees!");	
	$("#employees").addClass('active');
});

// ]]>

	</script>
	
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_man_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<h2>Employees</h2>
		<table border="5" id="accounts">
			<tr>
	          <th style="width: 150px"><span style="font-size: 10pt">Employee Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">First</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Last</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Address</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">City</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">State</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Zip Code</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Telephone</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Start Date</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Hourly Rate</span></th>
	        </tr>
			<c:forEach var="emp" items="${employees}">
				<tr>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${emp.id}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.fname}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.lname}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${emp.address}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.city}" /></span></td>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${emp.state}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.zip}"/></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.phone}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.start}" /></span></td>
		            <td style="width: 100px"><span style="font-size: 10pt"><c:out value="${emp.hourly}" /></span></td>
	            </tr>
		    </c:forEach>
	    </table>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>