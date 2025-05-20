package com.gyu.portfolio.model;

import org.springframework.web.multipart.MultipartFile;

import com.gyu.portfolio.common.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttachVO extends DefalutVO {

	private int    attachSeq 	=  0;  // 첨부파일 일련번호
	private int    boardSeq 	=  0;  // 게시물 번호
	private String fileNm 		= "";  // 파일명(원본명)
	private int    fileSz 		=  0;  // 파일크기
	private String filePath		= "";  // 파일경로
	private String strgFileNm	= "";  // 파일저장이름
	private String thumbYn 		= "";  // 썸네일여부(Y, N)
	private int    dwnldCnt 	=  0;  // 다운횟수?

	private int    regNo 		=  0;  // 등록자 번호
	private String regDt 		= "";  // 등록일자
	private int    updNo 		=  0;  // 수정자 번호
	private String updDt 		= "";  // 수정일자
	private int    stat 		=  0;  // 상태 ex) 미사용(삭제)[0] / 사용[1] / 영구삭제[9]
	
	private MultipartFile file  = null;
	
	/* 그 외 필드 */
	
}
