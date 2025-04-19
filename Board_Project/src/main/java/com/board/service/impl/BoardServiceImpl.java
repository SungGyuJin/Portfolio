package com.board.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.model.BoardVO;
import com.board.service.BoardService;
import com.board.service.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;
	
	@Override
	public int addBoard(BoardVO boardVO) throws Exception {
		
		int result = 0;
		result = boardMapper.addBoard(boardVO);

		
		System.out.println();
		System.out.println("방금boardSeq: "+boardVO.getBoardSeq());
		System.out.println();
		
		boardMapper.updateRef(boardVO);
		
		return result;
	}

	@Override
	public int updateBoard(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BoardVO> getBoardList(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getBoard(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int changeStat(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getBoardListCnt(BoardVO boardVO) {
		// TODO Auto-generated method stub
		return 0;
	}

}
