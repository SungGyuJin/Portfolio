package com.gyu.portfolio.service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gyu.portfolio.model.AttachVO;

@Mapper
public interface AttachMapper {
	
	/* 첨부파일 등록 */
	int addAttach(AttachVO attachVO) throws Exception;

	/* 첨부파일 삭제 */
	int deleteAttach(AttachVO attachVO) throws Exception;

	/* 첨부파일 목록 */
	List<AttachVO> getAttachList(AttachVO attachVO) throws Exception;
	
	/* 첨부파일 조회 */
	AttachVO getAttach(AttachVO attachVO) throws Exception;

	/* [공용]메인 이미지 삭제(Bner, Tech, Pofor) 삭제 */
	int deleteMainImg(AttachVO attachVO) throws Exception;

	// Front
	List<AttachVO> getFrontAttachList(AttachVO attachVO) throws Exception;
	
	/* 썸네일 초기화(All N) */
	int thumbInit(AttachVO attachVO) throws Exception;
	
	/* 프로필 이미지 초기화(All N) */
	int profileImgInit(AttachVO attachVO) throws Exception;
	
}
