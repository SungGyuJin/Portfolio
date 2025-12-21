package com.gyu.portfolio.front.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gyu.portfolio.model.AttachVO;
import com.gyu.portfolio.model.BbsVO;
import com.gyu.portfolio.model.BoardVO;
import com.gyu.portfolio.model.CmntVO;
import com.gyu.portfolio.model.MainVO;
import com.gyu.portfolio.model.UserVO;
import com.gyu.portfolio.service.AttachService;
import com.gyu.portfolio.service.BbsService;
import com.gyu.portfolio.service.BoardService;
import com.gyu.portfolio.service.CmntService;
import com.gyu.portfolio.service.MainService;
import com.gyu.portfolio.service.UserService;

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

	@Autowired
	private UserService userService;

	@Autowired
	private MainService mainService;
	
	
	@GetMapping(value={"/", "/main"})
	public String redirectToMain() {
	    return "redirect:/main.do";
	}
	
	@GetMapping(value="/main.do")
	public ModelAndView main(ModelMap model,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session
			) throws Exception{

		/* request 정보확인 START */
		System.out.println();
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println("============ /main.do INFO  ===========");
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name= (String) params.nextElement();
			System.out.println(name + ": " + request.getParameter(name));
		}
		System.out.println("++++++++++++++++++++++++++++++");
		System.out.println();
		/* request 정보확인 END */

		ModelAndView mav = null;
		mav = new ModelAndView("front/main");
	
		String msg = (String) session.getAttribute("loginMsg");
		
		if (msg != null) {
		    mav.addObject("loginMsg", msg);
		    session.removeAttribute("loginMsg");
		    session.removeAttribute("loginNum");
		}
		
		List<BbsVO> getBbsList = bbsService.getSelectBbsList();;

		MainVO mainVO = new MainVO();
		mainVO.setMainSe("B");
		Map<String, Object> getBanner =  mainService.getMainList(mainVO);;

		mav.addObject("getBbsList", getBbsList);
		mav.addObject("getBanner", getBanner.get("getBanner"));
		mav.addObject("getTechList", getBanner.get("getTechList"));
		
		return mav;
	}

	/* 게시물 목록 */
	@GetMapping("/main/getBoardList.do")
	@ResponseBody
	public Map<String, Object> getBoardList(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpSession session,
			HttpServletResponse response) throws Exception{
		
		// 게시물 목록
	    Map<String, Object> resultMap = new HashMap<>();

	    if(session.getAttribute("USERSEQ") != null) {
	    	boardVO.setRegNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
	    }

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
		
		boardVO.setRegNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = boardService.addBoard(boardVO, attachVO);
		
		return result;
	}

	/* 게시물 수정처리 */
	@PostMapping("/main/updateBoard.do")
	@ResponseBody
	public int updateBoard(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			@ModelAttribute("AttachVO") AttachVO attachVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		boardVO.setUpdNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
		int result = boardService.updateBoard(boardVO, attachVO);
		
		return result;
	}

	/* 게시물 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	@PostMapping("/main/changeStat.do")
	@ResponseBody
	public int changeStat(ModelMap model,
			@ModelAttribute("BoardVO") BoardVO boardVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{

		boardVO.setUpdNo(Integer.parseInt(session.getAttribute("USERSEQ").toString()));
//		boardVO.setBoardSeq(Integer.parseInt(request.getParameter("no")));
		boardVO.setStat(Integer.parseInt(request.getParameter("num")));
		int result = boardService.changeStat(boardVO);

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
		
	    Map<String, Object> resultMap = new HashMap<>();
	    boardVO.setBoardSeq(Integer.parseInt(request.getParameter("no")));
	    boardVO.setPwd(request.getParameter("pw"));
	    resultMap = boardService.chkPwd(boardVO);
	    
		model.clear();
		model.addAttribute("resultMap", resultMap);
		
		return resultMap;
	}
	
	/* 파일 업로드 */
	@PostMapping("/main/upload.do")
	@ResponseBody
	public Map<String, Object> upload(ModelMap model,
			@ModelAttribute("AttachVO") AttachVO attachVO,
			HttpServletRequest request,
			HttpServletResponse response
			) throws Exception{

		Map<String, Object> resultMap = new HashMap<>();
		List<Object> resultList = new ArrayList<>();
		
		for(MultipartFile file : attachVO.getFiles()) {

	        String fileOrgNm = file.getOriginalFilename();	// 파일명(원본)
	        String fileSvgNm = "";							// 파일명(저장명)
	        String fileExt   = "";							// 확장자
	        String filePath  = ROOT_PATH+UPLOAD_PATH;		// 경로
	        long   fileSz    = file.getSize();				// 크기
	        
	        int dotIdx = fileOrgNm.lastIndexOf('.');
	        if (dotIdx > 0) {
	            fileExt = fileOrgNm.substring(dotIdx);
	        }

	        String uuid = UUID.randomUUID().toString();
	        fileSvgNm = uuid + fileExt;
	        
	        File destFile = new File(filePath, fileSvgNm);
	        file.transferTo(destFile);

			Map<String, Object> tempMap = new HashMap<>();
	        
			tempMap.put("fileOrgNm", fileOrgNm);
			tempMap.put("fileSvgNm", fileSvgNm);
			tempMap.put("fileExt",   fileExt);
			tempMap.put("filePath",  filePath);
			tempMap.put("fileSz",    fileSz);
	        
	        resultList.add(tempMap);
	    }

		resultMap.put("fileList", resultList);

		return resultMap;
	}
	
	@GetMapping("/main/fileDownload")
	public void fileDownload(ModelMap model,
			@ModelAttribute("AttachVO") AttachVO attachVO,
			HttpServletRequest request,
			HttpServletResponse response
			) throws Exception {
		
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
	
	/* 게시판 조회 */
	@GetMapping("/main/getBbs.do")
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
	
	/* 유저정보 조회 */
	@GetMapping("/main/getUserInfo.do")
	@ResponseBody
	public Map<String, Object> getUserInfo(ModelMap model,
			@ModelAttribute("UserVO") UserVO userVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    userVO.setUserSeq(Integer.parseInt(request.getParameter("no")));
	    resultMap.put("uInfo", userService.getUserInfo(userVO));
	    
		model.clear();
		model.addAttribute("uInfo", resultMap);
		
		return resultMap;
	}
	
	/* 사용자 정보(비밀번호) 수정처리 */
	@PostMapping("/main/updateUser.do")
	@ResponseBody
	public int updateUser(ModelMap model,
			@ModelAttribute("UserVO") UserVO userVO,
			@ModelAttribute("AttachVO") AttachVO attachVO,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{
		
		session.setAttribute("USERNM", userVO.getUserNm());
		
		int result = userService.updateUser(userVO, attachVO);
		
		return result;
	}
	

	/* 사용자 탈퇴신청 비밀번호 CHK */
	@PostMapping("/main/pwChkUser.do")
	@ResponseBody
	public Map<String, Object> aprvChkUser(ModelMap model,
			@ModelAttribute("UserVO") UserVO userVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

	    Map<String, Object> resultMap = new HashMap<>();
	    userVO.setUserSeq(Integer.parseInt(request.getParameter("no")));
	    userVO.setUserPwd(request.getParameter("pw"));
	    resultMap = userService.chkPwdUser(userVO);
	    
		model.clear();
		model.addAttribute("resultMap", resultMap);
		
		return resultMap;
	}
	
}
