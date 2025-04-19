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
import com.board.model.BoardVO;
import com.board.service.BbsService;
import com.board.service.BoardService;
import com.page.obj.PageMakerDTO;

/* ##################################################### */
/* ################## 게시물 Controller ################## */
/* ##################################################### */

@Controller
@RequestMapping(value="/admin/board")
public class BoardController {

	@Autowired
	private BbsService bbsService;
	
	@Autowired
	private BoardService boardService;
	
	/* 게시물 목록 */
	@GetMapping("/list.do")
	public ModelAndView boardList(ModelMap model,
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
		mav = new ModelAndView("/admin/board/list");
		
		boardVO.setAmount(5);	// 페이지당 데이터 갯수

		// 게시물 목록
		List<BoardVO> getBoardList = new ArrayList<>();
		getBoardList = boardService.getBoardList(boardVO);
		
		
		// 페이징 처리
		int total = boardService.getBoardListCnt(boardVO);
		PageMakerDTO pageMaker = new PageMakerDTO(boardVO, total);

		model.clear();
		model.addAttribute("getBoardList", getBoardList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("boardVO", boardVO);

		return mav;
	}
	
	/* 게시물 조회 */
	@GetMapping("/getBoard.do")
	@ResponseBody
	public Map<String, Object> getBoard(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

	    Map<String, Object> resultMap = new HashMap<>();
	    
	    /* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/board/getBoard.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
	    
	    boardVO.setBoardSeq(Integer.parseInt(request.getParameter("no")));
	    resultMap = boardService.getBoard(boardVO);
	    
		model.clear();
		model.addAttribute("resultMap", resultMap);
		
		return resultMap;
	}

	/* 게시물 등록화면 */
	@GetMapping("/addBoard.do")
	public ModelAndView addBoardGET(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/board/addBoardGET.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
		ModelAndView mav = null;
		mav = new ModelAndView("/admin/board/add");
		
		// 게시판 목록(select option)
		List<BbsVO> getBbsList = bbsService.getSelectBbsList();
		

		model.clear();
		model.addAttribute("getBbsList", getBbsList);

		return mav;
	}
	
	/* 게시물 등록처리(Ajax) */
	@PostMapping("/addBoard.do")
	public String addBoardPOST(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/board/addBoardPOST.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
		int result = 0;
		result = boardService.addBoard(boardVO);
		
		if(result > 0) {
			return "redirect:list.do";
		}else {
			return "error";
		}
		
	}
	
	/* 게시물 수정처리(Ajax) */
	@PostMapping("/updateBoard.do")
	@ResponseBody
	public int updateBoard(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/board/addBoard.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */

		int result = 0;
		result = boardService.updateBoard(boardVO);

		return result;
	}
	
	/* 게시물 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	@PostMapping("/changeStat.do")
	@ResponseBody
	public int changeStat(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/board/changeStat.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
		int result = 0;
		result = boardService.changeStat(boardVO);

		return result;
	}
	
}
