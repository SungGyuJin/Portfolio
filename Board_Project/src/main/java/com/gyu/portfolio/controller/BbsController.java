package com.gyu.portfolio.controller;

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

import com.gyu.portfolio.model.BbsVO;
import com.gyu.portfolio.service.BbsService;

/* ##################################################### */
/* ################## 게시판 Controller ################## */
/* ##################################################### */

@Controller
@RequestMapping(value="/admin/bbs")
public class BbsController {
	
	@Autowired
	private BbsService bbsService;
	
	/* 게시판 목록 */
	@GetMapping("/list.do")
	public ModelAndView bbsList(ModelMap model,
			@ModelAttribute("BbsVO") BbsVO bbsVO,
			HttpServletRequest request,
			HttpSession session,
			HttpServletResponse response) throws Exception{
		
		ModelAndView mav = null;
		mav = new ModelAndView("admin/bbs/list");
		
//		bbsVO.setAmount(5);	// 페이지당 데이터 갯수

		// 게시판 목록
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap = bbsService.getBbsList(bbsVO);

		model.clear();
		model.addAttribute("getBbsList", resultMap.get("getBbsList"));
		model.addAttribute("pageMaker", resultMap.get("pageMaker"));
		model.addAttribute("total", resultMap.get("total"));
		model.addAttribute("bbsVO", resultMap.get("bbsVO"));

		return mav;
	}
	
	/* 게시판 조회 */
	@GetMapping("/getBbs.do")
	@ResponseBody
	public Map<String, Object> getBbs(ModelMap model,
			@ModelAttribute("BbsVO") BbsVO bbsVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    bbsVO.setBbsSeq(Integer.parseInt(request.getParameter("no")));
	    resultMap = bbsService.getBbs(bbsVO);
	    
		model.clear();
		model.addAttribute("getBbs", resultMap);
		
		return resultMap;
	}
	
	/* 게시판 등록처리(Ajax) */
	@PostMapping("/addBbs.do")
	@ResponseBody
	public int addBbs(ModelMap model,
			@ModelAttribute("BbsVO") BbsVO bbsVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{
		
		bbsVO.setRegNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = bbsService.addBbs(bbsVO);
		
		return result;
	}
	
	/* 게시판 수정처리(Ajax) */
	@PostMapping("/updateBbs.do")
	@ResponseBody
	public int updateBbs(ModelMap model,
			@ModelAttribute("BbsVO") BbsVO bbsVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		bbsVO.setUpdNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = bbsService.updateBbs(bbsVO);

		return result;
	}
	
	/* 게시판 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	@PostMapping("/changeStat.do")
	@ResponseBody
	public int changeStat(ModelMap model,
			@ModelAttribute("BbsVO") BbsVO bbsVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		bbsVO.setUpdNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = bbsService.changeStat(bbsVO);

		return result;
	}

	/* 게시판 순서변경 */
	@GetMapping("/updateBbsSrtOrd.do")
	@ResponseBody
	public int updateBbsSrtOrd(ModelMap model,
			@ModelAttribute("BbsVO") BbsVO bbsVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{
		
		bbsVO.setUpdNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = bbsService.updateBbsSrtOrd(bbsVO);

		return result;
	}
	
}
