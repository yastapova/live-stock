<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Year</title>
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
	<h2>Employee of the Year</h2>
	<table border="5" id="Eaccounts">
			<tr>
	          <th style="width: 150px"><span style="font-size: 10pt">Employee Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Total Revenue</span></th>	          
	        </tr>
			<c:forEach var="emp" items="${employees}">								
				<tr>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${emp.id}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.revenue}" /></span></td>		            
		        </tr>			                 
		    </c:forEach>
	    </table>
	<h2>Customer of the Year</h2>
	<table border="5" id="Caccounts">
			<tr>
	          <th style="width: 150px"><span style="font-size: 10pt">Customer Account #</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Total Revenue</span></th>	          
	        </tr>
			<c:forEach var="cust" items="${customers}">								
				<tr>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${cust.id}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${cust.revenue}" /></span></td>		            
		        </tr>			                 
		    </c:forEach>
	    </table>
	    <br>
	    <button value="back" class="btn-default" id="back" onclick="return back_onclick()">Back</button>  
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>