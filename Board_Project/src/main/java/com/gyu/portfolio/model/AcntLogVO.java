package com.gyu.portfolio.model;

import com.gyu.portfolio.common.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AcntLogVO extends DefalutVO {
	
	private int    logSeq  		=   0;	// 로그일련번호
	private String acntNo   	=  "";  // 계좌번호
	private String trxType 		=  ""; 	// 거래유형
	private String trxAmnt  	=  "";	// 거래금액
	private String otherAcntNo 	=  "";	// 상대방 계좌번호
	private String otherBacnkNm =  "";	// 상대방 은행명
	private String regDt 		=  "";	// 거래일시
	private int    stat 		=   0;	// 상태
	
	@Override
	public String toString() {
		return "AcntLogVO [logSeq=" + logSeq + ", acntNo=" + acntNo + ", trxType=" + trxType + ", trxAmnt=" + trxAmnt
				+ ", otherAcntNo=" + otherAcntNo + ", otherBacnkNm=" + otherBacnkNm + ", regDt=" + regDt + ", stat="
				+ stat + "]";
	}
	
}
