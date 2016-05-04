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
	window.open("current_stocks", "_self");
}

function suggested_onclick() {
	console.log("Suggested");
	window.open("suggested_stocks","_self");
}

function mostTraded_onclick() {
	console.log("Most Actively Traded");
	javascript:activeForm.submit();
}

function best_sellers_onclick() {
	console.log("Best");
    window.open("best_stocks","_self");
}

function search_type_onclick() {
	console.log("Search Type");
	javascript:typeForm.submit();
}

function search_keyword_onclick() {
	console.log("Search Keyword");
	javascript:keywordForm.submit();
}

function set_price_onclick() {
	console.log("Set Price");
	javascript:priceForm.submit();
}

function isStockSelected() {
    return ($('input[type=radio]:checked').size() > 0);
}

function order_stock_onclick() {
	console.log("Order Stock");
	if(!isStockSelected()) {
		alert("Please select a stock.");
		return;
	}
	javascript:orderForm.submit();
}

function get_history_onclick() {
	console.log("Get History");
	javascript:historyform.submit();
}

// ]]>


</script>

</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
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
		<h2><c:out value="${table}"/></h2>
		<c:if test="${userType=='C' or userType=='R'}">
			<form id="orderForm" name="myForm" action="order_stock" method="post">
				<table border="4" id="stock" >
		        <tr>
		          <th style="width: 10px"><span style="font-size: 10pt">Stock Symbol</span></th>
		          <th style="width: 200px"><span style="font-size: 10pt">Stock Name</span></th>
		          <th style="width: 200px"><span style="font-size: 10pt">Stock Type</span></th>
		          <th style="width: 100px"><span style="font-size: 10pt">Share Price</span></th>
		          <th style="width: 100px"><span style="font-size: 10pt">Number of Available Shares</span></th>
		          <th style="width: 50px"><span style="font-size: 10pt">Place Order</span></th>
		        </tr>
				<c:forEach var="stock" items="${stocks}">
		   			<tr>
			            <td><span style="font-size: 10pt"><c:out value="${stock.stocksym}" /></span></td>
			            <td><span style="font-size: 10pt"><c:out value="${stock.stockname}" /></span></td>
			            <td><span style="font-size: 10pt"><c:out value="${stock.stocktype}" /></span></td>
			            <td><span style="font-size: 10pt"><c:out value="${stock.shareprice}" /></span></td>
			            <td><span style="font-size: 10pt"><c:out value="${stock.numshares}" /></span></td>
			            <td align="center"><span style="font-size: 10pt"><input type="radio" name="stockOrder" value="${stock.stocksym}" /></span></td>
		        	</tr>
				</c:forEach>
	  		</table>
	  		</form>
	  		<br>
	  		<button class="btn-default" onclick="return order_stock_onclick()">Order Stock</button>
		</c:if>
		
		<c:if test="${userType=='M'}">
			<form id="priceForm" name="myForm" action="price_stocks" method="post">
				<table border="4" id="stock" >
		        <tr>
		          <th style="width: 10px"><span style="font-size: 10pt">Stock Symbol</span></th>
		          <th style="width: 200px"><span style="font-size: 10pt">Stock Name</span></th>
		          <th style="width: 200px"><span style="font-size: 10pt">Stock Type</span></th>
		          <th style="width: 100px"><span style="font-size: 10pt">Share Price</span></th>
		          <th style="width: 100px"><span style="font-size: 10pt">Number of Available Shares</span></th>
		          <th style="width: 50px"><span style="font-size: 10pt">Number of Orders</span></th>
		          <th style="width: 25px"><span style="font-size: 10pt">Set Price</span></th>
		        </tr>
				<c:forEach var="stock" items="${stocks}">
		   			<tr>
			            <td style="width: 10px"><span style="font-size: 10pt"><c:out value="${stock.stocksym}" /></span></td>
			            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${stock.stockname}" /></span></td>
			            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${stock.stocktype}" /></span></td>
			            <td style="width: 100px"><span style="font-size: 10pt"><c:out value="${stock.shareprice}" /></span></td>
			            <td style="width: 100px"><span style="font-size: 10pt"><c:out value="${stock.numshares}" /></span></td>
		            	<td style="width: 25px"><span style="font-size: 10pt"><c:out value="${stock.numOrders}" /></span></td>
	          			<td style="width: 25px"><span style="font-size: 10pt">
								<input class="forminput" id="new_price" name="stockprice" type="text" value="" />
								<input type ="hidden" class="forminput" id="old_price" name="stockprice" value="<c:out value="${stock.shareprice}" />" />
								<input type ="hidden" class="forminput" id="symbol" name="stockprice" value="<c:out value="${stock.stocksym}" />" />
						</span></td>
		        	</tr>
				</c:forEach>
	  		</table>
	  		</form>
	  		<br>
	  		<button class="btn-default" onclick="return set_price_onclick()">Set Price</button>
		</c:if>
		
  		<button class="btn-default" onclick="return stock_onclick()">Current Stock Listings</button>
  		<button class="btn-default" onclick="return best_sellers_onclick('Best Sellers')">Best Sellers</button>
  		<c:if test="${userType=='C'}">
			<button class="btn-default" onclick="return suggested_onclick()">Suggested For You</button>
		</c:if>
		<br><br>
		<c:if test="${userType=='M'}">
		<form id="activeForm" name="myForm" action="most_actively_traded" method="post">
			<span class="formlabel">Number to show:</span>
			<input class="formsmall" id="numstocks" name="numstocks" type="text" />
  			<button class="btn-default" onclick="return mostTraded_onclick()">Most Actively Traded</button>
  		</form>
  		</c:if>
  		<br />
		<form id="typeForm" name="myForm" action="search_stocks" method="post">
			<span class="formlabel">Search on type:</span>
			<input class="forminput" id="stocktype" name="stocktype" type="text" />
			<button value="searchtype" class="btn-default" id="searchtype" onclick="return search_type_onclick()">Search Type</button>
		</form>
		<br>
		<form id="keywordForm" name="myForm" action="search_stocks" method="post">
			<span class="formlabel">Search on keyword. Separate multiple terms with a comma:</span>
			<input class="forminput" id="keyword" name="stockkeyword" type="text" />
			<button value="searchkeyword" class="btn-default" id="searchkeyword" onclick="return search_keyword_onclick()">Search Keyword</button>
		</form>
		<br>
		<c:if test="${userType=='C'}">
			<table align="center">
				<form id="historyForm" name="myForm" action="history_stocks" method="post">
					<tr>
						<span class="formlabel">Get Price History for a Stock over a Range of Dates:</span>
					</tr>
					<tr>
						<td>Stock Symbol:</td>
						<td><input class="forminput" id="history" name="stocksymbol" type="text"/></td>
					</tr>
					<tr>
						<td>Start Date:</td>
						<td><input class="forminput" id="history" name="startdate" type="text" placeholder="yyyy-mm-dd"/></td>
					</tr>
					<tr>
						<td>End Date:</td>
						<td><input class="forminput" id="history" name="enddate" type="text" placeholder="yyyy-mm-dd"/></td>
					</tr>
						<td><button align="center" value="gethistory" class="btn-default" id="gethistory" onclick="return get_history_onclick()">Get History</button><td>
					</tr>
				</form>
			</table>
		</c:if>

	</div>
	
	
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>