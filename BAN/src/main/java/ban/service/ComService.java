package ban.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface ComService {

	public Object ajax(HttpServletRequest request) throws Exception;
	
	public String join(HttpServletRequest request) throws Exception;

	public String login(HttpServletRequest request) throws Exception;

	public ModelAndView page(HttpServletRequest request) throws Exception;
	
	public String pwdChg(HttpServletRequest request) throws Exception;
	
}
