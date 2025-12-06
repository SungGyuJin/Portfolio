package com.gyu.portfolio.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

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
		return mainMapper.addMain(mainVO);
	}

	@Override
	public int updateMain(MainVO mainVO) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map<String, Object> getMainList(MainVO mainVO) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getMain(MainVO mainVO) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	

}
