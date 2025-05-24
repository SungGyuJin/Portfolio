package com.gyu.portfolio.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gyu.portfolio.model.AttachVO;
import com.gyu.portfolio.service.AttachService;
import com.gyu.portfolio.service.mapper.AttachMapper;

@Service
public class AttachServiceImpl implements AttachService{

	@Autowired
	private AttachMapper attachMapper;

	@Override
	public int addAttach(AttachVO attachVO) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteAttach(AttachVO attachVO) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<AttachVO> getAttachList(AttachVO attachVO) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AttachVO getAttach(AttachVO attachVO) throws Exception {
		return attachMapper.getAttach(attachVO);
	}
	

}
