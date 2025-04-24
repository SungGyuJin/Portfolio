package com.board.model;

import com.page.obj.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginVO extends DefalutVO {
	
	int    userSeq 	=   0;  // 사용자 번호
	String userId 	=  ""; 	// ID
	String userPwd 	=  "";	// PW
	String userNm 	= "N";	// 사용자 이름
	String userSe 	= "N";	// 사용자 구분(A: 관리자 / U: 일반 사용자)
	int    stat 	=   0;	// 상태 ex) 미사용(삭제)[0] / 사용[1]
	
	/* 그 외 필드 */
	String aprvNum 	= "";
	String inputPwd = "";
	
}
