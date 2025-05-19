<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<body>
<script>

	$(function(){
		
		$('.custom-file-input').on('change', function (event) {
			var inputFile = event.currentTarget;
		    $(inputFile).siblings('.custom-file-label').addClass("selected").html(inputFile.files[0].name);
		});
		
	});

	// 버튼제어
	function btnControl(e, num){
		if(e == 'upd'){

			if($("#title").val() == '' || $("#cont").val() == ''){
				$("#frm-board").submit();
				return false;
			}

			Swal.fire({
				icon: "success",
				title: "수정완료"
			}).then(function(){
			 	$("#frm-board").submit();
			});

		// 답글페이지 이동
		}else if(e == 'reply'){
			location.href = 'replyBoard.do?boardSeq='+$("#boardSeq").val()+'&pageNum='+$("#pageNum").val()+'&listTyp='+$("#listTyp").val()+'&searchKeyword='+$("#searchKeyword").val()+'&gubun='+$("#gubun").val()+'&bbsSeq='+$("#bbsSeq").val();
		// 게시물 상태변경
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
						
						if(num == 1){
							location.href = 'list.do?listTyp=list';
						}else{
							location.href = 'list.do?listTyp=trash';
						}
						
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
	
</script>

<input type="hidden" id="pageNum" value="${boardVO.pageNum }" />
<input type="hidden" id="searchKeyword" value="${boardVO.searchKeyword }" />
<input type="hidden" id="gubun" value="${boardVO.gubun }" />
<input type="hidden" id="bbsSeq" value="${boardVO.bbsSeq }" />

<div id="content">
	<!-- Begin Page Content -->
	<div class="container-fluid">

      	<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
         	<h1 class="h3 mb-0 text-gray-800"><strong>게시물 관리</strong></h1>
         	<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
     	</div>

		<div class="row">
			<div class="col-xl-9 col-lg-7">
    			<div class="card shadow mb-4">
					<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
    					<h5 class="m-0 font-weight-bold text-primary">게시물 수정</h5>
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
    					</div>
					</div>
					
					<!-- Card Body -->
					<div class="card-body"> 
						<div class="">
                            <!-- <div class="text-left">
                                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                            </div> -->
                            <form class="user" id="frm-board" method="post" enctype="multipart/form-data" data-parsley-validate>
<!--                             <form class="user" id="frm-board" method="post" data-parsley-validate> -->
                            	<input type="hidden" name="listTyp" id="listTyp" value="${boardVO.listTyp }" />
                            	<input type="hidden" name="boardSeq" id="boardSeq" value="${getBoard.boardSeq }" />
                            	<input type="hidden" name="stat" id="stat" value="${getBoard.stat }" />
                                <div class="form-group mb-4">
                                	<label for="bbsNm"><strong>게시판</strong></label>
                                	<input type="text" class="form-control" id="bbsNm" value="${getBoard.bbsNm }" disabled="disabled">
                                </div>
                                <div class="form-group">
                                	<label for="title"><strong>제목</strong></label>
                                	<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력하세요." value="${getBoard.title }" required="required">
                                </div>
                                <div class="form-group">
                                	<label for="cont"><strong>내용</strong></label>
                                	<textarea class="form-control" name="cont" id="cont" rows="15" required="required">${getBoard.cont }</textarea>
                                </div>
                                <hr>
                                <div class="custom-file">
<!-- 								    <input type="file" class="custom-file-input" name="file" id="customFile" multiple="multiple"> -->
								    <input type="file" class="custom-file-input" name="file" id="customFile" multiple="multiple">
									<label class="custom-file-label" for="customFile">파일을 선택하세요</label>
								</div>
                            </form>
                        </div>
   					</div>
         		</div>
     		</div>

			<div class="col-xl-3 col-lg-5 sidebar">
			    <div class="card shadow mb-4">
			        	<!-- Card Header - Dropdown -->
						<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
						    <h5 class="m-0 font-weight-bold text-primary">OPTION BOX</h5>
						</div>
						<!-- .card-body START -->
	                    <div class="card-body">
<!--                       		<small class="text-danger">* 해당 게시판의 옵션여부입니다.</small> -->
			             	<div class="form-group row mt-2">
								<div class="col-sm-6 mb-3 mb-sm-0">
									<strong>상태:
										<c:if test="${getBoard.stat eq 1 }"><span class="text-primary text-lg">"게시중"</span></c:if>
										<c:if test="${getBoard.stat eq 0 }"><span class="text-danger text-lg">"삭제됨"</span></c:if>
									</strong>
								</div>
							</div>
	                      	<div class="form-group row">
								<div class="col-sm-12 mb-3 mb-sm-0">
									<strong>최근수정: ${getBoard.updDt }</strong>
								</div>
	                      	</div>
		                    <hr>
							<div class="text-center">
								<div class="d-flex justify-content-between">
									<div>
										<div id="btn-divTag1">
											<button class="btn btn-primary btn-icon-split init-class" id="btn-save" onclick="btnControl('upd');">
										    	<span class="text" id="btn-text-span">수정완료</span>
											</button>
											<button class="btn btn-secondary btn-icon-split init-class" onclick="history.back(-1);">
							         			<span class="text">취소</span>
							    			</button>
										</div>
									</div>
									<div id="btn-divTag2">
										<c:if test="${getBoard.stat eq 1 && getBoard.replyYn eq 'Y'}">
											<button class="btn btn-info btn-icon-split init-class" onclick="btnControl('reply');">
							         			<span class="text">답글쓰기</span>
							    			</button>
										</c:if>
										<c:if test="${getBoard.stat eq 0 }">
											<button class="btn btn-success btn-icon-split init-class " id="btn-restore" onclick="btnControl('stat', '1');">
							         			<span class="text">복구</span>
							    			</button>
											<button class="btn btn-danger btn-icon-split init-class" id="btn-delPermnt" onclick="btnControl('stat', '9');">
						         				<span class="text">영구삭제</span>
						    				</button>
										</c:if>
										<c:if test="${getBoard.stat eq 1 }">
											<button class="btn btn-danger btn-icon-split init-class" id="btn-delete" onclick="btnControl('stat', '0');">
							         			<span class="text">삭제</span>
							    			</button>
										</c:if>
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
