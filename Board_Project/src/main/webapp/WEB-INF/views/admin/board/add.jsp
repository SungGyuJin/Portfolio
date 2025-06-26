<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<body>
<script>

	$(function(){
		
		CKEDITOR.replace("cont", {
			removePlugins: 'elementspath, exportpdf',
			resize_enabled: false,
		    height: 350
		});
		   
	    CKEDITOR.on('instanceReady', function(evt) {
// 	        console.warn = function () {};
// 	        console.error = function () {};
// 	        console.log = function () {};
	    });
		
		$('.custom-file-input').on('change', function (event) {
			var inputFile = event.currentTarget;
	   		$(inputFile).siblings('.custom-file-label').addClass("selected").html(inputFile.files[0].name);
		});
		 
		// 게시물 등록처리
		$("#btn-save").on('click', function(){
			addBoard();
		});
		 
		$("#btn-reset").on('click', function(){
			 $("#title").val('');
			 $("#cont").val('');
		});
		
	});
	
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
	
	// 게시물 등록
	function addBoard(){

		if($("#bbsSeq").val() == ''){
			alert('게시판을 선택해 주세요.');
			$("#bbsSeq").focus();
			return false;
		}

		if($("#title").val().trim() == ''){
			alert('제목을 입력해 주세요.');
			$("#title").focus();
			$("#title").val('');
			return false;
		}

	  	CKEDITOR.instances['cont'].updateElement();
		var brdCont = CKEDITOR.instances['cont'].getData();
		
		if(cnChk(brdCont)){
			alert('내용을 입력해 주세요.');
			return false;
		}
		
		Swal.fire({
			icon: "success",
			title: "등록완료"
		}).then(function(){
		 	$("#frm-board").submit();
		});
		
	}

	function cnChk(content) {
	  var plainText = content.replace(/<[^>]*>/g, '').trim();
	  return plainText === '';
	}
	
</script>

<input type="hidden" id="frm-typ" value="add" />

<div id="content">
	<!-- Begin Page Content -->
	<div class="container-fluid">

      	<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
<!--          	<h1 class="h3 mb-0 text-gray-800"><a href="list.do"><strong>게시물 관리</strong></a></h1> -->
         	<h1 class="h3 mb-0 text-gray-800"><strong>게시물 관리</strong></h1>
<!--          	<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a> -->
     	</div>

		<div class="row">
			<div class="col-xl-9 col-lg-7">
    			<div class="card shadow mb-4">
					<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
    					<h5 class="m-0 font-weight-bold text-primary">게시물 등록</h5>
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
                            <form class="user" id="frm-board" method="post" enctype="multipart/form-data">
                            	<input type="hidden" name="pwdYn" value="N">
                                <div class="form-group mb-4">
                                	<label for="bbsSeq"><strong>게시판</strong></label>
                                	<select class="form-control" name="bbsSeq" id="bbsSeq">
                                		<option value="">=== 게시판을 선택하세요 ===</option>	
                                	<c:forEach var="list" items="${getBbsList }">
                                		<option value="${list.bbsSeq }">${list.nm }</option>
                                	</c:forEach>
                                	</select>
                                </div>
                                <div class="form-group">
                                	<label for="title"><strong>제목</strong></label>
                                	<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력하세요.">
                                </div>
                                <div class="form-group">
                                	<label for="cont"><strong>내용</strong></label>
                                	<textarea class="form-control" name="cont" id="cont" rows="15"></textarea>
                                </div>


