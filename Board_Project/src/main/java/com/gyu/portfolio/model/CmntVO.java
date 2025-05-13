package com.gyu.portfolio.model;

import com.gyu.portfolio.common.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CmntVO extends DefalutVO {
	
	private int    cmntSeq 	=  0;  // 댓글 번호
	private int    boardSeq =  0;  // 게시물 번호
	private String cn 		= "";  // 댓글 내용
	private int    ref 		=  0;
	private int    step 	=  0;
	private int    lvl 		=  0;
	private String pwd 		= "";  // password
	private int    regNo 	=  0;  // 등록자 번호
	private String regDt 	= "";  // 등록일자
	private int    updNo 	=  0;  // 수정자 번호
	private String updDt 	= "";  // 수정일자
	private int    stat 	=  0;  // 상태 ex) 미사용(삭제)[0] / 사용[1] / 영구삭제[9]
	
	/* 그 외 필드 */
	
}
