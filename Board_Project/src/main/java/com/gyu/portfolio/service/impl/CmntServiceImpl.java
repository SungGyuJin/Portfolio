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

import com.gyu.portfolio.model.CmntVO;
import com.gyu.portfolio.service.CmntService;
import com.gyu.portfolio.service.mapper.CmntMapper;

@Service
public class CmntServiceImpl implements CmntService{

	@Autowired
	private CmntMapper cmntMapper;

	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@Override
	public int addCmnt(CmntVO cmntVO) throws Exception {
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
			int result = 0;
			
			try{

				// 답글케이스만 진입
				if(cmntVO.getRef() > 0) {
					
					// 원글에 대한 답글인 경우
					if(cmntVO.getStep() == 0 && cmntVO.getLvl() == 0) {
						
						int currentMaxStep = 0;
						currentMaxStep = cmntMapper.getMaxStep(cmntVO);
						
						cmntVO.setStep(currentMaxStep);
						cmntVO.setLvl(1);
						
					// 답글에 대한 답글인 경우 모든 케이스	
					}else {
						
						/* 보류 */
//						cmntVO.setStep(cmntVO.getStep() + 1);
//						cmntMapper.updateStep(cmntVO);
//						cmntMapper.updateOldStep(cmntVO);
//						cmntVO.setLvl(cmntVO.getLvl() + 1);
						
						/* 원본 */
						cmntVO.setStep(cmntVO.getStep() + 1);
						cmntVO.setLvl(cmntVO.getLvl() + 1);
						cmntMapper.updateStep(cmntVO);
					}
				}

				result = cmntMapper.addCmnt(cmntVO);
				
				cmntMapper.updateRef(cmntVO);
				
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
	public int updateCmnt(CmntVO cmntVO) throws Exception {
		return cmntMapper.updateCmnt(cmntVO);
	}

	@Override
	public int deleteCmnt(CmntVO cmntVO) throws Exception {
		return cmntMapper.deleteCmnt(cmntVO);
	}

	@Override
	public Map<String, Object> getCmntList(CmntVO cmntVO) throws Exception {

		Map<String, Object> resultMap = new HashMap<>();

		// 댓글 목록
		List<CmntVO> getCmntList = new ArrayList<>();
		getCmntList = cmntMapper.getCmntList(cmntVO);

		resultMap.put("getCmntList", getCmntList);
	    
		return resultMap;
	}

	@Override
	public Map<String, Object> getCmnt(CmntVO cmntVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();

		// 댓글 상세
		CmntVO getCmnt = null;
		getCmnt = cmntMapper.getCmnt(cmntVO);

		resultMap.put("getCmnt", getCmnt);
	    
		return resultMap;
	}


}
