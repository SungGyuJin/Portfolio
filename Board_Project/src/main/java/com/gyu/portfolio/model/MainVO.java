package com.gyu.portfolio.model;

import com.gyu.portfolio.common.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MainVO extends DefalutVO {
	
	private int    mainSeq 		=   0;  // 메인 일련번호
	private String bannerTtl1 	=  ""; 	// 배너명1
	private String bannerTtl2 	=  "";	// 배너명2
	private String techNm 		= "N";	// 기술명
	private int    regNo 		=   0;	// 등록자 번호
	private String regDt 		=  "";	// 등록일자
	private int    updNo 		=   0;	// 수정자 번호
	private String updDt 		=  "";	// 수정일자
	private int    stat 		=   0;	// 상태 ex) 미사용(삭제)[0] / 사용[1]
	
	@Override
	public String toString() {
		return "MainVO [mainSeq=" + mainSeq + ", bannerTtl1=" + bannerTtl1 + ", bannerTtl2=" + bannerTtl2 + ", techNm="
				+ techNm + ", regNo=" + regNo + ", regDt=" + regDt + ", updNo=" + updNo + ", updDt=" + updDt + ", stat="
				+ stat + "]";
	}
	
}
