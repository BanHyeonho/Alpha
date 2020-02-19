package ban.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

public interface ComService {

	//ajax 호출
	public Object ajax(HttpServletRequest request) throws Exception;
	
	//회원가입
	public String join(HttpServletRequest request) throws Exception;

	//로그인
	public String login(HttpServletRequest request) throws Exception;

	//페이지 호출
	public ModelAndView page(HttpServletRequest request) throws Exception;
	
	//패스워드변경
	public String pwdChg(HttpServletRequest request) throws Exception;
		
	//트랜젝션 배치(여러건 일괄처리시 사용)
	@Transactional
	public String insertBatch(HttpServletRequest request) throws Exception;
	@Transactional
	public String updateBatch(HttpServletRequest request) throws Exception;
}
