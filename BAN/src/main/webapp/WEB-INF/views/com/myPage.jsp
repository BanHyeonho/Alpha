<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../ban.jsp" %>   
<div class='center-block max-Size-500'>
	<h1 style='margin-bottom: 20px;'><c:out value="${menuNm}" /></h1>
	<form class="form-horizontal" id='joinForm' autocomplete="off">
		<input type="hidden" id='puK' value='<c:out value="${puK}" />' >
		<div class="form-group">
			<label for="pwd" class="col-sm-3 control-label">기존 비밀번호</label>
			<div class="col-sm-9">
				<input type="password" class="form-control" id="oldPwd" placeholder="Password">
			</div>
		</div>
		<div class="form-group has-feedback has-error">
			<label for="pwd" class="col-sm-3 control-label">비밀번호</label>
			<div class="col-sm-9">
				<input type="password" class="form-control" id="pwd" placeholder="Password">
				<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
			</div>
			<span class='col-sm-offset-3 col-sm-9 font-red' style='display: none;' id='pwdText'>비밀번호가 일치하지 않습니다.</span>
		</div>
		<div class="form-group has-feedback has-error">
			<label for="pwdChk" class="col-sm-3 control-label">비밀번호 확인</label>
			<div class="col-sm-9">
				<input type="password" class="form-control" id="pwdChk" placeholder="Password">
				<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
			</div>
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-3 control-label">이름</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="name" placeholder="Name">
			</div>
		</div>
		<div class="form-group">
			<label for="nick" class="col-sm-3 control-label">별칭</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="nick" placeholder="NickName">
			</div>
		</div>
		<div class="form-group">
			<label for="Email" class="col-sm-3 control-label">이메일</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="Email" placeholder="E-mail">
			</div>
		</div>
		<div class="form-group">
			<label for="tel" class="col-sm-3 control-label">연락처</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="tel" placeholder="Telephone">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-3 col-sm-9">
				<button type="button" class="btn btn-default " onclick='change();'>변경</button>
			</div>
		</div>
	</form>
</div>

<script type="text/javascript">
	
	var idCheck = false;
	
	$( document ).ready(function() {
		$('#oldPwd').focus();
		
		//비밀번호 비교
		$( '#pwd' ).keyup(comparePwd);
		$( '#pwdChk' ).keyup(comparePwd);
		
		//마지막 입력태그에서 엔터키 입력시 가입실행
		$('#joinForm').find('input:last').keydown(function(){
			if (window.event.keyCode == 13) {
				// 엔터키가 눌렸을 때 실행할 내용
		         join();
		    }
		});
		
	});
	
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
	
	//회원가입 프로세스 실행
	function join(){
		
		if( !confirm('가입하시겠습니까') ){
			return false;
		}
		
		var id = $('#id').val();
		var pwd = $('#pwd').val();
		var pwdChk = $('#pwdChk').val();
		var puk = $('#puK').val();
		
		utilAjax( {
			'queryId'	: 'com.memberInsert'
			,'id'		: id
			,'pwd'		: utilSecurePw(pwd , puk)
			,'name'		: $('#name').val()
			,'nick'		: $('#nick').val()
			,'Email'	: $('#Email').val()
			,'tel'		: $('#tel').val()
		} , function(){
			
			//비밀번호 체크
			if(pwd.length == 0){
				alert('비밀번호를 입력하세요');
				$('#pwd').focus();
				return false;
			}
			else if(pwd != pwdChk){
				alert('비밀번호가 일치하지 않습니다.');
				$('#pwdChk').focus();
				return false;
			}
			
		} , function(data){
			
			utilMovePage('main');
			
		} , '/join' , false, null, null, null, null, null, 'text');
		
	}
	
	//로그인화면으로 이동
	function back(){
		utilMovePage('login');
	}
</script>