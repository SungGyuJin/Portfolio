package com.gyu.portfolio.service;


import com.gyu.portfolio.model.AttachVO;
import com.gyu.portfolio.model.UserVO;

public interface UserService {

	// 사용자 등록
	int addUser(UserVO userVO) throws Exception;

	// 사용자 수정
	int updateUser(UserVO userVO, AttachVO attachVO) throws Exception;

	// 사용자 조회
	UserVO getUser(UserVO userVO) throws Exception;

	// 사용자 정보조회(비밀번호 제외)
	UserVO getUserInfo(UserVO userVO) throws Exception;
	
}
