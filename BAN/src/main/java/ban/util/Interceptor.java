package ban.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Interceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		String requestURI = request.getRequestURI();
		String loginChk = String.valueOf(request.getSession().getAttribute("LOGIN_CHK"));
		
		//로그인 상태가 아니면서 특정 url 접근시 허용하지 않는다. 
		if( !"1".equals(loginChk) && 
		  ( "".equals(requestURI) )  ) {
			response.sendError(9999);
			return false;
		}
		
		
		return true;
	}

}
