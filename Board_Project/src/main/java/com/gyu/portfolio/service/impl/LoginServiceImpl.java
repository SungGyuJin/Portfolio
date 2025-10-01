package com.gyu.portfolio.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.gyu.portfolio.model.AttachVO;
import com.gyu.portfolio.model.LoginVO;
import com.gyu.portfolio.service.LoginService;
import com.gyu.portfolio.service.mapper.AttachMapper;
import com.gyu.portfolio.service.mapper.LoginMapper;

@Service
public class LoginServiceImpl implements LoginService{

	@Autowired
	private LoginMapper loginMapper;

	@Autowired
	private AttachMapper attachMapper;

	@Autowired
	private DataSourceTransactionManager transactionManager;

	@Override
	public int addLogin(LoginVO loginVO) throws Exception {
		return loginMapper.addLogin(loginVO);
	}

	@Override
	public int updateLogin(LoginVO loginVO,  AttachVO attachVO) throws Exception {
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
			int result = 0;
			
			try{
				
				result = loginMapper.updateLogin(loginVO);
				
				// 프로필 이미지 등록 및 수정
				if(attachVO.getThumbYn().equals("Y") || attachVO.getThumbYn().equals("N")){

					System.out.println();
					System.out.println("프로필 Image 진입");
					System.out.println();
					
					attachVO.setRegNo(loginVO.getUserSeq());
					
					AttachVO vo = new AttachVO();
					
					vo.setBoardSeq(0);
					vo.setRegNo(loginVO.getUserSeq());
					vo.setThumbYn(attachVO.getThumbYn());

					attachMapper.profileImgInit(attachVO);

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
	public LoginVO getLogin(LoginVO loginVO) throws Exception {
		return loginMapper.getLogin(loginVO);
	}

	@Override
	public LoginVO getUserInfo(LoginVO loginVO) throws Exception {
		return loginMapper.getUserInfo(loginVO);
	}
	
}
