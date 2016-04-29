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

function suggested_cusid_onclick() {
	console.log("Suggested");
	javascript:suggestForm.submit();
}

function best_sellers_onclick() {
	console.log("Best");
    window.open("best_stocks","_self");
}

function search_type_onclick() {
	console.log("Search Type");
	javascript:typeForm.submit();
}

function search_keywrod_onclick() {
	console.log("Search Keyword");
	javascript:keywordForm.submit();
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
		<table border="4" id="stock" onclick="return stock_onclick()">
	        <tr>
	          <th style="width: 10px"><span style="font-size: 10pt">Stock Symbol</span></th>
	          <th style="width: 200px"><span style="font-size: 10pt">Stock Name</span></th>
	          <th style="width: 200px"><span style="font-size: 10pt">Stock Type</span></th>
	          <th style="width: 100px"><span style="font-size: 10pt">Share Price</span></th>
	          <th style="width: 100px"><span style="font-size: 10pt">Number of Available Shares</span></th>
	          <c:if test="${userType=='M'}">
	          	<th style="width: 100px"><span style="font-size: 10pt">Set Price</span></th>
	          </c:if>
	        </tr>
			<c:forEach var="stock" items="${stocks}">
	   			<tr>
		            <td style="width: 10px"><span style="font-size: 10pt"><c:out value="${stock.stocksym}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${stock.stockname}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${stock.stocktype}" /></span></td>
		            <td style="width: 100px"><span style="font-size: 10pt"><c:out value="${stock.shareprice}" /></span></td>
		            <td style="width: 100px"><span style="font-size: 10pt"><c:out value="${stock.numshares}" /></span></td>
		            <c:if test="${userType=='M'}">
	          			<td style="width: 100px"><span style="font-size: 10pt">
							<form id="priceForm" name="myForm" action="price_stocks" method="post">
								<input class="forminput" id="price" name="stockprice" type="text" />
								<button value="updatedprice" class="btn-default" id="sstockprice" onclick="return set_price_onclick()">Set Price</button>
							</form>
						</span></td>
	          		</c:if>
	        	</tr>
			</c:forEach>
  		</table>
  		<br>
  		<button class="btn-default" onclick="return stock_onclick()">Current Stock Listings</button>
  		<button class="btn-default" onclick="return best_sellers_onclick('Best Sellers')">Best Sellers</button>
  		<c:if test="${userType=='C'}">
			<button class="btn-default" onclick="return suggested_onclick()">Suggested For You</button>
		</c:if>
		<br><br>
		<form id="typeForm" name="myForm" action="search_stocks" method="post">
			<span class="formlabel">Search on type:</span>
			<input class="forminput" id="stocktype" name="stocktype" type="text" />
			<button value="searchtype" class="btn-default" id="searchtype" onclick="return search_type_onclick()">Search Type</button>
		</form>
		<br>
		<form id="keywordForm" name="myForm" action="search_stocks" method="post">
			<span class="formlabel">Search on keyword:</span>
			<input class="forminput" id="keyword" name="stockkeyword" type="text" />
			<button value="searchkeyword" class="btn-default" id="searchkeyword" onclick="return search_keyword_onclick()">Search Keyword</button>
		</form>
		<c:if test="${userType=='R'}">
			<br>
			<form id="suggestForm" name="myForm" action="suggested_stocks" method="post">
			<span class="formlabel">Get Suggested Stocks for a CustomerID:</span>
			<input class="forminput" id="suggest" name="stocksuggest" type="text" />
			<button value="suggest" class="btn-default" id="suggest" onclick="return suggested_cusid_onclick()">Get Stocks</button>
		</form>
		</c:if>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>