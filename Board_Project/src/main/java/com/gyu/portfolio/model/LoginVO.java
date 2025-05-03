package com.gyu.portfolio.model;

import com.gyu.portfolio.common.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginVO extends DefalutVO {
	
	private int    userSeq 	=   0;  // 사용자 번호
	private String userId 	=  ""; 	// ID
	private String userPwd 	=  "";	// PW
	private String userNm 	= "N";	// 사용자 이름
	private String userSe 	= "N";	// 사용자 구분(A: 관리자 / U: 일반 사용자)
	private int    stat 	=   0;	// 상태 ex) 미사용(삭제)[0] / 사용[1]
	
	/* 그 외 필드 */
	private String aprvNum 	= "";
	private String inputPwd = "";
	
}
