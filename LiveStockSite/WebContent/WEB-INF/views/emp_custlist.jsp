<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Customer List</title>
	<link rel="stylesheet" href="gen.css" />
	<link rel="stylesheet" href="manEmp.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("customers!");	
	$("#customers").addClass('active');

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

function deleteCust_onclick() {
    console.log("deleteCust!");
    javascript:deleteCustomerForm.submit();
}

function editCust_onclick() {
    console.log("editCust!");
    javascript:editCustomerForm.submit();
}

function addCust_onclick() {
    console.log("addCust!");
    javascript:addCustomerForm.submit();
}

// ]]>

	</script>
	
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_rep_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<h2>Customers</h2>
		<table border="5" id="accounts">
			<tr>
	          <th style="width: 150px"><span style="font-size: 10pt">Customer Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">First</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Last</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Address</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">City</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">State</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Zip Code</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Telephone</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Email</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Rating</span></th>
	        </tr>
			<c:forEach var="cust" items="${customers}">
				<tr>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${cust.id}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${cust.fname}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${cust.lname}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${cust.address}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${cust.city}" /></span></td>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${cust.state}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${cust.zip}"/></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${cust.phone}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${cust.email}" /></span></td>
		            <td style="width: 100px"><span style="font-size: 10pt"><c:out value="${cust.rating}" /></span></td>
	            </tr>
		    </c:forEach>
	    </table>
	    <br />
	</div>

	<div class="utilities container" align="left">  
      <!-- Utility -->
      <div class="utility current">
        <div class="item row">
          <div class="col-xs-3">
             <h3>Add</h3>
          </div>
        </div>
        <div class="description row">
        <table>          
            <form id="addCustomer" name="addCustomerForm" action="addCustEmp" method="post">
            	<tr>  
		            <td>Username:</td>   
		  			<td><input type="text" name="username" class="inputA" ></td>
	  			</tr>
	  			<tr>  
		            <td>Password:</td>   
		  			<td><input type="password" name="password" class="inputA" ></td>
	  			</tr>
	            <tr>  
		            <td>First name:</td>   
		  			<td><input type="text" name="firstname" class="inputA" ></td>
	  			</tr>
	  			<tr>
		  			<td>Last name: </td>  
		  			<td><input type="text" name="lastname" class="inputA"></td>
	  			</tr>
	  			<tr>
		  			<td>Address:   </td>
		  			<td><input type="text" name="address" class="inputA"></td>
	  			</tr>
	  			<tr>
		  			<td>City:</td>   
		  			<td><input type="text" name="city" class="inputA"></td>
	  			</td>
	  			<tr>
		  			<td>State:</td>   
		  			<td><input type="text" name="state" class="inputA"></td>
	  			</tr>
	  			<tr>
		  			<td>Zip Code: </td>  
		  			<td><input type="text" name="zipcode" class="inputA"></td>
	  			</tr>
	  			<tr>
		  			<td>Telephone: </td>  
		  			<td><input type="text" name="telephone" class="inputA"></td>
	  			</tr>
	  			<tr>
		  			<td>Email: </td>
		  			<td><input type="text" name="email" class="inputA"></td>
	  			</tr>
	  			<tr>
		  			<td>Rating: </td>  
		  			<td><input type="text" name="rating" class="inputA"></td>
	  			</tr>	  				
			</form>  
		</table>    
		<br>
		<button value="Cust" class="btn-default" id="addCust" onclick="return addCust_onclick()">Confirm</button>     
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
            <form id="editCustomer" name="editCustomerForm" action="editCustEmp" method="post">
            	<tr>
            		<td>ID:</td>
					<td><select name="custIdEdit" class="inputA">
						    <c:forEach var="cust" items="${customers}">
						    <option value="${cust.id}"><c:out value="${cust.id}" /></option>
						    </c:forEach>
						</select>
            		</td>
            	</tr>
            	<tr>
            		<td>Field:</td>
					<td><select name="custEditField" class="inputA">						    
						    <option value="firstname" selected="selected">First Name</option>
						    <option value="lastname">Last Name</option>
						    <option value="address">Address</option>
						    <option value="city">City</option>
						    <option value="state">State</option>
						    <option value="zipcode">Zip Code</option>
						    <option value="telephone">Telephone</option>
						    <option value="email">Email</option>
						    <option value="rating">Rating</option>						    
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
		<button value="editCust" class="btn-default" id="editCust" onclick="return editCust_onclick()">Confirm</button>  
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
         	<form id="deleteCustomer" name="deleteCustomerForm" action="deleteCustEmp" method="post">
         	Customer ID:
			<select name="custIdDelete" class="inputA">
			    <c:forEach var="cust" items="${customers}">
			    <option value="${cust.id}"><c:out value="${cust.id}" /></option>
			    </c:forEach>
			</select>
			<br>
			<br>
			<button value="deleteCust" class="btn-default" id="deleteCust" onclick="return deleteCust_onclick()">Confirm</button>
			</form>  
        </div>
      </div>
    </div>
	
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>