<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./ban.jsp" %>   

<div class='center-block max-Size-500 vertical-center-16p'>
	<form class="form-horizontal" id='loginForm'>
		<div class="form-group">
			<label for="loginId" class="col-sm-2 control-label">아이디</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="loginId" placeholder="ID">
			</div>
		</div>
		<div class="form-group">
			<label for="loginPwd" class="col-sm-2 control-label">비밀번호</label>
			<div class="col-sm-10">
				<input type="password" class="form-control" name="loginPwd" placeholder="Password">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<div class="checkbox no-top-padding">
					<label class="pull-left">
						<input type="checkbox">기억하기
					</label>
					<label class="pull-right">
						<a>아이디, 비밀번호 찾기</a>
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
		$('#loginForm [name=loginId]').focus();
	});
	
	function login(){
		console.log($('#loginForm [name=loginId]').val());
		console.log($('#loginForm [name=loginPwd]').val());
	}
	
	function join(){
		parent.utilMovePage('join');
	}
</script>