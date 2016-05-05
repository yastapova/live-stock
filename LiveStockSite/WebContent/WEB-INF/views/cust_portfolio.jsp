<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Portfolio</title>
	<link rel="stylesheet" href="gen.css" />
	<link rel="stylesheet" href="manEmp.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("portfolio!");	
	$("#customerPortfolio").addClass('active');

	$('.inputA').click(function(event) {
  	event.stopPropagation();
	});

	// Show the first utility as selected
  $('.current').children('.description').show();

  // Close the current tab on click 
  $('.utility').click(function() {
    $('.utility').removeClass('current');
    $('.description').hide();
  // Open the new current tab
    $(this).addClass('current');
    $(this).children('.description').show();
   });
});

function addAcc_onclick() {
    console.log("addCust!");
    javascript:addAccountForm.submit();
}

// ]]>
</script>

</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_cust_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<h2>Accounts</h2>
	        <c:forEach var="account" items="${accounts}">
	        	<table border="5" id="accounts">
	        	<jsp:include page="_accTableRow.jsp"></jsp:include>        	
	   			<tr>
	   				<td style="width: 200px"><span style="font-size: 10pt"><c:out value="${account.accId}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${account.accCreationDate}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${account.creditCardNum}" /></span></td>		           
			            <c:forEach var="portfolio" items="${portfolios}">			 
			            <c:if test="${portfolio.accNum eq account.accId}">
			            <table border="4" id="portfolios">
			           <tr>
			          <th style="width: 150px"><span style="font-size: 10pt">Stock Symbol</span></th>
			          <th style="width: 150px"><span style="font-size: 10pt">Number of Shares</span></th>
			          <th style="width: 150px"><span style="font-size: 10pt">Stop</span></th>
			          <th style="width: 150px"><span style="font-size: 10pt">Stop Price</span></th></tr>
			            <tr>
			            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${portfolio.stockSymbol}" /></span></td>
			            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${portfolio.numShares}" /></span></td>
			            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${portfolio.stop}" /></span></td>
			            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${portfolio.stopPrice}" /></span></td>
			            </tr>
			            </table>
			            </c:if>			           
						</c:forEach>											
	        	</tr>	        	
	        	</table>
	        	<br><br>
			</c:forEach>
		<div class="utilities container" align="left">  
      <!-- Utility -->
      <div class="utility current">
        <div class="item row">
          <div class="col-xs-3">
             <h3>Add Account </h3>
          </div>
        </div>
        <div class="description row">
        <table>          
            <form id="addAccount" name="addAccountForm" action="addAcc" method="post">
            	<tr>  
		            <td>Credit Card Number</td>   
		  			<td><input type="text" name="cardNum" class="inputA" placeholder="16 digits" required></td>
	  			</tr>  				
			</form>  
		</table>    
		<br>
		<button value="Acc" class="btn-default" id="addAcc" onclick="return addAcc_onclick()">Confirm</button>     
        </div>
      </div>
	</div>
	</div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>