package com.gyu.portfolio.service.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gyu.portfolio.model.FnceVO;

@Mapper
public interface FnceMapper {
	
	int addFnce(FnceVO fnceVO) throws Exception;
}
