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
		
		var i = 0;
		
		// add Tech Stack
		$("#btn-addTech").on('click', function(){
			var html = '';
			
			html += '<div class="col-lg-3 col-md-4 col-sm-6 mb-4" id="tempDiv-'+i+'">';
			html +=		'<input type="file" class="d-none" id="temp-tech-file-'+i+'" onchange="addTechIcon(this, event, '+i+');">';
			html += 	'<div class="card border-left-success shadow h-100 py-2">';
			html +=     	'<div class="card-body">';
			html +=           	'<div class="d-flex justify-content-between">';
			html +=					'<div></div>';
			html +=					'<div>';
// 			html +=              		'<input type="checkbox" class="cursor-pointer custom-checkbox-lg item-chk ml-1">';
			html +=              		'<img src="'+contextPath+'/resources/admin/assets/img/x_button.png" id="techImg-delBtn-'+i+'" class="invisible cursor-pointer" onclick="techImgDel(\'temp\', '+i+');" style="width: 25px;">';
			html +=					'</div>';
			html +=           	'</div>';
			html +=					'<div class="text-center" id="techImg-temp-'+i+'">';
			html +=              		'<img src="'+contextPath+'/resources/admin/assets/img/no-image.png" class="w-50">';
			html +=					'</div>';
			html +=            	'<div class="text-xs mb-2"><input type="text" class="form-control form-control-user mt-3" placeholder="기술명을 입력하세요." name="techNm"></div>';
			html +=           	'<div class="d-flex justify-content-between">';
			html +=					'<div>';
			html +=           			'<button type="button" class="btn btn-sm btn-success btn-icon-split" onclick="btnControl(\'addTech\', '+i+');">';
	    	html +=							'<span class="text">이미지 추가</span>';
			html += 					'</button>';
			html +=           			'<button type="button" class="btn btn-sm btn-danger btn-icon-split ml-1" onclick="delTechImg('+i+');" disabled>';
	    	html +=							'<span class="text">이미지 삭제</span>';
			html += 					'</button>';
			html +=					'</div>';
			html +=					'<div>';
			html +=           			'<button type="button" class="btn btn-sm btn-danger btn-icon-split" onclick="btnControl(\'delTech\', '+i+');">';
	    	html +=							'<span class="text">삭제</span>';
			html += 					'</button>';
			html +=					'</div>';
			html +=        		'</div>';
			html +=     	'</div>';
			html += 	'</div>';
			html +=		'<div id="techImg-data-'+i+'"></div>';
			html += '</div>';			
			
			$("#tech-card-area").append(html);
			
			i++;
		});
		
		$("#all-chk-tech").on('click', function(){
			if($(this).prop('checked')){
				$(".tech-check").prop("checked", true);
				$("#btn-delTech").prop('disabled', false);
			}else{
				$(".tech-check").prop("checked", false);
				$("#btn-delTech").prop('disabled', true);
			}
		});
		
		// delete Tech Stack
		$("#btn-delTech").on('click', function(){
			$(".tech-check:checked").parent().parent().remove();

			if($(".tech-check").length == 0){
				var html = '';

				html += '<tr class="text-center">';
				html += 	'<td colspan="6">';
				html += 		'<strong class="text-lg"><br>등록된 기술이 없습니다.<br><br></strong>';
				html += 	'</td>';
				html += '</tr>';
			
				$("#tech-area").html(html);
				$("#all-chk-tech").prop('disabled', true);
				$("#btn-delTech").prop('disabled', true);
				$("#all-chk-tech").prop('checked', false);
			}else{
				$("#all-chk-tech").prop('disabled', false);
				$("#btn-delTech").prop('disabled', false);
			}
		});

	});
	
	function techCheck(){
		if($(".tech-check:checked").length > 0){
			$("#btn-delTech").prop('disabled', false);
		}else{
			$("#btn-delTech").prop('disabled', true);
		}

		if($(".tech-check").length == $(".tech-check:checked").length){
			$("#all-chk-tech").prop('checked', true);
		}else{
			$("#all-chk-tech").prop('checked', false);
		}
	}
	
	// 버튼제어
	function btnControl(e, num){
		if(e == 'addBn'){
			frmSubmit(e);
		}else if(e == 'reset'){
			btnReset();
		}else if(e == 'addBner'){
			$("#banner-file").trigger('click');
		}else if(e == 'addTech'){
			$("#temp-tech-file-"+num).trigger('click');
		}else if(e == 'delTech'){
			
		}else if(e == 'delImg'){
			$("#banner-area").empty();
			$("#banner-data").empty();
			$("#bannerYn").val('N');
			$("#btn-bannerImgDel").prop('disabled', true);
		}else{
			changeStat_1(num);
		}
	}
	
	function delTechImg(num){
		$("#techImg-temp-"+num).html('<img src="'+contextPath+'/resources/admin/assets/img/no-image.png" class="w-50">');
	}
	
	function frmSubmit(e){
		
		var frm = '';
		
		if(e == 'addBn'){
			frm = '#frm-banner';
		}else{
			
		}
		
		$.ajax({
			url      : contextPath+"/admin/main/addMain.do",
			method   : "POST",
			data     : $(frm).serialize(),
// 			processData: false,
// 			contentType: false,
			dataType : "json",
			success  : function(res){
				
				if(res > 0){
					Swal.fire({
						icon: "success",
						title: "저장완료"
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
	function addTechIcon(e, event, num){

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
						$("#banner-area").children().remove();
						var img_html = '';
// 						img_html += '<img src="'+ event.target.result +'" style="height: auto; width: 100%;">';
						img_html += '<img src="'+ event.target.result +'" class="w-50">';
						$("#techImg-temp-"+num).html(img_html);
					};
					
					reader.readAsDataURL(file[0]);

					$("#bannerYn").val('Y');

		        	var html = '';
					
					for(var i=0; i < res.fileList.length; i++) {
						html += '<div class="d-flex fileData-area">';
						html += 	'<input type="text" name="thumbFileOrgNm" value="'+res.fileList[i].fileOrgNm+'">';
						html += 	'<input type="text" name="thumbFileSvgNm" value="'+res.fileList[i].fileSvgNm+'">';
						html += 	'<input type="text" name="thumbFileExt" value="'+res.fileList[i].fileExt+'">';
						html += 	'<input type="text" name="thumbFilePath" value="'+res.fileList[i].filePath+'">';
						html += 	'<input type="text" name="thumbFileSize" value="'+res.fileList[i].fileSz+'">';
						html +=	'</div>';
					}
					
					$("#techImg-data-"+num).html(html);
					$("#btn-bannerImgDel").prop('disabled', false);
					
					$("#techImg-delBtn-"+num).removeClass('invisible');
					
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
			$("#bannerYn").val('N');
			$("#banner-file").val('');
			$("#banner-data").empty();
			$("#btn-bannerImgDel").prop('disabled', true);
		}
	}
	
	function techImgDel(str, num){
		
		if(str == 'temp'){
			
			$("#techImg-data-"+num).empty();
			$("#techImg-temp-"+num).html('<img src="'+contextPath+'/resources/admin/assets/img/no-image.png" class="w-50">');
			$("#techImg-delBtn").addClass('invisible');
			
		}else{
			
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
						img_html += '<img src="'+ event.target.result +'" style="height: auto; width: 100%;">';
// 						img_html += '<span class="thumb-close" onclick="removeThumb(\''+gubun+'\');">&times;</span>';
						$("#banner-area").append(img_html);
					};
					
					reader.readAsDataURL(file[0]);

					$("#bannerYn").val('Y');

		        	var html = '';
					
					for(var i=0; i < res.fileList.length; i++) {
						html += '<div class="d-flex fileData-area">';
						html += 	'<input type="text" name="thumbFileOrgNm" value="'+res.fileList[i].fileOrgNm+'">';
						html += 	'<input type="text" name="thumbFileSvgNm" value="'+res.fileList[i].fileSvgNm+'">';
						html += 	'<input type="text" name="thumbFileExt" value="'+res.fileList[i].fileExt+'">';
						html += 	'<input type="text" name="thumbFilePath" value="'+res.fileList[i].filePath+'">';
						html += 	'<input type="text" name="thumbFileSize" value="'+res.fileList[i].fileSz+'">';
						html +=	'</div>';
					}
					
					$("#banner-data").html(html);
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
			$("#banner-area").children().remove();
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
			url      : contextPath+"changeStat.do",
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
				$("#ttl-typ").html('수정');
				$(".init-class").prop("disabled", false);
			}
			$("#nm").focus();
		}
	}
	
	// 게시판 등록
	function addBbs(){
		
		$.ajax({
			url      : contextPath+"addBbs.do",
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
			url      : contextPath+"updateBbs.do",
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
	
</script>

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
														<td><input type="text" class="form-control form-control-user text-center" name="topBnNm" value="${list.topBnNm }"></td>
														<td><input type="text" class="form-control form-control-user text-center" name="botmBnNm" value="${list.botmBnNm }"></td>
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
												<button class="btn btn-secondary btn-icon-split init-class" id="btn-bnReset" onclick="btnControl('reset');">
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
         		
         		<%-- <div class="card shadow mb-4">
					<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
    					<h5 class="m-0 font-weight-bold text-primary">Tech Stack</h5>
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
	    					<button class="btn btn-primary btn-icon-split" id="btn-addTech" title="추가" value="add">
	    						<span class="text">추가</span>
			    			</button>
	    					<button class="btn btn-danger btn-icon-split" id="btn-delTech" title="삭제" value="del" disabled>
	    						<span class="text">삭제</span>
			    			</button>
    					</div>
					</div>
					
					<!-- Card Body -->
					<div class="card-body">
						<form id="frm-tech" method="get">
							<input type="hidden" name="listTyp" id="listTyp" value="${bbsVO.listTyp }" readonly="readonly">
					    	<div class="table-responsive" style="overflow-x: hidden;">
					  			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
									<div class="row">
										<div class="col-sm-12">
											<table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
												<colgroup>
													<col width="5">		<!-- all check 	-->
													<col width="30">	<!-- 아이콘 	-->
													<col width="50"> 	<!-- 기술명 	-->
													<col width="50"> 	<!-- 등록일 	-->
													<col width="50"> 	<!-- 수정일  	-->
													<col width="10"> 	<!-- 상태    	-->
												</colgroup>
												<thead>
												    <tr role="row">
												    	<th class="sorting sorting_asc text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending"><input type="checkbox" class="cursor-pointer custom-checkbox-lg" id="all-chk-tech" disabled></th>
												    	<th class="sorting sorting_asc text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending">아이콘</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">기술명</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">등록일시</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">수정일시</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">상태</th>
												    </tr>
												</thead>
												<tbody id="tech-area">
													<c:forEach var="list" items="${getTechList}">
													<tr class="text-center sorting" onclick="getTech(${list.mainSeq});" id="tr-${list.mainSeq }">
														<td class="sorting_1" id="nm-${list.bbsSeq }" aria-label="${list.bbsSeq }"><input type="checkbox" class="cursor-pointer custom-checkbox-lg" value="${list.mainSeq }"></td>
														<td>${list.techNm }</td>
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
													<c:if test="${empty getTechList }">
													<tr class="text-center">
														<td colspan="6">
															<strong class="text-lg"><br>등록된 기술이 없습니다.<br><br></strong>
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
         		</div> --%>
         		
         		<div class="card shadow mb-4">
				    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
				        <h5 class="m-0 font-weight-bold text-primary">Tech Stack</h5>
				        <div>
				            <button class="btn btn-primary btn-icon-split" id="btn-addTech" title="추가" value="add">
				                <span class="text">추가</span>
				            </button>
				            <button class="btn btn-danger btn-icon-split" id="btn-delTech" title="삭제" value="del" disabled>
				                <span class="text">삭제</span>
				            </button>
				        </div>
				    </div>
				
				    <div class="card-body">
				        <form id="frm-tech" method="get">
				            <input type="hidden" name="listTyp" id="listTyp" value="" readonly>
				
				            <!-- 카드 리스트 영역 -->
				            <div class="row" id="tech-card-area">
				
				                <!-- 데이터 없을 때 -->
				                <!-- <div class="col-12 text-center py-5">
				                    <strong class="text-lg"><br>등록된 기술이 없습니다.<br><br></strong>
				                </div> -->
				
				                <!-- 예시 카드 -->
				                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
				                    <div class="card border-left-primary shadow h-100 py-2">
				                        <div class="card-body">
				                            <div class="d-flex justify-content-between">
				                                <input type="checkbox" class="cursor-pointer custom-checkbox-lg item-chk">
<!-- 				                                <img src="/icons/java.png" width="40" height="40"> -->
				                            </div>
				
				                            <h6 class="mt-3 mb-2 font-weight-bold text-primary">Java</h6>
				
				                            <div class="text-xs mb-1">등록일: 2024-05-01</div>
				                            <div class="text-xs mb-1">수정일: 2024-05-02</div>
				                            <div>
				                                <span class="badge badge-success">생성중</span>
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
	                      			<label for="bbs-title"><strong>상단 배너명</strong></label>
	                          		<input type="email" class="form-control form-control-user init-class" placeholder="상단 배너명 없음" value="${getBanner[0].topBnNm }">
	                      		</div>
	                      		<div class="form-group">
	                      			<label for="bbs-title"><strong>하단 배너명</strong></label>
	                          		<input type="email" class="form-control form-control-user init-class" placeholder="하단 배너명 없음" value="${getBanner[0].botmBnNm }">
	                      		</div>
	                      		<div class="form-group">
	                      			<label for="bbs-title"><strong>현재이미지</strong></label>
	                      			<div class="text-center" id="banner-area">
	                      				<strong>등록된 이미지가 없습니다.</strong>
	                      			</div>
	                      		</div>
	                    		<div class="form-group">
		                      		<label for="bbs-title"><strong>설명</strong></label>
		                         	<input type="email" class="form-control form-control-user init-class" name="expln" id="expln" placeholder="설명" autocomplete="off">
	                      		</div>
			    				<input type="file" class="form-control d-none" id="banner-file" onchange="addBanner(this, event, 'img');">
	                      		<input type="text" name="thumbYn" class="" id="bannerYn">
	                      		<div id="banner-data"></div>
	                      		<hr>
							</form>
			  
						<div class="text-center">
							<div class="d-flex justify-content-between">
								<div id="btn-divTag1">
									<button class="btn btn-primary btn-icon-split init-class" id="btn-save" onclick="btnControl('add');">
								    	<span class="text" id="btn-text-span">저장</span>
									</button>
									<button class="btn btn-secondary btn-icon-split init-class" id="btn-reset" onclick="btnControl('reset');">
					         			<span class="text">취소</span>
					    			</button>
								</div>
								<div id="btn-divTag2">
									<button class="btn btn-success btn-icon-split init-class d-none" id="btn-restore" onclick="btnControl('stat', '1');">
					         			<span class="text">복구</span>
					    			</button>
									<button class="btn btn-danger btn-icon-split init-class d-none" id="btn-del" onclick="btnControl('stat', '0');">
					         			<span class="text">삭제</span>
					    			</button>
									<button class="btn btn-success btn-icon-split" id="btn-bannerImg" onclick="btnControl('addBner', '9');">
				         				<span class="text">이미지 추가</span>
				    				</button>
									<button class="btn btn-danger btn-icon-split init-class" id="btn-bannerImgDel" onclick="btnControl('delImg', '9');" disabled>
				         				<span class="text">이미지 삭제</span>
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
