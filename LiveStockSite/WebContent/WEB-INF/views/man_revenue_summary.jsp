<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Revenue Summary</title>
	<link rel="stylesheet" href="gen.css" />
	<link rel="stylesheet" href="manEmp.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("finances!");	
	$("#finances").addClass('active');

	$('.inputA').click(function(event) {
  	event.stopPropagation();
	});

	// Show the first utility as selected
  $('.current').children('.description').show();

  // Close the current tab on click 
  $('.utility').click(function() {
    $('.utility').removeClass('current');
    $('.description').hide();
  // Open the new current tab
    $(this).addClass('current');
    $(this).children('.description').show();
   });

});

function back_onclick() {
    window.open("finances","_self");

}

// ]]>

	</script>
	
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_man_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<h2><c:out value="${table}"/></h2>
		<c:if test="${types != null}" >
			<table border="5" id="accounts">
				<tr>
		          <th style="width: 150px"><span style="font-size: 10pt">Stock Type</span></th>
		          <th style="width: 150px"><span style="font-size: 10pt">Total Revenue</span></th>
		        </tr>
				<c:forEach var="type" items="${types}">							
					<tr>
						<c:forEach var="t" items="${type}" >
			            <td><span style="font-size: 10pt"><c:out value="${t}" /></span></td>
			            </c:forEach>
			        </tr>            
			    </c:forEach>
			</table>
		</c:if>
		<c:if test="${stocks != null}" >
			<table border="5" id="accounts">
				<tr>
		          <th style="width: 150px"><span style="font-size: 10pt">Stock Symbol</span></th>
		          <th style="width: 150px"><span style="font-size: 10pt">Stock Name</span></th>
		          <th style="width: 150px"><span style="font-size: 10pt">Total Revenue</span></th>
		        </tr>
				<c:forEach var="stock" items="${stocks}">							
					<tr>
						<c:forEach var="s" items="${stock}" >
			            <td><span style="font-size: 10pt"><c:out value="${s}" /></span></td>
			            </c:forEach>
			        </tr>            
			    </c:forEach>
			</table>
		</c:if>
		<c:if test="${customers != null}" >
			<table border="5" id="accounts">
				<tr>
		          <th style="width: 50px"><span style="font-size: 10pt">ID</span></th>
		          <th style="width: 50px"><span style="font-size: 10pt">Account Number</span></th>
		          <th style="width: 150px"><span style="font-size: 10pt">First Name</span></th>
		          <th style="width: 150px"><span style="font-size: 10pt">Last Name</span></th>
		          <th style="width: 150px"><span style="font-size: 10pt">Total Revenue</span></th>
		        </tr>
				<c:forEach var="c" items="${customers}">							
					<tr>
			            <td><span style="font-size: 10pt"><c:out value="${c.id}" /></span></td>
			            <td><span style="font-size: 10pt"><c:out value="${c.acc}" /></span></td>
			            <td><span style="font-size: 10pt"><c:out value="${c.fname}" /></span></td>
			            <td><span style="font-size: 10pt"><c:out value="${c.lname}" /></span></td>
			            <td><span style="font-size: 10pt"><c:out value="${c.revenue}" /></span></td>
			        </tr>            
			    </c:forEach>
			</table>
		</c:if>
	    <br>
	    <button value="back" class="btn-default" id="back" onclick="return back_onclick()">Back</button>  
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>