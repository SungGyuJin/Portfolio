package com.gyu.portfolio.service;

import java.util.List;
import java.util.Map;

import com.gyu.portfolio.model.AttachVO;
import com.gyu.portfolio.model.BbsVO;
import com.gyu.portfolio.model.BoardVO;

public interface BoardService {

	/* ########################################################################################################### */
	/* ################################################## Admin ################################################## */
	
	// 게시물 등록
	int addBoard(BoardVO boardVO, AttachVO attachVO) throws Exception;

	// 게시물 수정
	int updateBoard(BoardVO boardVO, AttachVO attachVO) throws Exception;

	// 게시물 목록
	Map<String, Object> getBoardList(BoardVO boardVO) throws Exception;
	
	// 게시물 조회
	Map<String, Object> getBoard(BoardVO boardVO) throws Exception;

	/* 게시물 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	int changeStat(BoardVO boardVO) throws Exception;

	// 정렬순서 변경
	int updateBoardRef(BoardVO boardVO) throws Exception;
	
	
	/* ########################################################################################################### */
	/* ################################################## Front ################################################## */

	// 게시물 목록
	Map<String, Object> getFrontBoardList(BoardVO boardVO) throws Exception;

	// 게시물 조회
	Map<String, Object> getFrontBoard(BoardVO boardVO) throws Exception;

	Map<String, Object> chkPwd(BoardVO boardVO) throws Exception;

}
