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
		
	});
	
	// 버튼제어
	function btnControl(e, num){
		if(e == 'upd'){
			updateBbs();

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
	
	// 게시물 수정
	function updateBbs(){

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
			title: "수정완료"
		}).then(function(){
		 	$("#frm-board").submit();
		});
		
	}

	function cnChk(content) {
	  var plainText = content.replace(/<[^>]*>/g, '').trim();
	  return plainText === '';
	}

	function removeThumb(){
    	$("#thumb-data").empty();
		$("#thumb-view").empty();
		$("#file-thumb").val('');
		$("#file-thumbYn").val('N');
		
		var html = '';

		html +=	'<label class="font-weight-bold">미리보기</label>';
		html +=		'<div class="dz-message added-file font-weight-bold added-zone">';
		html +=		'<span id="text-added">썸네일이 없습니다.</span>';
		html +=	'</div>';
		
		$("#thumb-view").html(html);
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
                            <form class="user" id="frm-board" method="post" enctype="multipart/form-data">
<!--                             <form class="user" id="frm-board" method="post" data-parsley-validate> -->
                            	<input type="hidden" name="listTyp" id="listTyp" value="${boardVO.listTyp }" />
                            	<input type="hidden" name="boardSeq" id="boardSeq" value="${getBoard.boardSeq }" />
                            	<input type="hidden" name="stat" id="stat" value="${getBoard.stat }" />
                                <div class="form-group font-weight-bold mb-4">
                                	<label for="bbsNm">게시판</label>
                                	<input type="text" class="form-control" id="bbsNm" value="${getBoard.bbsNm }" disabled="disabled">
                                </div>
                                <div class="form-group font-weight-bold">
                                	<label for="title">제목</label>
                                	<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력하세요." value="${getBoard.title }">
                                </div>
                                <div class="form-group font-weight-bold">
                                	<label for="cont">내용</label>
                                	<textarea class="form-control" name="cont" id="cont" rows="15">${getBoard.cont }</textarea>
                                </div>
                                
                                <div class="row mt-4">
                                	<div class="col-md-6">
										<label><strong>썸네일</strong></label>
									  	<div id="myDropzoneThumb" class="dropzone dz-zone cursor-pointer">
									    	<div class="dz-message font-weight-bold">
									      		여기에 이미지 파일을 드래그하거나 클릭해주세요.
									    	</div>
									  	</div>
                                	</div>
                                	<div class="col-md-6" id="thumb-view">
                                		<label class="font-weight-bold">미리보기</label>
											
	                                	<c:choose>
	                                		<c:when test="${getBoard.thumbInfo ne 'none' }">
	                                			<c:set var="info" value="${getBoard.thumbInfo }" />
	                                			<c:set var="infoArr" value="${fn:split(info, ',')}" />
												<img src="${pageContext.request.contextPath}${infoArr[1]}/${infoArr[2]}" style="height: auto; width: 99%;">
												<span class="thumb-close" onclick="removeThumb();">&times;</span>
	                                		</c:when>
	                                		<c:otherwise>
										  	<div class="dz-message added-file font-weight-bold added-zone">
												<span id="text-added">썸네일이 없습니다.</span>
											</div>
											</c:otherwise>
	                                	</c:choose>
											
                                	</div>
	                                	<c:choose>
	                                		<c:when test="${getBoard.thumbInfo ne 'none' }">
	                                			<c:set var="info" value="${getBoard.thumbInfo }" />
	                                			<c:set var="infoArr" value="${fn:split(info, ',')}" />
	                                			<input type="hidden" class="form-control my-input mb-2" name="thumbYn" id="file-thumbYn" value="${infoArr[0]}" readonly="readonly">
	                                		</c:when>
	                                		<c:otherwise>
			                                	<input type="hidden" class="form-control my-input mb-2" name="thumbYn" id="file-thumbYn" value="D" readonly="readonly">
	                                		</c:otherwise>
	                                	</c:choose>
                                	<div id="thumb-data"></div>
                                </div>
                                
                                <div class="row mt-4">
                                	<div class="col-md-6">
										<label><strong>첨부파일</strong></label>
									  	<div id="myDropzone" class="dropzone dz-zone cursor-pointer">
									    	<div class="dz-message font-weight-bold">
									      		여기에 이미지 파일을 드래그하거나 클릭해주세요.
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
                                <div id="file-data"></div>
                                <div id="file-delete"></div>
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
											<button type="button" class="btn btn-primary btn-icon-split init-class" id="btn-save" onclick="btnControl('upd');">
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



<script>
	
Dropzone.autoDiscover = false;

var myDropzone = new Dropzone("#myDropzoneThumb", {
    url: "./upload.do",
    paramName: "files", // 서버에 보낼 Param
    maxFilesize: 1, // 5MB
    acceptedFiles: "image/*",
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

        	if(file.previewElement){
                file.previewElement.remove();
            }
        	
       	});
        
        // 마지막 파일까지 드래그 및 첨부 후
        this.on("queuecomplete", function() {
        	$("#addedCnt").text($(".file-area").length);
        });
        
        // After controller
        var fileHiddenCnt = $("#fileTotalCnt").val();
        this.on("success", function (file, response) {

			$("#thumb-view").children().remove(); // 기존 내용 제거
			
			var img_html = '';
			
			img_html +=	'<label class="font-weight-bold">미리보기</label>';
			img_html += '<img src="'+ contextPath + response.filePath + '/' + response.fileSvgNm +'" style="height: auto; width: 99%;">';
			img_html += '<span class="thumb-close" onclick="removeThumb();">&times;</span>';
			
			$("#thumb-view").append(img_html);

        	var hiddenFile_html = '';

        	hiddenFile_html +=	'<div class="d-flex fileData-area">';
        	hiddenFile_html += 		'<input type="hidden" name="thumbFileOrgNm" value="'+response.fileOrgNm+'">';
        	hiddenFile_html += 		'<input type="hidden" name="thumbFileSvgNm" value="'+response.fileSvgNm+'">';
        	hiddenFile_html += 		'<input type="hidden" name="thumbFileExt" value="'+response.fileExt+'">';
        	hiddenFile_html += 		'<input type="hidden" name="thumbFilePath" value="'+response.filePath+'">';
        	hiddenFile_html += 		'<input type="hidden" name="thumbFileSize" value="'+response.fileSz+'">';
        	hiddenFile_html +=	'</div>';

        	$("#thumb-data").empty();
        	$("#thumb-data").append(hiddenFile_html);
			$("#file-thumbYn").val('Y');
        	
        });

        this.on("error", function (file, errMessage) {
//             console.error("업로드 실패", errMessage);
            console.log("업로드 실패");
            console.log(file)
        });

    }
});


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
