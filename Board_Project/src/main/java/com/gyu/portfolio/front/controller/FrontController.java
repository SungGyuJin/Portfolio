package com.gyu.portfolio.front.controller;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gyu.portfolio.model.BbsVO;
import com.gyu.portfolio.model.BoardVO;
import com.gyu.portfolio.service.BbsService;
import com.gyu.portfolio.service.BoardService;

@Controller
@RequestMapping(value="/")
public class FrontController {

	@Autowired
	private BbsService bbsService;
	
	@Autowired
	private BoardService boardService;
	
	
	@GetMapping(value={"/", "/main"})
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

	@GetMapping("/main.do/{id}")
	public ModelAndView mainList(ModelMap model,
			@PathVariable("id") int id,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/board/list.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */

		ModelAndView mav = null;
		
		// Portfolio :: 게시물 메인
		if(id == 1) {
			System.out.println("if 진입");
			mav = new ModelAndView("front/board/list");
		}
		
		
		return mav;
	}
	

	/* 게시물 목록 */
	@GetMapping("/main/getBoardList.do")
	@ResponseBody
	public Map<String, Object> getBoard(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /getBoardList.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */

		// 게시물 목록
	    Map<String, Object> resultMap = new HashMap<>();

//		boardVO.setAmount(10);	// 페이지당 데이터 갯수
	    resultMap = boardService.getBoardList(boardVO);

		return resultMap;
	}
	
	
}
