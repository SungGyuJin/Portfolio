package com.board.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.model.LoginVO;
import com.board.service.LoginService;
import com.board.service.mapper.LoginMapper;

@Service
public class LoginServiceImpl implements LoginService{

	@Autowired
	private LoginMapper loginMapper;

	@Override
	public int addLogin(LoginVO loginVO) throws Exception {
		return loginMapper.addLogin(loginVO);
	}

	@Override
	public int updateLogin(LoginVO loginVO) throws Exception {
		return loginMapper.updateLogin(loginVO);
	}

	@Override
	public LoginVO getLogin(LoginVO loginVO) throws Exception {
		return loginMapper.getLogin(loginVO);
	}
	
}
