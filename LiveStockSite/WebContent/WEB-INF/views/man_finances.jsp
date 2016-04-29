<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Finances </title>
	<link rel="stylesheet" href="gen.css" />
	<link rel="stylesheet" href="manEmp.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("finances!");	
	$("#finances").addClass('active');

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

function deleteEmp_onclick() {
    console.log("deleteEmp!");
    javascript:deleteEmployeeForm.submit();
}

function editEmp_onclick() {
    console.log("editEmp!");
    javascript:editEmployeeForm.submit();
}

function sales_onclick() {
    console.log("sales!");
    javascript:salesReportForm.submit();
}

// ]]>

	</script>
	
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_man_menu.jsp"></jsp:include>
	<c:set var="me" scope="session" value="${id}"/>
	<div class="body" align="center">
	<h2>Transactions</h2>
	<table border="5" id="accounts">
			<tr>
	          <th style="width: 150px"><span style="font-size: 10pt">Transaction Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Order Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Fee</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Time</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Price Per Share</span></th>
	        </tr>
			<c:forEach var="trans" items="${transactions}">							
				<tr>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${trans.id}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${trans.orderId}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${trans.fee}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${trans.time}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${trans.pps}" /></span></td>	
		        </tr>	            
		    </c:forEach>
	    </table>
	</div>
	<div class="utilities container">  
      <!-- Utility -->
      <div class="utility current">
        <div class="item row">
          <div class="col-xs-3">
             <h3>Sales Report</h3>
          </div>
        </div>
        <div class="description row">
        <table>          
            <form id="salesReport" name="salesReportForm" action="salesReport" method="post">
            <tr>
            	<td>Month:</td>
            	<td>            		
            		<select name="month" class="inputA">						    
					    <option value="january" selected="selected">January</option>
					    <option value="february">February</option>
					    <option value="march">March</option>
					    <option value="april">April</option>
					    <option value="may">May</option>
					    <option value="june">June</option>
					    <option value="july">July</option>
					    <option value="august">August</option>
					    <option value="september">September</option>
					    <option value="october">October</option>
					    <option value="november">November</option>
					    <option value="december">December</option>
					</select>
            	</td> 
            </tr>
            <tr>
            	<td>Year:</td>
		  		<td><input type="text" name="year" class="inputA" placeholder="yyyy"></td>  
		  	</tr>          	
			</form>  
		</table>    
		<br>
		<button value="sales" class="btn-default" id="sales" onclick="return sales_onclick()">Confirm</button>     
        </div>
      </div>
      <!-- Utility -->
      <div class="utility">
        <div class="item row">
          <div class="col-xs-3">
            <h3>Edit</h3>
          </div>
        </div>
        <div class="description row">
         	<table>          
            <form id="editEmployee" name="editEmployeeForm" action="editEmpMan" method="post">
            	<tr>
            		<td>ID:</td>
					<td><select name="empIdEdit" class="inputA">
						    <c:forEach var="emp" items="${employees}">
						    <option value="${emp.id}"><c:out value="${emp.id}" /></option>
						    </c:forEach>
						</select>
            		</td>
            	</tr>
            	<tr>
            		<td>Field:</td>
					<td><select name="empEditField" class="inputA">						    
						    <option value="firstname" selected="selected">First Name</option>
						    <option value="lastname">Last Name</option>
						    <option value="address">Address</option>
						    <option value="city">City</option>
						    <option value="state">State</option>
						    <option value="zipcode">Zip Code</option>
						    <option value="telephone">Telephone</option>
						    <option value="startdate">Start Date</option>
						    <option value="hourly">Hourly Rate</option>
						    <option value="ssn">SSN</option>
						</select>
            		</td>
            	</tr>
	            <tr>   
		  			<td>New:</td>
		  			<td><input type="text" name="new" class="inputA"></td>
	  			</tr>		
			</form>  
		</table>    
		<br>
		<button value="editEmp" class="btn-default" id="editEmp" onclick="return editEmp_onclick()">Confirm</button>  
        </div>
      </div>
      <!-- Utility -->
      <div class="utility">
        <div class="item row">
          <div class="col-xs-3">
            <h3>Delete</h3>
          </div>
        </div>
        <div class="description row">
         	<form id="deleteEmployee" name="deleteEmployeeForm" action="deleteEmpMan" method="post">
         	Employee ID:
			<select name="empIdDelete" class="inputA">
			    <c:forEach var="emp" items="${employees}">
			    <c:if test="${emp.id ne me}">
			    <option value="${emp.id}"><c:out value="${emp.id}" /></option>
			    </c:if>
			    </c:forEach>
			</select>
			<br>
			<br>
			<button value="deleteEmp" class="btn-default" id="deleteEmp" onclick="return deleteEmp_onclick()">Confirm</button>
			</form>  
        </div>
      </div>
    </div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>