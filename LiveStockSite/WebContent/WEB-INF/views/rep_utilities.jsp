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
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>