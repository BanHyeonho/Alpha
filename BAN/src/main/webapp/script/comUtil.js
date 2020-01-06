/**
 * 사용자정의 js
 */

function utilIsNull( val1, val2 ){
	
	if( val1 == undefined || val1 == '' || val1 == null ){
		val1 = val2;
	}
	
	return val1;
}

function utilMovePage(pageUrl){
	utilAjax( {
		menuUrl : pageUrl
	} , null , function(data){
		console.log(data);
	}, '/page');
}

function utilAjax( param , before , success , url , async , global , timeout , error , complete , method , dataType){
	
	var vUrl = utilIsNull( url , '/ajax' );
	var vMethod = utilIsNull( method , 'post' );
	var vDataType = utilIsNull( dataType , 'json' );
	var vAsync = utilIsNull( async , true );
	var vGlobal = utilIsNull( global , true );
	var vTimeout = utilIsNull( timeout , 30000 );
	
	var vParam = utilIsNull( param , {} );
	
	var vBefore = utilIsNull( before , function(){
		//aJax 요청전에 실행되는 함수, return false 일경우 ajax 요청 취소 가능
	} );
	
	var vSuccess = utilIsNull( success , function(data){
		//ajax통신 성공시 실행함수
		console.log('success' , data);
	} );
	
	var vError = utilIsNull( error , function(data){
		//ajax통신 실패시 실행함수
		console.log('error' , data);
		alert('error' , data);
	} );
	
	var vComplete = utilIsNull( complete , function(data){
		//ajax통신 완료시 실행함수
		console.log('complete' , data);
	} );
	
	var setting = {
			 url		: vUrl
			,method		: vMethod
			,dataType	: vDataType
			,async		: vAsync
			,timeout	: vTimeout
			,global		: vGlobal
			,data		: vParam
			,beforeSend	: vBefore
			,success	: vSuccess
			,error 		: vError
			,complete 	: vComplete
			
	};
	
	$.ajax(setting);
}

