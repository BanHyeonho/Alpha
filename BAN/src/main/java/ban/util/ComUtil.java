package ban.util;

import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.spec.PKCS8EncodedKeySpec;
import org.apache.tomcat.util.codec.binary.Base64;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;
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
	
    public static String decrypt(String p_privateKey, String val) throws Exception {
   	 
 		byte[] bPrivateKey = Base64.decodeBase64(p_privateKey.getBytes());
 
 		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
 
 		PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(bPrivateKey);
 		PrivateKey privateKey = keyFactory.generatePrivate(privateKeySpec);
 
 		
 		byte[] blogin_pw = Base64.decodeBase64(val.getBytes());
 		Cipher cipher = Cipher.getInstance("RSA");
 		cipher.init(Cipher.DECRYPT_MODE, privateKey);
 		byte[] blogin_pw2 = cipher.doFinal(blogin_pw);
 		val = new String(blogin_pw2);
 
 		return val;
 
 	}
}
