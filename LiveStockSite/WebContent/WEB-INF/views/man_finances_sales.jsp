<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Finances</title>
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
	<c:set var="month" scope="session" value="${month}"/>
	<c:set var="year" scope="session" value="${year}"/>
	<div class="body" align="center">
	<h2>Sales Report <c:out value="${month}"/>/<c:out value="${year}"/></h2>
	<table border="5" id="accounts">
			<tr>
	          <th style="width: 150px"><span style="font-size: 10pt">Transaction Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Order Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Fee</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Time</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Price Per Share</span></th>
	        </tr>
			<c:forEach var="trans" items="${transactions}">				
				<c:if test="${trans.year eq year and trans.month eq month}">							
				<tr>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${trans.id}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${trans.orderId}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${trans.fee}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${trans.time}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${trans.pps}" /></span></td>	
		        </tr>	
		        </c:if>            
		    </c:forEach>
	    </table>
	    <br>
	    <button value="back" class="btn-default" id="back" onclick="return back_onclick()">Back</button>  
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>