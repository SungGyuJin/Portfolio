package com.gyu.portfolio.service;


import java.util.List;

import com.gyu.portfolio.model.AttachVO;

public interface AttachService {

	/* 첨부파일 등록 */
	int addAttach(AttachVO attachVO) throws Exception;

	/* 첨부파일 삭제 */
	int deleteAttach(AttachVO attachVO) throws Exception;

	/* 첨부파일 목록 */
	List<AttachVO> getAttachList(AttachVO attachVO) throws Exception;

	/* 첨부파일 조회 */
	AttachVO getAttach(AttachVO attachVO) throws Exception;
	
}
