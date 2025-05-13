package com.gyu.portfolio.service;


import java.util.Map;

import com.gyu.portfolio.model.CmntVO;

public interface CmntService {

	// 댓글 등록
	int addCmnt(CmntVO cmntVO) throws Exception;

	// 댓글 수정
	int updateCmnt(CmntVO cmntVO) throws Exception;

	// 댓글 삭제
	int deleteCmnt(CmntVO cmntVO) throws Exception;

	// 댓글 목록
	Map<String, Object> getCmntList(CmntVO cmntVO) throws Exception;
	
	// 댓글 조회
	Map<String, Object> getCmnt(CmntVO cmntVO) throws Exception;

}
