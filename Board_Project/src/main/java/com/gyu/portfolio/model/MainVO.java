package com.gyu.portfolio.model;

import com.gyu.portfolio.common.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MainVO extends DefalutVO {
	
	private int    mainSeq 		=   0;  // 메인 일련번호
	private String mainSe 		=  ""; 	// 메인 구분(B, T, P)
	private String topBnTtl 	=  ""; 	// 상단 배너명
	private String bottomBnTtl 	=  ""; 	// 하단 배너명
	private String techNm 		=  "";	// 기술명
	private String poforNm 		=  "";	// 포트폴리오명
	private String expln 		=  "";	// 설명
	private int    regNo 		=   0;	// 등록자 번호
	private String regDt 		=  "";	// 등록일자
	private int    updNo 		=   0;	// 수정자 번호
	private String updDt 		=  "";	// 수정일자
	private int    stat 		=   0;	// 상태 ex) 미사용(삭제)[0] / 사용[1]
	
	@Override
	public String toString() {
		return "MainVO [mainSeq=" + mainSeq + ", mainSe=" + mainSe + ", topBnTtl=" + topBnTtl + ", bottomBnTtl="
				+ bottomBnTtl + ", techNm=" + techNm + ", poforNm=" + poforNm + ", expln=" + expln + ", regNo=" + regNo
				+ ", regDt=" + regDt + ", updNo=" + updNo + ", updDt=" + updDt + ", stat=" + stat + "]";
	}
	
}
