<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../ban.jsp" %>   
<div class='center-block'>
	<div class="page-header">
		<h1><c:out value="${menuNm}" /></h1>
	</div>
	<form class="form-horizontal" id='myForm' autocomplete="off">
		<input type="hidden" id='puK' value='<c:out value="${puK}" />' >
		<div class="form-group col-md-4 right-border no-margin">
			<div class="col-xs-12 col-md-4">
				<a href="#" class="thumbnail" style="width: 171px;height: 180px;">
					<img alt="100%x180" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMTcxIiBoZWlnaHQ9IjE4MCIgdmlld0JveD0iMCAwIDE3MSAxODAiIHByZXNlcnZlQXNwZWN0UmF0aW89Im5vbmUiPjxkZWZzLz48cmVjdCB3aWR0aD0iMTcxIiBoZWlnaHQ9IjE4MCIgZmlsbD0iI0VFRUVFRSIvPjxnPjx0ZXh0IHg9IjU5LjU0Njg3NSIgeT0iOTAiIHN0eWxlPSJmaWxsOiNBQUFBQUE7Zm9udC13ZWlnaHQ6Ym9sZDtmb250LWZhbWlseTpBcmlhbCwgSGVsdmV0aWNhLCBPcGVuIFNhbnMsIHNhbnMtc2VyaWYsIG1vbm9zcGFjZTtmb250LXNpemU6MTBwdDtkb21pbmFudC1iYXNlbGluZTpjZW50cmFsIj4xNzF4MTgwPC90ZXh0PjwvZz48L3N2Zz4=">
		    	</a>
			</div>
			<div class='form-group col-md-8'>
				<label for="name" class="col-sm-3 control-label">이름</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="name" placeholder="Name">
				</div>
			</div>
			<div class='form-group col-md-8'>
				<label for="nick" class="col-sm-3 control-label">별칭</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="nick" placeholder="NickName">
				</div>
			</div>
			<div class='form-group col-md-8'>
				<label for="Email" class="col-sm-3 control-label">이메일</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="Email" placeholder="E-mail">
				</div>
			</div>
			<div class="form-group col-md-8">
				<label for="tel" class="col-sm-3 control-label">연락처</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="tel" placeholder="Telephone">
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-sm-12">
					<button type="button" class="btn btn-default pull-right" onclick='chgMyInfo();'>개인정보 변경</button>
				</div>
			</div>
		</div>
		<div class="form-group col-md-4 right-border no-margin">
			<div class='form-group col-md-12'>
				<label for="pwd" class="col-sm-3 control-label">기존 비밀번호</label>
				<div class="col-sm-9">
					<input type="password" class="form-control no-copy-paste" id="oldPwd" placeholder="Password">
				</div>
			</div>
			<div class="form-group col-md-12 has-feedback has-error">
				<label for="pwd" class="col-sm-3 control-label">새 비밀번호</label>
				<div class="col-sm-9">
					<input type="password" class="form-control no-copy-paste" id="pwd" placeholder="Password">
					<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
				</div>
			</div>
			<div class="form-group col-md-12 has-feedback has-error">
				<label for="pwdChk" class="col-sm-3 control-label">새 비밀번호 확인</label>
				<div class="col-sm-9">
					<input type="password" class="form-control no-copy-paste" id="pwdChk" placeholder="Password">
					<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
				</div>
				<span class='col-sm-offset-3 col-sm-9 font-red' style='display: none;' id='pwdText'>새 비밀번호가 일치하지 않습니다.</span>
			</div>
			<div class="form-group col-md-12">
				<div class="col-sm-offset-3 col-sm-9">
					<button type="button" class="btn btn-default pull-right" onclick='chgPwd();'>비밀번호 변경</button>
				</div>
			</div>
		</div>
		<div class="form-group col-md-4 no-margin">
			<div class='form-group col-md-12'>
				<div class="checkbox no-top-padding">
					<label class="control-label">
						<input type="checkbox" id="goCalendar" onchange="goCalAction();" >구글캘린더 연동
					</label>
				</div>
			</div>
		</div>
	</form>
	<div class='pull-right'>
		<a href='#'>회원탈퇴</a>
	</div>
</div>


