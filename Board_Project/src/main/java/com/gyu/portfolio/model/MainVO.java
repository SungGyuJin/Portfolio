package com.gyu.portfolio.model;

import com.gyu.portfolio.common.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MainVO extends DefalutVO {
	
	private int    mainSeq 		=   0;  // 메인 일련번호
	private String mainSe 		=  ""; 	// 메인 구분(B, T, P)
	private String topBnNm 		=  ""; 	// 상단 배너명
	private String botmBnNm 	=  ""; 	// 하단 배너명
	private String techNm 		=  "";	// 기술명
	private String poforNm 		=  "";	// 포트폴리오명
	private String expln 		=  "";	// 설명
	private int    regNo 		=   0;	// 등록자 번호
	private String regDt 		=  "";	// 등록일자
	private int    updNo 		=   0;	// 수정자 번호
	private String updDt 		=  "";	// 수정일자
	private int    stat 		=   0;	// 상태 ex) 미사용(삭제)[0] / 사용[1]
	

	/* 그 외 필드 */
	private String[] arrMainSeq    = null;
	private String[] arrTechNm     = null;
	private String[] arrFileOrgNm  = null;	// 파일이름(원본명)
	private String[] arrFileSvgNm  = null;	// 파일이름(저장명)
	private String[] arrFileExt    = null;	// 파일확장자
	private String[] arrFilePath   = null;	// 파일경로
	private long[]   arrFileSize   = null;	// 파일크기(Byte)
	private String[] arrThumbYn    = null;  // 썸네일여부(Y, N)
	
	
}
