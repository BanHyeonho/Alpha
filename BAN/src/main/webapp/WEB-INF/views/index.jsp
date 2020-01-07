<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ban.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 크롬자동번역사용안합 -->
<meta name='google' content='notranslate' >
<title>BAN</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
</head>
<body>
	<div class="container-fluid">
	<!-- START container-fluid -->
	
	<!-- header -->
	<jsp:include page="header.jsp" flush="false"></jsp:include>
	
	<!-- content -->
	<div class='embed-responsive embed-responsive-ban'>
		<iframe id='content' class='embed-responsive-item' allowfullscreen scrolling="no"></iframe>	
	</div>
	
	<!-- END container-fluid -->
	</div>
<script type="text/javascript">
	$( document ).ready(function() {
		$('#content').attr('src', '/page?menuUrl=login');
	});
</script>
</body>
</html>