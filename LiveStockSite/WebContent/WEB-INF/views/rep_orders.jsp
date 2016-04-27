<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Orders</title>
	<link rel="stylesheet" href="gen.css" />
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
				<th width="80px"><span style="font-size: 10pt">Stock</span></th>
				<th width="200px"><span style="font-size: 10pt"># of Shares</span></th>
				<th width="25px"><span style="font-size: 10pt">Price Type</span></th>
				<th width="50px"><span style="font-size: 10pt">Stop Price</span></th>
				<th width="200px"><span style="font-size: 10pt">Recorded</span></th>
				<th width="200px"><span style="font-size: 10pt">Completed</span></th>
            </tr>
			<c:forEach var="order" items="${list}">
				<tr>
					<td><span style="font-size: 10pt"><c:out value="${order.timestamp}" /></span></td>
					<td><span style="font-size: 10pt"><c:out value="${order.orderType}" /></span></td>
					<td><span style="font-size: 10pt"><c:out value="${order.stockSymbol}" /></span></td>
					<td><span style="font-size: 10pt"><c:out value="${order.numShares}" /></span></td>
					<td><span style="font-size: 10pt"><c:out value="${order.priceType}" /></span></td>
					<td><span style="font-size: 10pt">$<c:out value="${order.stopPrice}" /></span></td>
					<td><span style="font-size: 10pt"><c:out value="${order.recorded}" /></span></td>
					<td><span style="font-size: 10pt"><c:out value="${order.completed}" /></span></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>