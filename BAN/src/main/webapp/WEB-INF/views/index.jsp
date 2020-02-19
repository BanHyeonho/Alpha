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
		<iframe id='content' class='embed-responsive-item' allowfullscreen></iframe>	
	</div>
	
	<!-- END container-fluid -->
	</div>
<!-- <script type="text/javascript" src="/script/api-google.js"></script> -->
<script type="text/javascript">
	$( document ).ready(function() {

		<c:choose>
		    <c:when test="${LOGIN_CHK eq '1'}">
	    		$('#header').show();
		    	$('#content').attr('src', '/page?menuUrl=main');
		    </c:when> 
		    <c:otherwise>
		    	$('#header').hide();
		    	$('#content').attr('src', '/page?menuUrl=login');
		    </c:otherwise>
		</c:choose>
		$('#content').attr('onload','fixHeight()');
		
		//구글API연동준비
// 		handleClientLoad();
	});
	
	function fixHeight(){
		var childHei = $('#content').contents().children().css('height');
		$('#content').parent().css({'min-height' : childHei});
	}
	
	
	
	/*******************************************/
	/************* 구글캘린더 API START ***********/
	/*******************************************/
	
	//Client ID and API key from the Developer Console
	var CLIENT_ID = '344958404992-9r4cjvpaqoprf0614i6udk04gifrkjhs.apps.googleusercontent.com';
	var API_KEY = 'AIzaSyC1HIx05xwfKkxTUw-X90N8vF-HHg-Lh7g';

	// Array of API discovery doc URLs for APIs used by the quickstart
	var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];

	// Authorization scopes required by the API; multiple scopes can be
	// included, separated by spaces.
	var SCOPES = "https://www.googleapis.com/auth/calendar";


	//구글 api 사용을 위한 oauth2 load
	function handleClientLoad() {
	  gapi.load('client:auth2', initClient);
	  
	}

	/**
	 *  Initializes the API client library and sets up sign-in state
	 *  listeners.
	 */
	function initClient() {
	  gapi.client.init({
	    apiKey: API_KEY,
	    clientId: CLIENT_ID,
	    discoveryDocs: DISCOVERY_DOCS,
	    scope: SCOPES
	  }).then(function () {
	    // Listen for sign-in state changes.
// 	    gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);
	    
	    // Handle the initial sign-in state.
// 	    updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
	   
	    if(gapi.auth2.getAuthInstance().isSignedIn.get()){
	    	var iframe = document.getElementById('content').contentWindow;
	    	iframe.$('#goCalendar').prop('checked',true);
	    }else{
	    	var iframe = document.getElementById('content').contentWindow;
	    	iframe.$('#goCalendar').prop('checked',false);
	    }
	    
	  }, function(error) {
		  console.error(error);
	  });
	}

	//인증여부 확인
	function updateSigninStatus(isSignedIn) {
	  
		 
		  if (!isSignedIn) {

			  gapi.auth2.getAuthInstance().signIn().then(function(){
				  
				  alert('인증완료');
	  		 
		  	  },function(error) {
		  		  	alert(error.error);
		  			console.error(error);
		        });
		  }else{
			  alert('이미 로그인되어있습니다.');
		  }
	}


	
	/*******************************************/
	/************* 구글캘린더 API END	 ***********/
	/*******************************************/
</script>
</body>
</html>