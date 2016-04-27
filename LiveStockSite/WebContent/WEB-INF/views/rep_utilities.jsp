<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>LiveStock Trading | Utilities</title>
	<link rel="stylesheet" href="gen.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js">
	</script>
	<script type="text/javascript">

	// <!CDATA[
	$(document).ready(function(){
		console.log("utilities!");	
		$("#utilities").addClass('active');
	});
	
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
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>