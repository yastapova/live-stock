<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Order Stock</title>
	<link rel="stylesheet" href="gen.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("stocks!");	
	$("#stocks").addClass('active');
});

function back_onclick() {
    window.open("stocks","_self");

}

function submit_order_onclick() {
	if(document.myForm.orderType.value == ""){
	    alert("Order Type Can Not Be Null!");
	    return;
	}
	if(document.myForm.numshares.value == ""){
		alert("Number of Shares Can Not Be Null!");
		return;
	}
	if(document.myForm.cusAccount.value == ""){
		alert("Customer Account Can Not Be Null!");
		return;
	}
	if(document.myForm.priceType.value == ""){
		alert("Price Type Can Not Be Null!");
		return;
	}
	if(document.getElementById('Sell').checked){
		if(document.myForm.stopPrice.value == ""){
			if(!(document.myForm.priceType.value == "Market")){
				alert("Please enter a stop price.");
				return;
			}
		}
	}
	if(!(+document.myForm.numshares.value === parseInt(document.myForm.numshares.value, 10))){
		alert("Number of Shares Must Be Integer!");
		return;
	}
	if(parseInt(document.myForm.numshares.value, 10) > parseInt(document.myForm.availshares.value, 10)){
		alert("Number of shares ordered cannot exceed the number of available shares.");
		return;
	}
	javascript:myForm.submit();
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
		<h2>Stock Order Form</h2>
		<form id="orderForm" name="myForm" action="do_order_stock" method="post">
			<table>
				<tr>
					<td>Stock:</td>
					<td><input class="forminput" id="stocksym" name="stocksym" type="text" value="${stocksym}" placeholder="${stocksym}" disabled /></td>
				</tr>
				<tr>
					<td>Order Type:</td>
					<td><input type="radio" name="orderType" id="Buy" value="Buy" />Buy 
					<input type="radio" name="orderType" id="Sell" value="Sell" />Sell</td>
				</tr>
				<tr>
					<td>Number of Shares:</td>
					<td><input type="text" class="forminput" name="numshares" id="numshares" /></td>
				</tr>
				<tr>
					<td>Customer Account:</td>
					<td><select name="cusAccount" class="inputA">
						    <c:forEach var="cus" items="${customers}">
						    <option value="${cus.id}">Acc <c:out value="${cus.accnum}" />: <c:out value="${cus.fname}" /> <c:out value="${cus.lname}" /></option>
						    </c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>Price type:</td>
					<td><select name="priceType" class="inputA">
						<option value="Market">Market</option>
						<option value="Trailing Stop">Trailing Stop</option>
						<option value="Hidden Stop">Hidden Stop</option>
					</select></td>
				</tr>
				<tr>
					<td>Stop Price:</td>
					<td><input type="text" class="forminput" name="stopPrice" id="stopPrice" placeholder="Blank if none"></td>
				</tr>
			</table>
			<c:if test="${empid != null}">
				<input type="hidden" name="empId" id="empId" value="${empid}" />
			</c:if>
			<input type="hidden" name="availshares" id="availshares" value="${numavailshares}" />
		</form>
		<br />
		<button value="submitOrder" class="btn-default" id="submitOrderButton" onclick="return submit_order_onclick()">Submit Order</button>
		<button value="back" class="btn-default" id="back" onclick="return back_onclick()">Back</button> 
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>