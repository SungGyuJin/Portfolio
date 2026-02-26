package com.gyu.portfolio.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.gyu.portfolio.service.FnceService;
import com.gyu.portfolio.service.mapper.FnceMapper;

@Service
public class FnceServiceImpl implements FnceService{

	@Autowired
	private FnceMapper fnceMapper;

	@Autowired
	private DataSourceTransactionManager transactionManager;
	

}
