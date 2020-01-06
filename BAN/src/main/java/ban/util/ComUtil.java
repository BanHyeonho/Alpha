package ban.util;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class ComUtil {

	public static Map getParameterMap(HttpServletRequest request) {
		// 파라미터 이름
		Enumeration paramNames = request.getParameterNames();

		// 저장할 맵
		Map paramMap = new HashMap();

		// 맵에 저장
		while(paramNames.hasMoreElements()) {
			String name	 = paramNames.nextElement().toString();
			String value = request.getParameter(name);
	
			paramMap.put(name, value);
		}

		// 결과반환
		return paramMap;
	}
}
