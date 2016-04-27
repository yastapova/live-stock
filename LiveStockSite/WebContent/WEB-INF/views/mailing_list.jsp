<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Utilities</title>
	<link rel="stylesheet" href="gen.css" />
	<script type="text/javascript">
// <!CDATA[


function customer_mailing_list() {
    window.open("mailing_list","_self");

}

// ]]>
	</script>
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_rep_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<button class="btn-default" onclick="return customer_mailing_list()">Mailing List</button>
		<table border="4">
        	<tr>
        		<th><span style="font-size: 10pt">Last Name</span></th>
				<th><span style="font-size: 10pt">First Name</span></th>
				<th><span style="font-size: 10pt">Address</span></th>
				<th><span style="font-size: 10pt">City</span></th>
				<th><span style="font-size: 10pt">State</span></th>
				<th><span style="font-size: 10pt">Zipcode</span></th>
				<th><span style="font-size: 10pt">Email</span></th>
            </tr>
			<c:forEach var="customer" items="${list}">
				<tr>
					<td><span style="font-size: 10pt">B<c:out value="${customer.lname}" /></span></td>
					<td><span style="font-size: 10pt">B<c:out value="${customer.fname}" /></span></td>
					<td><span style="font-size: 10pt">B<c:out value="${customer.address}" /></span></td>
					<td><span style="font-size: 10pt">B<c:out value="${customer.city}" /></span></td>
					<td><span style="font-size: 10pt">B<c:out value="${customer.state}" /></span></td>
					<td><span style="font-size: 10pt">B<c:out value="${customer.zip}" /></span></td>
					<td><span style="font-size: 10pt">B<c:out value="${customer.email}" /></span></td>
				</tr>
			</c:forEach>
		</table> 
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>