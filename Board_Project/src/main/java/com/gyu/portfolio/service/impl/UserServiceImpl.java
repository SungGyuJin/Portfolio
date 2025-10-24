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
import com.gyu.portfolio.model.BoardVO;
import com.gyu.portfolio.model.UserVO;
import com.gyu.portfolio.service.UserService;
import com.gyu.portfolio.service.mapper.AttachMapper;
import com.gyu.portfolio.service.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private AttachMapper attachMapper;

	@Autowired
	private DataSourceTransactionManager transactionManager;

	@Override
	public int addUser(UserVO userVO) throws Exception {
		return userMapper.addUser(userVO);
	}

	@Override
	public int updateUser(UserVO userVO,  AttachVO attachVO) throws Exception {
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
			int result = 0;
			
			try{
				
				result = userMapper.updateUser(userVO);
				
				// 프로필 이미지 등록 및 수정
				if(attachVO.getThumbYn().equals("Y") || attachVO.getThumbYn().equals("N")){

					attachVO.setRegNo(userVO.getUserSeq());
					
					AttachVO vo = new AttachVO();
					
					vo.setBoardSeq(0);
					vo.setRegNo(userVO.getUserSeq());
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
	public UserVO getUser(UserVO userVO) throws Exception {
		return userMapper.getUser(userVO);
	}

	@Override
	public UserVO getUserInfo(UserVO userVO) throws Exception {
		return userMapper.getUserInfo(userVO);
	}

	@Override
	public Map<String, Object> getUserList(UserVO userVO) throws Exception {
		
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    // 사용자 목록
		List<UserVO> getUserList = new ArrayList<>();
		getUserList = userMapper.getUserList(userVO);
	    
	    // 페이징 처리
		int totalCnt = userMapper.getUserListCnt(userVO);
		PageMakerDTO pageMaker = new PageMakerDTO(userVO, totalCnt);

		resultMap.put("getUserList", getUserList);
		resultMap.put("pageMaker", pageMaker);
		resultMap.put("total", totalCnt);
		resultMap.put("userVO", userVO);
		
		return resultMap;
	}
	
}
