package com.gyu.portfolio.service.mapper;

import com.gyu.portfolio.model.LoginVO;

public interface LoginMapper {

	// 계정 등록
	int addLogin(LoginVO loginVO) throws Exception;

	// 계정 수정
	int updateLogin(LoginVO loginVO) throws Exception;

	// 계정 조회
	LoginVO getLogin(LoginVO loginVO) throws Exception;

	// 유저 정보조회(비밀번호 제외)
	LoginVO getUserInfo(LoginVO loginVO) throws Exception;
    
}
