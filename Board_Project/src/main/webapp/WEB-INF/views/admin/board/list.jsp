<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<body>

<script>

	$(function(){
		
		$(".btn-list").on('click', function(){
			location.href = 'list.do?listTyp='+$(this).val();
		});
		
		if($("#listTyp").val() == 'list'){
			$("#bbs-ttl").html('게시물 목록');
			$("#btn-list").prop('disabled', true);
			$("#btn-trash").prop('disabled', false);
		}else{
			$("#bbs-ttl").html('휴지통');
			$("#btn-list").prop('disabled', false);
			$("#btn-trash").prop('disabled', true);
		}
		
		$("#bbsSeq").on('change', function(e){
			$("#frm-search").submit();
		});
		
	});
	
	// 버튼제어
	function btnControl(e, num){
		
		if(e == 'move'){
			location.href = 'updateBoard.do?boardSeq='+$("#boardSeq").val()+'&pageNum='+$("#pageNum").val()+'&listTyp='+$("#listTyp").val()+'&searchKeyword='+$("#searchKeyword").val()+'&gubun='+$("#gubun").val()+'&bbsSeq='+$("#bbsSeq").val();
		}else if(e == 'reply'){
			location.href = 'replyBoard.do?boardSeq='+$("#boardSeq").val()+'&pageNum='+$("#pageNum").val()+'&listTyp='+$("#listTyp").val()+'&searchKeyword='+$("#searchKeyword").val()+'&gubun='+$("#gubun").val()+'&bbsSeq='+$("#bbsSeq").val();
		// 삭제, 복구 처리
		}else{
			changeStat_1(num);
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
			data     : $("#frm-board").serialize(),
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
	
	// 게시물 조회
	function getBoard(no){
		
		$("table tr").removeClass('table-active');
		$("#tr-"+no).addClass('table-active');
		
		$.ajax({
			url      : "getBoard.do",
			method   : "GET",
			data     : {"no" : no},
			dataType : "json",
			success  : function(res){
				
				var getBoard = res.getBoard;
				
				console.log(getBoard)
				
				$("#boardSeq").val(getBoard.boardSeq);
				$("#title").val(getBoard.title);
// 				$("#cont").val(getBoard.cont);
				$("#cont").html(getBoard.cont);
				$("#stat").val(getBoard.stat);
				$("#btn-move").prop('disabled', false);

				// 버튼변화
				if(getBoard.stat == '1'){
					$("#btn-del").removeClass('d-none');
					$("#btn-restore").addClass('d-none');
					$("#btn-delPermnt").addClass('d-none');
				}else{
					$("#btn-del").addClass('d-none');
					$("#btn-restore").removeClass('d-none');
					$("#btn-delPermnt").removeClass('d-none');
				}
				
				
// 				getBoard.replyYn 	== 'Y' ? $("#replyYn").prop('checked',  true) : $("#replyYn").prop('checked',  false);
// 				getBoard.comentYn == 'Y' ? $("#comentYn").prop('checked', true) : $("#comentYn").prop('checked', false);
// 				getBoard.atchYn 	== 'Y' ? $("#atchYn").prop('checked',   true) : $("#atchYn").prop('checked',   false);
// 				getBoard.secrtYn 	== 'Y' ? $("#secrtYn").prop('checked',  true) : $("#secrtYn").prop('checked',  false);
					
				
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

<input type="hidden" id="pageNum" value="${boardVO.pageNum }" />

<div id="content">
	<!-- Begin Page Content -->
	<div class="container-fluid">

      	<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
         	<h1 class="h3 mb-0 text-gray-800 ml-1"><strong>게시물 관리</strong></h1>
<!--          	<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a> -->
     	</div>

		<div class="row">
			<div class="col-xl-9 col-lg-7">
    			<div class="card shadow mb-4">
					<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
    					<h5 class="m-0 font-weight-bold text-primary"><span id="bbs-ttl">게시물 목록</span> (${total })</h5>
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
						<form id="frm-search" method="get">
							<input type="hidden" name="listTyp" id="listTyp" value="${boardVO.listTyp }" readonly="readonly">
							<div class="form-group mb-3">
	                          	<select class="form-control text-center border-primary" name="bbsSeq" id="bbsSeq">
	                          		<option value="0">전체 게시판</option>	
	                          	<c:forEach var="list" items="${getBbsList }">
	                          		<option value="${list.bbsSeq }" <c:if test="${list.bbsSeq eq boardVO.bbsSeq }">selected</c:if>>${list.nm }</option>
	                          	</c:forEach>
	                          	</select>
                            </div>
					    	<div class="table-responsive" style="overflow-x: hidden;">
					  			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
									<div class="row">
										<div class="col-sm-12">
											<table class="table table-bordered dataTable" id="dataTable" cellspacing="0" role="grid" aria-describedby="dataTable_info">
												<colgroup>
													<col width="5%">	<!-- No. -->
													<col width="25%">	<!-- 제목 -->
													<col width="5%"> 	<!-- 작성자 -->
													<col width="10%"> 	<!-- 등록일시 -->
													<col width="10%"> 	<!-- 수정일시 -->
													<col width="5%"> 	<!-- 첨부파일 -->
													<col width="5%"> 	<!-- 상태 -->
												</colgroup>
												<thead>
												    <tr role="row">
												    	<th class="sorting sorting_asc text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending">No.</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">제목</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">작성자</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">등록일시</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">수정일시</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">첨부파일</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">상태</th>
												    </tr>
												</thead>
												<tbody>
													<c:forEach var="list" varStatus="varStatus" items="${getBoardList }">
													<tr onclick="getBoard('${list.boardSeq}');" id="tr-${list.boardSeq }">
														<td class="sorting_1 text-center">
															<c:if test="${list.lvl eq 0 }">
																${list.rowNum }
															</c:if>
														</td>
														<td>
															<c:if test="${list.lvl eq 1 }">
																<c:forEach begin="0" end="${list.lvl }">&nbsp;</c:forEach>
																<img class="mb-1" src="${pageContext.request.contextPath}/resources/admin/assets/img/arrow-return-right.svg" />
																<span class="border px-1 py-0 fw-bold small text-primary"><strong>RE</strong></span>
															</c:if>
															<c:if test="${list.lvl gt 1 }">
																<c:forEach begin="0" end="${list.lvl }">&nbsp;&nbsp;</c:forEach>
																<img class="mb-1" src="${pageContext.request.contextPath}/resources/admin/assets/img/arrow-return-right.svg" />
																<span class="border px-1 py-0 fw-bold small text-primary"><strong>RE</strong></span>
															</c:if>
															${list.title }
														</td>
														<td class="text-center"><strong>${list.userNm }</strong></td>
														<td class="text-center">${list.regDt }</td>
														<td class="text-center">${list.updDt }</td>
														<td class="text-center p-0"><c:if test="${list.atchCnt gt 0 }"><img src="${pageContext.request.contextPath}/resources/admin/assets/img/atch_icon.png" class="mt-2" style="max-width: 30px;" /></c:if></td>
														<td class="text-center">
															<c:choose>
																<c:when test="${list.stat eq 1 }">
																	<strong class="ms-3"><span class="text-primary">게시중</span></strong>
																</c:when>
																<c:otherwise>
																	<strong class="ms-3"><span class="text-danger">삭제됨</span></strong>
																</c:otherwise>
															</c:choose>
													    </td>
													</tr>
													</c:forEach>
													<c:if test="${empty getBoardList }">
													<tr class="text-center">
														<td colspan="7">
															<c:if test="${boardVO.listTyp eq 'list' }"><strong class="text-lg"><br>등록된 게시물이 없습니다.<br><br></strong></c:if>
															<c:if test="${boardVO.listTyp eq 'trash' }"><strong class="text-lg"><br>삭제된 게시물이 없습니다.<br><br></strong></c:if>
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
										 			
										 			<%-- <fmt:parseNumber value = "${pageMaker.endPage}" var = "endPage"/>
										 			<fmt:parseNumber value = "${pageMaker.realEndPageNum}" var = "realEnd"/> --%>
										 			
									 			 	<!-- 첫페이지 버튼 -->
									 			 	<%-- <c:if test="${pageMaker.prev}">
														<li class="paginate_button page-item previous" id="dataTable_previous"><a href="/admin/board/list.do?pageNum=1&amp;searchKeyword=${boardVO.searchKeyword}&amp;bbsSeq=${boardVO.bbsSeq}" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">◀</a></li>
									 				</c:if> --%>
										 			
									 			 	<!-- 이전페이지 버튼 -->
									 			 	<c:if test="${pageMaker.prev}">
														<li class="paginate_button page-item previous" id="dataTable_previous"><a href="/admin/board/list.do?pageNum=${pageMaker.startPage-1}&amp;searchKeyword=${boardVO.searchKeyword}&amp;bbsSeq=${boardVO.bbsSeq}" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">&lt;</a></li>
									 				</c:if>
									 				
									 				<!-- 페이지 번호 -->
													<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
										 				<li class="paginate_button page-item <c:if test="${pageMaker.cri.pageNum eq num }"> active</c:if>"><a href="/admin/board/list.do?pageNum=${num }&amp;searchKeyword=${boardVO.searchKeyword}&amp;bbsSeq=${boardVO.bbsSeq}" aria-controls="dataTable" data-dt-idx="${num }" tabindex="0" class="page-link">${num }</a></li>
													</c:forEach>
													
													<!-- 다음페이지 버튼 -->
													<c:if test="${pageMaker.next}">
											  			<li class="pageInfo_btn page-item next" id="dataTable_next"><a href="/admin/board/list.do?pageNum=${pageMaker.endPage + 1 }&amp;searchKeyword=${boardVO.searchKeyword}&amp;bbsSeq=${boardVO.bbsSeq}" aria-controls="dataTable" data-dt-idx="${pageMaker.endPage + 1 }" tabindex="0" class="page-link">&gt;</a></li>
													</c:if>
													
													<!-- 끝페이지 버튼 -->
													<%-- <c:if test="${pageMaker.next}">
											  			<li class="pageInfo_btn page-item next" id="dataTable_next"><a href="/admin/board/list.do?pageNum=${pageMaker.realEndPageNum }&amp;searchKeyword=${boardVO.searchKeyword}&amp;bbsSeq=${boardVO.bbsSeq}" aria-controls="dataTable" data-dt-idx="${pageMaker.endPage + 1 }" tabindex="0" class="page-link">▶</a></li>
													</c:if> --%>
													
										 		</ul>
											</div>
										</div>
										<div class="col-sm-12 col-md-5 text-right mb-1">
											<div class="input-group w-100" style="display: inline-flex; width: 100%;">
			                                	<select class="form-control mr-1" name="gubun" id="gubun" style="flex: 0 0 25%;">
			                                		<option value="">전체</option>
			                                		<option value="ttl" <c:if test="${boardVO.gubun eq 'ttl' }">selected="selected"</c:if>>제목</option>
			                                		<option value="cn" <c:if test="${boardVO.gubun eq 'cn' }">selected="selected"</c:if>>내용</option>
			                                		<option value="writer" <c:if test="${boardVO.gubun eq 'writer' }">selected="selected"</c:if>>작성자</option>
			                                	</select>
									    		<input type="text" class="form-control bg-light border-0 small" name="searchKeyword" id="searchKeyword" placeholder="검색어를 입력하세요." aria-label="Search" aria-describedby="basic-addon2" autocomplete="off" value="${boardVO.searchKeyword }">
									    		<div class="input-group-append">
											        <button type="submit" id="btn-search" class="btn btn-primary" type="button">
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
						    <h5 class="m-0 font-weight-bold text-primary">미리보기</h5>
						    <button class="btn btn-primary btn-icon-split" id="btn-new" onclick="location.href='addBoard.do';">
						        <span class="text">신규등록</span>
						   	</button>
						</div>
						<!-- .card-body START -->
	                    <div class="card-body">
	                   		<form class="user" id="frm-board">
	                   			<input type="hidden" name="stat" id="stat" value="1" readonly="readonly" />
	                    		<input type="hidden" name="boardSeq" id="boardSeq" value="0" readonly="readonly" />
	                      		<div class="form-group">
<!-- 	                      			<label for="bbs-title"><strong>제목</strong></label> -->
	                          		<input type="email" class="form-control form-control-user init-class" id="title" autocomplete="off" value="게시물을 선택하세요." disabled="disabled">
	                      		</div>
                                <div class="form-group">
<!-- 	                      			<label for="bbs-title"><strong>내용</strong></label> -->
<!--                                 	<textarea class="form-control init-class" name="cont" id="cont" rows="5" disabled="disabled"></textarea> -->
                                	<div class="p-2 rounded editor-preview" id="cont">
                                	</div>
                                </div>
                                <div class="form-group">
		                        	<button type="button" class="btn btn-primary btn-lg init-class w-100" id="btn-move" onclick="btnControl('move');" disabled="disabled">상세페이지 이동</button>
                                </div>
	                      		<hr>
	                      		<!-- <small class="text-danger">* 게시물 정보</small>
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
		                      	</div> -->
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
								<div id="btn-divTag1"></div>
								<div id="btn-divTag2">
									<button class="btn btn-info btn-icon-split init-class d-none" onclick="btnControl('reply');">
					         			<span class="text">답글쓰기</span>
					    			</button>
									<button class="btn btn-success btn-icon-split init-class d-none" id="btn-restore" onclick="btnControl('stat', '1');">
					         			<span class="text">복구</span>
					    			</button>
									<button class="btn btn-danger btn-icon-split init-class d-none" id="btn-del" onclick="btnControl('stat', '0');">
					         			<span class="text">삭제</span>
					    			</button>
									<button class="btn btn-danger btn-icon-split init-class d-none" id="btn-delPermnt" onclick="btnControl('stat', '9');">
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
