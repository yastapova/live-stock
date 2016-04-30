<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Orders </title>
	<link rel="stylesheet" href="gen.css" />
	<link rel="stylesheet" href="manEmp.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("orders!");	
	$("#managerOrders").addClass('active');

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
    window.open("manOrders", "_self");
}

// ]]>

	</script>
	
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_man_menu.jsp"></jsp:include>
	<div class="body" align="center">
	<h2>Orders</h2>
	<table border="5" id="accounts">
			<tr>
	          <th style="width: 150px"><span style="font-size: 10pt">Order Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Customer Account #</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Employee Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Stock Symbol</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Order Type</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Num Shares</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Price Type</span></th>       
	          <th style="width: 150px"><span style="font-size: 10pt">Share Price</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Time</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Recorded</span></th>	          
	        </tr>	
	          <c:forEach var="order" items="${orders}">	
	          <c:forEach var="accNum" items="${accNums}">
	          <c:if test="${order.cusAccNum eq accNum}">					
				<tr>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${order.id}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${order.cusAccNum}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${order.empId}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${order.stockSymbol}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${order.orderType}" /></span></td>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${order.numShares}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${order.priceType}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${order.curSharePrice}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${order.timestamp}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${order.recorded}" /></span></td>	
		        </tr>	  
		       </c:if>    
		       </c:forEach>      
		    </c:forEach>
	    </table>
	<br>
	<button value="back" class="btn-default" id="back" onclick="return back_onclick()">Back</button>
    </div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>