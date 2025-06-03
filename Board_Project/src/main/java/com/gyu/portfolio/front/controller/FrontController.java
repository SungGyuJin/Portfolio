package com.gyu.portfolio.front.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gyu.portfolio.model.AttachVO;
import com.gyu.portfolio.model.BbsVO;
import com.gyu.portfolio.model.BoardVO;
import com.gyu.portfolio.model.CmntVO;
import com.gyu.portfolio.service.AttachService;
import com.gyu.portfolio.service.BbsService;
import com.gyu.portfolio.service.BoardService;
import com.gyu.portfolio.service.CmntService;

@Controller
@PropertySource("classpath:/common.properties")
@RequestMapping(value="/")
public class FrontController {

	@Value("${Root.Path}")
	String ROOT_PATH;

	@Value("${Upload.Path}")
	String UPLOAD_PATH;
	
	@Autowired
	private AttachService attachService;
	
	@Autowired
	private BbsService bbsService;
	
	@Autowired
	private BoardService boardService;

	@Autowired
	private CmntService cmntService;
	
	
	@GetMapping(value={"/", "/main"})
	public String redirectToMain() {
	    return "redirect:/main.do";
	}
	
	@GetMapping(value="/main.do")
	public ModelAndView main(ModelMap model,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		ModelAndView mav = null;
		mav = new ModelAndView("front/main");
		
		List<BbsVO> getBbsList = null;
		getBbsList = bbsService.getSelectBbsList();
		
		model.clear();
		model.addAttribute("getBbsList", getBbsList);
		
		return mav;
	}

	/* 게시물 목록 */
	@GetMapping("/main/getBoardList.do")
	@ResponseBody
	public Map<String, Object> getBoardList(ModelMap model,
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
	    boardVO.setListTyp("list");
	    resultMap = boardService.getFrontBoardList(boardVO);

		return resultMap;
	}

	/* 게시물 조회 */
	@GetMapping("/main/getBoard.do")
	@ResponseBody
	public Map<String, Object> getBoard(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /getBoard.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    boardVO.setBoardSeq(Integer.parseInt(request.getParameter("no")));
	    resultMap = boardService.getFrontBoard(boardVO);
	    
		model.clear();
		model.addAttribute("resultMap", resultMap);
		
		return resultMap;
	}
	
	/* 게시물 등록처리 */
	@PostMapping("/main/addBoard.do")
	@ResponseBody
	public int addBoard(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			@ModelAttribute("AttachVO") AttachVO attachVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /addBoard.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */

		boardVO.setRegNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = boardService.addBoard(boardVO, attachVO);
		
		return result;
	}

	// #############################################################################################################
	// ################################################## Comment ##################################################
	
	/* 댓글 등록처리 */
	@PostMapping("/main/addCmnt.do")
	@ResponseBody
	public int addCmnt(ModelMap model,
			@ModelAttribute("CmntVO") CmntVO cmntVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /addCmnt.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */

		cmntVO.setRegNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = cmntService.addCmnt(cmntVO);
		
		return result;
	}
	
	/* 댓글 수정처리 */
	@PostMapping("/main/updateCmnt.do")
	@ResponseBody
	public int updateCmnt(ModelMap model,
			@ModelAttribute("CmntVO") CmntVO cmntVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /addCmnt.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */

		cmntVO.setRegNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = cmntService.updateCmnt(cmntVO);
		
		return result;
	}
	

	/* 댓글 목록 */
	@GetMapping("/main/getCmntList.do")
	@ResponseBody
	public Map<String, Object> getCmntList(ModelMap model,
			@ModelAttribute("CmntVO") CmntVO cmntVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /getCmntList.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */

	    Map<String, Object> resultMap = new HashMap<>();
	    
	    cmntVO.setBoardSeq(Integer.parseInt(request.getParameter("no")));
	    resultMap = cmntService.getCmntList(cmntVO);
		
		return resultMap;
	}

	/* 댓글 조회 */
	@GetMapping("/main/getCmnt.do")
	@ResponseBody
	public Map<String, Object> getCmnt(ModelMap model,
			@ModelAttribute("CmntVO") CmntVO cmntVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /getCmnt.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */

	    Map<String, Object> resultMap = new HashMap<>();
	    
	    cmntVO.setCmntSeq(Integer.parseInt(request.getParameter("no")));
	    resultMap = cmntService.getCmnt(cmntVO);
		
		return resultMap;
	}
	

	/* 댓글 삭제처리 */
	@PostMapping("/main/deleteCmnt.do")
	@ResponseBody
	public int deleteCmnt(ModelMap model,
			@ModelAttribute("CmntVO") CmntVO cmntVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /deleteCmnt.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */

		cmntVO.setCmntSeq(Integer.parseInt(request.getParameter("no")));
		cmntVO.setUpdNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = cmntService.deleteCmnt(cmntVO);
		
		return result;
	}
	
	
	/* 비밀글 Pwd 체크 */
	@PostMapping("/main/pwChk.do")
	@ResponseBody
	public Map<String, Object> aprvChk(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		
		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /pwChk.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
	    Map<String, Object> resultMap = new HashMap<>();
	    boardVO.setBoardSeq(Integer.parseInt(request.getParameter("no")));
	    boardVO.setPwd(request.getParameter("pw"));
	    resultMap = boardService.chkPwd(boardVO);
	    
		model.clear();
		model.addAttribute("resultMap", resultMap);
		
		return resultMap;
	}
	
	@GetMapping("/main/fileDownload")
	public void fileDownload(ModelMap model,
			@ModelAttribute("AttachVO") AttachVO attachVO,
			HttpServletRequest request,
			HttpServletResponse response
			) throws Exception {
		

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /fileDownload.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */
		
		AttachVO getAttach = null;
		attachVO.setAttachSeq(Integer.parseInt(request.getParameter("no")));
		getAttach = attachService.getAttach(attachVO);

		String orgFileNm = getAttach.getFileNm();
		String svgFileNm = getAttach.getStrgFileNm();

        // upload되어 있는 파일 위치
        File file = new File(ROOT_PATH+UPLOAD_PATH + File.separator + svgFileNm);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일이 존재하지 않습니다");
            return;
        }

        String mimeType = URLConnection.guessContentTypeFromName(file.getName());
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }

        response.setContentType(mimeType);
        response.setHeader("Content-Disposition",
                "attachment; filename=\"" + URLEncoder.encode(orgFileNm, "UTF-8") + "\"");

        try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
             BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())) {

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }

            out.flush();
        }
	}
	
}
