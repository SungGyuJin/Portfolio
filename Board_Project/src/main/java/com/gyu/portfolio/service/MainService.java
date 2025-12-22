package com.gyu.portfolio.service;


import java.util.Map;

import com.gyu.portfolio.model.MainVO;

public interface MainService {

	// 메인 등록
	int addMain(MainVO mainVO) throws Exception;

	// 메인 수정
	int updateMain(MainVO mainVO) throws Exception;

	// 메인 목록
	Map<String, Object> getMainList(MainVO mainVO) throws Exception;

	// 정렬순서 변경
	int updateMainSrtOrd(MainVO mainVO) throws Exception;
}
