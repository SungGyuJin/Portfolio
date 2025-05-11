package com.gyu.portfolio.controller;

import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
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
import com.gyu.portfolio.model.BoardVO;
import com.gyu.portfolio.service.BbsService;
import com.gyu.portfolio.service.BoardService;

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
		mav = new ModelAndView("admin/board/list");
		
		boardVO.setAmount(10);	// 페이지당 데이터 갯수

		// 게시판 목록(select option)
		List<BbsVO> getBbsList = bbsService.getSelectBbsList();
		
		// 게시물 목록
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap = boardService.getBoardList(boardVO);

		model.clear();
		model.addAttribute("getBoardList", resultMap.get("getBoardList"));
		model.addAttribute("getBbsList", getBbsList);
		model.addAttribute("pageMaker", resultMap.get("pageMaker"));
		model.addAttribute("total", resultMap.get("total"));
		model.addAttribute("boardVO", resultMap.get("boardVO"));
		
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
	    
	    boardVO.setBoardSeq(Integer.parseInt(request.getParameter("no")));
	    resultMap = boardService.getBoard(boardVO);
	    
		model.clear();
		model.addAttribute("resultMap", resultMap);
		
		return resultMap;
	}

	/* 게시물 등록화면 */
	@GetMapping("/addBoard.do")
	public ModelAndView addBoard(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		
		ModelAndView mav = null;
		mav = new ModelAndView("admin/board/add");
		
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
			HttpServletResponse response,
			HttpSession session) throws Exception{
		
		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /admin/board/updateBoard.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
		boardVO.setRegNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = boardService.addBoard(boardVO);
		
		if(result > 0) {
			if(boardVO.getRef() > 0) {
				String searchkeyword = URLEncoder.encode(boardVO.getSearchKeyword(), "UTF-8");
				return "redirect:list.do?pageNum="+boardVO.getPageNum()+"&listTyp="+request.getParameter("listTyp")+"&searchKeyword="+searchkeyword+"&gubun="+boardVO.getGubun()+"&bbsSeq="+boardVO.getBbsSeq();
			}else {
				return "redirect:list.do";
			}
		}else {
			return "error";
		}
	}

	/* 게시물 수정화면 */
	@GetMapping("/updateBoard.do")
	public ModelAndView updateBoard(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		
		ModelAndView mav = null;
		mav = new ModelAndView("admin/board/update");

		// 게시판 목록(select option)
		List<BbsVO> getBbsList = bbsService.getSelectBbsList();
		
		// 게시물 조회
		Map<String, Object> resultMap = new HashMap<>();
		resultMap = boardService.getBoard(boardVO);

		model.clear();
		model.addAttribute("getBoard", resultMap.get("getBoard"));
		model.addAttribute("getBbsList", getBbsList);
		model.addAttribute("boardVO", boardVO);

		return mav;
	}
	
	/* 게시물 수정처리(Ajax) */
	@PostMapping("/updateBoard.do")
	public String updateBoardPOST(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{
		
		boardVO.setUpdNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = boardService.updateBoard(boardVO);
		
		String searchkeyword = URLEncoder.encode(boardVO.getSearchKeyword(), "UTF-8");

		if(result > 0) {
			return "redirect:list.do?pageNum="+boardVO.getPageNum()+"&listTyp="+request.getParameter("listTyp")+"&searchKeyword="+searchkeyword+"&gubun="+boardVO.getGubun()+"&bbsSeq="+boardVO.getBbsSeq();
		}else {
			return "error";
		}
	}
	
	/* 게시물 수정화면 */
	@GetMapping("/replyBoard.do")
	public ModelAndView replyBoard(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		ModelAndView mav = null;
		mav = new ModelAndView("admin/board/reply");
		
		// 게시물 조회
		Map<String, Object> resultMap = new HashMap<>();
		resultMap = boardService.getBoard(boardVO);
		
		model.clear();
		model.addAttribute("getBoard", resultMap.get("getBoard"));
		model.addAttribute("boardVO", boardVO);

		return mav;
	}
	
	/* 게시물 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	@PostMapping("/changeStat.do")
	@ResponseBody
	public int changeStat(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		boardVO.setUpdNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = boardService.changeStat(boardVO);

		return result;
	}
	
}
