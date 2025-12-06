package com.gyu.portfolio.service.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gyu.portfolio.model.MainVO;

@Mapper
public interface MainMapper {

	// 메인 등록
	int addMain(MainVO mainVO) throws Exception;

	// 메인 수정
	int updateBbs(MainVO mainVO) throws Exception;

	// 메인 목록
	Map<String, Object> getBbsList(MainVO mainVO) throws Exception;
	
	// 메인 조회
	Map<String, Object> getBbs(MainVO mainVO) throws Exception;
    
}
