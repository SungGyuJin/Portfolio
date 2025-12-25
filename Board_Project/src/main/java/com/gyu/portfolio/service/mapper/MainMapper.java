package com.gyu.portfolio.service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gyu.portfolio.model.MainVO;

@Mapper
public interface MainMapper {

	// 메인 등록
	int addMain(MainVO mainVO) throws Exception;

	// 메인 수정
	int updateMain(MainVO mainVO) throws Exception;
	
	// 메인 목록
	List<MainVO> getMain(MainVO mainVO) throws Exception;

	// 메인 삭제
	int deleteMain(MainVO mainVO) throws Exception;

	// 정렬순서 변경
	int updateMainSrtOrd(MainVO mainVO) throws Exception;

	// 정렬순서 변경
	int updateStat(MainVO mainVO) throws Exception;
	
}
