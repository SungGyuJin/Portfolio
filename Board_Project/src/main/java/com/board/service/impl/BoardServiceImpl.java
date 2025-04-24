package com.board.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.board.model.BoardVO;
import com.board.service.BoardService;
import com.board.service.mapper.BoardMapper;
import com.page.obj.PageMakerDTO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper boardMapper;

	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@Override
	public int addBoard(BoardVO boardVO) throws Exception {
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
			int result = 0;
			
			try{

				// 답글케이스만 진입
				if(boardVO.getRef() > 0) {
					
					// 원글에 대한 답글인 경우
					if(boardVO.getStep() == 0 && boardVO.getLvl() == 0) {
						
						int currentMaxStep = 0;
						currentMaxStep = boardMapper.getMaxStep(boardVO);
						
						boardVO.setStep(currentMaxStep);
						boardVO.setLvl(1);
						
						
					// 답글에 대한 답글인 경우 모든 케이스	
					}else {
						
						/* 보류 */
//						boardVO.setStep(boardVO.getStep() + 1);
//						boardMapper.updateStep(boardVO);
//						boardMapper.updateOldStep(boardVO);
//						boardVO.setLvl(boardVO.getLvl() + 1);
						
						
						/* 원본 */
						boardVO.setStep(boardVO.getStep() + 1);
						boardVO.setLvl(boardVO.getLvl() + 1);
						boardMapper.updateStep(boardVO);
					}
				}
				
				

				result = boardMapper.addBoard(boardVO);
				
				boardMapper.updateRef(boardVO);
				
				transactionManager.commit(status);
			}catch(Exception e){
				transactionManager.rollback(status);
				System.out.println();
				System.out.println(e.getMessage());
				System.out.println();
			}
			
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
