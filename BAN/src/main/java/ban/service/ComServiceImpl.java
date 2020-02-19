package ban.service;

import java.security.Key;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import ban.dao.ComDao;
import ban.util.ComUtil;

@Service("genericService")
public class ComServiceImpl implements ComService{

	@Autowired
	ComDao comDao;

	@Override
	public String join(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> map = ComUtil.getParameterMap(request);
		
		String pwd = ComUtil.decrypt( request.getSession().getAttribute("prK").toString(), map.get("pwd") );
		map.put("pwd", pwd);
		comDao.insert(map.get("queryId"), map);
		
		//로그인 성공
		request.getSession().setAttribute("LOGIN_CHK", "1");
		request.getSession().setAttribute("LOGIN_ID", map.get("id"));
		request.getSession().setAttribute("NAME", map.get("name"));
		request.getSession().setAttribute("NICK", map.get("nick"));
		
		return "1";
	}

	@Override
	public String login(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> map = ComUtil.getParameterMap(request);
		
		String pwd = ComUtil.decrypt( request.getSession().getAttribute("prK").toString(), map.get("pwd") );
		map.put("pwd", pwd);
		
		Map<String, Object> rMap = comDao.selectOne( map.get("queryId") , map);
		
		//로그인 실패 (아이디 비밀번호 틀림)
		if(rMap == null) {
			
			return "-1";	
		}
		//탈퇴한 회원
		else if(rMap.get("USE_YN").equals("0")) {
			return "0";
		}
		
		//로그인 성공
		request.getSession().setAttribute("LOGIN_CHK", "1");
		request.getSession().setAttribute("LOGIN_ID", rMap.get("ID"));
		request.getSession().setAttribute("NAME", rMap.get("NAME"));
		request.getSession().setAttribute("NICK", rMap.get("NICK"));
		
		return "1";
	}

	@Override
	public ModelAndView page(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		ModelAndView mav = new ModelAndView();
		
		Map<String, String> map = ComUtil.getParameterMap(request);
		Map rMap = comDao.selectOne( "page" , map);
		mav.setViewName( String.valueOf(rMap.get("PATH")) + String.valueOf(rMap.get("MENU_URL")) );
		
		//보안키가 있는 화면
		if( String.valueOf(rMap.get("SECURE_YN")).equals("1") ) {
			
			KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
			keyPairGenerator.initialize(1024, new SecureRandom());
			
			KeyPair keyPair = keyPairGenerator.genKeyPair();
			Key publicKey = keyPair.getPublic();
			Key privateKey = keyPair.getPrivate();
			
			request.getSession().setAttribute("puK", Base64.getEncoder().encodeToString(publicKey.getEncoded()));
			request.getSession().setAttribute("prK", Base64.getEncoder().encodeToString(privateKey.getEncoded()));
		}
		//없는 화면
		else {
			request.getSession().removeAttribute("puK");
			request.getSession().removeAttribute("prK");
		}
		
		request.getSession().setAttribute("menuNm", String.valueOf(rMap.get("MENU_NM")) );
		
		return mav;
	}

	@Override
	public Object ajax(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> map = ComUtil.getParameterMap(request);
		
		map.put("LOGIN_ID",	 String.valueOf(request.getSession().getAttribute("LOGIN_ID")) );
		
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		//SELECT One
		if( String.valueOf( map.get("queryId") ).contains(".1_") ) {
				
			return comDao.selectOne( map.get("queryId").replace(".1_",".") , map);
		}
		//SELECT
		else if( String.valueOf( map.get("queryId") ).contains(".S_") ) {
			
			return comDao.selectList( map.get("queryId").replace(".S_",".") , map);
		}
		//INSERT
		else if( String.valueOf( map.get("queryId") ).contains(".I_") ) {
			
			rMap.put("inserted", comDao.insert( map.get("queryId").replace(".I_",".") , map) );
			return rMap;
		}
		//UPDATE
		else if( String.valueOf( map.get("queryId") ).contains(".U_") ) {
			
			rMap.put("updated", comDao.update( map.get("queryId").replace(".U_",".") , map) );
			return rMap;
		}
		//DELETE
		else if( String.valueOf( map.get("queryId") ).contains(".D_") ) {
			
			rMap.put("deleted", comDao.delete( map.get("queryId").replace(".D_",".") , map) );
			return rMap;
		}
		
		return "notFoundQuery";
	}

	@Override
	public String pwdChg(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> map = ComUtil.getParameterMap(request);
		
		String oldPwd = ComUtil.decrypt( request.getSession().getAttribute("prK").toString(), map.get("oldPwd") );
		String newPwd = ComUtil.decrypt( request.getSession().getAttribute("prK").toString(), map.get("pwd") );
		
		map.put("id", String.valueOf(request.getSession().getAttribute("LOGIN_ID")) );
		map.put("pwd", oldPwd);
		
		Map<String, Object> rMap = comDao.selectOne( "com.login" , map);
		
		//로그인 실패 (아이디 비밀번호 틀림)
		if(rMap == null) {
			
			throw new Exception("기존비밀번호가 일치하지 않습니다.");	
		}
		
		map.put("MEMBER_ID" , String.valueOf(rMap.get("MEMBER_ID"))  );
		map.put("pwd" , newPwd );
		comDao.update("com.pwdChg", map);
		
		return "1";
	}

	@Override
	public String insertBatch(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, String> map = new HashMap<String, String>();
		
		for (int i = 0; i < 10; i++) {
			int j = i;
			if(i > 5) {
				j = 5;
			}
			map.put("id",String.valueOf(j));
			map.put("val","value : " + String.valueOf(j));
			comDao.batchInsert("com.test", map);
		}
		
		
		
		return null;
	}

	@Override
	public String updateBatch(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
