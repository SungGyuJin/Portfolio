package com.gyu.portfolio.service.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gyu.portfolio.model.CmntVO;

@Mapper
public interface CmntMapper {

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

	/* update ref */
    void updateRef(CmntVO cmntVO) throws Exception;

	/* update step */
	void updateStep(CmntVO cmntVO) throws Exception;

	/* update step */
	void updateOldStep(CmntVO cmntVO) throws Exception;

	/* update step2 */
	int getMaxStep(CmntVO cmntVO) throws Exception;
	
}
