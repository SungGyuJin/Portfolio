package com.board.model;

import com.page.obj.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BbsVO extends DefalutVO {
	
	int    bbsSeq 	=   0;  // 게시판 번호
	String nm 		=  ""; 	// 게시판명
	String expln 	=  "";	// 설명
	String replyYn 	= "N";	// 답글 사용여부 (Y: 사용, N: 미사용)
	String comentYn = "N";	// 댓글 사용여부 (Y: 사용, N: 미사용)
	String atchYn 	= "N";	// 첨부파일 사용여부 (Y: 사용, N: 미사용)
	String secrtYn 	= "N";	// 비밀글 사용여부 (Y: 사용, N: 미사용)
	int    regNo 	=   0;	// 등록자 번호
	String regDt 	=  "";	// 등록일자
	int    updNo 	=   0;	// 수정자 번호
	String updDt 	=  "";	// 수정일자
	int    stat 	=   0;	// 상태 ex) 미사용(삭제)[0] / 사용[1] / 영구삭제[9]
	
	@Override
	public String toString() {
		return "BbsVO [bbsSeq=" + bbsSeq + ", nm=" + nm + ", expln=" + expln + ", replyYn=" + replyYn + ", comentYn="
				+ comentYn + ", atchYn=" + atchYn + ", secrtYn=" + secrtYn + ", regNo=" + regNo + ", regDt=" + regDt
				+ ", updNo=" + updNo + ", updDt=" + updDt + ", stat=" + stat + "]";
	}
	
	
}
