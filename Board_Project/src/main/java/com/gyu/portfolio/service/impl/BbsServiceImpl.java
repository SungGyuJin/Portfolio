package com.gyu.portfolio.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gyu.portfolio.common.PageMakerDTO;
import com.gyu.portfolio.model.BbsVO;
import com.gyu.portfolio.service.BbsService;
import com.gyu.portfolio.service.mapper.BbsMapper;

@Service
public class BbsServiceImpl implements BbsService{

	@Autowired
	private BbsMapper bbsMapper;
	
	@Override
	public int addBbs(BbsVO bbsVO) throws Exception {
		return bbsMapper.addBbs(bbsVO);
	}

	@Override
	public int updateBbs(BbsVO bbsVO) throws Exception {
		return bbsMapper.updateBbs(bbsVO);
	}

	@Override
	public Map<String, Object> getBbsList(BbsVO bbsVO) throws Exception {

	    Map<String, Object> resultMap = new HashMap<>();

		// 게시판 목록
		List<BbsVO> getBbsList = new ArrayList<>();
		getBbsList = bbsMapper.getBbsList(bbsVO);

		// 페이징 처리
		int totalCnt = bbsMapper.getBbsListCnt(bbsVO);
		PageMakerDTO pageMaker = new PageMakerDTO(bbsVO, totalCnt);

		resultMap.put("getBbsList", getBbsList);
		resultMap.put("pageMaker", pageMaker);
		resultMap.put("total", totalCnt);
		resultMap.put("bbsVO", bbsVO);
	    
		return resultMap;
	}

	@Override
	public Map<String, Object> getBbs(BbsVO bbsVO) throws Exception {

	    Map<String, Object> resultMap = new HashMap<>();
	    
	    BbsVO getBbs = bbsMapper.getBbs(bbsVO);
	    resultMap.put("getBbs", getBbs);
		
		return resultMap;
	}

	@Override
	public int changeStat(BbsVO bbsVO) throws Exception {
		return bbsMapper.changeStat(bbsVO);
	}

	@Override
	public List<BbsVO> getSelectBbsList() throws Exception {
		return bbsMapper.getSelectBbsList();
	}

}
