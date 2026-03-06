<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>

<script>
$(function(){
	
	$(".payBtn").on('click', function(){
		
		if($(this).val() == 0){
			$("#sendAmount").val("0");
			return false;
		}
		
		var rsAmnt = 0;
		var oldAmnt = $("#sendAmount").val().replace(/,/g, "");
		var newAmnt = $(this).val();
		
		rsAmnt = Number(oldAmnt) + Number(newAmnt);
		
		$("#sendAmount").val(rsAmnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		
		
	});
	
});


</script>

<!-- fnce Modal Page -->

<div class="portfolio-modal modal fade" id="getModalList-159" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered mx-auto" style="max-width: 900px;"> <div class="modal-content shadow-lg border-0">
            <div class="close-modal" data-bs-dismiss="modal" style="cursor:pointer; position:absolute; right:20px; top:20px; z-index:999;">
                <img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close" style="width: 30px;"/>
            </div>
            <div class="modal-body p-0">
                <div class="row g-0">
                    <div class="col-md-4 bg-dark text-white p-4">
                        <div class="user-info-section mb-4">
                            <h5 class="fw-bold mb-3">내 자산 현황</h5>
                            <div class="card bg-secondary border-0 mb-3">
                                <div class="card-body">
                                    <p class="small mb-1 text-light">주거래 계좌</p>
                                    <h4 class="fw-bold text-warning mb-0">5,000,000 원</h4>
                                    <p class="x-small text-muted mt-2 mb-0">신한 110-456-789012</p>
                                </div>
                            </div>
                        </div>

                        <div class="recent-transfer mt-5">
                            <h6 class="small fw-bold text-muted mb-3 text-uppercase">최근 이체 대상</h6>
                            <div class="small">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>김철수(신한)</span>
                                    <span class="text-muted">110-***</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>이영희(우리)</span>
                                    <span class="text-muted">1002-***</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-8 p-5 bg-white">
                        <h3 class="fw-bold mb-4">돈 보내기</h3>
                        <hr>
                        <form id="transferForm">
                            <div class="mb-4">
                                <label class="form-label small fw-bold text-primary">받는 분</label>
                                <div class="input-group">
                                    <select class="form-select border-primary-subtle" style="width: 30%;">
                                        <option selected>은행 선택</option>
                                        <option>신한</option><option>우리</option><option>국민</option>
                                    </select>
                                    <input type="text" class="form-control w-50" placeholder="계좌번호를 입력하세요.">
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label small fw-bold text-primary">보낼 금액</label>
                                <div class="input-group input-group-lg">
                                    <input type="text" class="form-control text-end" id="sendAmount" placeholder="0">
                                    <span class="input-group-text bg-white">원</span>
                                </div>
                                <div class="mt-2 d-flex gap-1 justify-content-end">
                                    <button type="button" class="btn btn-sm btn-outline-secondary payBtn" value="10000">+ 1만</button>
                                    <button type="button" class="btn btn-sm btn-outline-secondary payBtn" value="50000">+ 5만</button>
                                    <button type="button" class="btn btn-sm btn-outline-secondary payBtn" value="100000">+ 10만</button>
                                    <button type="button" class="btn btn-sm btn-outline-primary payBtn" value="0">0원</button>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label small fw-bold text-primary">받는 분 통장 표시</label>
                                <input type="text" class="form-control" placeholder="메모를 입력하세요(선택)">
                            </div>

                            <button type="button" class="btn btn-primary btn-lg w-100 fw-bold py-3 mt-3" onclick="doTransfer()">
                                이체하기
                            </button>
                        </form>
                    </div>
                </div> 
			</div>
        </div>
    </div>
</div>
        
