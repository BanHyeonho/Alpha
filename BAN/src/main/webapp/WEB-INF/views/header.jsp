<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id='header' style="display: none;">
	<div class="row black">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 no-pad-margin">
       		<div class="col-lg-1 col-md-2 col-sm-3 col-xs-12">
       			<a href='/' ><img src="/img/logo.png" width="100%"></a>
       		</div>
                 
            <div class="col-lg-10 col-md-8 col-sm-7 col-xs-12">
            	<ul class="list-inline">	
  					<li class='white'>Content1</li>
  					<li class='white'>Content2</li>
  					<li class='white'>시스템관리</li>
				</ul>
            </div>
                 
            <div class="visible-lg-block visible-md-block visible-sm-block">
                <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                    <a href='#' class='dropdown-toggle' data-toggle="dropdown" aria-expanded="false" ><span class="glyphicon glyphicon-user white pull-right" style="font-size: xx-large; padding-top:10px;" ></span></a>
                     <ul class="dropdown-menu" role="menu" style='left: -1;'>
					    <li><a href="javascript:myPage();">나의 페이지</a></li>
					    <li class="divider"></li>
					    <li><a href="javascript:logout();"><span class="glyphicon glyphicon-log-out"></span>&nbsp;로그아웃</a></li>
					  </ul>
                </div>
            </div>
             
            <div class="visible-xs-block">
                <div class="col-xs-12">
                    <a href='#' class='dropdown-toggle' data-toggle="dropdown" aria-expanded="false" ><span class="glyphicon glyphicon-user white pull-right" style="font-size: xx-large; padding-top:10px;" ></span></a>
                     <ul class="dropdown-menu col-xs-12" role="menu" style='left: -1;'>
					    <li><a href="javascript:myPage();">나의 페이지</a></li>
					    <li class="divider"></li>
					    <li><a href="/logout"><span class="glyphicon glyphicon-log-out"></span>&nbsp;로그아웃</a></li>
					  </ul>
                </div>
            </div>
         </div>
       </div>
</div>
<script type="text/javascript">
	$( document ).ready(function() {
		
	});
	
	function myPage(){
		$('#content').attr('src', '/page?menuUrl=myPage');
	}
	
	function logout(){
// 		//구글인증로그아웃
// 		var iframe = document.getElementById('content').contentWindow;
// 		iframe.gapi.auth2.getAuthInstance().disconnect();
		
		location.replace('/logout');
	}
	
</script>