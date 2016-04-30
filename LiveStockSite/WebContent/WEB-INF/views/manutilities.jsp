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
		console.log("Utilities!");	
		$("#utilities").addClass('active');
	});
	
	function export_onclick() {
		alert("Export successful!");
		window.open("doexport","_self");
	}
	function import_onclick() {
		alert("Import successful!");
		window.open("doimport","_self");
	}
// ]]>
	</script>
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_man_menu.jsp"></jsp:include>
	<div class="body" align="center">
		<h2>Backup Database</h2>
		<button class="btn-default" onclick="return export_onclick()">Export</button>
		<h2>Restore Database</h2>
		<button class="btn-default" onclick="return import_onclick()">Import</button>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>