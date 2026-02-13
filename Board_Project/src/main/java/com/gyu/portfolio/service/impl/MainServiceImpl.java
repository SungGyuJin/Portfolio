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

					if(!mainVO.getThumbYn().equals("D")) {
						mainImgLogic(mainVO, 0, 0);
					}

				// Tech Stack, Pofor
				}else {
					
					if(mainVO.getArrMainSeq() != null) {
						
						for(int i=0; i < mainVO.getArrMainSeq().length; i++) {
							
							// 등록
							if(mainVO.getArrMainSeq()[i].equals("0")) {
								MainVO vo = new MainVO();
								vo.setMainSeq(Integer.parseInt(mainVO.getArrMainSeq()[i]));
								vo.setRegNo(mainVO.getRegNo());
								vo.setUpdNo(mainVO.getRegNo());
								vo.setStat(1);

								if(mainVO.getMainSe().equals("T")) {
									vo.setTechNm(mainVO.getArrTechNm()[i]);
									vo.setMainSe("T");
								}else {
									vo.setPoforNm(mainVO.getArrPoNm()[i]);
									vo.setMainSe("P");
								}
								
								result = mainMapper.addMain(vo);

								// D: default
								if(!mainVO.getArrThumbYn()[i].equals("D")) {
									mainImgLogic(mainVO, vo.getMainSeq(), i);
								}

							// 수정
							}else {
								
								MainVO vo = new MainVO();
								vo.setMainSeq(Integer.parseInt(mainVO.getArrMainSeq()[i]));
								vo.setUpdNo(mainVO.getRegNo());

								if(mainVO.getMainSe().equals("T")) {
									vo.setTechNm(mainVO.getArrTechNm()[i]);
									vo.setMainSe("T");
								}else {
									vo.setPoforNm(mainVO.getArrPoNm()[i]);
									vo.setMainSe("P");
								}

								result = mainMapper.updateMain(vo);

								// D: default
								if(!mainVO.getArrThumbYn()[i].equals("D")) {
									mainImgLogic(mainVO, 0, i);
								}
							}
						}
					}
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
	    System.out.println(getPoList.size());
	    System.out.println();
	    
		return resultMap;
	}

	@Override
	public int updateMainSrtOrd(MainVO mainVO) throws Exception {

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
			int result = 0;
			
			try{
				
				MainVO vo = new MainVO();
				vo.setUpdNo(mainVO.getUpdNo());
				
				for(int i=0; i < mainVO.getMainSeqArr().length; i++) {
					vo.setSrtOrd(Integer.parseInt(mainVO.getSrtOrdArr()[i]));
					vo.setMainSeq(Integer.parseInt(mainVO.getMainSeqArr()[i]));
					
					result = mainMapper.updateMainSrtOrd(vo);
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
	public int updateStat(MainVO mainVO) throws Exception {
		return mainMapper.updateStat(mainVO);
	}

	@Override
	public void mainImgLogic(MainVO mainVO, int seq, int i) throws Exception {

		AttachVO atchVO = new AttachVO();

		// Banner
		if(mainVO.getMainSe().equals("B")) {
			atchVO.setBoardSeq(1);
			atchVO.setStat(11);

			attachMapper.deleteMainImg(atchVO);
			
			if(mainVO.getThumbYn().equals("Y")) {
				atchVO.setThumbYn("Y");
				atchVO.setFileNm(mainVO.getArrFileOrgNm()[i]);
				atchVO.setFileExt(mainVO.getArrFileExt()[i]);
				atchVO.setFileSz(mainVO.getArrFileSize()[i]);
				atchVO.setFilePath(mainVO.getArrFilePath()[i]);
				atchVO.setStrgFileNm(mainVO.getArrFileSvgNm()[i]);
				atchVO.setRegNo(mainVO.getRegNo());
				atchVO.setUpdNo(mainVO.getRegNo());
				
				attachMapper.addAttach(atchVO);
			}

		// Tech Stack, Pofor
		}else {
			
			atchVO.setStat(mainVO.getMainSe().equals("T") ? 22 : 33);
			
			// 등록
			if(mainVO.getArrMainSeq()[i].equals("0")) {
				
				if(mainVO.getArrThumbYn() != null) {
					
					if(mainVO.getArrThumbYn()[i].equals("Y")) {
						
						atchVO.setBoardSeq(seq);
						atchVO.setThumbYn("Y");
						atchVO.setFileNm(mainVO.getArrFileOrgNm()[i]);
						atchVO.setFileExt(mainVO.getArrFileExt()[i]);
						atchVO.setFileSz(mainVO.getArrFileSize()[i]);
						atchVO.setFilePath(mainVO.getArrFilePath()[i]);
						atchVO.setStrgFileNm(mainVO.getArrFileSvgNm()[i]);
						atchVO.setRegNo(mainVO.getRegNo());
						atchVO.setUpdNo(mainVO.getRegNo());
						
						attachMapper.addAttach(atchVO);
					}
				}

			// 수정
			}else {
				
				if(mainVO.getArrThumbYn() != null) {

					atchVO.setBoardSeq(Integer.parseInt(mainVO.getArrMainSeq()[i]));
					attachMapper.deleteMainImg(atchVO);
					
					if(mainVO.getArrThumbYn()[i].equals("Y")) {
						atchVO.setThumbYn("Y");
						atchVO.setFileNm(mainVO.getArrFileOrgNm()[i]);
						atchVO.setFileExt(mainVO.getArrFileExt()[i]);
						atchVO.setFileSz(mainVO.getArrFileSize()[i]);
						atchVO.setFilePath(mainVO.getArrFilePath()[i]);
						atchVO.setStrgFileNm(mainVO.getArrFileSvgNm()[i]);
						atchVO.setRegNo(mainVO.getRegNo());
						atchVO.setUpdNo(mainVO.getRegNo());
						
						attachMapper.addAttach(atchVO);
						
					}
				}
			}
		}
	}

}
