<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<body>

<script>

	$(function(){
		
		initBbs('init');
		
		// 신규등록 버튼
		$("#btn-new").on('click', function(){
			$("#frm-typ").val('add');
			initBbs('click');
			$("#btn-new").prop("disabled", true);
			$("#bbsSeq").val('0');
			$("#btn-text-span").html('등록완료');
			
			// 버튼삭제
			$("#btn-restore").addClass('d-none');	// 복구버튼
			$("#btn-del").addClass('d-none');		// 삭제버튼
			$("#btn-delPermnt").addClass('d-none');	// 영구삭제 버튼
		});
		
		$(".btn-list").on('click', function(){
			location.href = 'list.do?listTyp='+$(this).val();
		});
		
		if($("#listTyp").val() == 'list'){
			$("#bbs-ttl").html('게시판 목록');
			$("#btn-list").prop('disabled', true);
			$("#btn-trash").prop('disabled', false);
		}else{
			$("#bbs-ttl").html('휴지통');
			$("#btn-list").prop('disabled', false);
			$("#btn-trash").prop('disabled', true);
		}
		
	});
	
	// 버튼제어
	function btnControl(e, num){
		if(e == 'add'){
			btnRegister();
		}else if(e == 'reset'){
			btnReset();
		}else{
			changeStat_1(num);
		}
	}

	// 게시판 등록&수정
	function btnRegister(){
		if($("#frm-typ").val() == 'add'){
			addBbs();
		}else{
			updateBbs();
		}
	}
	
	// 취소버튼
	function btnReset(){
		if($("#frm-typ").val() == 'add'){
			$("#nm").val('');
			$("#expln").val('');
			$(".init-class").prop("checked", false);
		}else{
			getBbs($("#bbsSeq").val());
		}
	}
	
	// 복구, 삭제, 영구삭제 버튼(상태변경)
	function changeStat_1(num){
		
		if(num == '9'){
			Swal.fire({
				title: '영구삭제 하시겠습니까?',
				html: "※삭제된 데이터는 복구가 불가합니다.",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '확인',
				cancelButtonText: '취소'
			}).then(function(result){

		        if (result.isConfirmed) {
		        	$("#stat").val(num);
		        	changeStat_2(num, '영구삭제완료');
		        }
			})
		}else if(num == '1'){
        	$("#stat").val(num);
			changeStat_2(num, '복구완료');
		}else{
        	$("#stat").val(num);
			changeStat_2(num, '삭제완료');
		}
	}
	
	function changeStat_2(num, cmnt){
		$.ajax({
			url      : "changeStat.do",
			method   : "POST",
			data     : $("#frm-addBbs").serialize(),
			dataType : "json",
			success  : function(res){
				
				if(res > 0){
					Swal.fire({
						icon: "success",
						title: cmnt
					}).then(function(){
						location.reload();
					});
				}else{
					Swal.fire({
						icon: "error",
						title: "기능오류"
					})
				}
				
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
	}
	
	// 게시판 form 옵션변화 (ex.초기화면 세팅)
	function initBbs(e){
		if(e == 'init'){
			$(".init-class").prop("disabled", true);
		}else{
			if($("#frm-typ").val() == 'add'){
				$("#nm").val('');
				$("#expln").val('');
				$("#ttl-typ").html('등록');
				$(".init-class").prop("disabled", false);
				$(".init-class").prop("checked", false);
			}else{
// 				$("#ttl-typ").html('수정 / <span class="text-success">복구</span> / <span class="text-danger">삭제</span>');
				$("#ttl-typ").html('수정');
				$(".init-class").prop("disabled", false);
			}
			$("#nm").focus();
		}
	}
	
	// 게시판 등록
	function addBbs(){
		
		$.ajax({
			url      : "addBbs.do",
			method   : "POST",
			data     : $("#frm-addBbs").serialize(),
			dataType : "json",
			success  : function(res){
				
				if(res > 0){
					Swal.fire({
						icon: "success",
						title: "등록완료"
					}).then(function(){
						location.href = 'list.do';
					});
				}else{
					Swal.fire({
						icon: "error",
						title: "저장 오류"
					})
				}
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
	}
	
	// 게시판 수정
	function updateBbs(){
		
		$.ajax({
			url      : "updateBbs.do",
			method   : "POST",
			data     : $("#frm-addBbs").serialize(),
			dataType : "json",
			success  : function(res){
				
				if(res > 0){
					Swal.fire({
						icon: "success",
						title: "수정완료"
					}).then(function(){
// 						location.reload();
						$("#nm-"+$("#bbsSeq").val()).text($("#nm").val());
					});
				}else{
					Swal.fire({
						icon: "error",
						title: "저장 오류"
					})
				}
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
	}
	
	// 게시만 조회
	function getBbs(no){
		

		$("table tr").removeClass('table-active');
		$("#tr-"+no).addClass('table-active');
		
		$("#frm-typ").val('upd');
		initBbs('click');
		$("#btn-new").prop("disabled", false);
		$("#btn-text-span").html('수정완료');
		
		$.ajax({
			url      : "getBbs.do",
			method   : "GET",
			data     : {"no" : no},
			dataType : "json",
			success  : function(res){
				
				var getBbs = res.getBbs;
				
				$("#temp-stat").val(getBbs.stat);

				// 버튼변화
				if(getBbs.stat == '1'){
					$("#btn-del").removeClass('d-none');	// 삭제버튼 추가
					$("#btn-restore").addClass('d-none');	// 복구버튼 제거
					$("#btn-delPermnt").addClass('d-none');	// 영구삭제버튼 제거
				}else{
					
					if(getBbs.stat == '0'){
						$("#btn-del").addClass('d-none');			// 삭제버튼 삭제
						$("#btn-restore").removeClass('d-none');	// 복구버튼 추가
						$("#btn-delPermnt").removeClass('d-none');	// 영구삭제버튼 추가
					}else{
						
					}
				}
				
				$("#bbsSeq").val(getBbs.bbsSeq);
				$("#nm").val(getBbs.nm);
				$("#expln").val(getBbs.expln);
				$("#stat").val(getBbs.stat);

				getBbs.replyYn 	== 'Y' ? $("#replyYn").prop('checked',  true) : $("#replyYn").prop('checked',  false);
				getBbs.comentYn == 'Y' ? $("#comentYn").prop('checked', true) : $("#comentYn").prop('checked', false);
				getBbs.atchYn 	== 'Y' ? $("#atchYn").prop('checked',   true) : $("#atchYn").prop('checked',   false);
				getBbs.secrtYn 	== 'Y' ? $("#secrtYn").prop('checked',  true) : $("#secrtYn").prop('checked',  false);
					
				
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
	}
	
</script>

<input type="hidden" id="frm-typ" value="add" />

<div id="content">
	<!-- Begin Page Content -->
	<div class="container-fluid">

      	<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
         	<h1 class="h3 mb-0 text-gray-800 ml-1"><strong>게시판 관리</strong></h1>
<!--          	<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a> -->
     	</div>

		<div class="row">
			<div class="col-xl-9 col-lg-7">
    			<div class="card shadow mb-4">
					<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
    					<h5 class="m-0 font-weight-bold text-primary"><span id="bbs-ttl">게시판 목록</span> (${total })</h5>
    					<div class="dropdown no-arrow">
	        				<!-- <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	    						<i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
							</a> -->
					        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
					            <div class="dropdown-header">Dropdown Header:</div>
					            <a class="dropdown-item" href="#">Action</a>
					            <a class="dropdown-item" href="#">Another action</a>
					            <div class="dropdown-divider"></div>
					            <a class="dropdown-item" href="#">Something else here</a>
					        </div>
	    					<button class="btn btn-primary btn-icon-split btn-list" id="btn-list" title="목록보기" value="list">
	    						<span class="text"><i class="fas fa-fw fa-table"></i> 목록</span>
			    			</button>
	    					<button class="btn btn-danger btn-icon-split btn-list" id="btn-trash" title="휴지통" value="trash">
	    						<span class="text"><i class="fas fa-trash"></i> 휴지통</span>
			    			</button>
    					</div>
					</div>
					
					<!-- Card Body -->
					<div class="card-body">
<%-- 							<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }" /> --%>
<%-- 							<input type="hidden" name="amount" value="${pageMaker.cri.amount }"  /> --%>
						<form id="frm-search" method="get">
							<input type="hidden" name="listTyp" id="listTyp" value="${bbsVO.listTyp }" readonly="readonly">
					    	<div class="table-responsive" style="overflow-x: hidden;">
					  			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
									<div class="row">
										<div class="col-sm-12">
											<table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
												<colgroup>
													<col width="30">	<!-- 게시판명 	-->
													<col width="100"> 	<!-- 등록일시 	-->
													<col width="100"> 	<!-- 수정일시 	-->
													<col width="20"> 	<!-- 상태    	-->
												</colgroup>
												<thead>
												    <tr role="row">
												    	<th class="sorting sorting_asc text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 154px;">게시판명</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">등록일시</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">수정일시</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">상태</th>
												    </tr>
												</thead>
												<tbody>
													<c:forEach var="list" varStatus="varStatus" items="${getBbsList }">
													<tr class="text-center" onclick="getBbs(${list.bbsSeq});" id="tr-${list.bbsSeq }">
														<td class="sorting_1" id="nm-${list.bbsSeq }">${list.nm }</td>
														<td>${list.regDt }</td>
														<td>${list.updDt }</td>
														<td>
															<c:choose>
																<c:when test="${list.stat eq 1 }">
																	<strong class="ms-3"><span class="text-primary">사용중</span></strong>
																</c:when>
																<c:otherwise>
																	<strong class="ms-3"><span class="text-danger">삭제됨</span></strong>
																</c:otherwise>
															</c:choose>
													    </td>
													</tr>
													</c:forEach>
													<c:if test="${empty getBbsList }">
													<tr class="text-center">
														<td colspan="5">
															<c:if test="${bbsVO.listTyp eq 'list' }"><strong class="text-lg"><br>등록된 게시판이 없습니다.<br><br></strong></c:if>
															<c:if test="${bbsVO.listTyp eq 'trash' }"><strong class="text-lg"><br>삭제된 게시판이 없습니다.<br><br></strong></c:if>
														</td>
													</tr>
													</c:if>
									        	</tbody>
											</table>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12 col-md-7">
											<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
										 		<ul class="pagination">
										 			
									 			 	<!-- 이전페이지 버튼 -->
									 			 	<c:if test="${pageMaker.prev}">
														<li class="paginate_button page-item previous" id="dataTable_previous"><a href="/admin/bbs/list.do?pageNum=${pageMaker.startPage-1}" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
									 				</c:if>
									 				
									 				<!-- 페이지 번호 -->
													<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
										 				<li class="paginate_button page-item <c:if test="${pageMaker.cri.pageNum eq num }"> active</c:if>"><a href="/admin/bbs/list.do?pageNum=${num }&amp;searchKeyword=${bbsVO.searchKeyword}" aria-controls="dataTable" data-dt-idx="${num }" tabindex="0" class="page-link">${num }</a></li>
													</c:forEach>
													
													<!-- 다음페이지 버튼 -->
													<c:if test="${pageMaker.next}">
											  			<li class="pageInfo_btn page-item next" id="dataTable_next"><a href="/admin/bbs/list.do?pageNum=${pageMaker.endPage + 1 }" aria-controls="dataTable" data-dt-idx="${pageMaker.endPage + 1 }" tabindex="0" class="page-link">Next</a></li>
													</c:if>
										 		</ul>
											</div>
										</div>
										<div class="col-sm-12 col-md-5 text-right">
											<!-- <div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">Showing 1 to 10 of 57 entries</div> -->
											<div class="input-group w-75 mb-1" style="display: inline-flex; width: auto;">
									    		<input type="text" class="form-control bg-light border-0 small" name="searchKeyword" placeholder="게시판명을 입력하세요." aria-label="Search" aria-describedby="basic-addon2" autocomplete="off" value="${bbsVO.searchKeyword }">
									    		<div class="input-group-append">
											        <button type="submit" class="btn btn-primary" type="button">
											            <i class="fas fa-search"></i>
											        </button>
									    		</div>
											</div>
										</div>
									</div>
	      						</div>
	       					</div>
       					
						</form>
   					</div>
         		</div>
     		</div>

			<div class="col-xl-3 col-lg-5">
			    <div class="card shadow mb-4">
			        	<!-- Card Header - Dropdown -->
						<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
						    <h5 class="m-0 font-weight-bold text-primary">게시판 <span id="ttl-typ">등록</span></h5>
						    <button class="btn btn-primary btn-icon-split" id="btn-new">
						        <span class="text">신규등록</span>
						   	</button>
						</div>
						<!-- .card-body START -->
	                    <div class="card-body">
	                   		<form class="user" id="frm-addBbs">
	                   			<input type="hidden" name="stat" id="stat" value="1" readonly="readonly"/>
	                    		<input type="hidden" name="bbsSeq" id="bbsSeq" value="0" readonly="readonly" />
	                      		<div class="form-group">
	                      			<label for="bbs-title"><strong>게시판명</strong></label>
	                          		<input type="email" class="form-control form-control-user init-class" name="nm" id="nm" placeholder="게시판명" autocomplete="off">
	                      		</div>
	                    		<div class="form-group">
		                      		<label for="bbs-title"><strong>설명</strong></label>
		                         	<input type="email" class="form-control form-control-user init-class" name="expln" id="expln" placeholder="설명" autocomplete="off">
	                      		</div>
	                      		<hr>
<!-- 	                      		<small class="text-danger"><strong>*게시판 옵션을 선택하세요.</strong></small> -->
	                      		<small class="text-danger">* 게시판 옵션을 선택하세요.</small>
				             	<div class="form-group row mt-2">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<label class="toggle-wrapper">
											<strong>답글</strong>
										  	<input type="checkbox" class="tiny-toggle init-class" id="replyYn" name="replyYn" value="Y" />
									  		<span class="tiny-slider"></span>
										</label>
									</div>
		                      	 	<div class="col-sm-6 mb-3 mb-sm-0">
										<label class="toggle-wrapper">
										  <strong>첨부파일</strong>
										  <input type="checkbox" class="tiny-toggle init-class" id="atchYn" name="atchYn" value="Y" />
										  <span class="tiny-slider"></span>
										</label>
									</div>
								</div>
			                      
		                      	<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<label class="toggle-wrapper">
										  	<strong>댓글</strong>
										  	<input type="checkbox" class="tiny-toggle init-class" id="comentYn" name="comentYn" value="Y" />
										  	<span class="tiny-slider"></span>
										</label>
									</div>
									<div class="col-sm-6 mb-3 mb-sm-0">
										<label class="toggle-wrapper">
											<strong>비밀&nbsp;글</strong>
											<input type="checkbox" class="tiny-toggle init-class" id="secrtYn" name="secrtYn" value="Y" />
											<span class="tiny-slider"></span>
										</label>
			                        </div>
		                      	</div>
							</form>
			  
							<!-- <div class="mt-4 text-center small mb-2">
							    <span class="mr-2">
							        <i class="fas fa-circle text-primary"></i> Direct
							    </span>
							    <span class="mr-2">
							        <i class="fas fa-circle text-success"></i> Social
							    </span>
							    <span class="mr-2">
							        <i class="fas fa-circle text-info"></i> Referral
							    </span>
							</div> -->
			
						<div class="text-center">
							<div class="d-flex justify-content-between">
								<div>
									<div id="btn-divTag1">
<!-- 										<button class="btn btn-primary btn-icon-split init-class" id="btn-save" onclick="bbsPostFlag();"> -->
										<button class="btn btn-primary btn-icon-split init-class" id="btn-save" onclick="btnControl('add');">
<!-- 										    <span class="icon text-white-50"><i class="fas fa-check"></i></span> -->
									    	<span class="text" id="btn-text-span">등록완료</span>
										</button>
<!-- 										<button class="btn btn-secondary btn-icon-split init-class" id="btn-reset" onclick="btnReset();"> -->
										<button class="btn btn-secondary btn-icon-split init-class" id="btn-reset" onclick="btnControl('reset');">
<!-- 											<span class="icon text-white-50"><i class="fas fa-arrow-left"></i></span> -->
						         			<span class="text">취소</span>
						    			</button>
									</div>
								</div>
								<div id="btn-divTag2">
<!-- 									<button class="btn btn-success btn-icon-split init-class d-none" id="btn-restore" onclick="btnDel(4);"> -->
									<button class="btn btn-success btn-icon-split init-class d-none" id="btn-restore" onclick="btnControl('stat', '1');">
<!-- 										<span class="icon text-white-50"><i class="fas fa-trash"></i></span> -->
					         			<span class="text">복구</span>
					    			</button>
									<button class="btn btn-danger btn-icon-split init-class d-none" id="btn-del" onclick="btnControl('stat', '0');">
<!-- 										<span class="icon text-white-50"><i class="fas fa-trash"></i></span> -->
					         			<span class="text">삭제</span>
					    			</button>
									<button class="btn btn-danger btn-icon-split init-class d-none" id="btn-delPermnt" onclick="btnControl('stat', '9');">
<!-- 										<span class="icon text-white-50"><i class="fas fa-trash"></i></span> -->
				         				<span class="text">영구삭제</span>
				    				</button>
			    				</div>
							</div>
			    		</div>
					</div>	<!-- .card-body END -->
					
				</div>
			</div>
    	</div>
	</div>
</div>
</body>
