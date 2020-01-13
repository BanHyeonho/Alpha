<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../ban.jsp" %>   
<div class='center-block max-Size-500 vertical-center-12p'>
	<div class="page-header">
		<h1 class="col-sm-offset-3"><c:out value="${menuNm}" /></h1>
	</div>
	
	<form class="form-horizontal" id='joinForm' autocomplete="off">
		<input type="hidden" id='puK' value='<c:out value="${puK}" />' >
		
		<div class="form-group has-feedback has-error">
			<label for="id" class="col-sm-3 control-label">아이디</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="id" placeholder="ID">
				<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
			</div>
		</div>
		<div class="form-group has-feedback has-error">
			<label for="pwd" class="col-sm-3 control-label">비밀번호</label>
			<div class="col-sm-9">
				<input type="password" class="form-control no-copy-paste" id="pwd" placeholder="Password">
				<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
			</div>
			<span class='col-sm-offset-3 col-sm-9 font-red' style='display: none;' id='pwdText'>비밀번호가 일치하지 않습니다.</span>
		</div>
		<div class="form-group has-feedback has-error">
			<label for="pwdChk" class="col-sm-3 control-label">비밀번호 확인</label>
			<div class="col-sm-9">
				<input type="password" class="form-control no-copy-paste" id="pwdChk" placeholder="Password">
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
				<button type="button" class="btn btn-default " onclick='join();'>가입</button>
				<button type="button" class="btn btn-default " onclick='back();' >뒤로</button>
			</div>
		</div>
	</form>
</div>

<script type="text/javascript">
	
	var idCheck = false;
	
	$( document ).ready(function() {
		utilNoCtrl();
		
		$('#id').focus();
		
		//아이디 입력시 자동 중복체크
		$( '#id' ).keyup(function() {
			
			utilAjax( {
				   queryId : 'com.S_idChk'
				  ,id : $('#id').val()
			  } , function(){
				  var id = $('#id').val();
				  
				  if( utilChkPattern( id, 'spc', true) ){
					  $("#id").closest('.has-feedback').removeClass('has-success');
					  $("#id").closest('.has-feedback').addClass('has-error');
					  $("#id").siblings('span').remove();
					  $("#id").after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
					  alert('특수문자는 사용할수 없습니다.');
					  return false;					  
				  }else if( id.length > 20 ){
					  $("#id").closest('.has-feedback').removeClass('has-success');
					  $("#id").closest('.has-feedback').addClass('has-error');
					  $("#id").siblings('span').remove();
					  $("#id").after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
					  alert('아이디는 최대 20글자 이내여야 합니다.');
					  return false;
				  }
				  
			  } , function(data){
				  if(data.length > 0){
					  $("#id").closest('.has-feedback').removeClass('has-success');
					  $("#id").closest('.has-feedback').addClass('has-error');
					  $("#id").siblings('span').remove();
					  $("#id").after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
					  alert('중복된 아이디 입니다.');
					  idCheck = false;
				  }
				  //사용가능 아이디
				  else{
					  if($('#id').val().length > 0){
						  $("#id").closest('.has-feedback').removeClass('has-error');
						  $("#id").closest('.has-feedback').addClass('has-success');
						  $("#id").siblings('span').remove();
						  $("#id").after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
						  idCheck = true;						  
					  }else{
						  $("#id").closest('.has-feedback').removeClass('has-success');
						  $("#id").closest('.has-feedback').addClass('has-error');
						  $("#id").siblings('span').remove();
						  $("#id").after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
					  }
					  
				  }
				  
			  } );
			  
		});
		
		//비밀번호 비교
		$( '#pwd' ).keyup(comparePwd);
		$( '#pwdChk' ).keyup(comparePwd);
		
		//마지막 입력태그에서 엔터키 입력시 가입실행
		$('#joinForm').find('input[class^=form-control]:last').keydown(function(){
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
			
			//아이디 체크
			if(utilChkPattern( id, 'spc', true)){
				alert('특수문자는 사용할수 없습니다.');
				$('#id').focus();
				return false;	
				
			}
			else if(id.length > 20){
				alert('아이디는 최대 20글자 이내여야 합니다.');
				$('#id').focus();
				return false;
				  
			}
			else if(id.length == 0){
				alert('아이디를 입력하세요');
				$('#id').focus();
				return false;
			}
			else if(!idCheck){
				alert('중복된 아이디 입니다.');
				$('#id').focus();
				return false;
			}
			//비밀번호 체크
			else if(pwd.length == 0){
				alert('비밀번호를 입력하세요');
				$('#pwd').focus();
				return false;
			}
			else if( pwd.search(/\s/) != -1 ){		// -1 일경우 공백없음
				alert('비밀번호에 공백을 입력할수 없습니다.');
				$('#pwd').focus();
				return false;
			}
			else if(pwd != pwdChk){
				alert('비밀번호가 일치하지 않습니다.');
				$('#pwdChk').focus();
				return false;
			}
			
		} , function(data){
			
			parent.$('#header').show();
			utilMovePage('main');
			
		} , '/join' , false);
		
	}
	
	//로그인화면으로 이동
	function back(){
		utilMovePage('login');
	}
</script>