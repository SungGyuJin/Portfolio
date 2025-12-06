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
	function btnControl(e){
		if(e == 'addBn'){
			frmSubmit(e);
		}else if(e == 'reset'){
			btnReset();
		}else if(e == 'addImg'){
			$("#banner-file").trigger('click');
		}else if(e == 'delImg'){
			$("#banner-area").empty();
			$("#banner-data").empty();
			$("#bannerYn").val('N');
			$("#btn-bannerImgDel").prop('disabled', true);
		}else{
			changeStat_1(num);
		}
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
					alert("등록완료")
				}else{
					alert("실패")
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

	// 배너이미지
	function bannerImgChk(e, event, gubun){

	    console.log('진입!!')
	    
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
			
		    console.log(file)
		    
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
	
	// 게시만 조회
	function getBbs(no){
		

		$("table tr").removeClass('table-active');
		$("#tr-"+no).addClass('table-active');
		
		$("#frm-typ").val('upd');
		initBbs('click');
		$("#btn-new").prop("disabled", false);
		$("#btn-text-span").html('수정완료');
		
		$.ajax({
			url      : contextPath+"getBbs.do",
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
	    					<!-- <button class="btn btn-primary btn-icon-split" id="btn-addBanner" title="추가" value="add">
	    						<span class="text">추가</span>
			    			</button>
	    					<button class="btn btn-danger btn-icon-split" id="btn-delBanner" title="삭제" value="del" disabled>
	    						<span class="text">삭제</span>
			    			</button> -->
    					</div>
					</div>
					
					<!-- Banner Card Body -->
					<div class="card-body">
						<form id="frm-banner" method="get">
							<input type="hidden" name="mainSeq" value="1" readonly="readonly">
							<input type="hidden" name="mainSe" id="mainSeBanner" value="B" readonly="readonly">
							<input type="text" name="stat" id="bnStat" value="1">
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
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">등록일</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">수정일</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">상태</th>
												    </tr>
												</thead>
												<tbody>
													<tr class="text-center sorting">
														<td><input type="text" class="form-control form-control-user text-center" name="topBnNm"></td>
														<td><input type="text" class="form-control form-control-user text-center" name="botmBnNm"></td>
														<td>등록일시</td>
														<td>수정일시</td>
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
													<!-- <tr class="text-center">
														<td colspan="6">
															<strong class="text-lg"><br>등록된 배너데이터가 없습니다.<br><br></strong>
														</td>
													</tr> -->
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
         		
         		<div class="card shadow mb-4">
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
						<form id="frm-tech" method="get">
							<input type="hidden" name="listTyp" id="listTyp" value="${bbsVO.listTyp }" readonly="readonly">
					    	<div class="table-responsive" style="overflow-x: hidden;">
					  			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
									<div class="row">
										<div class="col-sm-12">
											<table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
												<colgroup>
													<col width="10">	<!-- 게시판명 	-->
													<col width="50"> 	<!-- 등록일시 	-->
													<col width="50"> 	<!-- 등록일 	-->
													<col width="50"> 	<!-- 상태    	-->
													<col width="10"> 	<!-- 상태    	-->
												</colgroup>
												<thead>
												    <tr role="row">
												    	<th class="sorting sorting_asc text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending">아이콘</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">기술명</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">등록일시</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">수정일시</th>
														<th class="sorting text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">상태</th>
												    </tr>
												</thead>
												<tbody>
													<tr class="text-center sorting" onclick="getBbs(${list.bbsSeq});" id="tr-${list.bbsSeq }">
														<td class="sorting_1" id="nm-${list.bbsSeq }" aria-label="${list.bbsSeq }">${list.nm }</td>
														<td>${list.regDt }</td>
														<td>등록일시</td>
														<td>수정일시</td>
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
													<c:if test="${empty getBbsList }">
													<tr class="text-center">
														<td colspan="5">
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
<%-- 													<c:forEach var="list" varStatus="varStatus" items="${getBbsList }"> --%>
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
<%-- 													</c:forEach> --%>
													<c:if test="${empty getBbsList }">
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
	                          		<input type="email" class="form-control form-control-user init-class" name="nm" id="nm" placeholder="게시판명" autocomplete="off">
	                      		</div>
	                      		<div class="form-group">
	                      			<label for="bbs-title"><strong>하단 배너명</strong></label>
	                          		<input type="email" class="form-control form-control-user init-class" name="nm" id="nm" placeholder="게시판명" autocomplete="off">
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
			    				<input type="file" class="form-control d-none" id="banner-file" onchange="bannerImgChk(this, event, 'img');">
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
									<button class="btn btn-success btn-icon-split" id="btn-bannerImg" onclick="btnControl('addImg', '9');">
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
