package com.gyu.portfolio.model;

import java.util.Arrays;

import com.gyu.portfolio.common.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MainVO extends DefalutVO {
	
	private int    mainSeq 		=   0;  // 메인 일련번호
	private String mainSe 		=  ""; 	// 메인 구분(B, T, P)
	private String topBnNm 		=  ""; 	// 상단 배너명
	private String botmBnNm 	=  ""; 	// 하단 배너명
	private String techNm 		=  "";	// 기술명
	private String poforNm 		=  "";	// 포트폴리오명
	private int    srtOrd 		=   0;	// 정렬순서
	private int    regNo 		=   0;	// 등록자 번호
	private String regDt 		=  "";	// 등록일자
	private int    updNo 		=   0;	// 수정자 번호
	private String updDt 		=  "";	// 수정일자
	private int    stat 		=   0;	// 상태 ex) 미사용(삭제)[0] / 사용[1]
	
	/* 그 외 필드 */
	private int    boardSeq 	=  0;  // 게시물 번호
	private String fileNm 		= "";  // 파일이름(원본명)
	private String fileExt		= "";  // 파일확장자
	private long   fileSz 		=  0;  // 파일크기
	private String filePath		= "";  // 파일경로
	private String strgFileNm	= "";  // 파일이름(저장명)
	private String thumbYn 		= "";  // 썸네일여부(Y, N)

	private String taRegDt 		=  "";	// 이미지 등록일자
	private String taUpdDt 		=  "";	// 이미지 수정일자
	
	private String[] arrMainSeq    = null;
	private String[] arrTechNm     = null;
	private String[] arrFileOrgNm  = null;	// 파일이름(원본명)
	private String[] arrFileSvgNm  = null;	// 파일이름(저장명)
	private String[] arrFileExt    = null;	// 파일확장자
	private String[] arrFilePath   = null;	// 파일경로
	private long[]   arrFileSize   = null;	// 파일크기(Byte)
	private String[] arrThumbYn    = null;  // 썸네일여부(Y, N)
	private String[] delSeqArr 	   = null;
	private String[] mainSeqArr    = null;
	private String[] srtOrdArr     = null;
	
	@Override
	public String toString() {
		return "MainVO [mainSeq=" + mainSeq + ", mainSe=" + mainSe + ", topBnNm=" + topBnNm + ", botmBnNm=" + botmBnNm
				+ ", techNm=" + techNm + ", poforNm=" + poforNm + ", srtOrd=" + srtOrd + ", regNo=" + regNo + ", regDt="
				+ regDt + ", updNo=" + updNo + ", updDt=" + updDt + ", stat=" + stat + ", boardSeq=" + boardSeq
				+ ", fileNm=" + fileNm + ", fileExt=" + fileExt + ", fileSz=" + fileSz + ", filePath=" + filePath
				+ ", strgFileNm=" + strgFileNm + ", thumbYn=" + thumbYn + ", taRegDt=" + taRegDt + ", taUpdDt="
				+ taUpdDt + ", arrMainSeq=" + Arrays.toString(arrMainSeq) + ", arrTechNm=" + Arrays.toString(arrTechNm)
				+ ", arrFileOrgNm=" + Arrays.toString(arrFileOrgNm) + ", arrFileSvgNm=" + Arrays.toString(arrFileSvgNm)
				+ ", arrFileExt=" + Arrays.toString(arrFileExt) + ", arrFilePath=" + Arrays.toString(arrFilePath)
				+ ", arrFileSize=" + Arrays.toString(arrFileSize) + ", arrThumbYn=" + Arrays.toString(arrThumbYn)
				+ ", delSeqArr=" + Arrays.toString(delSeqArr) + ", mainSeqArr=" + Arrays.toString(mainSeqArr)
				+ ", srtOrdArr=" + Arrays.toString(srtOrdArr) + "]";
	}
	
}
