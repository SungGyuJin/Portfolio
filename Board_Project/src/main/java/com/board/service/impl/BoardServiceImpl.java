package com.board.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.model.BbsVO;
import com.board.model.BoardVO;
import com.board.service.BoardService;
import com.board.service.mapper.BoardMapper;
import com.page.obj.PageMakerDTO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;
	
	@Override
	public int addBoard(BoardVO boardVO) throws Exception {
		
		int result = 0;
		result = boardMapper.addBoard(boardVO);

		boardMapper.updateRef(boardVO);
		
		return result;
	}

	@Override
	public int updateBoard(BoardVO boardVO) throws Exception {
		
		int result = 0;
		result = boardMapper.updateBoard(boardVO);
		
		return result;
	}

	@Override
	public Map<String, Object> getBoardList(BoardVO boardVO) throws Exception {
		
	    Map<String, Object> resultMap = new HashMap<>();

		// 게시물 목록
		List<BoardVO> getBoardList = new ArrayList<>();
		getBoardList = boardMapper.getBoardList(boardVO);

		// 페이징 처리
		int totalCnt = boardMapper.getBoardListCnt(boardVO);
		PageMakerDTO pageMaker = new PageMakerDTO(boardVO, totalCnt);

		resultMap.put("getBoardList", getBoardList);
		resultMap.put("pageMaker", pageMaker);
		resultMap.put("total", totalCnt);
		resultMap.put("boardVO", boardVO);
	    
		return resultMap;
	}

	@Override
	public Map<String, Object> getBoard(BoardVO boardVO) throws Exception {

	    Map<String, Object> resultMap = new HashMap<>();
	    
	    BoardVO getBoard = boardMapper.getBoard(boardVO);
	    resultMap.put("getBoard", getBoard);
	    
		return resultMap;
	}

	@Override
	public int changeStat(BoardVO boardVO) throws Exception {
		return boardMapper.changeStat(boardVO);
	}

}
