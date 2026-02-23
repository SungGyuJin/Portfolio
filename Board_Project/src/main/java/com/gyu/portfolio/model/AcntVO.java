package com.gyu.portfolio.model;

import com.gyu.portfolio.common.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AcntVO extends DefalutVO {
	
	private String acntNo   =  "";  // 계좌번호
	private int    userSeq  =   0;	// 사용자 일련번호
	private String bankNm 	=  ""; 	// 사용자 일련번호
	private String currBal  =  "";	// 현재잔액
	private String accPwd 	=  "";	// 계좌 비밀번호
	private int    regNo 	=   0;	// 등록자 번호
	private String regDt 	=  "";	// 등록일자
	private int    updNo 	=   0;	// 수정자 번호
	private String updDt 	=  "";	// 수정일자
	private int    stat 	=   0;	// 상태
	
	@Override
	public String toString() {
		return "AcntVO [acntNo=" + acntNo + ", userSeq=" + userSeq + ", bankNm=" + bankNm + ", currBal=" + currBal
				+ ", accPwd=" + accPwd + ", regNo=" + regNo + ", regDt=" + regDt + ", updNo=" + updNo + ", updDt="
				+ updDt + ", stat=" + stat + "]";
	}
	
}
