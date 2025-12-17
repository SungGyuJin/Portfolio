package com.gyu.portfolio.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.gyu.portfolio.model.MainVO;
import com.gyu.portfolio.service.MainService;
import com.gyu.portfolio.service.mapper.MainMapper;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper mainMapper;

	@Autowired
	private DataSourceTransactionManager transactionManager;

	@Override
	public int addMain(MainVO mainVO) throws Exception {

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
			int result = 0;
			
			try{
				
				for(int i=0; i < mainVO.getArrMainSeq().length; i++) {
					MainVO vo = new MainVO();
					vo.setMainSeq(Integer.parseInt(mainVO.getArrMainSeq()[i]));
					vo.setMainSe(mainVO.getMainSe());
					vo.setTechNm(mainVO.getArrTechNm()[i]);
					vo.setRegNo(mainVO.getRegNo());
					vo.setUpdNo(mainVO.getRegNo());
					vo.setStat(1);

					result = mainMapper.addMain(vo);
				}
				
				
				if(mainVO.getDelSeqArr().length > 0) {
					mainMapper.deleteMain(mainVO);
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
	public int updateMain(MainVO mainVO) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map<String, Object> getMainList(MainVO mainVO) throws Exception {

	    Map<String, Object> resultMap = new HashMap<>();
	    
	    // banner Data
	    mainVO.setMainSe("B");
	    List<MainVO> getBanner = mainMapper.getMain(mainVO);
	    resultMap.put("getBanner", getBanner);
	    
	    // tech stack Data
	    mainVO.setMainSe("T");
	    List<MainVO> getTechList = mainMapper.getMain(mainVO);
	    resultMap.put("getTechList", getTechList);
	    
	    // portfolio Data
	    mainVO.setMainSe("P");
	    List<MainVO> getPoList = mainMapper.getMain(mainVO);
	    resultMap.put("getPoList", getPoList);

	    System.out.println();
	    System.out.println("getBanner");
	    for(int i=0; i < getBanner.size(); i++) {
	    	System.out.println(getBanner.get(i));
	    }
	    System.out.println();
	    System.out.println();
	    System.out.println("getTechList");
	    for(int i=0; i < getTechList.size(); i++) {
	    	System.out.println(getTechList.get(i));
	    }
	    System.out.println();
	    System.out.println();
	    System.out.println("getPoList");
	    for(int i=0; i < getPoList.size(); i++) {
	    	System.out.println(getPoList.get(i));
	    }
	    System.out.println();
	    System.out.println();
		return resultMap;
	}

}
