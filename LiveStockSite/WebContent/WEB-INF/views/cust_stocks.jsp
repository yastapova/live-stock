<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Stocks</title>
	<link rel="stylesheet" href="gen.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("stocks!");	
	$("#stocks").addClass('active');
});

function stock_onclick(){
	console.log("stock!");
	window.open("stocks", "_self");
}

// ]]>

/*if(true) {
	document.getElementById('include').innerHTML = "CATS";
}*/

</script>

</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<div id="include"></div>
	<c:if test="${userType=='C'}">
		<jsp:include page="_cust_menu.jsp"></jsp:include>
	</c:if>
	<c:if test="${userType=='R'}">
		<jsp:include page="_rep_menu.jsp"></jsp:include>
	</c:if>
	<c:if test="${userType=='M'}">
		<jsp:include page="_man_menu.jsp"></jsp:include>
	</c:if>
	<div class="body" align="center">
		<h2>Current Stock Listings</h2>
		<table border="4" id="stock" onclick="return stock_onclick()">
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
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>