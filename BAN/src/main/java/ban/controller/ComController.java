package ban.controller;

import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import ban.util.ComUtil;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ComController {
	
	private static final Logger logger = LoggerFactory.getLogger(ComController.class);
	
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
	public @ResponseBody Object ajax(HttpServletRequest request) {
	
		Map<String, String> map = ComUtil.getParameterMap(request);
		
		try {
			
			//SELECT One
			if( String.valueOf( map.get("queryId") ).contains(".1_") ) {
					
				return cs.selectOne( map.get("queryId").replace(".1_",".") , map);
			}
			//SELECT
			else if( String.valueOf( map.get("queryId") ).contains(".S_") ) {
				
				return cs.selectList( map.get("queryId").replace(".S_",".") , map);
			}
			//INSERT
			else if( String.valueOf( map.get("queryId") ).contains(".I_") ) {
				cs.insert( map.get("queryId").replace(".I_",".") , map);
				return "inserted";
			}
			//UPDATE
			else if( String.valueOf( map.get("queryId") ).contains(".U_") ) {
				cs.update( map.get("queryId").replace(".U_",".") , map);
				return "updated";
			}
			//DELETE
			else if( String.valueOf( map.get("queryId") ).contains(".D_") ) {
				
				cs.delete( map.get("queryId").replace(".D_",".") , map);
				return "deleted";
			}
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return "notFoundQuery";
	}
	

	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ModelAndView page(HttpServletRequest request){
		
		ModelAndView mav = new ModelAndView();
		
		try {
			
			Map<String, String> map = ComUtil.getParameterMap(request);
			Map rMap = cs.selectOne( "page" , map);
			mav.setViewName( String.valueOf(rMap.get("MENU_URL")) );
			
		}catch(Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return mav;
	}
	
}
