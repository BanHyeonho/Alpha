package ban.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ban.service.ComService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ComController {
	
	private static final Logger logger = LoggerFactory.getLogger(ComController.class);
	
	private Object rObj = null;
	
	@Autowired
	ComService cs;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	
	@RequestMapping(value = "/ajax")
	public @ResponseBody Object ajax(HttpServletRequest request ,HttpServletResponse response) {
	
		try {
			rObj = cs.ajax(request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			response.setStatus(9998);
			rObj = e.getMessage();
			logger.error((String) rObj);
		}
	
		return rObj;
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public @ResponseBody Object login(HttpServletRequest request ,HttpServletResponse response){
	
		try {
			rObj = cs.login(request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			response.setStatus(9998);
			rObj = e.getMessage();
			logger.error((String) rObj);
		}
		
		return rObj;
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request ,HttpServletResponse response){
	
		request.getSession().invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public @ResponseBody Object join(HttpServletRequest request ,HttpServletResponse response){
		
		try {
			rObj = cs.join( request );
		} catch (Exception e) {
			// TODO Auto-generated catch block
			response.setStatus(9998);
			rObj = e.getMessage();
			logger.error((String) rObj);
		}
		
		return rObj;
	}

	@RequestMapping(value = "/pwdChg", method = RequestMethod.POST)
	public @ResponseBody Object pwdChg(HttpServletRequest request ,HttpServletResponse response){
		
		try {
			rObj = cs.pwdChg( request );
		} catch (Exception e) {
			// TODO Auto-generated catch block
			response.setStatus(9998);
			rObj = e.getMessage();
			logger.error((String) rObj);
		}
		
		return rObj;
	}
	
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ModelAndView page(HttpServletRequest request) throws Exception{
		
		return cs.page(request);
	}
	
}
