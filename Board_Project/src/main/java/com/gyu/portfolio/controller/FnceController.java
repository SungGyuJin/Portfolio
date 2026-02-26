package com.gyu.portfolio.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gyu.portfolio.model.FnceVO;
import com.gyu.portfolio.service.FnceService;

/* ##################################################### */
/* ################## 게시판 Controller ################## */
/* ##################################################### */

@Controller
@RequestMapping(value="/admin/fnce")
public class FnceController {
	
	@Autowired
	private FnceService fnceService;
	
	/* 게시판 목록 */
	public ModelAndView getFnceList(ModelMap model,
			@ModelAttribute("FnceVO") FnceVO fnceVO,
			HttpServletRequest request,
			HttpSession session,
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /list.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
		ModelAndView mav = null;
		mav = new ModelAndView("admin/fnce/list");
		
		return mav;
	}
	
	@GetMapping("/getBbs.do")
	@ResponseBody
	public Map<String, Object> getFnce(ModelMap model,
			@ModelAttribute("FnceVO") FnceVO fnceVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		
	    Map<String, Object> resultMap = new HashMap<>();
	    
		
		return resultMap;
	}
	
	@PostMapping("/addFnce.do")
	@ResponseBody
	public int addBbs(ModelMap model,
			@ModelAttribute("FnceVO") FnceVO fnceVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{
		
		fnceVO.setRegNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = 0;
		
		return result;
	}
	
	@PostMapping("/updateBbs.do")
	@ResponseBody
	public int updateBbs(ModelMap model,
			@ModelAttribute("FnceVO") FnceVO fnceVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		fnceVO.setUpdNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = 0;

		return result;
	}
	
	/* 게시판 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	@PostMapping("/changeStat.do")
	@ResponseBody
	public int changeStat(ModelMap model,
			@ModelAttribute("FnceVO") FnceVO fnceVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		fnceVO.setUpdNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = 0;

		return result;
	}
	
}
