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
		<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
	    	<tr>
            	<td style="vertical-align: top; width: 10000px; text-align: center; height: 500px;">
                    <span style="font-size: 10pt">Current Stock Listings</span></td>
				<table border="4" id="STOCK" onclick="return STOCK_onclick()">
                    <tr>
                      <th style="width: 10px"><span style="font-size: 10pt">Stock Symbol</span></th>
                      <th style="width: 100px"><span style="font-size: 10pt">Stock Name</span></th>
                      <th style="width: 100px"><span style="font-size: 10pt">Stock Type</span></th>
                      <th style="width: 50px"><span style="font-size: 10pt">Share Price</span></th>
                      <th style="width: 50px"><span style="font-size: 10pt">Number of Available Shares</span></th>
                    </tr>
	 				<c:forEach items="${list}" var="stock">
	        			<tr>
	                      <td style="width: 10px"><span style="font-size: 10pt"><c:out value="${stock.stocksym}" /></span></td>
	                      <td style="width: 100px"><span style="font-size: 10pt"><c:out value="${stock.stockname}" /></span></td>
	                      <td style="width: 100px"><span style="font-size: 10pt"><c:out value="${stock.stocktype}" /></span></td>
	                      <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${stock.shareprice}" /></span></td>
	                      <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${stock.numshares}" /></span></td>
	                    </tr>
	    			</c:forEach>
	    		</table> 
	    	</tr>
	    </table>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>