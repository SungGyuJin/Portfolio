package com.board.service.mapper;

import java.util.List;

import com.board.model.BoardVO;

public interface BoardMapper {

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
    
	/* update ref */
    void updateRef(BoardVO boardVO) throws Exception;
    
    
    
}
