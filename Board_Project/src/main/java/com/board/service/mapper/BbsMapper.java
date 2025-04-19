package com.board.service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.model.BbsVO;

@Mapper
public interface BbsMapper {
	
	// 게시판 등록
	int addBbs(BbsVO bbsVO) throws Exception;

	// 게시판 수정
	int updateBbs(BbsVO bbsVO) throws Exception;

	// 게시판 목록
	List<BbsVO> getBbsList(BbsVO bbsVO) throws Exception;

	// 게시판 조회
	BbsVO getBbs(BbsVO bbsVO) throws Exception;

	/* 게시판 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	int changeStat(BbsVO bbsVO) throws Exception;

    /* 게시판 총 갯수 */
    public int getBbsListCnt(BbsVO bbsVO) throws Exception;

	// 게시물 Select Option
	List<BbsVO> getSelectBbsList() throws Exception;
	
}
