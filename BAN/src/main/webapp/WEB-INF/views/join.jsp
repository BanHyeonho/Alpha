<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ban.jsp" %>   

<div class='center-block max-Size-500 vertical-center-12p'>
	<form class="form-horizontal" id='joinForm'>
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
				<button type="button" class="btn btn-default " onclick='join();'>가입</button>
				<button type="button" class="btn btn-default " onclick='back();' >뒤로</button>
			</div>
		</div>
	</form>
</div>

<script type="text/javascript">
	$( document ).ready(function() {
		$('#id').focus();
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
				  }
				  //사용가능 아이디
				  else{
					  $("#id").closest('.has-feedback').removeClass('has-error');
					  $("#id").closest('.has-feedback').addClass('has-success');
					  $("#id").siblings('span').remove();
					  $("#id").after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
				  }
				  
			  } );
			  
		});
		
		$( '#pwd' ).keyup(comparePwd);
		$( '#pwdChk' ).keyup(comparePwd);
	});
	
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
	
	
	function join(){
		
	}
	
	function back(){
		utilMovePage('login');
	}
</script>