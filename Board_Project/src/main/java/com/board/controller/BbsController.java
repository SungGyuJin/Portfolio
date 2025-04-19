package com.board.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.board.model.BbsVO;
import com.board.service.BbsService;
import com.page.obj.PageMakerDTO;

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
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/bbs/list.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
		ModelAndView mav = null;
		mav = new ModelAndView("/admin/bbs/list");
		
		bbsVO.setAmount(5);	// 페이지당 데이터 갯수

		// 게시판 목록
		List<BbsVO> getBbsList = new ArrayList<>();
		getBbsList = bbsService.getBbsList(bbsVO);
		
		
		// 페이징 처리
		int total = bbsService.getBbsListCnt(bbsVO);
		PageMakerDTO pageMaker = new PageMakerDTO(bbsVO, total);

		model.clear();
		model.addAttribute("getBbsList", getBbsList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("bbsVO", bbsVO);
		model.addAttribute("total", total);

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
	    
	    /* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/getBbs.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
	    
	    bbsVO.setBbsSeq(Integer.parseInt(request.getParameter("no")));
	    resultMap = bbsService.getBbs(bbsVO);
	    
		model.clear();
		model.addAttribute("resultMap", resultMap);
		
		return resultMap;
	}
	
	/* 게시판 등록처리(Ajax) */
	@PostMapping("/addBbs.do")
	@ResponseBody
	public int addBbs(ModelMap model,
			@ModelAttribute("BbsVO") BbsVO bbsVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/addBbs.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
		int result = 0;
		result = bbsService.addBbs(bbsVO);
		
		return result;
	}
	
	/* 게시판 수정처리(Ajax) */
	@PostMapping("/updateBbs.do")
	@ResponseBody
	public int updateBbs(ModelMap model,
			@ModelAttribute("BbsVO") BbsVO bbsVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/bbs/updateBbs.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */

		int result = 0;
		result = bbsService.updateBbs(bbsVO);

		return result;
	}
	
	/* 게시판 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	@PostMapping("/changeStat.do")
	@ResponseBody
	public int changeStat(ModelMap model,
			@ModelAttribute("BbsVO") BbsVO bbsVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/bbs/changeStat.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
		int result = 0;
		result = bbsService.changeStat(bbsVO);

		return result;
	}
	
}
