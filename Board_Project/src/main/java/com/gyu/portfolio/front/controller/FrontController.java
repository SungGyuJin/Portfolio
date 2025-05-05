package com.gyu.portfolio.front.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/")
public class FrontController {

	@GetMapping("/")
	public String redirectToMain() {
	    return "redirect:/main.do";
	}
	
	/* Front Main2  */
	@GetMapping(value="/main.do")
	public ModelAndView main(ModelMap model,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		ModelAndView mav = null;
		mav = new ModelAndView("front/main");
		
		return mav;
	}
}
