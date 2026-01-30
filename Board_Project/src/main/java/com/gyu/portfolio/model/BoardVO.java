package com.gyu.portfolio.model;

import java.util.Arrays;

import com.gyu.portfolio.common.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardVO extends DefalutVO {
	
	private int    boardSeq =  0;  // 게시물 번호
	private int    bbsSeq 	=  0;  // 게시판 번호
	private String title 	= "";  // 제목
	private String cont 	= "";  // 내용
	private int    ref 		=  0;
	private int    step 	=  0;
	private int    lvl 		=  0;
	private String pwdYn 	= "";
	private String pwd 		= "";  // password
	private int    readCnt 	=  0;  // 조회수
	private int    srtOrd 	=  0;	// 정렬순서
	private int    regNo 	=  0;  // 등록자 번호
	private String regDt 	= "";  // 등록일자
	private int    updNo 	=  0;  // 수정자 번호
	private String updDt 	= "";  // 수정일자
	private int    stat 	=  0;  // 상태 ex) 미사용(삭제)[0] / 사용[1] / 영구삭제[9]
	
	/* 그 외 필드 */
	private String replyYn 	 = "";
	private String atchYn 	 = "";
	private String secrtYn 	 = "";
	private String bbsStat 	 = "";
	private String bbsNm 	 = "";
	private String rsMatch 	 = "";
	private String thumbInfo = "";
	private String[] delSeqArr  = null;

	private String filePath		= "";
	private String strgFileNm	= "";
	private String pFilePath	= "";
	private String pStrgFileNm	= "";
	private String myPageYn		= "N";
	
	private int    rowNum 	=  0;
	private int    cmntCnt 	=  0;
	private int    boardCnt =  0;
	private int    tempCnt 	=  0;
	private int    atchCnt 	=  0;
	
	@Override
	public String toString() {
		return "BoardVO [boardSeq=" + boardSeq + ", bbsSeq=" + bbsSeq + ", title=" + title + ", cont=" + cont + ", ref="
				+ ref + ", step=" + step + ", lvl=" + lvl + ", pwdYn=" + pwdYn + ", pwd=" + pwd + ", readCnt=" + readCnt
				+ ", srtOrd=" + srtOrd + ", regNo=" + regNo + ", regDt=" + regDt + ", updNo=" + updNo + ", updDt="
				+ updDt + ", stat=" + stat + ", replyYn=" + replyYn + ", atchYn=" + atchYn + ", secrtYn=" + secrtYn
				+ ", bbsStat=" + bbsStat + ", bbsNm=" + bbsNm + ", rsMatch=" + rsMatch + ", thumbInfo=" + thumbInfo
				+ ", delSeqArr=" + Arrays.toString(delSeqArr) + ", filePath=" + filePath + ", strgFileNm=" + strgFileNm
				+ ", pFilePath=" + pFilePath + ", pStrgFileNm=" + pStrgFileNm + ", myPageYn=" + myPageYn + ", rowNum="
				+ rowNum + ", cmntCnt=" + cmntCnt + ", boardCnt=" + boardCnt + ", tempCnt=" + tempCnt + ", atchCnt="
				+ atchCnt + "]";
	}
	
}
