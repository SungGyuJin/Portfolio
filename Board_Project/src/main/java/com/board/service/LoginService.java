package com.board.service;


import com.board.model.LoginVO;

public interface LoginService {

	// 계정 등록
	int addLogin(LoginVO loginVO) throws Exception;

	// 계정 수정
	int updateLogin(LoginVO loginVO) throws Exception;

	// 계정 조회
	LoginVO getLogin(LoginVO loginVO) throws Exception;
	
}
