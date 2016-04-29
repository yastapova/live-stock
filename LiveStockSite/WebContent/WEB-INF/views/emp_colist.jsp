<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Colleague List</title>
	<link rel="stylesheet" href="gen.css" />
	<link rel="stylesheet" href="manEmp.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("colleagues!");	
	$("#colleagues").addClass('active');

});

// ]]>

	</script>
	
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_rep_menu.jsp"></jsp:include>
	<c:set var="me" scope="session" value="${id}"/>
	<div class="body" align="center">
		<h2>Colleagues</h2>
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
	        </tr>
	        <c:set var="me" scope="session" value="${id}"/>
			<c:forEach var="emp" items="${employees}">			
				 <c:if test="${emp.id ne me}">
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
	            </tr>
	            </c:if>
		    </c:forEach>
	    </table>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>