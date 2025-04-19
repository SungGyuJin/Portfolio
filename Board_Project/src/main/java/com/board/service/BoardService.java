package com.board.service;

import java.util.List;
import java.util.Map;

import com.board.model.BoardVO;

public interface BoardService {

	// 게시물 등록
	int addBoard(BoardVO boardVO) throws Exception;

	// 게시물 수정
	int updateBoard(BoardVO boardVO) throws Exception;

	// 게시물 목록
	List<BoardVO> getBoardList(BoardVO boardVO) throws Exception;
	
	// 게시물 조회
	Map<String, Object> getBoard(BoardVO boardVO) throws Exception;

	/* 게시물 상태변경(복구, 삭제, 영구삭제)(Ajax) */
	int changeStat(BoardVO boardVO) throws Exception;

    /* 게시물 총 갯수 */
    int getBoardListCnt(BoardVO boardVO) throws Exception;
	
}
