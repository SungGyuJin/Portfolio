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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gyu.portfolio.model.LoginVO;
import com.gyu.portfolio.service.LoginService;

@Controller
//@RequestMapping(value="/account")
public class LoginController {

	@Autowired
	private LoginService loginService;
	
	/* 로그인 화면 */
	@GetMapping(value="/login.do")
	public ModelAndView loginView(ModelMap model,
			HttpServletRequest request,
			HttpServletResponse response 
			) throws Exception{
		
		ModelAndView mav = null;
		mav = new ModelAndView("account/login");
		
		
		return mav;
	}

	/* 로그인 처리 */
	@PostMapping(value="/login.do")
	public ModelAndView getLogin(ModelMap model,
			@ModelAttribute("LoginVO") LoginVO loginVO,
			HttpServletRequest request,
			HttpServletResponse response 
			) throws Exception{
		
		ModelAndView mav = null;
		mav = new ModelAndView("/admin/main");
		
		LoginVO vo = null;
		vo = loginService.getLogin(loginVO);
		
		if(vo == null) {
			mav.setViewName("account/login_error");
			mav.addObject("errorMsg", "아이디가 존재하지 않습니다.");
			mav.addObject("errorMsgEng", "The ID does not exist.");
		}else {
			if(!vo.getUserPwd().toString().equals(vo.getInputPwd())) {
				mav.setViewName("account/login_error");
				mav.addObject("errorMsg", "비밀번호가 일치하지 않습니다.");
				mav.addObject("errorMsgEng", "Password does not match.");
			}else {

				System.out.println("else");
				
//				if(vo.getUserSe().equals("A")) {
//					System.out.println("AAA");
//					processLogin(request, vo);
//					response.sendRedirect("/main.do");
//				}else {
//					System.out.println("UUU");
//					mav.addObject("loginChk", request.getParameter("loginChk"));
//					mav.addObject("errorCode", "0000");
//					processLogin(request, vo);
//					response.sendRedirect("/main.do");
//				}
				

//				mav.addObject("loginChk", request.getParameter("loginChk"));
//				mav.addObject("errorCode", "0000");
				processLogin(request, vo);
				response.sendRedirect("/main.do");
				
				
			}
		}
		
		return mav;
	}
	

	private void processLogin(HttpServletRequest request, LoginVO rs){
		HttpSession session = request.getSession();
		
		session.setAttribute("USERSEQ", rs.getUserSeq());
		session.setAttribute("USERID", rs.getUserId());
		session.setAttribute("USERNM", rs.getUserNm());
		session.setAttribute("USERSE", rs.getUserSe());
		
//		if(rs.getUserSe().equals("U")) {
			session.setAttribute("loginChk", request.getParameter("loginChk"));
			session.setAttribute("errorCode", "0000");
//		}
		
	}
	
	@GetMapping(value="/logout.do")
	public String logout(ModelMap model,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception{
		
		String returnVal = "redirect:login.do";
		
		if(session.getAttribute("USERSE").equals("A") || session.getAttribute("USERSE").equals("U")) {
			returnVal = "redirect:/main.do";
		}
		
		session.removeAttribute("USERSEQ");
		session.removeAttribute("USERID");
		session.removeAttribute("USERNM");
		session.removeAttribute("USERSE");
		session.removeAttribute("loginChk");
		session.removeAttribute("errorCode");
		
		session.invalidate();
		
		return returnVal;
	}
	

	/* 계정생성 화면 */
	@GetMapping(value="/create.do")
	public ModelAndView createView(ModelMap model,
			HttpServletRequest request,
			HttpServletResponse response 
			) throws Exception{
		
		ModelAndView mav = null;
		mav = new ModelAndView("account/create");
		
		
		return mav;
	}


	/* 계정 등록처리 */
	@PostMapping("/create.do")
	public String create(ModelMap model,
			@ModelAttribute("LoginVO") LoginVO loginVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		int result = 0;
		result = loginService.addLogin(loginVO);
		
		if(result > 0) {
			return "redirect:login.do";
		}else {
			return "error";
		}
		
	}
	

	/* 관리자 승인번호 체크 조회 */
	@GetMapping("/aprvChk.do")
	@ResponseBody
	public Map<String, Object> aprvChk(ModelMap model,
			@RequestParam("aprvNum") String num,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		
		int result = 0;
		
		if(num.equals("1111")) {
			result = 1;
		}

	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("result", result);
		
		model.clear();
		model.addAttribute("resultMap", resultMap);
		
		return resultMap;
	}
	
}
