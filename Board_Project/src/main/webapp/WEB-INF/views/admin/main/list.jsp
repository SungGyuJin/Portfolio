<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<body>

<script>

	$(function(){

		$("#tech-card-area").sortable({
            items:$('.sorting'),
            start:function(event, ui){
				
            },
            stop: function(event, ui) {
            	
            	var html = '';
            	
                $("#tech-card-area .sorting_1").each(function(index){
                	console.log($(this).attr('aria-label'));
					html += '<input type="hidden" name="mainSeqArr" value="'+$(this).attr('aria-label')+'">';
					html += '<input type="hidden" name="srtOrdArr" value="'+(index+1)+'">';
                });
                
                $("#frm_sorting").html(html);
                
                $.ajax({
        			url      : contextPath+"updateMainSrtOrd.do",
        			method   : "GET",
        			data     : $("#frm_sorting").serialize(),
        			dataType : "json",
        			success  : function(res){
						
        				
        			},
        			error : function(request, status, error){
        				Swal.fire({
        					icon: "error",
        					title: "통신불가"
        				})
        			}
        		});
            }
			
        });
		
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
		
		var i = 0;
		
		// add Tech Stack
		$("#btn-addTech").on('click', function(){
			var html = '';
			
			html += '<div class="col-lg-3 col-md-4 col-sm-6 mb-4 tech-card" id="tempTechDiv-'+i+'">';
			html +=		'<input type="file" class="d-none" id="temp-tech-file-'+i+'" onchange="addTechIcon(this, event, '+i+', \'temp\');">';
			html +=		'<input type="hidden" name="arrMainSeq" value="0">';
			html +=		'<input type="hidden" name="arrThumbYn" id="techImgYn-temp-'+i+'" value="D">';
			html += 	'<div class="card border-left-success shadow h-100 py-2">';
			html +=     	'<div class="card-body">';
			html +=           	'<div class="text-right">';
			html +=              	'<img src="'+contextPath+'/resources/admin/assets/img/x_button.png" id="techImg-delBtn-temp-'+i+'" class="invisible cursor-pointer" title="이미지 삭제" onclick="techImgDel(\'temp\', '+i+');" style="width: 20px;">';
			html +=           	'</div>';
			html +=				'<div class="text-center" id="techImgArea-temp-'+i+'">';
			html +=              	'<img src="'+contextPath+'/resources/admin/assets/img/no-image.png" class="w-50">';
			html +=				'</div>';
			html +=            	'<div class="mb-2"><input type="text" class="form-control text-center mt-2" placeholder="기술명을 입력하세요." name="arrTechNm" autocomplete="off"></div>';
            html += 			'<div class="font-weight-bold mb-1">등록일시: -</div>';
            html += 			'<div class="font-weight-bold mb-1">수정일시: -</div>';
            html += 			'<div class="font-weight-bold mb-1">상태: <span class="text-success">생성중</span></div>';
			html +=           	'<div class="d-flex justify-content-between">';
			html +=					'<div>';
			html +=           			'<button type="button" class="btn btn-sm btn-success btn-icon-split" onclick="btnControl(\'addTechImg\', '+i+', \'temp\');">';
	    	html +=							'<span class="text">이미지 추가</span>';
			html += 					'</button>';
			html +=					'</div>';
			html +=					'<div>';
// 			html +=           			'<button type="button" class="btn btn-sm btn-primary btn-icon-split mr-1" id="btnAddTech-temp-'+i+'" onclick="btnControl(\'addTech\', '+i+', \'temp\');">';
// 	    	html +=							'<span class="text">저장</span>';
// 			html += 					'</button>';
			html +=           			'<button type="button" class="btn btn-sm btn-danger btn-icon-split" onclick="btnControl(\'delTech\', '+i+', \'temp\');">';
	    	html +=							'<span class="text">삭제</span>';
			html += 					'</button>';
			html +=					'</div>';
			html +=        		'</div>';
			html +=     	'</div>';
			html += 	'</div>';
			html +=		'<div id="techImgData-temp-'+i+'">';
			html += 		'<input type="hidden" name="arrFileOrgNm" value="N">';
			html += 		'<input type="hidden" name="arrFileSvgNm" value="N">';
			html += 		'<input type="hidden" name="arrFileExt" value="N">';
			html += 		'<input type="hidden" name="arrFilePath" value="N">';
			html += 		'<input type="hidden" name="arrFileSize" value="0">';
			html +=		'</div>';
			html += '</div>';
			
			if($(".tech-card").length == 0){
				$("#tech-card-area").empty();
			}
			
			$("#tech-card-area").append(html);
			
			i++;
		});
		
	});
	
	// 버튼제어
	function btnControl(e, num, gubun, stat){
		
		// 배너 등록(수정) 처리
		if(e == 'addBn'){
			frmSubmit(e);
			
		// 배너 이미지 추가 버튼
		}else if(e == 'addBnerImg'){
			$("#banner-file").trigger('click');
		
		// 기술 이미지 추가 버튼
		}else if(e == 'addTechImg'){
			if(gubun == 'temp'){
				$("#temp-tech-file-"+num).trigger('click');
			}else{
				$("#data-tech-file-"+num).trigger('click');
			}
		}else if(e == 'delBnerImg'){
			
			if(gubun == 'data'){
				Swal.fire({
					title: '배경을 삭제하시겠습니까?',
					html: "※확인 즉시 배경이 삭제됩니다. (복구불가)",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: '확인',
					cancelButtonText: '취소'
				}).then(function(result){
	
			        if (result.isConfirmed) {
						$("#bannerYn").val('N');
						frmSubmit('addBn', e, '삭제');
			        }
				})
			}else{
				$("#banner-area").children().remove();
				$("#bannerYn").val('');
				$("#banner-file").val('');
				$("#banner-data").empty();
				$("#btn-bannerImgDel").prop('disabled', true);
				
				$("#banner-area").html('<strong>등록된 이미지가 없습니다.</strong>');
			}
		// 기술 이미지 삭제 버튼
		}else if(e == 'delImg'){
			$("#banner-area").empty();
			$("#banner-data").empty();
			$("#bannerYn").val('N');
			$("#btn-bannerImgDel").prop('disabled', true);

		// 기술 등록(수정) 처리
		}else if(e == 'addTech'){
			frmSubmit(e);
		// 기술 삭제(전체방식)
		}else if(e == 'reset'){
			btnReset();

		// 기술 복구,삭제
		}else{
			if(gubun == 'temp'){
				$("#tempTechDiv-"+num).remove();
			}else{
				changeStat_1(num, stat);
			}
		}
	}
	
	function frmSubmit(e, str){
		
		
		var frm = '';
		
		if(e == 'addBn'){
			
			frm = '#frm-banner';
			
			if($("#topBnNm").val() == ''){
				alert("상단 배너명을 입력하세요.");
				$("#topBnNm").focus();
				return false;
			}else if($("#botmBnNm").val() == ''){
				alert("하단 배너명을 입력하세요.");
				$("#botmBnNm").focus();
				return false;
			}
			
		}else if(e == 'addTech'){
			
			frm = '#frm-tech';
			
			var idx = 0;
			var cnt = 0;
			
			$(".techNm").each(function(index){
				if($(this).val().length == 0){
					idx = index;
					cnt++;
					return false;
				}
			});
			
			if(cnt > 0){
				alert((idx+1)+"번 기술명을 입력하세요.");
				$('[name="arrTechNm"]').eq(idx).focus();
				return false;
			}
			
		}
		
		$.ajax({
			url      : contextPath+"/admin/main/addMain.do",
			method   : "POST",
			data     : $(frm).serialize(),
			dataType : "json",
			success  : function(res){
				
				if(res > 0){

					var ment = '저장완료';
					
					if(str == 'delBnerImg'){
						ment = '삭제완료';
					}

					Swal.fire({
						icon: "success",
						title: ment,
					}).then(function(){
						location.reload();
					});
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

	// 기술 아이콘 추가
	function addTechIcon(e, event, num, gubun){

		var file = e.files;

		if(file.length > 0){
			var imgChk = file[0].type.substr(0,5);

			if(imgChk != "image"){
				alert("이미지파일만 첨부 가능합니다");
// 				$("#"+gubun+"-file-thumb").val('');
// 				$("#"+gubun+"-thumb-view").children().remove();
// 				$("#"+gubun+"-file-thumbYn").val('N');
				return false;
			}
			
			var formData = new FormData();
			
		    formData.append("files", file[0]);
			
			$.ajax({
				url      : contextPath+"/main/upload.do",
				method   : "POST",
				data     : formData,
				processData: false,
				contentType: false,
				dataType : "json",
				success  : function(res){
					
					var reader = new FileReader();
					
					reader.onload = function(event) {
						var img_html = '';
						img_html += '<img src="'+ event.target.result +'" class="mt-2" style="height: auto; width: 50%;">';
						$("#techImgArea-"+gubun+"-"+num).html(img_html);
					};
					
					reader.readAsDataURL(file[0]);

		        	var html = '';
					
					for(var i=0; i < res.fileList.length; i++) {
						html += '<div class="d-flex fileData-area">';
						
						html += 	'<input type="hidden" name="arrFileOrgNm" value="'+res.fileList[i].fileOrgNm+'">';
						html += 	'<input type="hidden" name="arrFileSvgNm" value="'+res.fileList[i].fileSvgNm+'">';
						html += 	'<input type="hidden" name="arrFileExt" value="'+res.fileList[i].fileExt+'">';
						html += 	'<input type="hidden" name="arrFilePath" value="'+res.fileList[i].filePath+'">';
						html += 	'<input type="hidden" name="arrFileSize" value="'+res.fileList[i].fileSz+'">';
						
						html +=	'</div>';
					}
					
					$("#techImgData-"+gubun+"-"+num).html(html);
					$("#techImgYn-"+gubun+"-"+num).val("Y");
					
					$("#techImg-delBtn-"+gubun+"-"+num).removeClass('invisible');
					$("#btn-bannerImgDel").prop('disabled', false);
					
				},
				error : function(request, status, error){
					Swal.fire({
						icon: "error",
						title: "통신불가"
					})
				}
			});
			
		}else{
// 			$("#banner-area").children().remove();
// 			$("#bannerYn").val('N');
// 			$("#banner-file").val('');
// 			$("#banner-data").empty();
// 			$("#btn-bannerImgDel").prop('disabled', true);
		}
	}
	
	function techImgDel(gubun, num){
		$("#techImgData-"+gubun+"-"+num).empty();
		$("#techImgArea-"+gubun+"-"+num).html('<img src="'+contextPath+'/resources/admin/assets/img/no-image.png" class="w-50">');
		$("#techImg-delBtn-"+gubun+"-"+num).addClass('invisible');
		
		if(gubun == 'data'){
			$("#techImgYn-"+gubun+"-"+num).val('N');
		}else{
			$("#techImgYn-"+gubun+"-"+num).val('D');
		}
	}
	
	// 배너이미지 추가
	function addBanner(e, event, gubun){

		var file = e.files;

		if(file.length > 0){
			var imgChk = file[0].type.substr(0,5);

			if(imgChk != "image"){
				alert("이미지파일만 첨부 가능합니다");
				$("#"+gubun+"-file-thumb").val('');
				$("#"+gubun+"-thumb-view").children().remove();
				$("#"+gubun+"-file-thumbYn").val('N');
				return false;
			}
			
			var formData = new FormData();
			
		    formData.append("files", file[0]);
		    
		    $.ajax({
				url      : contextPath+"/main/upload.do",
				method   : "POST",
				data     : formData,
				processData: false,
				contentType: false,
				dataType : "json",
				success  : function(res){

					var reader = new FileReader();
					
					reader.onload = function(event) {
						$("#banner-area").children().remove();
						var img_html = '';
// 						img_html += '<img src="'+ event.target.result +'" style="height: auto; width: 100%;">';
						img_html += '<img src="'+ event.target.result +'">';
						$("#banner-area").append(img_html);
					};
					
					reader.readAsDataURL(file[0]);

					$("#bannerYn").val('Y');

		        	var html = '';
					
					for(var i=0; i < res.fileList.length; i++) {
						html += '<div class="d-flex fileData-area">';
						html += 	'<input type="hidden" name="arrFileOrgNm" value="'+res.fileList[i].fileOrgNm+'">';
						html += 	'<input type="hidden" name="arrFileSvgNm" value="'+res.fileList[i].fileSvgNm+'">';
						html += 	'<input type="hidden" name="arrFileExt" value="'+res.fileList[i].fileExt+'">';
						html += 	'<input type="hidden" name="arrFilePath" value="'+res.fileList[i].filePath+'">';
						html += 	'<input type="hidden" name="arrFileSize" value="'+res.fileList[i].fileSz+'">';
						html +=	'</div>';
					}
					
					$("#banner-data").html(html);
					$("#btn-bannerImgDel").prop('disabled', false);
					
					$("#btn-bnerImgsave").prop('disabled', false);
					
				},
				error : function(request, status, error){
					Swal.fire({
						icon: "error",
						title: "통신불가"
					})
				}
			});
			
		}else{
			$("#banner-area").children().remove();
			$("#banner-area").html('<strong>등록된 이미지가 없습니다.</strong>');
			$("#bannerYn").val('N');
			$("#banner-file").val('');
			$("#banner-data").empty();
			$("#btn-bannerImgDel").prop('disabled', true);
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
	function changeStat_1(num, stat){
		
		$("#changeSeq").val(num);
    	$("#changeStat").val(stat);
		
		if(stat == '9'){
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
		        	changeStat_2('영구삭제완료');
		        }
			})
		}else if(stat == '1'){
			changeStat_2('복구완료');
		}else{
			changeStat_2('삭제완료');
		}
	}
	
	function changeStat_2(cmnt){
		
		$.ajax({
			url      : contextPath+"updateStat.do",
			method   : "POST",
			data     : $("#frm-changeStat").serialize(),
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
	
</script>

<form id="frm_sorting"></form>
<form id="frm-changeStat">
	<input type="hidden" name="mainSeq" id="changeSeq">
	<input type="hidden" name="stat" id="changeStat">
</form>

<div id="content">
	<!-- Begin Page Content -->
	<div class="container-fluid">

      	<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
         	<h1 class="h3 mb-0 text-gray-800 ml-1"><strong>메인 관리</strong></h1>
     	</div>

		<div class="row">
			<div class="col-xl-9 col-lg-7">
    			<div class="card shadow mb-4">
					<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
    					<h5 class="m-0 font-weight-bold text-primary">Banner</h5>
    					<div class="dropdown no-arrow">
					        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
					            <div class="dropdown-header">Dropdown Header:</div>
					            <a class="dropdown-item" href="#">Action</a>
					            <a class="dropdown-item" href="#">Another action</a>
					            <div class="dropdown-divider"></div>
					            <a class="dropdown-item" href="#">Something else here</a>
					        </div>
    					</div>
					</div>
					
					<!-- Banner Card Body -->
					<div class="card-body">
						<form id="frm-banner" method="get">
                      		<div id="banner-data"></div>
							<input type="file" class="form-control d-none" id="banner-file" onchange="addBanner(this, event, 'img');">
                      		<input type="hidden" name="thumbYn" class="" id="bannerYn">
							<input type="hidden" name="mainSe" id="mainSeBanner" value="B" readonly="readonly">
							<input type="hidden" name="stat" id="bnStat" value="1">
					    	<div class="table-responsive" style="overflow-x: hidden;">
					  			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
									<div class="row">
										<div class="col-sm-12">
											<table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
												<colgroup>
													<col width="80"> 	<!-- 상단 배너명 -->
													<col width="80"> 	<!-- 하단 배너명 -->
													<col width="80"> 	<!-- 등록일 -->
													<col width="80"> 	<!-- 수정일 -->
													<col width="10"> 	<!-- 상태 -->
												</colgroup>
												<thead>
												    <tr role="row">
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">상단 배너명</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">하단 배너명</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">등록일시</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">수정일시</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">상태</th>
												    </tr>
												</thead>
												<tbody>
													<c:forEach var="list" items="${getBanner}">
													<input type="hidden" name="mainSeq" value="${list.mainSeq }" readonly="readonly">
													<tr class="text-center sorting">
														<td><input type="text" class="form-control form-control-user text-center" name="topBnNm" id="topBnNm" value="${list.topBnNm }" autocomplete="off"></td>
														<td><input type="text" class="form-control form-control-user text-center" name="botmBnNm" id="botmBnNm" value="${list.botmBnNm }" autocomplete="off"></td>
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
													<c:if test="${empty getBanner }">
													<tr class="text-center">
														<td colspan="6">
															<strong class="text-lg"><br>등록된 배너데이터가 없습니다.<br><br></strong>
														</td>
													</tr>
													</c:if>
									        	</tbody>
											</table>
											<div class="text-right">
												<button type="button" class="btn btn-primary btn-icon-split" id="btn-bnSave" onclick="btnControl('addBn');">
											    	<span class="text">저장</span>
												</button>
												<button class="btn btn-secondary btn-icon-split" id="btn-bnReset" onclick="btnControl('reset');">
								         			<span class="text">취소</span>
								    			</button>
						    				</div>
										</div>
									</div>
	      						</div>
	       					</div>
						</form>
   					</div>
         		</div>
         		
         		<div class="card shadow mb-4">
				    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
				        <h5 class="m-0 font-weight-bold text-primary">Tech Stack</h5>
				        <div>
				            <button class="btn btn-primary btn-icon-split" id="btn-addTech" title="추가" value="add">
				                <span class="text">추가</span>
				            </button>
				        </div>
				    </div>
				
				    <div class="card-body">
				    	<form id="frm-tech">
               				<input type="hidden" name="mainSe" value="T">
				            <!-- 기술 목록 영역 -->
				            <div class="row" id="tech-card-area">
								
								<c:if test="${empty getTechList }">
					                <!-- 데이터 없을 때 -->
					                <div class="col-12 text-center py-5">
					                    <strong class="text-lg"><br>등록된 기술이 없습니다.<br><br></strong>
					                </div>
								</c:if>
				
								<c:set var="techCnt" value="0" />
								<c:forEach var="list" items="${getTechList}">
									<c:set var="techCnt" value="${techCnt + 1}" />
					                <div class="col-lg-3 col-md-4 col-sm-6 mb-4 tech-card sorting cursor-pointer" id="dataTechDiv-${list.mainSeq }">
										<input type="file" class="d-none" id="data-tech-file-${list.mainSeq }" onchange="addTechIcon(this, event, '${list.mainSeq }', 'data');">					                    
					                    <input type="hidden" name="arrMainSeq" value="${list.mainSeq }">
					                    <input type="hidden" name="arrThumbYn" id="techImgYn-data-${list.mainSeq }" value="D">
					                    <div class="card <c:if test="${list.stat eq 0 }">border-left-danger</c:if><c:if test="${list.stat eq 1 }">border-left-primary</c:if> shadow h-100 py-2">
					                        <div class="card-body">
					                            <div class="text-right">
							              			<img src="${pageContext.request.contextPath }/resources/admin/assets/img/x_button.png" id="techImg-delBtn-data-${list.mainSeq }" class="cursor-pointer <c:if test="${empty list.filePath }">invisible</c:if>" title="이미지 삭제" onclick="techImgDel('data', ${list.mainSeq})" style="width: 20px">
									           	</div>
									           	<div class="text-center sorting_1" id="techImgArea-data-${list.mainSeq }" aria-label="${list.mainSeq }">
									           		<c:choose>
									           			<c:when test="${not empty list.filePath }"><img src="${pageContext.request.contextPath }${list.filePath }/${list.strgFileNm}" class="mt-2" style="height: auto; width: 50%;"></c:when>
									           			<c:otherwise><img src="${pageContext.request.contextPath }/resources/admin/assets/img/no-image.png" class="w-50"></c:otherwise>
									           		</c:choose>
												</div>
					                            <div class="mb-2"><input type="text" class="form-control text-center techNm mt-2" name="arrTechNm" placeholder="기술명을 입력하세요." value="${list.techNm }" autocomplete="off"></div>
					                            <div class="font-weight-bold mb-1">등록일시: ${list.regDt }</div>
					                            <div class="font-weight-bold mb-1">수정일시: ${list.updDt }</div>
												<c:choose>
													<c:when test="${list.stat eq 0 }">
							                            <div class="font-weight-bold mb-1">상태: <span class="text-danger">삭제됨</span></div>
													</c:when>
													<c:otherwise>
							                            <div class="font-weight-bold mb-1">상태: <span class="text-primary">사용중</span></div>
													</c:otherwise>
								           		</c:choose>
					                            <div class="d-flex justify-content-between">
												<c:choose>
													<c:when test="${list.stat eq 1 }">
					                            	<div class="mt-1">
					                                	<button type="button" class="btn btn-sm btn-success btn-icon-split" onclick="btnControl('addTechImg', '${list.mainSeq}')">
							    							<span class="text">이미지 추가</span>
									 					</button>
					                            	</div>
					                            	<div>
									           			<button type="button" class="btn btn-sm btn-danger btn-icon-split" onclick="btnControl('changeStat', '${list.mainSeq}', 'data', '0')">
							    							<span class="text">삭제</span>
									 					</button>
					                            	</div>
													</c:when>
													<c:otherwise>
					                            	<div>
									           			<button type="button" class="btn btn-sm btn-success btn-icon-split" onclick="btnControl('changeStat', '${list.mainSeq}', 'data', '1')">
							    							<span class="text">복구</span>
									 					</button>
					                            	</div>
					                            	<div>
									           			<button type="button" class="btn btn-sm btn-danger btn-icon-split" onclick="btnControl('changeStat', '${list.mainSeq}', 'data', '9')">
							    							<span class="text">영구삭제</span>
									 					</button>
					                            	</div>
													</c:otherwise>
								           		</c:choose>
					                            </div>
					                        </div>
					                    </div>
					                    <div id="techImgData-data-${list.mainSeq }">
					                    	<input type="hidden" name="arrFileOrgNm" value="N">
					                    	<input type="hidden" name="arrFileSvgNm" value="N">
					                    	<input type="hidden" name="arrFileExt" value="N">
					                    	<input type="hidden" name="arrFilePath" value="N">
					                    	<input type="hidden" name="arrFileSize" value="0">
					                    </div>
					                </div>
								</c:forEach>
								
				            </div>
							<div class="text-right mt-4">
								<button type="button" class="btn btn-primary btn-icon-split" id="btn-techSave" onclick="btnControl('addTech');">
							    	<span class="text" id="btn-text-span">저장</span>
								</button>
								<button class="btn btn-secondary btn-icon-split" id="btn-reset" onclick="btnControl('reset');">
				         			<span class="text">취소</span>
				    			</button>
							</div>
						</form>
				    </div>
				</div>
         		
         		<div class="card shadow mb-4">
					<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
    					<h5 class="m-0 font-weight-bold text-primary">Portfolio</h5>
    					<div class="dropdown no-arrow">
					        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
					            <div class="dropdown-header">Dropdown Header:</div>
					            <a class="dropdown-item" href="#">Action</a>
					            <a class="dropdown-item" href="#">Another action</a>
					            <div class="dropdown-divider"></div>
					            <a class="dropdown-item" href="#">Something else here</a>
					        </div>
	    					<button class="btn btn-primary btn-icon-split" id="btn-addBanner" title="추가" value="add">
	    						<span class="text">추가</span>
			    			</button>
	    					<button class="btn btn-danger btn-icon-split" id="btn-delBanner" title="삭제" value="del" disabled>
	    						<span class="text">삭제</span>
			    			</button>
    					</div>
					</div>
					
					<!-- Card Body -->
					<div class="card-body">
						<form id="frm-pofor" method="get">
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
												    	<th class="sorting sorting_asc text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 154px;">포트폴리오명</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">포트폴리오명</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">배너 이미지</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">상태</th>
												    </tr>
												</thead>
												<tbody>
													<c:set var="poCnt" value="0" />
													<c:forEach var="list" items="${getPoList}">
													<tr class="text-center sorting" onclick="getBbs(${list.bbsSeq});" id="tr-${list.bbsSeq }">
														<td class="sorting_1" id="nm-${list.bbsSeq }" aria-label="${list.bbsSeq }">${list.nm }</td>
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
													<c:if test="${empty getPoList }">
													<tr class="text-center">
														<td colspan="5">
															<strong class="text-lg"><br>등록된 포트폴리오가 없습니다.<br><br></strong>
														</td>
													</tr>
													</c:if>
									        	</tbody>
											</table>
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
						    <h5 class="m-0 font-weight-bold text-primary">메인화면 미리보기</h5>
						</div>
						<!-- .card-body START -->
	                    <div class="card-body">
	                   		<form class="user" id="frm-addBbs">
	                   			<input type="hidden" name="stat" id="stat" value="1" readonly="readonly"/>
	                    		<input type="hidden" name="bbsSeq" id="bbsSeq" value="0" readonly="readonly" />
	                      		<div class="form-group">
	                      			<label for="topBnNm"><strong>상단 배너명</strong></label>
	                          		<input type="text" class="form-control form-control-user init-class" placeholder="상단 배너명 없음" value="${getBanner[0].topBnNm }" readonly="readonly">
	                      		</div>
	                      		<div class="form-group">
	                      			<label for="botmNmNm"><strong>하단 배너명</strong></label>
	                          		<input type="text" class="form-control form-control-user init-class" placeholder="하단 배너명 없음" value="${getBanner[0].botmBnNm }" readonly="readonly">
	                      		</div>
	                      		<div class="form-group">
	                      			<label for=""><strong>Tech Stack</strong></label>
	                          		<input type="text" class="form-control form-control-user init-class" value="${techCnt} 개" readonly="readonly">
	                      		</div>
	                      		<div class="form-group">
	                      			<label for=""><strong>Portfolio</strong></label>
	                          		<input type="text" class="form-control form-control-user init-class" value="${poCnt} 개" readonly="readonly">
	                      		</div>
	                      		<div class="form-group">
	                      			<label for="bannerImg">
									  <strong>현재 배경</strong> <c:if test="${not empty getBanner[0].filePath }"><span class="small"> (등록일시: ${getBanner[0].taRegDt })</span></c:if>
									</label>
	                      			<div class="text-center banner-preview" id="banner-area">
	                      				<c:choose>
						           			<c:when test="${not empty getBanner[0].filePath }"><img src="${pageContext.request.contextPath }${getBanner[0].filePath }/${getBanner[0].strgFileNm }"></c:when>
						           			<c:otherwise><strong>등록된 이미지가 없습니다.</strong></c:otherwise>
						           		</c:choose>
	                      			</div>
	                      		</div>
	                      		<hr>
							</form>
			  
						<div class="text-center">
							<div class="d-flex justify-content-between">
								<div id="btn-divTag1">
									<button class="btn btn-primary btn-icon-split init-class" id="btn-bnerImgsave" onclick="btnControl('addBn');" <c:if test="${empty getBanner[0].filePath }">disabled</c:if>>
								    	<span class="text" id="btn-text-span">배경 저장</span>
									</button>
									<!-- <button class="btn btn-secondary btn-icon-split init-class" id="btn-reset" onclick="btnControl('reset');">
					         			<span class="text">취소</span>
					    			</button> -->
								</div>
								<div id="btn-divTag2">
									<button class="btn btn-success btn-icon-split init-class d-none" id="btn-restore" onclick="btnControl('stat', '1');">
					         			<span class="text">복구</span>
					    			</button>
									<button class="btn btn-danger btn-icon-split init-class d-none" id="btn-del" onclick="btnControl('stat', '0');">
					         			<span class="text">삭제</span>
					    			</button>
									<button class="btn btn-success btn-icon-split" id="btn-bannerImg" onclick="btnControl('addBnerImg', '9');">
				         				<span class="text">배경 추가</span>
				    				</button>
				    				<c:choose>
					           			<c:when test="${not empty getBanner[0].filePath }">
											<button class="btn btn-danger btn-icon-split init-class" id="btn-bannerImgDel" onclick="btnControl('delBnerImg', '9', 'data');">
						         				<span class="text">배경 삭제</span>
						    				</button>
					           			</c:when>
					           			<c:otherwise>
											<button class="btn btn-danger btn-icon-split init-class" id="btn-bannerImgDel" onclick="btnControl('delBnerImg', '9', 'temp');" disabled>
						         				<span class="text">배경 삭제</span>
						    				</button>
					           			</c:otherwise>
					           		</c:choose>
				    				
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
