package com.gyu.portfolio.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Configuration
public class SessionInterceptor implements HandlerInterceptor {
	
	/* preHandle() — 컨트롤러 진입 전에 실행됨 (여기서 로그인 체크) */
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		response.setContentType("text/html.charset=UTF-8");

		try {	
			HttpSession session = request.getSession();
			String uri = request.getRequestURI();
			
			/* 세션 X */
			if(session.getAttribute("USERID") == null){

				// 로그인 안했지만 front는 허용
				if (uri.matches("^/main.*")) {
					return true;
				}

				System.out.println();
				System.out.println("2");
				System.out.println();
				
				// 그 외 로그인 페이지로 이동
				response.sendRedirect("/login.do");
//				response.sendRedirect("/main.do");
				return false;

			/* 세션 O */
			}else{
				
				if (uri.matches("^/logout\\.do$") || uri.matches("^/main.*")) {
					return true;
				}
				
				// 로그인 했지만, 사용자 계정일 경우 front로 return
				if(session.getAttribute("USERSE").toString().equals("U")) {
					response.sendRedirect("/main.do");
					return false;
				}else {
					return true;
				}
			}
			
		}catch(Exception e) {
            System.err.println("인터셉터 에러: " + e.getMessage());
			return false;
			
		}
	}

	/* postHandle() — 컨트롤러 실행 후, 뷰 렌더링 전에 실행됨 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* 뷰까지 렌더링 완료된 후 실행됨 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
	
}
