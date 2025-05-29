package com.gyu.portfolio.service.mapper;

import java.util.List;
import java.util.Map;

import com.gyu.portfolio.model.BoardVO;

public interface BoardMapper {

	/* ########################################################################################################### */
	/* ################################################## Admin ################################################## */
	
	// 게시물 등록
	int addBoard(BoardVO boardVO) throws Exception;

	// 게시물 목록
	List<BoardVO> getBoardList(BoardVO boardVO) throws Exception;

	// 게시물 조회
	BoardVO getBoard(BoardVO boardVO) throws Exception;

	// 게시물 수정
	int updateBoard(BoardVO boardVO) throws Exception;

	/* 게시물 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	int changeStat(BoardVO boardVO) throws Exception;
    
    /* 게시물 총 갯수 */
    int getBoardListCnt(BoardVO boardVO) throws Exception;

    /* 게시물 총 갯수(원글) */
    int getBoardListOriCnt(BoardVO boardVO) throws Exception;
    
	/* update ref */
    void updateRef(BoardVO boardVO) throws Exception;

	/* update step */
	void updateStep(BoardVO boardVO) throws Exception;

	/* update step */
	void updateOldStep(BoardVO boardVO) throws Exception;

	/* update step2 */
	int getMaxStep(BoardVO boardVO) throws Exception;
	

	/* ########################################################################################################### */
	/* ################################################## Front ################################################## */

	// 게시물 목록
	List<BoardVO> getFrontBoardList(BoardVO boardVO) throws Exception;
	
    /* 게시물 총 갯수 */
    int getFrontBoardListCnt(BoardVO boardVO) throws Exception;

	// 게시물 조회
	BoardVO getFrontBoard(BoardVO boardVO) throws Exception;
	
	// 조회수 카운트
	int updateReadCnt(BoardVO boardVO) throws Exception;
	
	BoardVO chkPwd(BoardVO boardVO) throws Exception;
    
}
