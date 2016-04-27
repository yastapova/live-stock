<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Stocks</title>
	<link rel="stylesheet" href="gen.css" />
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_cust_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<br />
		<table border="4" id="stock" onclick="return stock_onclick()">
			<caption style="font-size: 20pt">Current Stock Listings</caption>
	        <tr>
	          <th style="width: 10px"><span style="font-size: 10pt">Stock Symbol</span></th>
	          <th style="width: 200px"><span style="font-size: 10pt">Stock Name</span></th>
	          <th style="width: 200px"><span style="font-size: 10pt">Stock Type</span></th>
	          <th style="width: 100px"><span style="font-size: 10pt">Share Price</span></th>
	          <th style="width: 100px"><span style="font-size: 10pt">Number of Available Shares</span></th>
	        </tr>
			<c:forEach var="stock" items="${stocks}">
	   			<tr>
		            <td style="width: 10px"><span style="font-size: 10pt"><c:out value="${stock.stocksym}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${stock.stockname}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${stock.stocktype}" /></span></td>
		            <td style="width: 100px"><span style="font-size: 10pt"><c:out value="${stock.shareprice}" /></span></td>
		            <td style="width: 100px"><span style="font-size: 10pt"><c:out value="${stock.numshares}" /></span></td>
	        	</tr>
			</c:forEach>
  		</table> 
  		<br />
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>