package com.gyu.portfolio.service.mapper;

import java.util.List;

import com.gyu.portfolio.model.UserVO;

public interface UserMapper {

	// 사용자 등록
	int addUser(UserVO userVO) throws Exception;

	// 사용자 수정
	int updateUser(UserVO userVO) throws Exception;

	// 사용자 권한정보 수정(관리자)
	int updateUserAdmin(UserVO userVO) throws Exception;

	// 사용자 목록
	List<UserVO> getUserList(UserVO userVO) throws Exception;

	// 사용자 목록 수
	int getUserListCnt(UserVO userVO) throws Exception;
	
	// 사용자 조회
	UserVO getUser(UserVO userVO) throws Exception;

	// 사용자 정보조회(비밀번호 제외)
	UserVO getUserInfo(UserVO userVO) throws Exception;
    
}