<script type="text/javascript">

	$( document ).ready(function() {
		//비밀번호 복사 금지
		utilNoCtrl();
		
		//내정보 가져오기
		myInfo();
		
		//비밀번호 비교
		$( '#pwd' ).keyup(comparePwd);
		$( '#pwdChk' ).keyup(comparePwd);
		
		//구글API연동준비
// 		parent.handleClientLoad();
	});
	
	//구글캘린더 연동
	function goCalAction(){
		
		if($('#goCalendar').is(':checked')){
			$('#goCalendar').prop('checked',false);
			if(confirm('연동시 브라우저가 구글계정에 로그인하게됩니다.\n'
					  +'개인PC가 아닌경우 사용후 로그아웃하여주시기 바랍니다.\n'
					  +'연동하시겠습니까?')){
// 				handleAuthClick(event);			
// 				location.href='/oauth';
				utilAjax( null , null , null , '/oauth');
			}
		}else{
// 			handleSignoutClick(event);
		}
	}
	
	//내정보 가져오기
	function myInfo(){
		utilAjax( {
			'queryId'	: 'com.1_myInfo'
		} , null, function(data){
			
			$('#name').val( utilIsNull( data.NAME, '' ) );
			$('#nick').val( utilIsNull( data.NICK, '' ) );
			$('#Email').val( utilIsNull( data.EMAIL, '' ));
			$('#tel').val( utilIsNull( data.TEL, '' ) );   
			
		});
	}
	
	
	//비밀번호 비교
	function comparePwd(){
		var pwd = $('#pwd').val();
		var pwdChk = $('#pwdChk').val();
		
		//비밀번호 일치
		if(pwd == pwdChk){
			
			//비밀번호 입력
			if(pwd.length > 0){
				$("#pwd").closest('.has-feedback').removeClass('has-error');
				$("#pwd").closest('.has-feedback').addClass('has-success');
				$("#pwd").siblings('span').remove();
				$("#pwd").after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
				$("#pwdChk").closest('.has-feedback').removeClass('has-error');
				$("#pwdChk").closest('.has-feedback').addClass('has-success');
				$("#pwdChk").siblings('span').remove();
				$("#pwdChk").after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');	
			}
			$('#pwdText').hide();				
			
		}
		//비밀번호 일치하지 않음
		else{
			$("#pwd").closest('.has-feedback').removeClass('has-success');
			$("#pwd").closest('.has-feedback').addClass('has-error');
			$("#pwd").siblings('span').remove();
			$("#pwd").after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
			$("#pwdChk").closest('.has-feedback').removeClass('has-success');
			$("#pwdChk").closest('.has-feedback').addClass('has-error');
			$("#pwdChk").siblings('span').remove();
			$("#pwdChk").after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
			$('#pwdText').show();
		}
	}
	
	//비밀번호변경 프로세스 실행
	function chgPwd(){
		
		if( !confirm('비밀번호를 변경하시겠습니까') ){
			return false;
		}
		
		var oldPwd = $('#oldPwd').val();
		var pwd = $('#pwd').val();
		var pwdChk = $('#pwdChk').val();
		var puk = $('#puK').val();
		
		utilAjax( {
			'queryId'	: 'com.pwdChg'
			,'oldPwd'	: utilSecurePw(oldPwd , puk)
			,'pwd'		: utilSecurePw(pwd , puk)
		} , function(){
			
			//비밀번호 체크
			if(oldPwd.length == 0){
				alert('비밀번호를 입력하세요');
				$('#oldPwd').focus();
				return false;
			}
			else if( pwd.search(/\s/) != -1 ){		// -1 일경우 공백없음
				alert('비밀번호에 공백을 입력할수 없습니다.');
				$('#pwd').focus();
				return false;
			}
			else if(pwd.length == 0){
				alert('비밀번호를 입력하세요');
				$('#pwd').focus();
				return false;
			}
			else if(pwd != pwdChk){
				alert('새 비밀번호가 일치하지 않습니다.');
				$('#pwdChk').focus();
				return false;
			}
			
		} , function(data){
			if(data == '1'){
				alert('비밀번호가 변경되었습니다.');
				$('#oldPwd').val('');
				$('#pwd').val('');
				$('#pwdChk').val('');
				$("#pwd").closest('.has-feedback').removeClass('has-success');
				$("#pwd").closest('.has-feedback').addClass('has-error');
				$("#pwd").siblings('span').remove();
				$("#pwd").after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
				$("#pwdChk").closest('.has-feedback').removeClass('has-success');
				$("#pwdChk").closest('.has-feedback').addClass('has-error');
				$("#pwdChk").siblings('span').remove();
				$("#pwdChk").after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
			}
			
		} , '/pwdChg' , false);
		
	}
	
	function chgMyInfo(){
		
		utilAjax( {
			'queryId'	: 'com.U_myInfoChg'
			,'name'		: $('#name').val()
			,'nick'		: $('#nick').val()
			,'Email'	: $('#Email').val()
			,'tel'		: $('#tel').val()
		} , null, function(data){
			
			if(data.updated > 0){
				alert('개인정보가 변경되었습니다.');	
			}
			
		} , null , false);
		
	}
	
	
	//구글로그인
	function handleAuthClick(event) {
		
		parent.gapi.auth2.getAuthInstance().signIn().then(function(){
			  
			  alert('인증완료');
			  $('#goCalendar').prop('checked',true);
	  	  },function(error) {
	  			console.error(error.error);
	        });;
	}

	//구글로그아웃
	function handleSignoutClick(event) {
		parent.gapi.auth2.getAuthInstance().disconnect();
		$('#goCalendar').prop('checked',false);
	}
	
	
</script>