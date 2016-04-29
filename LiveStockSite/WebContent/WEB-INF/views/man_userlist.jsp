<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | User List</title>
	<link rel="stylesheet" href="gen.css" />
	<link rel="stylesheet" href="manEmp.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("users!");	
	$("#users").addClass('active');

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

function addEmp_onclick() {
    console.log("addEmp!");
    javascript:addEmployeeForm.submit();
}

function deleteCust_onclick() {
    console.log("deleteCust!");
    javascript:deleteCustomerForm.submit();
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
	<jsp:include page="_man_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<h2>Employees</h2>
		<table border="5" id="accounts">
			<tr>
	          <th style="width: 150px"><span style="font-size: 10pt">Employee Id</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">First</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Last</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Address</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">City</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">State</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Zip Code</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Telephone</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Start Date</span></th>
	          <th style="width: 150px"><span style="font-size: 10pt">Hourly Rate</span></th>
	        </tr>
			<c:forEach var="emp" items="${employees}">
				<tr>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${emp.id}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.fname}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.lname}" /></span></td>
		            <td style="width: 200px"><span style="font-size: 10pt"><c:out value="${emp.address}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.city}" /></span></td>
		            <td style="width: 50px"><span style="font-size: 10pt"><c:out value="${emp.state}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.zip}"/></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.phone}" /></span></td>
		            <td style="width: 150px"><span style="font-size: 10pt"><c:out value="${emp.start}" /></span></td>
		            <td style="width: 100px"><span style="font-size: 10pt"><c:out value="${emp.hourly}" /></span></td>
	            </tr>
		    </c:forEach>
	    </table>
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
	</div>
	<div class="utilities container">  
      <!-- Utility -->
      <div class="utility current">
        <div class="item row">
          <div class="col-xs-3">
             <h3>Add Employee</h3>
          </div>
        </div>
        <div class="description row">
        <table>          
            <form id="addEmployee" name="addEmployeeForm" action="addUserEmpMan" method="post">
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
		  			<td>Start Date: </td>
		  			<td><input type="text" name="startdate" class="inputA" placeholder="yyyy-mm-dd"></td>
	  			</tr>
	  			<tr>
		  			<td>Hourly Rate: </td>  
		  			<td><input type="text" name="hourly" class="inputA"></td>
	  			</tr>
	  			<tr>
		  			<td>SSN:  </td> 
		  			<td><input type="text" name="ssn" class="inputA"></td>
	  			</tr>		
			</form>  
		</table>    
		<br>
		<button value="addEmp" class="btn-default" id="addEmp" onclick="return addEmp_onclick()">Confirm</button>     
        </div>
      </div>
      
      <!-- Utility -->
      <div class="utility">
        <div class="item row">
          <div class="col-xs-3">
            <h3>Delete Employee</h3>
          </div>
        </div>
        <div class="description row">
         	<form id="deleteEmployee" name="deleteEmployeeForm" action="deleteUserEmpMan" method="post">
         	Employee ID:
			<select name="empIdDelete" class="inputA">
			    <c:forEach var="emp" items="${employees}">
			    <option value="${emp.id}"><c:out value="${emp.id}" /></option>
			    </c:forEach>
			</select>
			<br>
			<br>
			<button value="deleteEmp" class="btn-default" id="deleteEmp" onclick="return deleteEmp_onclick()">Confirm</button>
			</form>  
        </div>
      </div>
      <!-- Utility -->
      <div class="utility">
        <div class="item row">
          <div class="col-xs-3">
             <h3>Add Customer</h3>
          </div>
        </div>
        <div class="description row">
        <table>          
            <form id="addCustomer" name="addCustomerForm" action="addUserCustMan" method="post">
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
            <h3>Delete Customer</h3>
          </div>
        </div>
        <div class="description row">
         	<form id="deleteCustomer" name="deleteCustomerForm" action="deleteUserCustMan" method="post">
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