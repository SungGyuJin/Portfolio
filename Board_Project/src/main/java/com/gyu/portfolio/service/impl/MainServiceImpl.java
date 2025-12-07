package com.gyu.portfolio.service.impl;

import java.util.HashMap;
import java.util.List;
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
		
		return resultMap;
	}

}
