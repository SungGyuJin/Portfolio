package com.gyu.portfolio.common;

public class PageMakerDTO {

	/* 시작 페이지 */
	private int startPage;

	/* 끝 페이지 */
	private int endPage;

	/* 이전 페이지, 다음 페이지 존재유무 */
	private boolean prev, next;

	/* 전체 게시물 수 */
	private int total;

	/* 보여지는 페이지 버튼(Num)의 수 */
	private int pageBtnCnt = 10;
	
	/* 실제 데이터 끝 페이지 */
	private int realEndPageNum = 1;
	
	/* 현재 페이지, 페이지당 게시물 표시수 정보 */
	private DefalutVO cri;

	public PageMakerDTO(DefalutVO cri, int total) {

		this.cri = cri;
		this.total = total;

		/* 마지막 페이지 */
		this.endPage = (int) (Math.ceil(cri.getPageNum() / (double) pageBtnCnt)) * pageBtnCnt;

		/* 시작 페이지 */
		this.startPage = this.endPage - (pageBtnCnt - 1);

		/* 전체 마지막 페이지 */
		int realEnd = (int) (Math.ceil(total * 1.0 / cri.getAmount()));
		
		this.realEndPageNum = realEnd;
		
		/*
		 * 전체 마지막 페이지(realend)가 화면에 보이는 마지막페이지(endPage)보다 작은 경우, 보이는 페이지(endPage) 값 조정
		 */
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}

		/* 시작 페이지(startPage)값이 1보다 큰 경우 true */
		this.prev = this.startPage > 1;

		/* 마지막 페이지(endPage)값이 1보다 큰 경우 true */
		this.next = this.endPage < realEnd;

	}

	public int getPageBtnCnt() {
		return pageBtnCnt;
	}

	public void setPageBtnCnt(int pageBtnCnt) {
		this.pageBtnCnt = pageBtnCnt;
	}

	public int getRealEndPageNum() {
		return realEndPageNum;
	}

	public void setRealEndPageNum(int realEndPageNum) {
		this.realEndPageNum = realEndPageNum;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public DefalutVO getCri() {
		return cri;
	}

	public void setCri(DefalutVO cri) {
		this.cri = cri;
	}

}
