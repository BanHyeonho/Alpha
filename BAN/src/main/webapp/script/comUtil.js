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
	//최상위 iframe src 를 수정한다.
	$(window.top.document).find('#content').attr('src', '/page?menuUrl=' + pageUrl);
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


function utilChkPattern( val, type, bool){
	var pattern_num = /[0-9]/;					// 숫자 
	var pattern_eng = /[a-zA-Z]/;				// 문자 
	var pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
	var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; 		// 한글체크

	bool = utilIsNull( bool, false );
	
	if(bool){
		
		//숫자가 있는경우 true
		if(utilIsNull( type, '' ) == 'num'){
			return pattern_num.test(val);
		}
		//문자 있는경우 true
		else if(utilIsNull( type, '' ) == 'eng'){
			return pattern_eng.test(val);
		}
		//특수문자 있는경우 true
		else if(utilIsNull( type, '' ) == 'spc'){
			return pattern_spc.test(val);
		}
		//한글 있는경우 true
		else if(utilIsNull( type, '' ) == 'kor'){
			return pattern_kor.test(val);
		}
	}
	else{
		
		//숫자가 없는경우 true
		if(utilIsNull( type, '' ) == 'num'){
			return !pattern_num.test(val);
		}
		//문자 없는경우 true
		else if(utilIsNull( type, '' ) == 'eng'){
			return !pattern_eng.test(val);
		}
		//특수문자 없는경우 true
		else if(utilIsNull( type, '' ) == 'spc'){
			return !pattern_spc.test(val);
		}
		//한글 없는경우 true
		else if(utilIsNull( type, '' ) == 'kor'){
			return !pattern_kor.test(val);
		}
	}
	
}






















