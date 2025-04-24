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
		 
		// 게시물 등록처리
		$("#btn-save").on('click', function(){
			
			if($("#title").val() == '' || $("#cont").val() == ''){
				$("#frm-board").submit();
				return false;
			}
			
			Swal.fire({
				icon: "success",
				title: "등록완료"
			}).then(function(){
			 	$("#frm-board").submit();
			});
		});
		 
	});
	
</script>

<input type="hidden" id="frm-typ" value="add" />

<div id="content">
	<!-- Begin Page Content -->
	<div class="container-fluid">

      	<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
         	<h1 class="h3 mb-0 text-gray-800"><a href="list.do"><strong>게시물 관리</strong></a></h1>
         	<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
     	</div>

		<div class="row">
			<div class="col-xl-9 col-lg-7">
    			<div class="card shadow mb-4">
					<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
    					<h5 class="m-0 font-weight-bold text-primary">게시물 답글</h5>
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
                            <form class="user" id="frm-board" method="post" action="addBoard.do" data-parsley-validate>
                               	<input type="hidden" name="bbsSeq" value="${getBoard.bbsSeq }">
                               	<input type="hidden" name="ref" value="${getBoard.ref }">
                               	<input type="hidden" name="step" value="${getBoard.step }">
                               	<input type="hidden" name="lvl" value="${getBoard.lvl }">
                                <div class="form-group mb-4">
                                	<label for="bbsNm"><strong>게시판</strong></label>
                                	<input type="text" class="form-control" id="bbsNm" value="${getBoard.bbsNm }" disabled="disabled">
                                </div>
                                <div class="form-group">
                                	<label for="bbsSeq"><strong>제목</strong></label>
                                	<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력하세요." required="required">
                                </div>
                                <div class="form-group">
                                	<label for="bbsSeq"><strong>내용</strong></label>
                                	<textarea class="form-control" name="cont" id="cont" rows="15" required="required"></textarea>
                                </div>
                                <hr>
                                <div class="custom-file">
								    <input type="file" class="custom-file-input" id="customFile" multiple="multiple">
									<label class="custom-file-label" for="customFile">파일을 선택하세요</label>
								</div>
								<button type="submit" class="d-none" id="btn-hiddenSave"></button>
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
                     		<div class="form-group row mt-2">
							<div class="col-sm-6 mb-3 mb-sm-0">
								<strong>상태: <span class="text-primary text-lg">"답글 등록중"</span></strong>
							</div>
						</div>
	                    <hr>
						<div class="text-center">
							<div class="d-flex justify-content-between">
								<div>
									<div id="btn-divTag1">
										<button class="btn btn-primary btn-icon-split init-class" id="btn-save">
									    	<span class="text" id="btn-text-span">등록완료</span>
										</button>
										<button class="btn btn-secondary btn-icon-split init-class" onclick="history.back(-1);">
						         			<span class="text">취소</span>
						    			</button>
									</div>
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
