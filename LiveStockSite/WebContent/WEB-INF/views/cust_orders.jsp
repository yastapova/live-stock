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

function history_onclick() {
	console.log("Get History");
	javascript:orderRecords.submit();
}

function default_onclick() {
	console.log("Orders");
    window.open("orders","_self");
}
// ]]>

	</script>
	
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_cust_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<c:if test="${isHistory==true}">
			<h2>Conditional Price History</h2>
			<table border="4">
	        	<tr>
					<th width="80px"><span style="font-size: 10pt">Current Share Price</span></th>
					<th width="80px"><span style="font-size: 10pt">Stop Price</span></th>
					<th width="80px"><span style="font-size: 10pt">Timestamp</span></th>
	            </tr>
				<c:forEach var="order" items="${orders}">
					<tr>
						<td><span style="font-size: 10pt">$<c:out value="${order.curSharePrice}" /></span></td>
						<td><span style="font-size: 10pt">$<c:out value="${order.stopPrice}" /></span></td>
						<td><span style="font-size: 10pt"><c:out value="${order.timestamp}" /></span></td>
					</tr>
				</c:forEach>
			</table>
			<button value="Orders" class="btn-default" id="orders" onclick="return default_onclick()">Go Back</button>
		</c:if>
		<c:if test="${isHistory==false}">
			<h2>Orders</h2>
			<form name="orderRecords" id="orderRecords" action="orders" method="post">
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
					<th width="80px"><span style="font-size: 10pt">Get Conditional Price History?</span></th>
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
						<td align="center">
							<c:if test="${order.priceType=='Trailing Stop' || order.priceType=='Hidden Stop'}">
								<input type="radio" name="order_id" value="<c:out value="${order.id}" />" />
							</c:if>
						</td>	
					</tr>
				</c:forEach>
			</table>
			<button value="History" class="btn-default" id="history" onclick="return history_onclick()">Get History</button>
			</form>
		</c:if>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>