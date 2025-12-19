package com.gyu.portfolio.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.aop.framework.AbstractAdvisingBeanPostProcessor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.gyu.portfolio.model.AttachVO;
import com.gyu.portfolio.model.MainVO;
import com.gyu.portfolio.service.MainService;
import com.gyu.portfolio.service.mapper.AttachMapper;
import com.gyu.portfolio.service.mapper.MainMapper;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper mainMapper;
	
	@Autowired
	private AttachMapper attachMapper;

	@Autowired
	private DataSourceTransactionManager transactionManager;

	@Override
	public int addMain(MainVO mainVO) throws Exception {

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
			int result = 0;
			
			try{
				
				// Banner
				if(mainVO.getMainSe().equals("B")) {
					
					result = mainMapper.updateMain(mainVO);
					
				// Tech Stack
				}else if(mainVO.getMainSe().equals("T")) {

					
					if(mainVO.getArrMainSeq() != null) {
						
//						System.out.println();
//						System.out.println("mainVO.getArrMainSeq():: "+mainVO.getArrMainSeq().length);
//						System.out.println();
//						
//	
//						System.out.println("+++++");
//						System.out.println("+++++");
//						System.out.println("+++++");
//						for(int i=0; i < mainVO.getArrMainSeq().length; i++) {
//							System.out.println();
//							System.out.println("getArrMainSeq:: "+mainVO.getArrMainSeq()[i]);
//							System.out.println();
//						}
//						System.out.println("+++++");
//						System.out.println("+++++");
//						System.out.println("+++++");
					
						System.out.println("seq 길이: "+mainVO.getArrMainSeq().length);
						

						
								
						if(mainVO.getArrFileOrgNm() != null) {
							System.out.println("파일 유무 진입 Null 아님");
							System.out.println("CNT:: "+mainVO.getArrFileOrgNm().length);
							
							for(int i=0; i < mainVO.getArrFileOrgNm().length; i++) {
								System.out.println("fileNm:: "+mainVO.getArrFileOrgNm()[i]);
							}
							
						}
								
						
						for(int i=0; i < mainVO.getArrMainSeq().length; i++) {
							
							// 등록
							if(mainVO.getArrMainSeq()[i].equals("0")) {

								System.out.println();
								System.out.println("+++++++++++++++ 등록 +++++++++++++++");
								System.out.println();
								
								MainVO vo = new MainVO();
								vo.setMainSeq(Integer.parseInt(mainVO.getArrMainSeq()[i]));
								vo.setMainSe(mainVO.getMainSe());
								vo.setTechNm(mainVO.getArrTechNm()[i]);
								vo.setRegNo(mainVO.getRegNo());
								vo.setUpdNo(mainVO.getRegNo());
								vo.setStat(1);
								
								result = mainMapper.addMain(vo);
								
								if(mainVO.getArrThumbYn() != null) {
									
									if(mainVO.getArrThumbYn()[i].equals("Y")) {
										
										AttachVO atchVO = new AttachVO();
										
										atchVO.setBoardSeq(vo.getMainSeq());
										atchVO.setThumbYn("Y");
										atchVO.setFileNm(mainVO.getArrFileOrgNm()[i]);
										atchVO.setFileExt(mainVO.getArrFileExt()[i]);
										atchVO.setFileSz(mainVO.getArrFileSize()[i]);
										atchVO.setFilePath(mainVO.getArrFilePath()[i]);
										atchVO.setStrgFileNm(mainVO.getArrFileSvgNm()[i]);
										atchVO.setRegNo(mainVO.getRegNo());
										atchVO.setUpdNo(mainVO.getRegNo());
										atchVO.setStat(11);
										
										attachMapper.addAttach(atchVO);
									}
								}

							// 수정
							}else {

								System.out.println();
								System.out.println("+++++++++++++++ 수정 +++++++++++++++");
								System.out.println();
								
								MainVO vo = new MainVO();
								vo.setMainSeq(Integer.parseInt(mainVO.getArrMainSeq()[i]));

								System.out.println();
								System.out.println(i+"번째 반복: mainVO.getArrTechNm().length: "+mainVO.getArrTechNm().length);
								System.out.println();
								
								vo.setTechNm(mainVO.getArrTechNm()[i]);
								vo.setUpdNo(mainVO.getRegNo());
								
								result = mainMapper.updateMain(vo);
								
								if(mainVO.getArrThumbYn() != null) {
									
									if(mainVO.getArrThumbYn()[i].equals("Y")) {
										
										AttachVO atchVO = new AttachVO();
										
										atchVO.setBoardSeq(Integer.parseInt(mainVO.getArrMainSeq()[i]));
										atchVO.setThumbYn("Y");
										atchVO.setFileNm(mainVO.getArrFileOrgNm()[i]);
										atchVO.setFileExt(mainVO.getArrFileExt()[i]);
										atchVO.setFileSz(mainVO.getArrFileSize()[i]);
										atchVO.setFilePath(mainVO.getArrFilePath()[i]);
										atchVO.setStrgFileNm(mainVO.getArrFileSvgNm()[i]);
										atchVO.setRegNo(mainVO.getRegNo());
										atchVO.setUpdNo(mainVO.getRegNo());
										atchVO.setStat(11);
										
										attachMapper.addAttach(atchVO);
										
									}else if(mainVO.getArrThumbYn()[i].equals("N")) {
										AttachVO atchVO = new AttachVO();
										atchVO.setBoardSeq(Integer.parseInt(mainVO.getArrMainSeq()[i]));

										System.out.println("atchVO.getBoardSeq:: "+atchVO.getBoardSeq());
										System.out.println("atchVO.getBoardSeq:: "+atchVO.getBoardSeq());
										System.out.println("atchVO.getBoardSeq:: "+atchVO.getBoardSeq());
										
										result = attachMapper.deleteTechImg(atchVO);
									}else {
										
									}
									
								}
								
							}
						}
					}
					
					if(mainVO.getDelSeqArr() != null) {
						
						result = mainMapper.deleteMain(mainVO);
					}
					
				// Pofor
				}else {
					
				}

				transactionManager.commit(status);
				
			}catch(Exception e){
				transactionManager.rollback(status);
				System.out.println();
				e.printStackTrace();
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
