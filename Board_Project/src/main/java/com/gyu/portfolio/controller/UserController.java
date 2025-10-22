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

import com.gyu.portfolio.model.UserVO;
import com.gyu.portfolio.service.UserService;

@Controller
@RequestMapping(value="/admin/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	/* 사용자 목록 */
	@GetMapping("/list.do")
	public ModelAndView boardList(ModelMap model,
			@ModelAttribute("UserVO") UserVO userVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

		ModelAndView mav = null;
		mav = new ModelAndView("admin/board/list");
		
		userVO.setAmount(15);	// 페이지당 데이터 갯수

		// 회원 목록
	    Map<String, Object> resultMap = new HashMap<>();

		model.clear();
		
		return mav;
	}
	
	/* 사용자 조회 */
	@GetMapping("/getUser.do")
	@ResponseBody
	public Map<String, Object> getUser(ModelMap model,
			@ModelAttribute("UserVO") UserVO userVO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{

	    Map<String, Object> resultMap = new HashMap<>();
	    
		model.clear();
//		model.addAttribute("resultMap", resultMap);
		
		return resultMap;
	}
	
}
