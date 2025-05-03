package com.gyu.portfolio.service.mapper;

import com.gyu.portfolio.model.LoginVO;

public interface LoginMapper {

	// 계정 등록
	int addLogin(LoginVO loginVO) throws Exception;

	// 계정 수정
	int updateLogin(LoginVO loginVO) throws Exception;

	// 계정 조회
	LoginVO getLogin(LoginVO loginVO) throws Exception;
    
}
