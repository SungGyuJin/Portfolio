package com.board.model;

import com.page.obj.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardVO extends DefalutVO {
	
	int    boardSeq =  0;  // 게시물 번호
	int    bbsSeq 	=  0;  // 게시판 번호
	String title 	= "";  // 제목
	String cont 	= "";  // 내용
	int    ref 		=  0;
	int    step 	=  0;
	int    lvl 		=  0;
	String pwd 		= "";  // password
	int    readCnt 	=  0;  // 조회수
	int    regNo 	=  0;  // 등록자 번호
	String regDt 	= "";  // 등록일자
	int    updNo 	=  0;  // 수정자 번호
	String updDt 	= "";  // 수정일자
	int    stat 	=  0;  // 상태 ex) 미사용(삭제)[0] / 사용[1] / 영구삭제[9]
}
