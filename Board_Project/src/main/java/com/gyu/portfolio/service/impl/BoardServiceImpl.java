package com.gyu.portfolio.service.impl;

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

import com.gyu.portfolio.common.PageMakerDTO;
import com.gyu.portfolio.model.AttachVO;
import com.gyu.portfolio.model.BbsVO;
import com.gyu.portfolio.model.BoardVO;
import com.gyu.portfolio.service.BoardService;
import com.gyu.portfolio.service.mapper.AttachMapper;
import com.gyu.portfolio.service.mapper.BbsMapper;
import com.gyu.portfolio.service.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private BbsMapper bbsMapper;

	@Autowired
	private BoardMapper boardMapper;

	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@Override
	public int addBoard(BoardVO boardVO, AttachVO attachVO) throws Exception {
		
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
						
						/* 원본 */
						boardVO.setStep(boardVO.getStep() + 1);
						boardVO.setLvl(boardVO.getLvl() + 1);
						boardMapper.updateStep(boardVO);
					}
				}

				result = boardMapper.addBoard(boardVO);
				
				boardMapper.updateRef(boardVO);
				
				// 첨부파일 등록
				if(attachVO.getArrFileOrgNm() != null) {
					
					AttachVO vo = new AttachVO();
					
					vo.setBoardSeq(boardVO.getBoardSeq());
					vo.setRegNo(boardVO.getUpdNo());
					vo.setThumbYn("N");
					vo.setDwnldCnt(0);
					vo.setStat(1);
					
					for(int i=0; i < attachVO.getArrFileOrgNm().length; i++) {
						vo.setFileNm(attachVO.getArrFileOrgNm()[i]);
						vo.setFileExt(attachVO.getArrFileExt()[i]);
						vo.setFileSz(attachVO.getArrFileSize()[i]);
						vo.setFilePath(attachVO.getArrFilePath()[i]);
						vo.setStrgFileNm(attachVO.getArrFileSvgNm()[i]);
						
						attachMapper.addAttach(vo);
					}
				}
				
				// 썸네일 등록 및 수정
				if(attachVO.getThumbYn().equals("Y") || attachVO.getThumbYn().equals("N")){

					AttachVO vo = new AttachVO();
					
					vo.setBoardSeq(boardVO.getBoardSeq());
					vo.setRegNo(boardVO.getUpdNo());
					vo.setThumbYn(attachVO.getThumbYn());

					attachMapper.thumbInit(attachVO);
					
					if(attachVO.getThumbYn().equals("Y")){
						
						vo.setStat(1);
						vo.setFileNm(attachVO.getThumbFileOrgNm());
						vo.setFileExt(attachVO.getThumbFileExt());
						vo.setFileSz(attachVO.getThumbFileSize());
						vo.setFilePath(attachVO.getThumbFilePath());
						vo.setStrgFileNm(attachVO.getThumbFileSvgNm());
						
						attachMapper.addAttach(vo);
					}
				}
				
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
	public int updateBoard(BoardVO boardVO, AttachVO attachVO) throws Exception {

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		int result = 0;
		
		try{
			
			result = boardMapper.updateBoard(boardVO);

			
			// 첨부파일 등록
			if(attachVO.getArrFileOrgNm() != null) {

				AttachVO vo = new AttachVO();
				
				vo.setBoardSeq(boardVO.getBoardSeq());
				vo.setRegNo(boardVO.getUpdNo());
				vo.setThumbYn("N");
				vo.setDwnldCnt(0);
				vo.setStat(1);
				
				for(int i=0; i < attachVO.getArrFileOrgNm().length; i++) {
					vo.setFileNm(attachVO.getArrFileOrgNm()[i]);
					vo.setFileExt(attachVO.getArrFileExt()[i]);
					vo.setFileSz(attachVO.getArrFileSize()[i]);
					vo.setFilePath(attachVO.getArrFilePath()[i]);
					vo.setStrgFileNm(attachVO.getArrFileSvgNm()[i]);
					
					attachMapper.addAttach(vo);
				}
			}

			// 썸네일 등록 및 수정
			if(attachVO.getThumbYn().equals("Y") || attachVO.getThumbYn().equals("N")){

				AttachVO vo = new AttachVO();
				
				vo.setBoardSeq(boardVO.getBoardSeq());
				vo.setRegNo(boardVO.getUpdNo());
				vo.setThumbYn(attachVO.getThumbYn());

				attachMapper.thumbInit(attachVO);
				
				if(attachVO.getThumbYn().equals("Y")){
					
					vo.setStat(1);
					vo.setFileNm(attachVO.getThumbFileOrgNm());
					vo.setFileExt(attachVO.getThumbFileExt());
					vo.setFileSz(attachVO.getThumbFileSize());
					vo.setFilePath(attachVO.getThumbFilePath());
					vo.setStrgFileNm(attachVO.getThumbFileSvgNm());
					
					attachMapper.addAttach(vo);
				}
			}
			
			// 첨부파일 삭제
			if(attachVO.getDelSeqArr() != null) {
				attachMapper.deleteAttach(attachVO);
			}
			
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
	public Map<String, Object> getBoardList(BoardVO boardVO) throws Exception {
		
	    Map<String, Object> resultMap = new HashMap<>();
		
		// 게시물 목록
		List<BoardVO> getBoardList = new ArrayList<>();
		getBoardList = boardMapper.getBoardList(boardVO);
		
		// 게시판 목록(select option)
		List<BbsVO> getBbsList = bbsMapper.getSelectBbsList();
		
		// 페이징 처리
		int totalCnt = boardMapper.getBoardListCnt(boardVO);
		PageMakerDTO pageMaker = new PageMakerDTO(boardVO, totalCnt);

		resultMap.put("getBoardList", getBoardList);
		resultMap.put("getBbsList", getBbsList);
		resultMap.put("pageMaker", pageMaker);
		resultMap.put("total", totalCnt);
		resultMap.put("boardVO", boardVO);
	    
		return resultMap;
	}

	@Override
	public Map<String, Object> getBoard(BoardVO boardVO) throws Exception {

	    Map<String, Object> resultMap = new HashMap<>();
	    BoardVO getBoard = boardMapper.getBoard(boardVO);
	    
	    AttachVO attachVO = new AttachVO();
	    attachVO.setBoardSeq(boardVO.getBoardSeq());
	    
	    List<AttachVO> getAttachList = new ArrayList<>();
	    getAttachList = attachMapper.getAttachList(attachVO);

	    resultMap.put("getBoard", getBoard);
	    resultMap.put("getAttachList", getAttachList);
	    
		return resultMap;
	}

	@Override
	public int changeStat(BoardVO boardVO) throws Exception {

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
			int result = 0;
					
			try{

				System.out.println();
				
//				if(boardVO.getDelSeqArr() == null) {
//					System.out.println("진입~~~ Null");
//					System.out.println("if: "+boardVO.getDelSeqArr());
//
//					result = boardMapper.changeStatRef(boardVO);
//				}	
				
				for(int i=0; i < boardVO.getDelSeqArr().length; i++) {

					System.out.println("i: "+i);
					boardVO.setBoardSeq(Integer.parseInt(boardVO.getDelSeqArr()[i]));
					
					int cnt = boardMapper.getRefCnt(boardVO);
					
					if(cnt > 1) {
						System.out.println();
						System.out.println("if");
						System.out.println();
						result = boardMapper.changeStatRef(boardVO);
					}else {
						System.out.println();
						System.out.println("else");
						System.out.println();
						result = boardMapper.changeStat(boardVO);
					}
				}
				
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
	public Map<String, Object> getFrontBoardList(BoardVO boardVO) throws Exception {
		
	    Map<String, Object> resultMap = new HashMap<>();
		
		// 게시물 목록
		List<BoardVO> getBoardList = new ArrayList<>();
		getBoardList = boardMapper.getFrontBoardList(boardVO);
		
		// 게시판 목록(select option)
		List<BbsVO> getBbsList = bbsMapper.getSelectBbsList();
		
		// 페이징 처리
		int totalCnt = boardMapper.getFrontBoardListCnt(boardVO);
		PageMakerDTO pageMaker = new PageMakerDTO(boardVO, totalCnt);
		
		if(boardVO.getRegNo() > 0) {
			// 게시글 수, 댓글 수
			List<BoardVO> getWriterCnt = new ArrayList<>();
			getWriterCnt = boardMapper.getWriterCnt(boardVO);
			resultMap.put("getWriterCnt", getWriterCnt);
		}

		resultMap.put("getBoardList", getBoardList);
		resultMap.put("getBbsList", getBbsList);
		resultMap.put("pageMaker", pageMaker);
		resultMap.put("total", totalCnt);
		resultMap.put("boardVO", boardVO);
	    
		return resultMap;
	}

	@Override
	public Map<String, Object> getFrontBoard(BoardVO boardVO) throws Exception {

	    Map<String, Object> resultMap = new HashMap<>();
	    
	    // 게시물 조회수 카운트
	    boardMapper.updateReadCnt(boardVO);
	    
	    // 게시물 상세
	    BoardVO getBoard = null;
	    getBoard = boardMapper.getFrontBoard(boardVO);

	    // 게시물 상세(답글포함)
	    List<BoardVO> getBoardReply = null;
	    getBoardReply = boardMapper.getFrontBoardReply(boardVO);

	    AttachVO attachVO = new AttachVO();
	    attachVO.setBoardSeq(boardVO.getBoardSeq());

	    List<AttachVO> getAttachList = new ArrayList<>();
	    getAttachList = attachMapper.getFrontAttachList(attachVO);

	    resultMap.put("getBoard", getBoard);
	    resultMap.put("getBoardReply", getBoardReply);
	    resultMap.put("getAttachList", getAttachList);
	    
		return resultMap;
	}

	@Override
	public Map<String, Object> chkPwd(BoardVO boardVO) throws Exception {

	    Map<String, Object> resultMap = new HashMap<>();
	    BoardVO getBoard = boardMapper.chkPwd(boardVO);

	    String rsMatch = getBoard.getRsMatch();
	    
	    resultMap.put("result", rsMatch);
		
		return resultMap;
	}

}