<!--                                 <div class="custom-file"> -->
<!-- 								    <input type="file" class="custom-file-input" id="customFile" multiple="multiple"> -->
<!-- 									<label class="custom-file-label" for="customFile">파일을 선택하세요</label> -->
<!-- 								</div> -->
<!-- 								<button type="submit" class="d-none" id="btn-hiddenSave"></button> -->

								<div class="row">
                                	<div class="col-md-6">
										<label><strong>첨부파일</strong></label>
									  	<div id="myDropzone" class="dropzone dz-zone cursor-pointer">
									    	<div class="dz-message font-weight-bold">
									      		여기에 파일을 드래그하거나 클릭해주세요.
									    	</div>
									  	</div>
                                	</div>
                                	<div class="col-md-6">
                                		<input type="hidden" id="fileTotalCnt" value="${fn:length(getAttachList) + 1}">
										<label>총&nbsp;&nbsp;<span class="font-weight-bold" id="addedCnt">${fn:length(getAttachList)}</span> 개</label>
									   	<div id="file-list" class="dz-message added-file font-weight-bold <c:if test="${empty getAttachList }">added-zone</c:if>">
		                                	<c:forEach var="list" varStatus="varStatus" items="${getAttachList }">
		                                		<div class="d-flex justify-content-between mt-1 file-area" id="fileDiv-${varStatus.count }">
									            	${list.fileNm }
										           	<div><fmt:formatNumber value="${list.fileSz/1024.0}" type="number" maxFractionDigits="2" minFractionDigits="2" /> KB
										           		<button type="button" class="btn btn-success btn-sm ml-2" onclick="location.href='fileDownload.do?no=${list.attachSeq}';">다운로드</button>
										           		<button type="button" class="btn btn-secondary btn-sm" onclick="removeFile(${varStatus.count }, ${list.attachSeq });">삭제</button>
										            </div>
									            </div>
											</c:forEach>
											<c:if test="${empty getAttachList }">
												<span id="text-added">첨부된 파일이 없습니다.</span>
											</c:if>
									    </div>
                                	</div>
                                </div>
                                
                                <div id="file-data">
<%--                                 	<c:forEach var="list" varStatus="varStatus" items="${getAttachList }"> --%>
<%--                                 		<div class="d-flex fileData-area fileData-${varStatus.count }"> --%>
<%--                                 			<input type="text" name="arrFileOrgNm" value="${list.fileNm }"> --%>
<%--                                 			<input type="text" name="arrFileSvgNm" value="${list.strgFileNm }"> --%>
<%--                                 			<input type="text" name="arrFileExt" value="${list.fileExt }"> --%>
<%--                                 			<input type="text" name="arrFilePath" value="${list.filePath }"> --%>
<%--                                 			<input type="text" name="arrFileSize" value="${list.fileSz }"> --%>
<!--                                 		</div> -->
<%--                                 	</c:forEach> --%>
                                </div>

                                <div id="file-delete">
                                	
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
                      		<div class="form-group row mt-2">
								<div class="col-sm-6 mb-3 mb-sm-0">
									<strong>상태: <span class="text-primary text-lg">"등록중"</span></strong>
								</div>
							</div>
			  
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
			
	                    <hr>
						<div class="text-center">
							<div class="d-flex justify-content-between">
								<div>
									<div id="btn-divTag1">
										<button type="button" class="btn btn-primary btn-icon-split init-class" id="btn-save">
									    	<span class="text" id="btn-text-span">등록완료</span>
										</button>
										<button class="btn btn-secondary btn-icon-split init-class" onclick="history.back(-1);">
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
<!-- <!-- 										<span class="icon text-white-50"><i class="fas fa-trash"></i></span> --> -->
<!-- 					         			<span class="text">삭제</span> -->
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


<script>
	
Dropzone.autoDiscover = false;

