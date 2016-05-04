<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Employee List</title>
	<link rel="stylesheet" href="gen.css" />
	<link rel="stylesheet" href="manEmp.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

// <!CDATA[
$(document).ready(function(){
	console.log("employees!");	
	$("#employees").addClass('active');

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

function addEmp_onclick() {
    console.log("addEmp!");
    javascript:addEmployeeForm.submit();
}

// ]]>

	</script>
	
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_man_menu.jsp"></jsp:include>
	<c:set var="me" scope="session" value="${id}"/>
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
	        <c:set var="me" scope="session" value="${id}"/>
			<c:forEach var="emp" items="${employees}">			
				 <c:if test="${emp.id ne me}">
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
	            </c:if>
		    </c:forEach>
	    </table>
	</div>

	<div class="utilities container">  
      <!-- Utility -->
      <div class="utility current">
        <div class="item row">
          <div class="col-xs-3">
             <h3>Add</h3>
          </div>
        </div>
        <div class="description row">
        <table>          
            <form id="addEmployee" name="addEmployeeForm" action="addEmpMan" method="post">
            	<tr>  
		            <td>Username:</td>   
		  			<td><input type="text" name="username" class="inputA" required></td>
	  			</tr>
	  			<tr>  
		            <td>Password:</td>   
		  			<td><input type="password" name="password" class="inputA" required></td>
	  			</tr>
	            <tr>  
		            <td>First name:</td>   
		  			<td><input type="text" name="firstname" class="inputA" required></td>
	  			</tr>
	  			<tr>
		  			<td>Last name: </td>  
		  			<td><input type="text" name="lastname" class="inputA" required></td>
	  			</tr>
	  			<tr>
		  			<td>Address:   </td>
		  			<td><input type="text" name="address" class="inputA" required></td>
	  			</tr>
	  			<tr>
		  			<td>City:</td>   
		  			<td><input type="text" name="city" class="inputA" required></td>
	  			</td>
	  			<tr>
		  			<td>State:</td>   
		  			<td><input type="text" name="state" class="inputA" required></td>
	  			</tr>
	  			<tr>
		  			<td>Zip Code: </td>  
		  			<td><input type="text" name="zipcode" class="inputA" required></td>
	  			</tr>
	  			<tr>
		  			<td>Telephone: </td>  
		  			<td><input type="text" name="telephone" class="inputA" required></td>
	  			</tr>
	  			<tr>
		  			<td>Start Date: </td>
		  			<td><input type="text" name="startdate" class="inputA" placeholder="yyyy-mm-dd" required></td>
	  			</tr>
	  			<tr>
		  			<td>Hourly Rate: </td>  
		  			<td><input type="text" name="hourly" class="inputA" required></td>
	  			</tr>
	  			<tr>
		  			<td>SSN:  </td> 
		  			<td><input type="text" name="ssn" class="inputA" required></td>
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