package com.gyu.portfolio.service;


import java.util.List;
import java.util.Map;

import com.gyu.portfolio.model.BbsVO;

public interface BbsService {

	// 게시판 등록
	int addBbs(BbsVO bbsVO) throws Exception;

	// 게시판 수정
	int updateBbs(BbsVO bbsVO) throws Exception;

	// 게시판 목록
	Map<String, Object> getBbsList(BbsVO bbsVO) throws Exception;
	
	// 게시판 조회
	Map<String, Object> getBbs(BbsVO bbsVO) throws Exception;

	/* 게시판 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	int changeStat(BbsVO bbsVO) throws Exception;

	// 게시물 Select Option
	List<BbsVO> getSelectBbsList() throws Exception;
	
}