var myDropzone = new Dropzone("#myDropzone", {
    url: "./upload.do",
    paramName: "files", // 서버에 보낼 Param
    maxFilesize: 5, // 5MB
    acceptedFiles: "image/*,application/pdf,.doc,.docx,.xls,.xlsx,.txt",
    uploadMultiple: true, // ← 이걸 false 또는 제거하면 기본값이라 각 파일 따로 업로드됨
    parallelUploads: 1,
    autoProcessQueue: true,
//     autoProcessQueue: false,
    createImageThumbnails: false,
    addRemoveLinks: true,
//     previewTemplate: "",
    dictRemoveFile: "삭제",
//     dictDefaultMessage: "여기에 파일을 드래그하거나 클릭하여 업로드하세요.",

    init: function () {
        var dropZoneIns = this;

        this.on("drop", function (file) {
            // 기존 파일 제거 후 새로운 파일 처리
//             this.removeAllFiles(true); // true = 서버 업로드 여부와 관계없이 클라이언트 파일 제거
//             $("#file-list").empty();   // 리스트도 비우기
        });

        var fileCnt = $("#fileTotalCnt").val();
        this.on("addedfile", function (file) {

//          document.getElementById("file-list").appendChild(entry);
//         	console.log(this.files.length)
//         	this.removeAllFiles(true);
        	
        	if(file.previewElement){
                file.previewElement.remove();
            }

        	if(fileCnt == 0){
//         		$(".file-area").remove();
//         		$(".fileData-area").remove();
        	}

            // 파일 정보
            const fileName 		= file.name;
            const fileSizeKb 	= (file.size / 1024).toFixed(2); // KB
            const fileSizeByte 	= file.size; 					 // Byte
            const filetype 		= file.type; 					 // 형식

            var html = '';
            
            html += '<div class="d-flex justify-content-between mt-1 file-area" id="fileDiv-'+fileCnt+'">';
            html += 	fileName;
            html +=		'<div>'+fileSizeKb+' KB ';
            html +=			'<button type="button" class="btn btn-white btn-sm disabled ml-2"><span class="font-weight-bold">신규파일</span></button>';
            html +=			'<button type="button" class="btn btn-secondary btn-sm ml-1" onclick="removeFile('+fileCnt+');">삭제</button>';
            html +=		'</div>';
            html += '</div>';
        	
        	if($(".file-area").length == 0){
	        	$("#text-added").removeClass('d-none');
        	}else{
	        	$("#text-added").addClass('d-none');
        	}
        	
			$("#file-list").append(html);
			
			if($(".file-area").length > 0){
				$("#file-list").removeClass('added-zone');
				$("#text-added").addClass('d-none');
			}
			
// 			this.processQueue();

			fileCnt++;
			
       	});
        
        // 마지막 파일까지 드래그 및 첨부 후
        this.on("queuecomplete", function() {
//         	fileCnt = 0;
        	$("#addedCnt").text($(".file-area").length);
        });
        
        // After controller
        var fileHiddenCnt = $("#fileTotalCnt").val();
        this.on("success", function (file, response) {
            
        	var hiddenFile_html = '';

        	hiddenFile_html += '<div class="d-flex fileData-area fileData-'+fileHiddenCnt+'">';
        	hiddenFile_html +=     '<input type="hidden" name="arrFileOrgNm" value="'+response.fileOrgNm+'">';
        	hiddenFile_html += 	   '<input type="hidden" name="arrFileSvgNm" value="'+response.fileSvgNm+'">';
        	hiddenFile_html += 	   '<input type="hidden" name="arrFileExt" value="'+response.fileExt+'">';
        	hiddenFile_html += 	   '<input type="hidden" name="arrFilePath" value="'+response.filePath+'">';
        	hiddenFile_html += 	   '<input type="hidden" name="arrFileSize" value="'+response.fileSz+'">';
        	hiddenFile_html +='</div>';
        	
        	$("#file-data").append(hiddenFile_html);
        	
        	fileHiddenCnt++;
        });

        this.on("error", function (file, errMessage) {
//             console.error("업로드 실패", errMessage);
            console.log("업로드 실패");
            console.log(file)
        });

    }
});


function removeFile(num, no){
	$("#fileDiv-"+num).remove();
	$(".fileData-"+num).remove();
	$("#addedCnt").text($(".file-area").length);
	if($(".file-area").length == 0){
		$("#file-list").addClass('added-zone');
		$("#text-added").removeClass('d-none');
		$("#file-list").html('<span id="text-added">첨부된 파일이 없습니다.</span>');
	}
	
	if(no != null){
		const delInput_html = '<input type="hidden" name="delSeqArr" value="'+no+'">';
		$("#file-delete").append(delInput_html);
	}	
}


</script>

</body>
