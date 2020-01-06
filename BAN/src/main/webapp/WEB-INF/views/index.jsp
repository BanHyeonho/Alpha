<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ban.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BAN</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
</head>
<body>
	<div class="container-fluid">
	<!-- START container-fluid -->
	
	<!-- header -->
	<jsp:include page="header.jsp" flush="false"></jsp:include>
	
	<!-- content -->
	<div class='content'>
		<div class='embed-responsive embed-responsive-ban'>
			<iframe class='embed-responsive-item' src="/page?menuUrl=login" allowfullscreen></iframe>		
		</div>
	</div>
	
	<!-- END container-fluid -->
	</div>
<script type="text/javascript">
	$( document ).ready(function() {
	
	});
</script>
</body>
</html>