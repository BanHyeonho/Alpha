<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../ban.jsp" %>   

<div class='center-block max-Size-500 vertical-center-16p'>
	<form class="form-horizontal" id='loginForm' autocomplete="off">
		<input type="hidden" id='puK' value='<c:out value="${puK}" />' >
		<div class="form-group">
			<label for="loginId" class="col-sm-2 control-label">아이디</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="loginId" placeholder="ID">
			</div>
		</div>
		<div class="form-group">
			<label for="loginPwd" class="col-sm-2 control-label">비밀번호</label>
			<div class="col-sm-10">
				<input type="password" class="form-control no-copy-paste" name="loginPwd" placeholder="Password">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<div class="checkbox no-top-padding">
					<label class="pull-left">
						<input type="checkbox" id='remember'>기억하기
					</label>
					<label class="pull-right">
						<a href='javascript:;'>아이디, 비밀번호 찾기</a>
					</label>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="button" class="btn btn-default" onclick='login();'>로그인</button>
				<button type="button" class="btn btn-default" onclick='join();' >회원가입</button>
				
			</div>
		</div>
	</form>
</div>

<script type="text/javascript">
	$( document ).ready(function() {
		utilNoCtrl();
		
		$('#loginForm [name=loginId]').focus();
		
		$('#loginForm [name=loginId]').val(utilGetCookie('loginId'));
		$('#loginForm [name=loginPwd]').val(utilGetCookie('loginPwd'));
		if( utilIsNull( utilGetCookie('loginId'), '' ) != ''){
			$("#remember").prop("checked", true);
		}
		
		$('#loginForm').find('input[class^=form-control]:last').keydown(function(){
			if (window.event.keyCode == 13) {
				// 엔터키가 눌렸을 때 실행할 내용
		         login();
		    }
		});
		
	});
	
	function login(){
		
		var id = $('#loginForm [name=loginId]').val();
		var pwd = $('#loginForm [name=loginPwd]').val();
		var puk = $('#puK').val();
		
		utilAjax( {
			'queryId'	: 'com.login'
			,'id'		: id
			,'pwd'		: utilSecurePw(pwd , puk)
		} , function(){
			
			//아이디 체크
			if(id.length == 0){
				alert('아이디를 입력하세요.');
				$('#id').focus();
				return false;	
				
			}
			//비밀번호 체크
			else if(pwd.length == 0){
				alert('비밀번호를 입력하세요');
				$('#pwd').focus();
				return false;
			}
			
		} , function(data){
			
			//로그인 성공
			if(data == '1'){
				
				//기억하기 체크
				if($('#remember').is(':checked')){
					utilSetCookie('loginId', id, 365);
					utilSetCookie('loginPwd', pwd, 365);
				}else{
					utilSetCookie('loginId', '', 365);
					utilSetCookie('loginPwd', '', 365);
				}
				
				parent.$('#header').show();
				utilMovePage('main');
			}
			//탈퇴한 회원
			else if(data == '0'){
				alert('이미 탈퇴한 회원입니다.');
			}
			//아이디 비밀번호 틀림
			else if(data == '-1'){
				alert('아이디 또는 비밀번호가 틀립니다.');
			}
			
		} , '/login' , false);
		
	}
	
	function join(){
		utilMovePage('join');
	}
</script>