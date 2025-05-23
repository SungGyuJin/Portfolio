package com.gyu.portfolio.model;

import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

import com.gyu.portfolio.common.DefalutVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttachVO extends DefalutVO {

	private int    attachSeq 	=  0;  // 첨부파일 일련번호
	private int    boardSeq 	=  0;  // 게시물 번호
	private String fileNm 		= "";  // 파일이름(원본명)
	private String fileExt		= "";  // 파일확장자
	private long   fileSz 		=  0;  // 파일크기
	private String filePath		= "";  // 파일경로
	private String strgFileNm	= "";  // 파일이름(저장명)
	private String thumbYn 		= "";  // 썸네일여부(Y, N)
	private int    dwnldCnt 	=  0;  // 다운횟수?

	private int    regNo 		=  0;  // 등록자 번호
	private String regDt 		= "";  // 등록일자
	private int    updNo 		=  0;  // 수정자 번호
	private String updDt 		= "";  // 수정일자
	private int    stat 		=  0;  // 상태 ex) 미사용(삭제)[0] / 사용[1] / 영구삭제[9]
	
	
	/* 그 외 필드 */
	private MultipartFile files[]  = null;
	
	private String[] arrFileOrgNm  = null;	// 파일이름(원본명)
	private String[] arrFileSvgNm  = null;	// 파일이름(저장명)
	private String[] arrFileExt    = null;	// 파일확장자
	private String[] arrFilePath   = null;	// 파일경로
	private long[]   arrFileSize   = null;	// 파일크기(Byte)
	
	@Override
	public String toString() {
		return "AttachVO [attachSeq=" + attachSeq + ", boardSeq=" + boardSeq + ", fileNm=" + fileNm + ", fileExt="
				+ fileExt + ", fileSz=" + fileSz + ", filePath=" + filePath + ", strgFileNm=" + strgFileNm
				+ ", thumbYn=" + thumbYn + ", dwnldCnt=" + dwnldCnt + ", regNo=" + regNo + ", regDt=" + regDt
				+ ", updNo=" + updNo + ", updDt=" + updDt + ", stat=" + stat + ", files=" + Arrays.toString(files)
				+ ", arrFileOrgNm=" + Arrays.toString(arrFileOrgNm) + ", arrFileSvgNm=" + Arrays.toString(arrFileSvgNm)
				+ ", arrFileExt=" + Arrays.toString(arrFileExt) + ", arrFilePath=" + Arrays.toString(arrFilePath)
				+ ", arrFileSize=" + Arrays.toString(arrFileSize) + "]";
	}
	
	
	
}
