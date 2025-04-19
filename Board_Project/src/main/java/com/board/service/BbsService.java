package com.board.service;


import java.util.List;
import java.util.Map;

import com.board.model.BbsVO;

public interface BbsService {

	// 게시판 등록
	int addBbs(BbsVO bbsVO) throws Exception;

	// 게시판 수정
	int updateBbs(BbsVO bbsVO) throws Exception;

	// 게시판 목록
	List<BbsVO> getBbsList(BbsVO bbsVO) throws Exception;
	
	// 게시판 조회
	Map<String, Object> getBbs(BbsVO bbsVO) throws Exception;

	/* 게시판 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	int changeStat(BbsVO bbsVO) throws Exception;

    /* 게시판 총 갯수 */
    public int getBbsListCnt(BbsVO bbsVO) throws Exception;

	// 게시물 Select Option
	List<BbsVO> getSelectBbsList() throws Exception;
	
}
