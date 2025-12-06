package com.gyu.portfolio.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gyu.portfolio.model.BbsVO;
import com.gyu.portfolio.model.MainVO;
import com.gyu.portfolio.service.MainService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value="/admin/main")
public class MainController {
	
	@Autowired
	private MainService mainService;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model) {

//		System.out.println("++++++++++++++++++++++++++++");
//		System.out.println("++++++ MainController ++++++");
//		System.out.println("++++++++++++++++++++++++++++");
		
		ModelAndView mav = null;
		mav = new ModelAndView("admin/main");
		
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		
		model.addAttribute("serverTime", formattedDate );
		
		return mav;
	}
	
	/* 메인 (배너, Tech Stack, Portfolio)*/
	@GetMapping("/list.do")
	public ModelAndView bbsList(ModelMap model,
			@ModelAttribute("BbsVO") BbsVO bbsVO,
			HttpServletRequest request,
			HttpSession session,
			HttpServletResponse response) throws Exception{

		System.out.println("++++++++++++++++++++++++++++");
		System.out.println("++++++ MainController ++++++");
		System.out.println("++++++++++++++++++++++++++++");
		
		ModelAndView mav = null;
		mav = new ModelAndView("admin/main/list");
		
//		bbsVO.setAmount(5);	// 페이지당 데이터 갯수

		// 게시판 목록
	    Map<String, Object> resultMap = new HashMap<>();
//	    resultMap = bbsService.getBbsList(bbsVO);

		model.clear();
//		model.addAttribute("getBbsList", resultMap.get("getBbsList"));
//		model.addAttribute("pageMaker", resultMap.get("pageMaker"));
//		model.addAttribute("total", resultMap.get("total"));
//		model.addAttribute("bbsVO", resultMap.get("bbsVO"));

		return mav;
	}

	/* 메인(Banner, Tech, Portfolio) 등록처리(Ajax) */
	@PostMapping("/addMain.do")
	@ResponseBody
	public int addMain(ModelMap model,
			@ModelAttribute("MainVO") MainVO mainVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{
		
		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /addMain.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
		mainVO.setRegNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = mainService.addMain(mainVO);
		
		return result;
	}
	
	
}
