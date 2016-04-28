<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Orders</title>
	<link rel="stylesheet" href="gen.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("orders!");	
	$("#customerOrders").addClass('active');
});

// ]]>

	</script>
	
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_cust_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<h2>Orders</h2>
		<table border="4">
        	<tr>
				<th width="100px"><span style="font-size: 10pt">Time</span></th>
        		<th width="80px"><span style="font-size: 10pt">Order Type</span></th>
        		<th width="80px"><span style="font-size: 10pt">Account</span></th>
				<th width="80px"><span style="font-size: 10pt">Stock</span></th>
				<th width="100px"><span style="font-size: 10pt">NumShares</span></th>
				<th width="80px"><span style="font-size: 10pt">Price Type</span></th>
				<th width="80px"><span style="font-size: 10pt">Stop Price</span></th>
				<th width="80px"><span style="font-size: 10pt">Recorded</span></th>
				<th width="80px"><span style="font-size: 10pt">Completed</span></th>
            </tr>
			<c:forEach var="order" items="${orders}">
				<tr>
					<td><span style="font-size: 10pt"><c:out value="${order.timestamp}" /></span></td>
					<td><span style="font-size: 10pt"><c:out value="${order.orderType}" /></span></td>
					<td><span style="font-size: 10pt"><c:out value="${order.cusAccNum}" /></span></td>
					<td><span style="font-size: 10pt"><c:out value="${order.stockSymbol}" /></span></td>
					<td><span style="font-size: 10pt"><c:out value="${order.numShares}" /></span></td>
					<td><span style="font-size: 10pt"><c:out value="${order.priceType}" /></span></td>
					<td><span style="font-size: 10pt">$<c:out value="${order.stopPrice}" /></span></td>
					<td><span style="font-size: 10pt"><c:if test="${order.recorded==true}">Yes</c:if>
													  <c:if test="${order.recorded==false}">No</c:if></span></td>
					<td><span style="font-size: 10pt"><c:if test="${order.completed==true}">Yes</c:if>
													  <c:if test="${order.completed==false}">No</c:if></span></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>