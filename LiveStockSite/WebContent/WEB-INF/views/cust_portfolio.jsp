<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Portfolio</title>
	<link rel="stylesheet" href="gen.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("portfolio!");	
	$("#customerPortfolio").addClass('active');
});

// ]]>
</script>

</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_cust_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<h2>Accounts</h2>
		<table border="5" id="accounts">		
	        <c:forEach var="account" items="${accounts}">
	        	<jsp:include page="_accTableRow.jsp"></jsp:include>        	
	   			<tr>
	   				<td style="width: 200px"><span style="font-size: 10pt"><c:out value="${account.accId}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${account.accCreationDate}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${account.creditCardNum}" /></span></td>
		            <table border="4" id="portfolios">
			           <tr>
			          <th style="width: 150px"><span style="font-size: 10pt">Stock Symbol</span></th>
			          <th style="width: 150px"><span style="font-size: 10pt">Number of Shares</span></th>
			          <th style="width: 150px"><span style="font-size: 10pt">Stop</span></th>
			          <th style="width: 150px"><span style="font-size: 10pt">Stop Price</span></th></tr>
			            <c:forEach var="portfolio" items="${portfolios}">
			            <c:if test="${portfolio.accNum eq account.accId}">
			            <tr>
			            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${portfolio.stockSymbol}" /></span></td>
			            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${portfolio.numShares}" /></span></td>
			            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${portfolio.stop}" /></span></td>
			            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${portfolio.stopPrice}" /></span></td>
			            </tr>
			            </c:if>			           
						</c:forEach>
						</table>
	        	</tr>
	        	<tr><br>___________________________________________<br><br></tr>
			</c:forEach>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>