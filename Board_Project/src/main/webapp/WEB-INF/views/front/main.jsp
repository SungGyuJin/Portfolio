<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>

<body>
<script>

<c:choose>
	<c:when test="${errorCode eq '0000' }">
		<c:if test="${loginChk eq 'Y'}">
			localStorage.setItem("loginChk", "${sessionScope.USERID }");
		</c:if>
		<c:if test="${loginChk ne 'Y'}">
			localStorage.removeItem("loginChk");
		</c:if>
	</c:when>
</c:choose>

$(function(){
	
    var loginMsg = '${loginMsg}';
    var loginNum = '${loginNum}';
    
    if (loginMsg && loginMsg.length > 0) {
        alert(loginMsg);
    }
    
    if(loginNum == 0){
// 		location.href = '/login.do';
    }
	
    
	getUserInfo($("#uno").val(), 'refresh');
	
	$("#btn-addProfile").on('click', function(){
		$("#profile-file").trigger('click');
	});
	
	$("#brd-select").on('change', function(){
		
		if($(this).val() != ''){
			
			$.ajax({
				url      : contextPath+"/main/getBbs.do",
				method   : "GET",
				data     : {"no" : $(this).val() },
				dataType : "json",
				success  : function(res){
					
					if(res != null){
	
						res.getBbs.secrtYn == 'Y' ? $("#div-add-secrt").removeClass('d-none') : $("#div-add-secrt").addClass('d-none');
						res.getBbs.atchYn == 'Y' ? $("#div-add-atchYn").removeClass('d-none') : $("#div-add-atchYn").addClass('d-none');
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
		
	});
	
	$("#brd-pwdYn").on('change', function(){
		
		if($("#brd-pwdYn:checked").val() == 'Y'){
			$("#brd-pwd").prop("disabled", false);
			$("#brd-pwd").focus();
			$("#brd-pwd").prop("placeholder", "비밀번호를 설정하세요.");
		}else{
			$("#brd-pwd").prop("disabled", true);
			$("#brd-pwd").val('');
			$("#brd-pwd").removeAttr("placeholder");
		}
	});

	$("#brd-upd-pwdYn").on('change', function(){
		if($("#brd-upd-pwdYn:checked").val() == 'Y'){
			$("#brd-upd-pwd").prop("disabled", false);
			$("#brd-upd-pwd").focus();
			$("#brd-upd-pwd").prop("placeholder", "비밀번호를 설정하세요.");
			$("#brd-upd-pwdYnCancel").prop("checked", false);
		}else{
			$("#brd-upd-pwd").prop("disabled", true);
			$("#brd-upd-pwd").val('');
			$("#brd-upd-pwd").removeAttr("placeholder");
		}
	});
	
	$("#brd-upd-pwdYnCancel").on('change', function(){
		if($(this).val() == 'N'){
			$("#brd-upd-pwd").prop("disabled", true);
			$("#brd-upd-pwd").val('');
			$("#brd-upd-pwd").removeAttr("placeholder");
			$("#brd-upd-pwdYn").prop("checked", false);
		}
	});
	
	$('#getBoardListModal').modal({
	    backdrop: 'static',
	    keyboard: false,
	    focus: false
	});
	
	CKEDITOR.replace("brd-cont", {
		removePlugins: 'elementspath, exportpdf',
		resize_enabled: false,
	    height: 350
	});

	CKEDITOR.replace("brd-upd-cont", {
		removePlugins: 'elementspath, exportpdf',
		resize_enabled: false,
	    height: 350
	});
	   
    CKEDITOR.on('instanceReady', function(evt) {
//         console.warn = function () {};
//         console.error = function () {};
//         console.log = function () {};
    });
	
	$('#frm-board').on('submit', function(e) {
        e.preventDefault();  // 기본 submit 막음
    });
	
 	$('#frm-board').on('keydown', function(e) {
    	if(e.key === 'Enter') {
            e.preventDefault();
    		changeList();
        }
	});
	
	$(document).on('input', '.autosize-textarea', function () {
		$(this).css('height', 'auto');
		$(this).css('height', this.scrollHeight + 'px');
	});
	
	// 댓글 등록처리
	$("#btn-addCmnt").on('click', function(){
		addCmnt('frm-addCmnt', 'add');
	});
	
	// 게시글 등록
	$("#btn-addBoard").on('click', function(){
		addBoardPost();
	});

	// 게시글 임시저장
	$("#btn-addBoardTemp").on('click', function(){
		addBoardPost('temp');
	});
	
	getBoardList(null, $("#listTyp").val());
	
	$('#brd-add-file').on('change', function() {
		
		var fileInput = $('#brd-add-file')[0];
		
		if (fileInput.files.length === 0) {
	        return;
	    }
		
		var formData = new FormData();
		
		for (var i=0; i < fileInput.files.length; i++) {
		    formData.append("files", fileInput.files[i]);
		}
		
		$.ajax({
			url      : contextPath+"/main/upload.do",
			method   : "POST",
			data     : formData,
			processData: false,
			contentType: false,
			dataType : "json",
			success  : function(res){

	        	var addFile 	  = '';
	        	var addFileHidden = '';

				for(var i=0; i < res.fileList.length; i++) {
					addFile += 	'<div class="d-flex fileData-area" id="new-file-'+i+'">';
					addFile += 		'<input type="hidden" name="arrFileOrgNm" value="'+res.fileList[i].fileOrgNm+'">';
					addFile += 		'<input type="hidden" name="arrFileSvgNm" value="'+res.fileList[i].fileSvgNm+'">';
					addFile += 		'<input type="hidden" name="arrFileExt" value="'+res.fileList[i].fileExt+'">';
					addFile += 		'<input type="hidden" name="arrFilePath" value="'+res.fileList[i].filePath+'">';
					addFile += 		'<input type="hidden" name="arrFileSize" value="'+res.fileList[i].fileSz+'">';
					addFile +=	'</div>';
					
					addFileHidden += '<div class="d-flex justify-content-between mt-1 file-area" id="new-file-hidden-'+i+'">';
					addFileHidden += 	'<div>';
					addFileHidden += 		'<small class="text-danger fw-bolder me-1">New</small>';
					addFileHidden += 		res.fileList[i].fileOrgNm;
					addFileHidden += 	'</div>';
					addFileHidden += 	'<div>';
					addFileHidden += 		(res.fileList[i].fileSz / 1024).toFixed(2)+' KB';
					addFileHidden += 		'<button type="button" class="btn btn-secondary btn-sm ms-2" onclick="removeFile(\'new\', \'del\' , \''+i+'\');">삭제</button>';
					addFileHidden += 	'</div>';
					addFileHidden += '</div>';
				}
	        	
	        	$("#add-file-data").append(addFile);
	        	$("#add-added-file").append(addFileHidden);
				
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
		
	});
	
	$('#brd-upd-file').on('change', function() {
		
		var fileInput = $('#brd-upd-file')[0];
		
		if (fileInput.files.length === 0) {
	        return;
	    }
		
		var formData = new FormData();
		
		for (var i=0; i < fileInput.files.length; i++) {
		    formData.append("files", fileInput.files[i]);
		}
		
		$.ajax({
			url      : contextPath+"/main/upload.do",
			method   : "POST",
			data     : formData,
			processData: false,
			contentType: false,
			dataType : "json",
			success  : function(res){

	        	var addFile 	  = '';
	        	var addFileHidden = '';

				for(var i=0; i < res.fileList.length; i++) {
					addFile += 	'<div class="d-flex fileData-area" id="new-file-'+i+'">';
					addFile += 		'<input type="hidden" name="arrFileOrgNm" value="'+res.fileList[i].fileOrgNm+'">';
					addFile += 		'<input type="hidden" name="arrFileSvgNm" value="'+res.fileList[i].fileSvgNm+'">';
					addFile += 		'<input type="hidden" name="arrFileExt" value="'+res.fileList[i].fileExt+'">';
					addFile += 		'<input type="hidden" name="arrFilePath" value="'+res.fileList[i].filePath+'">';
					addFile += 		'<input type="hidden" name="arrFileSize" value="'+res.fileList[i].fileSz+'">';
					addFile +=	'</div>';
					
					addFileHidden += '<div class="d-flex justify-content-between mt-1 file-area" id="new-file-hidden-'+i+'">';
					addFileHidden += 	'<div>';
					addFileHidden += 		'<small class="text-danger fw-bolder me-1">New</small>';
					addFileHidden += 		res.fileList[i].fileOrgNm;
					addFileHidden += 	'</div>';
					addFileHidden += 	'<div>';
					addFileHidden += 		(res.fileList[i].fileSz / 1024).toFixed(2)+' KB';
					addFileHidden += 		'<button type="button" class="btn btn-secondary btn-sm ms-2" onclick="removeFile(\'new\', \'del\' , \''+i+'\');">삭제</button>';
					addFileHidden += 	'</div>';
					addFileHidden += '</div>';
				}
	        	
	        	$("#upd-file-data").append(addFile);
	        	$("#upd-added-file").append(addFileHidden);
				
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
		
	});
	
	$("#btn-userSave").on('click', function(){
		
		if($("#uPwd").val() == $("#uPwd-chk").val()){
			
			if($("#uNm").val().length == 0){
				alert('사용자 이름을 입력하세요.');
				$("#uNm").focus();
				return false;
			}

			$.ajax({
				url      : contextPath+"/main/updateUser.do",
				method   : "POST",
				data     : $("#frm-user").serialize(),
				dataType : "json",
				success  : function(res){
					
					if(res > 0){
						alert('저장되었습니다.');
						getBoardList($("#pageNum").val(), $("#listTyp").val(), $("#myPageYn").val());
						
						$("#user-nickname").html($("#uNm").val());
						$("#btn-getUserInfoModal-close").trigger('click');
						$("#profile-data").empty();

						getUserInfo($("#uNo").val(), 'refresh');

					}else{
						alert('저장에러')
					}
					
				},
				error : function(request, status, error){
					Swal.fire({
						icon: "error",
						title: "통신불가"
					})
				}
			});
			
		}else{
			alert('비밀번호가 일치하지 않습니다.');
		}
	});

	$("#btn-userDelete").on('click', function(){

		var tempMsg = '';
		var tempStr = $(this).val();

		if(tempStr == '7'){
			tempMsg = '(탈퇴신청을 철회합니다.)';
		}else{
			tempMsg = '(탈퇴 처리전 취소 가능합니다.)';
		}
		
		Swal.fire({
			  title: '비밀번호를 입력하세요',
			  text: tempMsg,
			  input: 'password',
			  inputPlaceholder: '비밀번호 입력',
			  showCancelButton: true,
			  confirmButtonText: '확인',
			  cancelButtonText: '취소',
			  preConfirm: (password) => {
			    return $.ajax({
			      url: contextPath+"/main/pwChkUser.do",
			      method: "POST",
			      data: { "no" : $("#uNo").val(), "pw": password },
			      dataType: "json"
			    }).then(res => {
			    	
		    	if (res.result === 'S') {
		    	      return password;
		    	    } else {
		    	      Swal.showValidationMessage('비밀번호가 틀렸습니다.');
		    	      return false;
		    	    }
		    	  }).catch(() => {
		    	    Swal.showValidationMessage('서버오류');
		    	  });
			  }
			}).then((result) => {
				if (result.isConfirmed) {
					
					$("#user-stat").remove();
					
					if(tempStr == '1'){
						var html = '<input type="hidden" name="stat" id="user-stat" value="7">';
					}else{
						var html = '<input type="hidden" name="stat" id="user-stat" value="1">';
					}
					
					$("#frm-user").append(html);

					$.ajax({
						url      : contextPath+"/main/updateUser.do",
						method   : "POST",
						data     : $("#frm-user").serialize(),
						dataType : "json",
						success  : function(res){

							if(res > 0){
								
								if(tempStr == '7'){
									alert('계정탈퇴가 철회되었습니다.');
									$("#btn-userDelete").html('탈퇴신청');
									$("#btn-userDelete").val('1');
									$("#btn-userDelete").addClass('text-danger');
									$("#btn-userDelete").removeClass('text-dark');
								}else{
									alert('계정탈퇴가 신청되었습니다.');
									$("#btn-userDelete").html('탈퇴철회');
									$("#btn-userDelete").val('7');
									$("#btn-userDelete").addClass('text-dark');
									$("#btn-userDelete").removeClass('text-danger');
								}
								
								userOptionInit($("#btn-userDelete").val());
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
			});
		
	});
	
});

// 썸네일 업로드 조건 및 표시
function thumbChk(e, event, gubun){
	
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
					$("#"+gubun+"-thumb-view").children().remove(); // 기존 내용 제거
					var img_html = '';
					img_html += '<img src="'+ event.target.result +'" style="height: auto; width: 100%;">';
					img_html += '<span class="thumb-close" onclick="removeThumb(\''+gubun+'\');">&times;</span>';
					$("#"+gubun+"-thumb-view").append(img_html);
				};
				
				reader.readAsDataURL(file[0]);

				$("#"+gubun+"-file-thumbYn").val('Y');

	        	var html = '';
				
				for(var i=0; i < res.fileList.length; i++) {
					html += '<div class="d-flex fileData-area">';
					html += 	'<input type="hidden" name="thumbFileOrgNm" value="'+res.fileList[i].fileOrgNm+'">';
					html += 	'<input type="hidden" name="thumbFileSvgNm" value="'+res.fileList[i].fileSvgNm+'">';
					html += 	'<input type="hidden" name="thumbFileExt" value="'+res.fileList[i].fileExt+'">';
					html += 	'<input type="hidden" name="thumbFilePath" value="'+res.fileList[i].filePath+'">';
					html += 	'<input type="hidden" name="thumbFileSize" value="'+res.fileList[i].fileSz+'">';
					html +=	'</div>';
				}
				
				$("#"+gubun+"-thumb-data").html(html);
				
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
		
	}else{
		
		$("#"+gubun+"-thumb-view").children().remove();
		$("#"+gubun+"-file-thumbYn").val('N');
		$("#"+gubun+"-file-thumb").val('');
	}
}

function profileChk(e, event, gubun){
	
	var file = e.files;

	if(file.length > 0){
		var imgChk = file[0].type.substr(0,5);

		if(imgChk != "image"){
			alert("이미지파일만 첨부 가능합니다");
			$("#profile-file").val('');
			$("#profile-view").children().remove();
			$("#profile-thumbYn").val('N');
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
					$("#profile-view").children().remove(); // 기존 내용 제거
					var img_html = '';
					img_html += '<img src="'+ event.target.result +'" style="height: auto; width: 100%;">';
					$("#profile-view").append(img_html);
				};
				
				reader.readAsDataURL(file[0]);

				$("#profile-thumbYn").val('Y');

	        	var html = '';
				
				for(var i=0; i < res.fileList.length; i++) {
					html += '<div class="d-flex fileData-area">';
					html += 	'<input type="hidden" name="thumbFileOrgNm" value="'+res.fileList[i].fileOrgNm+'">';
					html += 	'<input type="hidden" name="thumbFileSvgNm" value="'+res.fileList[i].fileSvgNm+'">';
					html += 	'<input type="hidden" name="thumbFileExt" value="'+res.fileList[i].fileExt+'">';
					html += 	'<input type="hidden" name="thumbFilePath" value="'+res.fileList[i].filePath+'">';
					html += 	'<input type="hidden" name="thumbFileSize" value="'+res.fileList[i].fileSz+'">';
					html +=	'</div>';
				}
				
				$("#profile-data").html(html);
				
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
		
		$("#btn-delProfile").prop("disabled", false);
		
	}else{
		removeProfile('del');
	}
}

function removeProfile(str) {
	if(str == 'upd' || str == 'del'){
		$("#profile-thumbYn").val('N');
	}else{
		$("#profile-thumbYn").val('D');
	}
	
	$("#profile-view").children().remove();
	$("#profile-file").val('');
	$("#profile-data").empty();
	$("#btn-delProfile").prop("disabled", true);
	
	$("#profile-view").html('<img class="img-fluid my-round" src="'+contextPath+'/resources/front/main/assets/img/profile.png" alt="profile img" />');
}

/* ################################################################################################# */
/* ######################################## BOARD ################################################## */

function removeThumb(gubun){
	$("#"+gubun+"-thumb-view").empty();
	$("#"+gubun+"-file-thumbYn").val('N');
	$("#"+gubun+"-file-thumb").val('');
}

// 게시물 등록처리
function addBoardPost(gubun){
	
	gubun == 'temp' ? $("#board-stat").val('5') : $("#board-stat").val('1');

	if(gubun == 'temp'){
		$("#myPageYn").val('T');
	}
	
	if($("#brd-select").val() == ''){
		alert('게시판을 선택해 주세요.');
		$("#brd-select").focus();
		return false;
	}

	if($("#brd-title").val().trim() == ''){
		alert('제목을 입력해 주세요.');
		$("#brd-title").focus();
		return false;
	}

  	CKEDITOR.instances['brd-cont'].updateElement();
	var brdCont = CKEDITOR.instances['brd-cont'].getData();
	
	if(cnChk(brdCont)){
		alert('내용을 입력해 주세요.');
		return false;
	}

	$.ajax({
		url      : contextPath+"/main/addBoard.do",
		method   : "POST",
		data     : $("#frm-addBoard").serialize(),
		dataType : "json",
		success  : function(res){
			
			if(res > 0){
				
				if(gubun == 'temp'){
					alert('임시저장되었습니다.');
				}else{
					alert('등록되었습니다.');
					$("#bbsSeq").val($("#brd-select").val());
					getBoardList('1', $("#listTyp").val(), '');
					$("#brd-select").val('');
					$("#brd-title").val('');
					$("#brd-cont").val('');
				}

				getBoardList('1', $("#listTyp").val(), $("#myPageYn").val());
				$("#btn-addBoard-close").trigger('click');
			}
			
		    CKEDITOR.instances['brd-cont'].setData('');
		},
		error : function(request, status, error){
			Swal.fire({
				icon: "error",
				title: "통신불가"
			})
		}
	});
}


// 게시물 수정처리
function updateBoardPost(no, pYn, stat){
	
	$("#brd-upd-stat").val(stat);
	
	if($("#brd-upd-title").val().trim() == ''){
		alert('제목을 입력해 주세요.');
		$("#brd-upd-title").focus();
		return false;
	}

	CKEDITOR.instances['brd-upd-cont'].updateElement();
	var brdCont = CKEDITOR.instances['brd-upd-cont'].getData();
	
	if(cnChk(brdCont)){
		alert('내용을 입력해 주세요.');
		return false;
	}
	
	if ($("#brd-upd-pwdYn").prop("checked") && $("#brd-upd-pwd").val().trim() == '') {
		alert('비밀번호를 설정하세요.');
		$("#brd-upd-pwd").focus();
		return false
	}

	var formData = new FormData($('#frm-updateBoard')[0]);
	
	$.ajax({
		url      : contextPath+"/main/updateBoard.do",
		method   : "POST",
	    data: formData,
	    contentType: false,
	    processData: false,
		dataType : "json",
		success  : function(res){
			
			if(res > 0){
				alert('수정되었습니다.');
				$("#updateBoardModal").modal('hide');
				getBoard(no, pYn);
				getBoardList($("#pageNum").val(), $("#listTyp").val(), $("#myPageYn").val());
				
				$("#brd-upd-pwdYn").prop("checked", false);
				$("#brd-upd-pwd").removeAttr("placeholder");
				$("#brd-upd-pwd").prop("disabled", true);
				$("#brd-upd-pwd").val('');
				$("#brd-upd-pwdYnCancel").prop("checked", false);
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

function cnChk(content) {
  var plainText = content.replace(/<[^>]*>/g, '').trim();
  return plainText === '';
}

// 게시판 클릭
function bbsClick(no){
	if($("#bbsSeq").val() == 0){
		$("#brd-select").val('');
	}else{
		
		if($("#ustat").val() == '2' || $("#ustat").val() == '4' || $("#ustat").val() == '8'){
			$("#brd-select").val('');
		}else{
			$("#brd-select").val($("#bbsSeq").val());
		}
	}
}

var cnt = 0;
function addBoardModalView(){

	if($("#ustat").val() == '2' || $("#ustat").val() == '4'){
		alert('글쓰기 기능이 금지되었습니다.\n문의하기 게시판을 통해 관리자에게 문의하세요.');
	}

	if($("#ustat").val() == '8' && cnt == 0){
		alert('계정이용이 정지되었습니다.\n문의하기 게시판을 통해 관리자에게 문의하세요.');
		cnt++;
	}
	
	var addBoardModal = new bootstrap.Modal($('#addBoardModal')[0], {
		backdrop: 'static',
		keyboard: false
	});
	
	addBoardModal.show();
	
	$('#addBoardModal').css('z-index', '1060');
	$('.modal-backdrop').last().css('z-index', '1055');
	
	$("#brd-add-file").val('');
	$("#add-file-data").empty();
	$("#add-added-file").empty();
}

function btnUpdateBoardClose(no, pYn){
	if(confirm("수정을 취소하시겠습니까?")){
		$("#updateBoardModal").modal('hide');
		getBoard(no, pYn);
	}
}

function getBoard(no, pYn, stat){

	if($("#ustat").val() == '3' || $("#ustat").val() == '4' || $("#ustat").val() == '8'){
		$("#cmnt-cn").prop('disabled', true);
		$("#cmnt-cn").prop('placeholder', '댓글(답글) 쓰기가 금지되었습니다. 관리자에게 문의하세요.');
	}else{
		$("#cmnt-cn").prop('disabled', false);
		$("#cmnt-cn").prop('placeholder', '댓글을 남겨보세요.');
	}
	
	$("#fn-area").empty();
	
	$("#btn-updateBoard-close").attr('onclick', 'btnUpdateBoardClose(\''+no+'\', \''+pYn+'\');');
	$("#btn-updateBoard").attr('onclick', 'updateBoardPost(\''+no+'\', \''+pYn+'\', \'1\');');
	$("#btn-updateBoard-temp").attr('onclick', 'updateBoardPost(\''+no+'\', \''+pYn+'\', \'5\');');
	
	if(pYn == 'N'){
		
		// Bootstrap 모달 인스턴스 생성 및 표시
		const getBoardModal = new bootstrap.Modal($('#getBoardModal')[0], {
			backdrop: true,
			keyboard: true,
		    focus: true
		});
		getBoardModal.show();
	
		// z-index 조정 (중첩 모달 문제 방지)
		$('#getBoardModal').css('z-index', '1060');
		$('.modal-backdrop').last().css('z-index', '1055');
		
		$("#cmnt-cn").val('');
		
		$.ajax({
			url      : contextPath+"/main/getBoard.do",
			method   : "GET",
			data     : {"no" : no, "stat" : stat},
			dataType : "json",
			success  : function(res){
				
				var data = res.getBoard;

				var profileImg = '<img src="'+contextPath+'/resources/front/main/assets/img/profile.png" class="me-2" alt="프로필 이미지" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">';
				$("#brd-profile").html(html);
				
				if(data.pfilePath.length > 0){
					profileImg = '<img class="img-fluid my-round profile-icon me-1" src="'+contextPath+data.pfilePath+'/'+data.pstrgFileNm+'" alt="profile img" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">';
				}
				
				$("#brd-profile").html(profileImg);
				
				$("#brd-bbsNm").html(data.bbsNm);
				
				if(data.pwdYn == 'Y'){
					$("#brd-ttl").html('<img class="mb-2 me-1" src="'+contextPath+'/resources/front/main/assets/img/lock.png" style="max-width: 22px;">'+data.title);
				}else{
					
					var html = '';
					
					if(data.stat == 5){
						html = '<small class="text-danger fw-bolder me-2">임시저장중</small>';
					}
					
					html +=	data.title;
					
					$("#brd-ttl").html(html);
				}
				
				$("#brd-userNm").html(data.userNm);
				$("#brd-regDt").html(data.regDt);
				$("#brd-readCnt").html(data.readCnt);
				$("#brd-cn").html(data.cont);
				$("#brdReadCnt-"+data.boardSeq).html(data.readCnt);
				$("#cmnt-userNm").html(data.userNm);

				var dataAtch = res.getAttachList;
				
				if(dataAtch.length > 0){
					var html = '<ul class="list-unstyled">';
					
					for(var i=0; i < dataAtch.length; i++){
						
						if(dataAtch[i].thumbYn == 'N'){
							html +=	'<li class="mb-2 d-flex align-items-center">';
							html +=		'<img src="'+ contextPath +'/resources/front/main/assets/img/front-atch-icon.png" alt="file" style="width: 20px; height: 20px; object-fit: cover;" class="mb-1 me-2">';
							html +=		'<a href="/main/fileDownload?no='+dataAtch[i].attachSeq+'" class="custom-link">'+dataAtch[i].fileNm+'</a>';
							html +=	'</li>';
						}
					}
					
					html +=	'</ul>';
					
					$("#brd-atch").html(html);
				}else{
					$("#brd-atch").empty();
				}
				
				// 답글
				if(res.getBoardReply[1] != null){
					$("#brd-reply-area").removeClass('d-none');
					
					var rData = res.getBoardReply[1];

					$("#brd-ttl-reply").html(rData.title);
					$("#brd-userNm-reply").html(rData.userNm);
					$("#brd-cn-reply").html(rData.cont);

					$("#brd-regDt-reply").html(rData.regDt);
					$("#brd-readCnt").html(rData.readCnt);
					
				}else{
					$("#brd-reply-area").addClass('d-none');
				}
				
					
				// 본인 여부
				if($("#uno").val() != 1 && $("#uno").val() == data.regNo && $("#ustat").val() != 8){
					var html = '';
					
					html += '<small class="text-muted cursor-pointer ms-2" onclick="updateBoard(\''+data.boardSeq+'\', \'upd\', 0);">수정</small>';
					html += '<small class="text-muted cursor-pointer ms-2" onclick="updateBoard(\''+data.boardSeq+'\', \'del\', 9);">삭제</small>';
				
					$("#fn-area").html(html);
					
				}else if($("#uno").val() != 1 && $("#uno").val() == data.regNo && $("#ustat").val() == 8){
					$("#fn-area").html('<small class="text-danger">* 계정이 정지되어 수정(삭제)권한이 없습니다.</small>');
				}
				
				// 댓글 관련
				$("#cmnt-boardSeq").val(data.boardSeq);
				
				getCmntList(data.boardSeq);
				
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
		
	}else{
		
		Swal.fire({
			  title: '비밀번호를 입력하세요',
			  input: 'password',
			  inputPlaceholder: '비밀번호 입력',
			  showCancelButton: true,
			  confirmButtonText: '확인',
			  cancelButtonText: '취소',
// 			  didOpen: () => {
// 			    const confirmBtn = Swal.getConfirmButton();
// 			    confirmBtn.disabled = false;
// 			  },
			  preConfirm: (password) => {
			    return $.ajax({
			      url: contextPath+"/main/pwChk.do",
			      method: "POST",
			      data: { "no" : no, "pw": password },
			      dataType: "json"
			    }).then(res => {
			    	
		    	if (res.result === 'S') {
		    	      return password;
		    	    } else {
		    	      Swal.showValidationMessage('비밀번호가 틀렸습니다.');
		    	      return false;
		    	    }
		    	  }).catch(() => {
		    	    Swal.showValidationMessage('서버오류');
		    	  });
			  }
			}).then((result) => {
			  if (result.isConfirmed) {
			    getBoard(no, 'N');
			  }
			});
	}
	
}
function changeList(num){
	getBoardList(num, $("#listTyp").val(), $("#myPageYn").val());
}

// 게시판 이동
function changeBbsSeq(no, info){
	$("#js-searchKeyword").val('');

	$("#bbsSeq").val(no);
	getBoardList(null, $("#listTyp").val());
}

// 게시물 목록 JS
function getBoardList(num, style, myPg, card){
	
	if(card == 'click'){
		var getBoardListModal = new bootstrap.Modal($('#getBoardListModal')[0], {
			backdrop: 'static',
			keyboard: false,
			focus: false
		});

		getBoardListModal.show();
	}
	
	$("#searchKeyword").val($("#js-searchKeyword").val());
	
	if($("#js-searchKeyword").val() != null){
		
		if($("#oldKeyword").val() == $("#js-searchKeyword").val() && num != null){
			$("#pageNum").val(num);
		}else{
			$("#pageNum").val('1');
		}
	}
	
	// Mpg 클릭
	if(myPg != null){
		$("#myPageYn").val(myPg);
		$("#stat").val('1');
	}else{
		$("#myPageYn").val('N');
		if($("#ustat").val() == 8){
	 		$("#stat").val('8');
		}else{
			$("#stat").val('1');
			
		}
	}
	
	$.ajax({
		url      : contextPath+"/main/getBoardList.do",
		method   : "get",
		data     : $("#frm-board").serialize(),
		dataType : "json",
		success  : function(res){
			
			var bbsList 		= res.getBbsList;
			var boardList 		= res.getBoardList;
			var boardListCnt 	= res.total;
			var page 			= res.pageMaker;
			var vo 				= res.boardVO;
			var html 			= '';
			var html_bbs		= '';
			
			var bbsNm = '';
			var bbsSeq = 0;
			
			if(res.getWriterCnt != null){
				$("#boardCnt").html(res.getWriterCnt[0].boardCnt);
				$("#cmntCnt").html(res.getWriterCnt[0].cmntCnt);
				$("#tempCnt").html(res.getWriterCnt[0].tempCnt);
			}

			if($("#ustat").val() != '8'){
			
				// 게시판 목록
				html_bbs +=	'<tr>';
				html_bbs += 	'<td class="my-td"> └ <a href="javascript:bbsClick(0)" id="bbsSeq-0" class="my-a text-dark" onclick="changeBbsSeq(0, this);"><img class="mb-1 me-1" src="'+contextPath +'/resources/front/main/assets/img/bbs_icon.png" style="max-width: 16px;"/><span class="underline">전체글보기</span></td>';
				html_bbs +=	'</tr>';
				
				for(let i=0; i < bbsList.length; i++){
					
						
					
					html_bbs += '<tr>';
					if(bbsList[i].bbsSeq != 1){
						html_bbs += '<td class="my-td"> └ <a href="javascript:bbsClick('+bbsList[i].bbsSeq+')" id="bbsSeq-'+bbsList[i].bbsSeq+'" class="my-a text-dark" onclick="changeBbsSeq('+bbsList[i].bbsSeq+', this);"><img class="mb-1 me-1" src="'+contextPath +'/resources/front/main/assets/img/bbs_icon.png" style="max-width: 16px;"/><span class="underline">'+bbsList[i].nm+'</span></a></td>';
					}
					html_bbs += '</tr>';
					
					if(vo.bbsSeq == bbsList[i].bbsSeq){
						bbsSeq = bbsList[i].bbsSeq;
						bbsNm = bbsList[i].nm;
					}
				}
			}else{

				for(let i=0; i < bbsList.length; i++){
					
					html_bbs += '<tr>';
					if(bbsList[i].bbsSeq == 26){
						html_bbs += '<td class="my-td"> └ <a href="javascript:bbsClick('+bbsList[i].bbsSeq+')" id="bbsSeq-'+bbsList[i].bbsSeq+'" class="my-a text-dark" onclick="changeBbsSeq('+bbsList[i].bbsSeq+', this);"><img class="mb-1 me-1" src="'+contextPath +'/resources/front/main/assets/img/bbs_icon.png" style="max-width: 16px;"/><span class="underline">'+bbsList[i].nm+'</span></a></td>';
					}
					html_bbs += '</tr>';
					
					if(vo.bbsSeq == bbsList[i].bbsSeq){
						bbsSeq = bbsList[i].bbsSeq;
						bbsNm = bbsList[i].nm;
					}
				}
			}

			$("#my-board").removeClass('fw-bolder');
			$("#my-cmnt").removeClass('fw-bolder');
			$("#my-temp").removeClass('fw-bolder');
			
			$("#append-bbs").html(html_bbs);
			$("#bbsSeq-"+bbsSeq).addClass('fw-bolder');
			
			if(bbsNm.length == 0 && res.boardVO.myPageYn == 'N'){
				bbsNm = '전체글보기';
			}else if(res.boardVO.myPageYn == 'B'){
				bbsNm = '내가 쓴 게시글';
				$("#bbsSeq-"+bbsSeq).removeClass('fw-bolder');
				$("#my-board").addClass('fw-bolder');
			}else if(res.boardVO.myPageYn == 'C'){
				bbsNm = '내가 쓴 댓글';
				$("#bbsSeq-"+bbsSeq).removeClass('fw-bolder');
				$("#my-cmnt").addClass('fw-bolder');
			}else if(res.boardVO.myPageYn == 'T'){
				bbsNm = '임시저장 글';
				$("#bbsSeq-"+bbsSeq).removeClass('fw-bolder');
				$("#my-temp").addClass('fw-bolder');
			}
			
			if($("#ustat").val() == 8){
				bbsNm = '문의하기';
				$("#bbsSeq-26").addClass('fw-bolder');
			}
			
			html += 	'<div class="mb-3">';
			html += 		'<div class="d-flex justify-content-between">';
			html += 			'<div><h4>'+bbsNm+'</h4></div>';
			html += 			'<div class="d-flex">';
			html +=					'<img src="'+contextPath +'/resources/front/main/assets/img/list.svg" class="cursor-pointer mb-1 me-2" id="list-icon" onclick="getBoardList(null, \'L\');" style="width: 45px;"/>';
			html +=					'<img src="'+contextPath +'/resources/front/main/assets/img/grid.svg" class="cursor-pointer mb-1 me-3" id="grid-icon" onclick="getBoardList(null, \'G\');" style="width: 35px;"/>';
			html += 				'<select class="form-select cursor-pointer" name="amount" onchange="changeList('+vo.pageNum+');" id="sel-amount">';
			html += 					'<option value="10">10개씩</option>';
			html += 					'<option value="20">20개씩</option>';
			html += 					'<option value="30">30개씩</option>';
			html += 					'<option value="40">40개씩</option>';
			html += 					'<option value="50">50개씩</option>';
			html += 				'</select>';
			html += 			'</div>';
			html += 		'</div>';
			html += 	'</div>';
			
			$("#board-header").html(html);

			if(style == 'L'){
				
				$("#listTyp").val('L');
				
				html = 	'';
				html += 		'<table class="table table-sm mb-5">';
				html +=				'<colgroup>';
				html +=					'<col width="5%">';
				html +=					'<col width="30%">';
				html +=					'<col width="10%">';
				html +=					'<col width="10%">';
				html +=					'<col width="10%">';
				html +=				'</colgroup>';
				html += 			'<thead class="my-thead text-muted">';
				html += 				'<tr>';
				html += 					'<th colspan="2">제목</th>';
				html += 					'<th>작성자</th>';
				html += 					'<th>작성일(수정일)</th>';
				html += 					'<th>조회수</th>';
				html += 				'</tr>';
				html += 			'</thead>';
				html += 			'<tbody>';
				
								if(boardList.length > 0){
									
									for(let i=0; i < boardList.length; i++){
										
										if(boardList[i].bbsSeq == 1){
				html +=						'<tr class="tr-notice">';
				html +=							'<td class=""><span class="my-notice">공지</span></td>';
				html +=							'<td class="text-start fw-bolder">';
				html +=								'<img class="mb-1" src="'+contextPath +'/resources/front/main/assets/img/spk.png" style="max-width: 20px;"/>\u00a0\u00a0';
				html +=								'<small><a href="javascript:getBoard('+boardList[i].ref+', \''+boardList[i].pwdYn+'\', \''+boardList[i].stat+'\');" class="my-a text-danger"><span class="underline">'+boardList[i].title+'</span></a></small>';
										}else{
				html +=						'<tr>';
											
											if(boardList[i].stat == 5){
				html +=							'<td><small class="text-danger fw-bolder me-2">임시저장중</small></td>';
											}else{
												boardList[i].rowNum > 0 ? html += '<td class="text-secondary"><small>'+boardList[i].rowNum+'</small></td>' : html += '<td></td>';
											}
				
				
				html +=							'<td class="text-start">';
											if(boardList[i].lvl > 0){
												for(let k=0; k < boardList[i].lvl; k++){
													html += "\u00a0";
												}
												
				html +=							' └ <small><span class="border px-1 py-0 fw-bold small my-danger me-1"><strong>RE:</strong></span></small>';
											}
											
											if(boardList[i].pwdYn == 'Y'){
												if(boardList[i].lvl < 1){
				html +=	 							'<img class="mb-1 me-1" src="'+contextPath +'/resources/front/main/assets/img/lock.png" style="max-width: 18px;"/>';
												}
				html +=							'<small><a href="javascript:getBoard('+boardList[i].ref+', \''+boardList[i].pwdYn+'\', \''+boardList[i].stat+'\');" class="my-a text-dark"><span class="underline">'+boardList[i].title+'</span></a></small>';
											}else{
				html +=							'<small><a href="javascript:getBoard('+boardList[i].ref+', \''+boardList[i].pwdYn+'\', \''+boardList[i].stat+'\');" class="my-a text-dark"><span class="underline">'+boardList[i].title+'</span></a></small>';
											}
										}
	
											if(boardList[i].atchCnt > 0){
				html += 						'<img class="ms-1 mb-1" src="'+contextPath +'/resources/front/main/assets/img/front-atch.png" style="max-width: 20px;"/>';
											}
	
											if(boardList[i].cmntCnt > 0){
				html +=							'<span class="cmnt-cnt fw-bolder ms-1">['+boardList[i].cmntCnt+']</span>';
											}
				
				html +=						'</td>';
				
				html +=						'<td class="text-secondary">';
				html +=							'<span>';
											if(boardList[i].regNo > 1){
												if(boardList[i].pfilePath.length > 0){
				html += 							'<img class="img-fluid my-round profile-icon me-1" src="'+contextPath+boardList[i].pfilePath+'/'+boardList[i].pstrgFileNm+'" alt="profile img">';
												}else{
				html += 							'<img class="img-fluid my-round profile-icon me-1" src="'+contextPath+'/resources/front/main/assets/img/profile.png" alt="profile img">';
												}
												
											}
				html +=								'<small>'+boardList[i].userNm+'</small>';
				html +=							'</span>';
				
				html +=						'</td>';
				html +=						'<td class="text-secondary"><small>'+boardList[i].regDt+' ('+boardList[i].updDt+')</small></td>';
				html +=						'<td class="text-secondary"><small id="brdReadCnt-'+boardList[i].boardSeq+'">'+boardList[i].readCnt+'</small></td>';
				html +=					'</tr>';
									}
										
									
								}else{
				html +=					'<tr>';
				html +=						'<td colspan="5">';
				html +=							'<img class="m-4" src="'+contextPath +'/resources/front/main/assets/img/nocontent.png" style="max-height: 230px;" />';
				html += 						'<br>검색 결과가 존재하지 않습니다.<br><br>';
				html +=						'</td>';
				html +=					'<tr>';
								}
				
				html += 			'</tbody>';
				html += 		'</table>';
				
			}else{

				$("#listTyp").val('G');

				if(boardList.length > 0){
					
					html = 	'<div class="row">';
					
					for(let i=0; i < boardList.length; i++){
						
						html +=	'<div class="col-md-3 mb-4" style="width: 20%;">';
						html +=		'<a href="javascript:getBoard('+boardList[i].ref+', \''+boardList[i].pwdYn+'\', \''+boardList[i].stat+'\');" class="my-a">';
						html +=			'<div class="card h-100 shadow-sm">';
						html +=				'<img src="'+ contextPath + boardList[i].filePath+'/'+boardList[i].strgFileNm+'" class="card-img-top" alt="thumbnail" onerror="this.onerror=null; this.src=\''+contextPath +'/resources/front/main/assets/img/default-img.png\'" style="object-fit: cover; height: 180px;">';
						
						if(boardList[i].pwdYn == 'Y'){
							html +=				'<img class="lock-icon" src="'+contextPath +'/resources/front/main/assets/img/lock.png" style="width: 30px; height: 30px;"/>';
						}
						
						html +=				'<div class="card-body">';
						html +=					'<h5 class="card-title underline">'+boardList[i].title+'</h5>';
						html +=				'</div>';
						html +=				'<div class="card-footer d-flex justify-content-between">';

						var uProfileImg = '';
						
						if(boardList[i].regNo > 1){
							if(boardList[i].pfilePath.length > 0){
								uProfileImg += '<img class="img-fluid my-round profile-icon me-1" src="'+contextPath+boardList[i].pfilePath+'/'+boardList[i].pstrgFileNm+'" alt="profile img">';
							}else{
								uProfileImg += '<img class="img-fluid my-round profile-icon me-1" src="'+contextPath+'/resources/front/main/assets/img/profile.png" alt="profile img">';
							}
						}

						html +=					'<small class="text-muted">'+uProfileImg+boardList[i].userNm+'</small>';
						
						html +=					'<small class="text-muted">작성일: '+boardList[i].regDt+'</small>';
						html +=				'</div>';
						html +=			'</div>';
						html +=		'</a>';
						html +=	'</div>';
					}
					
					html +=	'</div>';
					
				}else{
					
					
					
				}
				
				
			}

			$("#board-body").html(html);
			
// 			html += 	'<div class="d-flex justify-content-between">';
			html = 		'<div style="background-color: #f9f9f8;">';
			html +=			'<br>';
			html += 		'<nav aria-label="Page navigation">';
			html += 			'<ul class="pagination justify-content-center mb-4">';
								
							if(boardListCnt > 0){
								if(page.prev){
			html += 				'<li class="page-item"><a class="page-link" href="javascript:changeList('+(page.startPage -1)+');" tabindex="-1">＜</a></li>';
								}

								for(let num=page.startPage; num <= page.endPage; num++){
									if(vo.pageNum == num){
			html += 					'<li class="page-item active"><a class="page-link" href="javascript:void(0);">'+num+'</a></li>';
									}else{
			html += 					'<li class="page-item"><a class="page-link" href="javascript:changeList('+num+');">'+num+'</a></li>';
									}
								}

								if(page.next){
			html += 				'<li class="page-item"><a class="page-link" href="javascript:changeList('+(page.endPage +1)+');">＞</a></li>';
								}
							}else{
			html += 				'<li class="page-item active"><a class="page-link" href="javascript:void(0);">1</a></li>';
							}
			
			html += 			'</ul>';
			html += 		'</nav>';

			html += 		'<div class="row g-3 mb-4 d-flex justify-content-end">';
			html += 			'<div class="input-group justify-content-center mb-4">';
			html += 				'<div class="me-1" style="width: 15%;">';
			html += 					'<select class="form-select me-1 my-round" name="gubun" id="sel-gubun">';
			html += 						'<option value="">제목 + 내용</option>';
			html += 						'<option value="cn">내용</option>';
			html += 						'<option value="writer">작성자</option>';
			html += 						'<option value="cmnt">댓글내용</option>';
			html += 					'</select>';
			html += 				'</div>';
			
			
			html += 				'<input type="text" class="form-control me-1 my-round" id="js-searchKeyword" placeholder="검색어를 입력해주세요" value="'+vo.searchKeyword+'" autocomplete="off" style="flex: 0 0 30%;" spellcheck=\"false\">';
// 			html += 				'<button type="button" class="btn btn-success my-primary my-round" onclick="changeList();" style="flex: 0 0 15%;"></button>';
			html += 				'<button type="button" class="btn my-green my-round" onclick="changeList();"><i class="fas fa-search fa-lg"></i></button>';
			html += 			'</div>';
			html += 		'</div>';
			html += 	'</div>';
			

			$("#board-footer").html(html);
			
			if($("#ustat").val() == 8){
				$("#append-cnt").html(boardListCnt+' 개의 글 <small class="text-danger ms-2">* 현재 계정이 정지된 상태입니다. 관리자에게 문의하세요.</small>');
			}else if($("#ustat").val() == 2){
				$("#append-cnt").html(boardListCnt+' 개의 글 <small class="text-danger ms-2">* 현재 글쓰기 금지상태입니다. 관리자에게 문의하세요.</small>');
			}else if($("#ustat").val() == 3){
				$("#append-cnt").html(boardListCnt+' 개의 글 <small class="text-danger ms-2">* 현재 댓글쓰기 금지상태입니다. 관리자에게 문의하세요.</small>');
			}else if($("#ustat").val() == 4){
				$("#append-cnt").html(boardListCnt+' 개의 글 <small class="text-danger ms-2">* 현재 글쓰기 및 댓글쓰기 금지상태입니다. 관리자에게 문의하세요.</small>');
			}else{
				$("#append-cnt").html(boardListCnt+' 개의 글');
			}
			
			$("#sel-amount").val(vo.amount);
			$("#sel-bbs").val(vo.bbsSeq);
			$("#searchKeyword").val(vo.searchKeyword);
			$("#sel-gubun").val(vo.gubun);
			
			$("#oldKeyword").val(vo.searchKeyword);
			
			if(boardListCnt < 10){
				$("#sel-amount").prop('disabled', true);
				$("#sel-amount").val('10');
			}else{
				$("#sel-amount").prop('disabled', false);
			}
			
		},
		error : function(request, status, error){
// 			console.log("status: " + request.status);
// 			console.log("responseText: " + request.responseText);
// 			console.log("error: " + error);
			Swal.fire({
				icon: "error",
				title: "통신불가"
			})
		}
	});
}

function getUserInfo(no, str){
	
	if(str != 'refresh'){
		var getUserInfoModal = new bootstrap.Modal($('#getUserInfoModal')[0], {
			backdrop: 'static',
		    keyboard: false,
		    focus: false
		});
		getUserInfoModal.show();
	}else{
		$("#uPwd").val('');
		$("#uPwd-chk").val('');
		$("#profile-thumbYn").val('D');
	}
	
	if(no.length > 0){
		
		$.ajax({
			url      : contextPath+"/main/getUserInfo.do",
			method   : "GET",
			data     : {"no" : no},
			dataType : "json",
			success  : function(res){
	
				$("#uNo").val(res.uInfo.userSeq);
				$("#uId").val(res.uInfo.userId);
				$("#uNm").val(res.uInfo.userNm);
				
				if(res.uInfo.stat == '7'){
					$("#btn-userDelete").val(res.uInfo.stat);
					$("#btn-userDelete").html('탈퇴철회');
					$("#btn-userDelete").addClass('text-dark');
					$("#btn-userDelete").removeClass('text-danger');
				}else{
					$("#btn-userDelete").val(res.uInfo.stat);
					$("#btn-userDelete").html('탈퇴신청');
					$("#btn-userDelete").addClass('text-danger');
					$("#btn-userDelete").removeClass('text-dark');
				}
				
				var dflt_profile = '<img class="img-fluid my-round" src="'+contextPath+'/resources/front/main/assets/img/profile.png" alt="profile img" style="width: 25px; height: 25px; object-fit: cover; border-radius: 50%;" />';
				
				if(res.uInfo.filePath.length > 0){
					var html = '';
					html = '<img src="'+ contextPath + res.uInfo.filePath+'/'+res.uInfo.strgFileNm+'" class="card-img-top" alt="thumbnail" onerror="this.onerror=null; this.src=\''+contextPath +'/resources/front/main/assets/img/profile.png\'">';
					$("#profile-view").html(html);
					
					$("#btn-delProfile").prop('disabled', false);
					$("#btn-delProfile").attr('onclick', "removeProfile('upd')");
	
					var p_html = '<img src="'+ contextPath + res.uInfo.filePath+'/'+res.uInfo.strgFileNm+'" class="card-img-top" alt="thumbnail" onerror="this.onerror=null; this.src=\''+contextPath +'/resources/front/main/assets/img/profile.png\'" style="width: 25px; height: 25px; object-fit: cover; border-radius: 50%;">';
					$("#user-profile").html(p_html);
					
				}else{ 
					$("#user-profile").html(dflt_profile);
				}
				
				userOptionInit(res.uInfo.stat);
				
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
	}
}

function userOptionInit(str){
	if(str == 7){
		$("#uNm").prop('readonly', true);
		$("#uPwd").prop('readonly', true);
		$("#uPwd-chk").prop('readonly', true);
		$("#btn-addProfile").prop('disabled', true);
		$("#btn-delProfile").prop('disabled', true);
		$("#btn-userSave").addClass('d-none');
		$("#btn-userRefresh").addClass('d-none');
		$("#uSttsMent").removeClass('d-none');
	}else{
		$("#uNm").prop('readonly', false);
		$("#uPwd").prop('readonly', false);
		$("#uPwd-chk").prop('readonly', false);
		$("#btn-addProfile").prop('disabled', false);
		$("#btn-delProfile").prop('disabled', false);
		$("#btn-userSave").removeClass('d-none');
		$("#btn-userRefresh").removeClass('d-none');
		$("#uSttsMent").addClass('d-none');
	}
}

// 첨부파일 삭제
function removeFile(no, gubun, num){
	if(no == 'new'){
		$("#new-file-"+num).remove();
		$("#new-file-hidden-"+num).remove();
	}else{
		$("#upd-added-file-"+num).remove();
		$("#upd-removed-file").append('<input type="hidden" class="brd-upd-delFile" name="delSeqArr" value="'+no+'">');
	}
}

// 첨부파일(원복)
function refreshFile(no, gubun, num, option){
	$(".brd-upd-delFile").remove();
	updateBoard(no, gubun, num, option);
}

// 게시물 수정화면
function updateBoard(no, gubun, num, option){

	$("#brd-upd-file").val('');
	$("#upd-removed-file").empty();
	$("#upd-file-data").empty();
	$("#upd-added-file").empty();
	$("#upd-file-thumbYn").val('D');
	$("#upd-file-thumb").val('');
	$("#upd-thumb-view").empty();
	$("#upd-thumb-data").empty();
	
	$.ajax({
		url      : contextPath+"/main/getBoard.do",
		method   : "GET",
		data     : {"no" : no},
		dataType : "json",
		success  : function(res){
	
			if(gubun == 'upd'){
				
				$("#getBoardModal").modal('hide');
				
				if(option != 're'){
				  // Bootstrap 모달 인스턴스 생성 및 표시
					var updateBoardModal = new bootstrap.Modal($('#updateBoardModal')[0], {
						backdrop: 'static',
					    keyboard: false
// 					    focus: false
					});
					updateBoardModal.show();
				}
				
				if(res.getBoard.stat == 5){
					$("#btn-updateBoard-temp").removeClass('d-none');
				}else{
					$("#btn-updateBoard-temp").addClass('d-none');
				}
				
// 				res.getBoard.secrtYn == 'Y' ? $("#div-upd-secrt").removeClass('d-none') : $("#div-upd-secrt").addClass('d-none');
				res.getBoard.atchYn == 'Y' ? $("#div-upd-atchYn").removeClass('d-none') : $("#div-upd-atchYn").addClass('d-none');
			
				$("#brd-upd-boardSeq").val(res.getBoard.boardSeq);
				$('#updateBoardModal').css('z-index', '1060');
				$('.modal-backdrop').last().css('z-index', '1055');

// 				$("#brd-upd-select").val(res.getBoard.bbsSeq);
				$("#upd-bbs").val(res.getBoard.bbsNm);
				$("#brd-upd-title").val(res.getBoard.title);
				CKEDITOR.instances['brd-upd-cont'].setData(res.getBoard.cont);
				
				var fileCnt = 0;
				
				if(res.getAttachList.length > 0){
					
					$("#upd-file-area").removeClass('d-none');

					var header_html = '';
					var body_html = '';
					
					for(var i=0; i < res.getAttachList.length; i++){
						
						if(res.getAttachList[i].thumbYn == 'N'){
							body_html += '<div class="d-flex justify-content-between mt-1 file-area" id="upd-added-file-'+i+'">';
							body_html += 	res.getAttachList[i].fileNm;
							body_html += 	'<div>'+(res.getAttachList[i].fileSz / 1024).toFixed(2)+' KB';
							body_html += 		'<button type="button" class="btn btn-secondary btn-sm ms-2" onclick="removeFile('+res.getAttachList[i].attachSeq+', \''+gubun+'\' , \''+i+'\');">삭제</button>';
							body_html += 	'</div>';
							body_html += '</div>';
							
							fileCnt++;
						}else{
							var img_html = '';
							
							img_html += '<img src="'+ contextPath + res.getAttachList[i].filePath+'/'+res.getAttachList[i].strgFileNm+'" alt="썸네일" title="썸네일" width="100%" height="100%" class="mb-2">';
							img_html += '<span class="thumb-close" onclick="removeThumb(\''+gubun+'\');">&times;</span>';
							
							$("#upd-thumb-view").html(img_html);
						}
					}

					if(fileCnt > 0){
						
						header_html +=	'<div class="d-flex justify-content-between mt-1">';
						header_html += 		'<div>';
						header_html +=			'<label class="form-label fw-bold">첨부된 파일('+fileCnt+')</label>';
						header_html += 		'</div>';
						header_html += 		'<div>';
						header_html += 			'<a href="javascript:refreshFile('+no+', \''+gubun+'\', '+num+', \'re\');">';
						header_html +=				'<img src='+contextPath+'"/resources/front/main/assets/img/refresh.png" alt="새로고침" title="새로고침" width="34" height="34" class="mb-2">';
						header_html +=			'</a>';
						header_html += 		'</div>';
						header_html += '</div>';
					}
					
					$("#upd-added-file").html(header_html+body_html);
				}
				
			    if(res.getBoard.pwdYn == 'N'){
					$("#brd-pwd-cancel").addClass('d-none');
			    }else{
				    $("#brd-pwd-cancel").removeClass('d-none');
			    }
			  
			}else{
		
				if(res.getBoard.pwdYn == 'Y'){
					
					Swal.fire({
						  title: '비밀번호를 입력하세요',
						  text: '(삭제후 복구가 불가능합니다)',
						  input: 'password',
						  inputPlaceholder: '비밀번호 입력',
						  showCancelButton: true,
						  confirmButtonText: '확인',
						  cancelButtonText: '취소',
						  preConfirm: (password) => {
						    return $.ajax({
						      url: contextPath+"/main/pwChk.do",
						      method: "POST",
						      data: { "no" : no, "pw": password },
						      dataType: "json"
						    }).then(res => {
						    	
					    	if (res.result === 'S') {
					    	      return password;
					    	    } else {
					    	      Swal.showValidationMessage('비밀번호가 틀렸습니다.');
					    	      return false;
					    	    }
					    	  }).catch(() => {
					    	    Swal.showValidationMessage('서버오류');
					    	  });
						  }
						}).then((result) => {
							if (result.isConfirmed) {
								deleteBoard(no, num);
// 						    	getBoard(no, 'N');
							}
						});
					
				}else{
					deleteBoard(no, num);
				}			
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

function deleteBoard(no, num, pwdYn){

	if(confirm("삭제하시겠습니까?")){
		
		$.ajax({
			url      : contextPath+"/main/changeStat.do",
			method   : "POST",
			data     : {"delSeqArr" : no, "num" : num},
			dataType : "json",
			success  : function(res){
	
				if(res > 0){
					$("#getBoardModal").modal('hide');
					getBoardList($("#pageNum").val(), $("#listTyp").val(), $("#myPageYn").val());
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
}


/* ################################################################################################# */
/* ######################################## COMMENT ################################################ */

// 댓글 등록
function addCmnt(frm, gubun){
	
	if(gubun == 'update'){
		
		$.ajax({
			url      : contextPath+"/main/updateCmnt.do",
			method   : "POST",
			data     : $("#"+frm).serialize(),
			dataType : "json",
			success  : function(res){
				
				if(res > 0){
					getCmntList($("#cmnt-boardSeq").val());
					getBoardList($("#pageNum").val(), $("#listTyp").val());
				}
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
		
	}else{
		
		$.ajax({
			url      : contextPath+"/main/addCmnt.do",
			method   : "POST",
			data     : $("#"+frm).serialize(),
			dataType : "json",
			success  : function(res){
				
				if(res > 0){
					getCmntList($("#cmnt-boardSeq").val());
					getBoardList($("#pageNum").val(), $("#listTyp").val());
					
					if(gubun == 'add'){
						$("#btn-addCmnt").addClass('disabled');
						$("#cmnt-cn").val('');
					}
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
	
}

// 댓글 목록
function getCmntList(no){
	
	$.ajax({
		url      : contextPath+"/main/getCmntList.do",
		method   : "GET",
		data     : {"no" : no},
		dataType : "json",
		success  : function(res){
			
			var cmntList = res.getCmntList;			
			var html = '';
			
			var tempCnt = 0;
			
			if(cmntList.length > 0){
				
				for(var i=0; i < cmntList.length; i++){
					
					html += '<li class="mb-3 border-bottom pb-2 d-flex align-items-start" id="cmntRow-'+i+'">';
					
					if(cmntList[i].lvl > 0){
						for(var k=0; k < cmntList[i].lvl; k++){
							html += '&emsp;&emsp;&emsp;';
						}
					}
					
					html += 	'<img src="'+contextPath+'/resources/front/main/assets/img/profile.png" alt="프로필 이미지" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">';
					html += 	'<div class="ms-2 flex-grow-1">';
					html += 		'<div class="mb-1">';
					
										if($("#uNo").val() == cmntList[i].regNo){
											if(tempCnt == 0){
												$("#cmnt-userNm").html(cmntList[i].userNm);
												tempCnt++;
											}
										}
					
					html += 			'<span class="fw-bold">'+cmntList[i].userNm+'</span>';

					if(cmntList[i].authYn == 'Y'){
						html += 		'<span class="my-writer ms-2"><span>작성자</span></span>';
					}
					
					if($("#ustat").val() == 3 || $("#ustat").val() == 4 || $("#ustat").val() == 8){
						$("#cmnt-warn").removeClass('d-none');
						$("#frm-addCmnt").remove();
					}else{
						if($("#uno").val().length > 0){
							html += 		'<small class="text-muted ms-2 cursor-pointer cmnt-reply-btn" id="cmnt-replyBtn-'+i+'" onclick="replyCmntView(\''+cmntList[i].boardSeq+'\', \''+cmntList[i].ref+'\', \''+cmntList[i].step+'\', \''+cmntList[i].lvl+'\', \''+i+'\');">답글쓰기</small>';
						}
							
						if(cmntList[i].regNo == $("#uno").val()){
							html += 		'<small class="text-muted ms-2 cursor-pointer" onclick="updateCmnt('+cmntList[i].cmntSeq+', \'upd\', '+i+');">수정</small>';
							html += 		'<small class="text-muted ms-2 cursor-pointer" onclick="updateCmnt('+cmntList[i].cmntSeq+', \'del\');">삭제</small>';
						}
					}
					
					html += 		'</div>';
					html += 		'<div class="text-body"><pre>'+cmntList[i].cn+'</pre></div>';
					html += 		'<small class="text-muted">'+cmntList[i].updDt+'</small>';
					html += 	'</div>';
					html += '</li>';
				}
		
			}else{
				html += '<li class="mb-3 border-bottom pb-2 d-flex align-items-start">';
				html += 	'<div class="flex-grow-1 mb-2">';
				html += 		'<div class="text-body text-center m-4">등록된 댓글이 없습니다.</div>';
				html += 	'</div>';
				html += '</li>';
			}
			
			$("#cmnt-cmntCnt").html(cmntList.length);
			$("#append-cmnt").html(html);
			
		},
		error : function(request, status, error){
			Swal.fire({
				icon: "error",
				title: "통신불가"
			})
		}
	});
}

// 취소버튼
function btnCmntCancel(no, gubun){
	
	if(gubun == 'update'){
		$("#frm-updateCmnt").remove();
		$("#cmntRow-"+no).removeClass('d-none');
	}else if(gubun == 'reply'){
		$("#frm-addReplyCmnt").remove();
	}
}

var liOld = null;

// 댓글 수정(삭제)
function updateCmnt(cmntSeq, gubun, no){
	
	// 수정
	if(gubun == 'upd'){
		
		if(liOld != null){
			$("#cmntRow-"+liOld).removeClass('d-none');
		}
		liOld = no;
		
		$(".frm-updateCmnt").remove();
		
		$.ajax({
			url      : contextPath+"/main/getCmnt.do",
			method   : "GET",
			data     : {"no" : cmntSeq},
			dataType : "json",
			success  : function(res){
				
				let html = '';
				
				html += 	'<form class="frm-updateCmnt" id="frm-updateCmnt">';
				html += 		'<input type="hidden" name="cmntSeq" value="'+cmntSeq+'">';
				html += 		'<div class="comment-box border rounded p-3 position-relative text-start mb-3" style="min-height: 100px;">';
				html += 			'<div class="fw-bold mb-1">'+$("#unm").val()+'</div>';
				html += 			'<textarea class="form-control border-0 p-0 my-textarea autosize-textarea" id="cmnt-updateCn" name="cn" onkeyup="btnAddCmntChange(\'update\');" placeholder="댓글 수정중..." rows="2" style="resize: none;" spellcheck=\"false\">'+res.getCmnt.cn+'</textarea>';
				html +=				'<div class="register_box">';
				html += 				'<button type="button" class="button btn_cancel is_active me-1" id="btn-updCancel" onclick="btnCmntCancel('+no+', \'update\')">취소</button>';
				html += 				'<button type="button" class="button btn_register is_active" id="btn-updateCmnt" onclick="addCmnt(\'frm-updateCmnt\', \'update\');">수정</button>';
				html += 			'</div>';
				html += 		'</div>';
				html += 	'</form>';
				
				$("#cmntRow-"+no).after(html);
				$("#cmntRow-"+no).addClass('d-none');
				
			},
			error : function(request, status, error){
				Swal.fire({
					icon: "error",
					title: "통신불가"
				})
			}
		});
	
	// 삭제
	}else{

		if(confirm("삭제하시겠습니까?")){
			
			$.ajax({
				url      : contextPath+"/main/deleteCmnt.do",
				method   : "POST",
				data     : {"no" : cmntSeq},
				dataType : "json",
				success  : function(res){
					
					if(res > 0){
						getCmntList($("#cmnt-boardSeq").val());
						getBoardList($("#pageNum").val(), $("#listTyp").val(), $("#myPageYn").val());
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
	}
}


// 답글쓰기 클릭시 변화
function replyCmntView(brdSeq, ref, step, lvl, no){

	if($("#ustat").val() == '3' || $("#ustat").val() == '4'){
		alert('댓글(답글) 쓰기가 금지되었습니다. 관리자에게 문의하세요.');
		return false;
	}
	
	$("#frm-addReplyCmnt").remove();
	
	let html = '';

	html += 	'<form class="" id="frm-addReplyCmnt">';
	html += 		'<input type="hidden" name="boardSeq" value="'+brdSeq+'">';
	html += 		'<input type="hidden" name="ref" value="'+ref+'">';
	html += 		'<input type="hidden" name="step" value="'+step+'">';
	html += 		'<input type="hidden" name="lvl" value="'+lvl+'">';
	html += 		'<div class="comment-box border rounded p-3 position-relative text-start mb-3 ms-5" style="min-height: 100px;">';
	html += 			'<div class="fw-bold mb-1">'+$("#unm").val()+'</div>';
	html += 			'<textarea class="form-control border-0 p-0 my-textarea autosize-textarea" id="cmnt-replyCn" name="cn" onkeyup="btnAddCmntChange(\'reply\');" placeholder="답글 작성중..." rows="2" style="resize: none;" spellcheck=\"false\"></textarea>';
	html +=				'<div class="register_box">';
	html += 				'<button type="button" class="button btn_cancel is_active me-1" id="btn-replyCancel" onclick="btnCmntCancel('+no+', \'reply\')">취소</button>';
	html += 				'<button type="button" class="button btn_register is_active disabled" id="btn-addReplyCmnt" onclick="addCmnt(\'frm-addReplyCmnt\', \'reply\');">등록</button>';
	html += 			'</div>';
	html += 		'</div>';
	html += 	'</form>';
	
	$("#cmntRow-"+no).after(html);
	$("#cmnt-replyCn").focus();
		
}

function btnAddCmntChange(str){
	
	// 등록
	if(str == 'add'){
		if($("#cmnt-cn").val().trim().length > 0){
			$("#btn-addCmnt").removeClass('disabled');
		}else{
			$("#btn-addCmnt").addClass('disabled');
		}
	// 수정
	}else if(str == 'update'){
		if($("#cmnt-updateCn").val().trim().length > 0){
			$("#btn-updateCmnt").removeClass('disabled');
		}else{
			$("#btn-updateCmnt").addClass('disabled');
		}
	// 답글(대댓글)
	}else if(str == 'reply'){
		if($("#cmnt-replyCn").val().trim().length > 0){
			$("#btn-addReplyCmnt").removeClass('disabled');
		}else{
			$("#btn-addReplyCmnt").addClass('disabled');
		}
	}
}

</script>

	<!-- getBoardList Modal -->
	<div class="portfolio-modal modal fade" id="getBoardListModal" tabindex="-1" role="dialog" aria-hidden="true">
<!-- 		<input type="hidden" id="nowBbs" readonly="readonly"> -->
        <div class="modal-dialog modal-dialog-centered mx-auto" style="max-width: 100%;">
<!--         <div class="modal-dialog modal-dialog-centered mx-auto" style="max-width: 50%;"> -->
<!--     <div class="modal-dialog modal-dialog-centered"> -->
        <div class="modal-content m-3">
            <div class="close-modal" data-bs-dismiss="modal">
                <img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" style="width: 50px; height: 50px; object-fit: cover; border-radius: 50%;" />
            </div>
            <div class="container-fluid">
                <div class="row justify-content-center">
                    <div class="col-lg-12">
						<div class="modal-body mt-5" id="modal-board">
	                        <div class="row">
	                        	<div class="col-md-2"></div>
	                        	<div class="col-md-1">
            						<div class="sticky-sidebar">
										<div class="col-md-1 me-2 d-flex align-items-center justify-content-center"></div>
	            						<div class="image-wrapper mb-2">
									        
									        <c:choose>
									        	<c:when test="${sessionScope.USERSEQ ne null }">
			            								
			            								
									        <c:choose>
									        	<c:when test="${sessionScope.USERSEQ ne 1 }">
			            							<div class="user-info-box bg-light border rounded pt-2 mb-1 text-center fixed-image">
									        		
											            <div class="fw-bold mb-2">
											            	<a href="javascript:getUserInfo('${sessionScope.USERSEQ }');" class="my-a">
											            		<!-- <span id="user-profile">👤</span> -->
											            		<span id="user-profile">
											            			<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/profile.png" alt="프로필 이미지" style="width: 25px; height: 25px; object-fit: cover; border-radius: 50%;">
											            		</span>
											            		<span id="user-nickname">${sessionScope.USERNM }</span> 님
											            	</a>
											            </div>
											            
											            <div class="small text-muted d-flex justify-content-between ms-1 me-1" id="my-board">
														    <div><img class="mb-1 me-1" src="${pageContext.request.contextPath}/resources/front/main/assets/img/pencil-black.png" style="max-width: 16px;">내가 쓴 게시글:</div>
														    <div><a href="javascript:getBoardList(1, 'L', 'B');" class="my-a"><span id="boardCnt"></span> 개</a></div>
														</div>
														
											            <div class="small text-muted d-flex justify-content-between ms-1 me-1" id="my-cmnt">
														    <div><img class="mb-1 me-1" src="${pageContext.request.contextPath}/resources/front/main/assets/img/cmnt.png" style="max-width: 16px;">내가 쓴 댓글:</div>
														    <div><a href="javascript:getBoardList(1, 'L', 'C');" class="my-a"><span id="cmntCnt"></span> 개</a></div>
														</div>
														
											            <div class="small text-muted d-flex justify-content-between ms-1 me-1" id="my-temp">
														    <div><img class="mb-1 me-1" src="${pageContext.request.contextPath}/resources/front/main/assets/img/cmnt.png" style="max-width: 16px;">임시저장 글:</div>
														    <div><a href="javascript:getBoardList(1, 'L', 'T');" class="my-a"><span id="tempCnt"></span> 개</a></div>
														</div>
			       										<button type="button" class="btn my-success w-100 mt-1" id="btn-addBoradModal" onclick="addBoardModalView();">
			       											글쓰기
			       										</button>
											        </div>
									        	</c:when>
									        	<c:otherwise>
			            							<div class="user-info-box bg-light border rounded pt-2 mb-1 text-center fixed-image">
			            								<br>
			            								<br>
											            <div class="fw-bold mb-2">👤 <span id="admin-nickname">관리자 계정입니다</span></div>
											        </div>
									        	</c:otherwise>
									        </c:choose>
			            							
									        	</c:when>
									        	<c:otherwise>
			            							<div class="user-info-box bg-light border rounded p-2 mb-1 text-center fixed-image">
											            <div class="mt-5">※ 로그인이 필요합니다.</div>
											        </div>
									        	</c:otherwise>
									        </c:choose>
	            						</div>
		                        		<table class="table table-sm mb-0 text-start">
											<tbody class="text-muted my-thead" id="append-bbs"></tbody>
										</table>
            						</div>
	                        	</div>
	                        	
		                        <div class="col-md-6 mt-4">
		                            <div class="d-flex justify-content-between">
		                            	<span class="mt-3" id="append-cnt"></span>
		                            </div>
									<input type="hidden" id="oldKeyword" value="">
		                        	<hr>
		                        	<form id="frm-board">
		                        		<input type="hidden" name="myPageYn" id="myPageYn" value="N">
		                        		<input type="hidden" name="listTyp" id="listTyp" value="L">
		                        		<input type="hidden" name="bbsSeq" id="bbsSeq" value="0">
		                        		<input type="hidden" name="pageNum" id="pageNum" value="1">
		                        		<input type="hidden" name="searchKeyword" id="searchKeyword" autocomplete="off">
		                        		<input type="hidden" name="bbsNm" id="bbsNm" value="${vo.pageNum }">
		                        		<input type="hidden" name="stat" id="stat" value="1">
		                        		<div id="board-header"></div>
		                        		<div id="board-body"></div>
		                        		<div id="board-footer"></div>
		                        	</form>
		                        </div>
	                        </div>	<!-- .row end -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

	<!-- getBoard Modal -->
	<div class="portfolio-modal modal fade" id="getBoardModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-half-right modal-lg">
  			<div class="modal-content modal-content-scrollable" id="modal-board">
	            <div class="close-modal" data-bs-dismiss="modal">
	            	<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
	            </div>
    			<!-- 상단 툴바 -->
				<div class="modal-header border-0 pb-0 mt-4">
    				<hr>
      				<div class="w-100 d-flex justify-content-between align-items-start mt-2 text-start">
        				<div>
          					<small class="text-success fw-bold ms-1"><span id="brd-bbsNm"></span>&gt;</small>
          					<h4 class="fw-bold mt-1" id="brd-ttl"></h4>
          					<div class="d-flex align-items-center mt-2 mb-4">
	          					<span class="me-1" id="brd-profile">
  									<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/profile.png" class="me-2" alt="프로필 이미지" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
    	      					</span>
            					<div>
            						<span class="me-2 fw-bolder" id="brd-userNm"></span>
            						<br>
            						<span class="text-muted small"><span id="brd-regDt"></span>&nbsp;&nbsp;조회 <span id="brd-readCnt"></span></span>
            						<span id="fn-area"></span>
            					</div>
          					</div>
        				</div>
      				</div>
					<hr>
    			</div>

			    <!-- 본문 -->
			    <div class="my-modal-body text-start">
					<div class="p-2 rounded editor-preview" id="brd-cn"></div>
					<div class="mt-5" id="brd-atch"></div>
			    </div>
			    
			    <!-- 답글 -->
			    <div class="my-modal-body text-start me-2" id="brd-reply-area">
       				<div>
      					<h5 class="fw-bold text-muted mt-1"><span class="border px-1 py-0 fw-bold small my-danger-reply me-1"><strong>RE:</strong></span><span id="brd-ttl-reply"></span></h5>
        				<div class="d-flex align-items-center mt-2 mb-4">
        					<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/profile.png" class="me-2" alt="프로필 이미지" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
        					<div>
        						<span class="me-2 fw-bolder" id="brd-userNm-reply"></span>
        						<br>
        						<span class="text-muted small"><span id="brd-regDt-reply"></span></span>
        						<span id="fn-area-reply"></span>
        					</div>
      					</div>
       				</div>
<!-- 					<div class="p-2 rounded editor-preview" id="brd-title-reply"></div> -->
					<div class="p-2 rounded editor-preview" id="brd-cn-reply"></div>
					<div class="mt-5" id="brd-atch-reply"></div>
			    </div>

    			<!-- 댓글 -->
			    <div class="comments-section text-start">
			    	<div class="d-flex">
				  		<h6 class="fw-bold mb-2 me-2">댓글 <span class="text-danger" id="cmnt-cmntCnt">0</span></h6>
				  		<small class="text-danger d-none" id="cmnt-warn">* 댓글(답글) 쓰기가 금지되었습니다. 관리자에게 문의하세요.</small>
			    	</div>
			    	<hr>
			  		<ul class="list-unstyled mt-4" id="append-cmnt"></ul>
			  		
			  		<form id="frm-addCmnt">
			  			<input type="hidden" name="boardSeq" id="cmnt-boardSeq">
						<div class="comment-box border rounded p-3 position-relative text-start mb-3" style="min-height: 100px;">
				  			<div class="fw-bold mb-1">
				  				<span id="cmnt-userNm">${sessionScope.USERNM}</span>
				  			</div>
				  			<c:choose>
				  				<c:when test="${empty sessionScope.USERSEQ }">
				  					<textarea class="form-control border-0 p-0 my-textarea autosize-textarea" placeholder="로그인이 필요합니다." rows="2" style="resize: none;" disabled></textarea>
				  				</c:when>
				  				<c:otherwise>
						  			<textarea class="form-control border-0 p-0 my-textarea autosize-textarea" name="cn" id="cmnt-cn" onkeyup="btnAddCmntChange('add');" placeholder="댓글을 남겨보세요." rows="2" style="resize: none;"  spellcheck="false"></textarea>
				  				</c:otherwise>
				  			</c:choose>
							<div class="register_box <c:if test="${empty sessionScope.USERSEQ }">invisible</c:if>">
								<button type="button" class="button btn_register is_active disabled" id="btn-addCmnt">등록</button>
							</div>
						</div>
			  		</form>
				</div>	<!-- .comments-section End -->
				
  			</div>
		</div>
	</div>
        
	<!-- addBoard Modal -->
	<div class="portfolio-modal modal fade" id="addBoardModal" tabindex="-1" role="dialog" aria-hidden="true">
  		<div class="modal-dialog modal-half-left modal-lg">
    		<div class="modal-content modal-content-scrollable" id="modal-addBoard">
				<div class="close-modal" data-bs-dismiss="modal" id="btn-addBoard-close">
					<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
				</div>
				<div class="modal-header border-0 pb-0 mt-4">
					<div class="w-100 mt-2 text-start">
			            <div class="d-flex justify-content-between mt-5">
			            	<div>
					        	<h1>글쓰기</h1>
			            	</div>
			            	<div>
					            <button type="button" class="naver-button-temp <c:if test="${sessionScope.USERSTAT eq 8 }">invisible</c:if>" id="btn-addBoardTemp">임시저장</button>
					            <button type="button" class="naver-button" id="btn-addBoard">등록</button>
			            	</div>
			            </div>
			         	<div style="border-top: 1px solid #000; margin-top: 20px;">
				        	<form id="frm-addBoard" enctype="multipart/form-data">
				        		<input type="hidden" name="stat" id="board-stat">
					            <div class="mb-3 mt-3">
					            	<label for="brd-select" class="form-label fw-bold">게시판</label>
					              	<select class="form-select" name="bbsSeq" id="brd-select">
					              		<option value="">게시판을 선택해 주세요.</option>
										<c:forEach var="list" items="${getBbsList }">
											<c:choose>
												<c:when test="${sessionScope.USERSTAT eq 2 || sessionScope.USERSTAT eq 4 || sessionScope.USERSTAT eq 8}">
													<c:if test="${list.bbsSeq eq 26 }">
														<option value="${list.bbsSeq }" selected="selected">${list.nm }</option>
													</c:if>
												</c:when>
												<c:otherwise>
													<c:if test="${list.bbsSeq ne 1 }">
														<option value="${list.bbsSeq }">${list.nm }</option>
													</c:if>
												</c:otherwise>
											</c:choose>
										</c:forEach>
					              	</select>
					            </div>
					            <div class="mb-3">
					            	<label for="brd-title" class="form-label fw-bold">제목</label>
					              	<input type="text" class="form-control my-input" name="title" id="brd-title">
					            </div>
					            <div class="mb-3" id="div-add-secrt">
					            	<label for="brd-pwdYn" class="form-label fw-bold">비밀 글</label>
					              	<input type="checkbox" class="form-check-input cursor-pointer ms-1" name="pwdYn" id="brd-pwdYn" value="Y">
					              	<input type="password" class="form-control my-input" name="pwd" id="brd-pwd" disabled>
					            </div>
					            <div class="mb-3">
					            	<label for="brd-cont" class="form-label fw-bold">내용</label>
					              	<textarea class="form-control my-input" name="cont" id="brd-cont" rows="20"></textarea>
					            </div>
					            <div class="mb-4">
									<label for="brd-add-file" class="form-label fw-bold">썸네일</label>
					              	<input type="file" class="form-control my-input mb-2" id="add-file-thumb" onchange="thumbChk(this, event, 'add');">
					              	<input type="hidden" class="form-control my-input mb-2" name="thumbYn" id="add-file-thumbYn" value="D" readonly="readonly">
					              	<div id="add-thumb-view"></div>
					              	<div id="add-thumb-data"></div>
					            </div>
					            <div class="mb-4" id="div-add-atchYn">
									<label for="brd-add-file" class="form-label fw-bold">첨부파일</label>
					              	<input type="file" class="form-control my-input" name="uploadFile" id="brd-add-file" multiple="multiple">
					            </div>
					            <div id="add-file-data"></div>
					            <div class="text-end mb-4" id="add-file-area">
									<div id="add-added-file"></div>
					            </div>
				        	</form>
			          	</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- updateBoard Modal -->
	<div class="portfolio-modal modal fade" id="updateBoardModal" tabindex="-1" role="dialog" aria-hidden="true">
  		<div class="modal-dialog modal-half-right modal-lg">
    		<div class="modal-content modal-content-scrollable" id="modal-updateBoard">
<!-- 				<div class="close-modal" data-bs-dismiss="modal" id="btn-updateBoard-close"> -->
				<div class="close-modal" id="btn-updateBoard-close">
					<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
				</div>
				<div class="modal-header border-0 pb-0 mt-4">
					<div class="w-100 mt-2 text-start">
			            <div class="d-flex justify-content-between mt-5">
				        	<h1>수정</h1>
				        	<div>
					            <button type="button" class="naver-button-temp" id="btn-updateBoard-temp">임시저장</button>
					            <button type="button" class="naver-button" id="btn-updateBoard">수정</button>
				        	</div>
			            </div>
			         	<div style="border-top: 1px solid #000; margin-top: 20px;">
				        	<form id="frm-updateBoard" enctype="multipart/form-data">
				        		<input type="hidden" name="stat" id="brd-upd-stat">
				        		<input type="hidden" name="boardSeq" id="brd-upd-boardSeq">
					            <div class="mb-3 mt-3">
					            	<label for="brd-upd-select" class="form-label fw-bold">게시판</label>
					              	<input type="text" class="form-control my-input" id="upd-bbs" disabled>
					            </div>
					            <div class="mb-3">
					            	<label for="brd-upd-title" class="form-label fw-bold">제목</label>
					              	<input type="text" class="form-control my-input" name="title" id="brd-upd-title"  spellcheck="false" >
					            </div>
					            <div class="mb-3" id="div-upd-secrt">
					            	<label for="brd-upd-pwdYn" class="form-label fw-bold">비밀 글</label>
					              	<input type="checkbox" class="form-check-input cursor-pointer ms-1" name="pwdYn" id="brd-upd-pwdYn" value="Y">
					              	<span class="ms-2" id="brd-pwd-cancel">
						            	<label for="brd-upd-pwdYnCancel" class="form-label fw-bold">비밀 글 해제</label>
						              	<input type="checkbox" class="form-check-input cursor-pointer ms-1" name="pwdYn" id="brd-upd-pwdYnCancel" value="N">
					              	</span>
					              	<input type="password" class="form-control my-input" name="pwd" id="brd-upd-pwd" disabled>
					            </div>
					            <div class="mb-3">
					            	<label for="brd-upd-cont" class="form-label fw-bold">내용</label>
					              	<textarea class="form-control my-input" name="cont" id="brd-upd-cont" rows="20"></textarea>
					            </div>
					            <div class="mb-4">
									<label for="upd-file-thumb" class="form-label fw-bold">썸네일</label>
					              	<input type="file" class="form-control my-input mb-2" id="upd-file-thumb" onchange="thumbChk(this, event, 'upd');">
					              	<input type="hidden" class="form-control my-input mb-2" name="thumbYn" id="upd-file-thumbYn" value="D" readonly="readonly">
					              	<div id="upd-thumb-view"></div>
					              	<div id="upd-thumb-data"></div>
					            </div>
					            <div class="mb-4" id="div-upd-atchYn">
									<label for="brd-upd-file" class="form-label fw-bold">첨부파일</label>
					              	<input type="file" class="form-control my-input" name="file" id="brd-upd-file" multiple="multiple">
					            </div>
					            <div id="upd-file-data"></div>
					            <div class="text-end mb-4" id="upd-file-area">
									<div id="upd-added-file"></div>
									<div id="upd-removed-file"></div>
					            </div>
				        	</form>
			          	</div>
					</div>
				</div>
			</div>
		</div>
	</div>
        
        
        <!-- Modal Sample -->
        <%-- <div class="portfolio-modal modal fade" id="getBoardModal" tabindex="-1" role="dialog" aria-hidden="true">
<!--             <div class="modal-dialog modal-dialog-centered mx-auto" style="max-width: 50%;"> -->
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content" id="modal-board">
                    <div class="close-modal" data-bs-dismiss="modal">
                    	<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" />
                    </div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <h2 class="text-uppercase">Board</h2>
                                    <p class="item-intro text-muted">Lorem ipsum dolor sit amet consectetur.</p>
                                    <img class="img-fluid d-block mx-auto" src="${pageContext.request.contextPath}/resources/front/main/assets/img/portfolio/1-board-img.jpg" alt="..." />
                                    <p class="fs-5">사용자가 원하는 게시판에 글을 쓰고, 수정할 수 있으며 댓글, 비밀 글 등의 옵션이 있는 게시판입니다.</p>
                                    <ul class="list-inline">
                                        <li>
                                            <strong>Client:</strong>
                                            Threads(Name)
                                        </li>
                                        <li>
                                            <strong>Category:</strong>
                                            Illustration
                                        </li>
                                    </ul>
<!--                                     <button class="btn btn-danger btn-xl text-uppercase btn-opt" data-bs-dismiss="modal" type="button" value="1"> -->
                                    <button type="button" class="btn btn-danger btn-xl text-uppercase btn-opt" value="1">
                                        GO
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> --%>
        


	 <!-- Masthead-->
        <header class="masthead mb-4">
            <div class="container">
<!--                 <div class="masthead-subheading">Welcome To Our Studio!</div> -->
                <div class="masthead-subheading">Welcome To Me Portfolio!</div>
<!--                 <div class="masthead-heading text-uppercase">It's Nice To Meet You</div> -->
                <div class="masthead-heading text-uppercase">Nice To Meet You</div>
<!--                 <a class="btn btn-primary btn-xl text-uppercase" href="#services">Tell Me More</a> -->
            </div>
        </header>
        
        
        <!-- Tech Stack -->
        <section class="page-section" id="techStack">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Tech Stack</h2>
                    <h3 class="section-subheading text-muted">Tools & Technologies</h3>
                </div>
                <div class="row text-center">
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/java.png" alt="javaLogo" />
                        </span>
<!--                         <h5 class="my-5"></h5> -->
                        <p class="text-muted my-5">Java</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/springframework.png" alt="springframeworkLogo" />
                        </span>
                        <p class="text-muted my-5">Spring Framework</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/html.png" alt="htmlLogo" />
                        </span>
                        <p class="text-muted my-5">HTML</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/javascript.png" alt="javascriptLogo" />
                        </span>
                        <p class="text-muted my-5">JavaScript</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/bootstrap.png" alt="bootstrapLogo" />
                        </span>
                        <p class="text-muted my-5">Bootstarp</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/jquery.png" alt="jqueryLogo" style="max-width: 135px;"/>
                        </span>
                        <p class="text-muted my-5">jQuery</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/mysql.png" alt="mysqlLogo" />
                        </span>
                        <p class="text-muted my-5">MySQL</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/git.png" alt="gitLogo" />
                        </span>
                        <p class="text-muted my-5">Git</p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Portfolio Grid-->
        <section class="page-section bg-light" id="portfolio">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Portfolio</h2>
                    <h3 class="section-subheading text-muted">Click on the portfolio you want.</h3>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-sm-6 mb-4">
                        <!-- Portfolio item 1-->
                        <div class="portfolio-item">
                            <a href="javascript:getBoardList(1, 'L', null, 'click');" class="portfolio-link">
                                <div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/portfolio/1-board-img.jpg" alt="..." />
                            </a>
                            <div class="portfolio-caption text-center my-round">
                                <div class="portfolio-caption-heading">Board</div>
                                <div class="portfolio-caption-subheading text-muted">Basic</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- getUserInfoModal Modal -->
        <div class="portfolio-modal modal fade" id="getUserInfoModal" tabindex="-1" role="dialog" aria-hidden="true">
	  		<div class="modal-dialog modal-half-center modal-lg">
	    		<div class="modal-content modal-content-scrollable">
					<div class="close-modal" data-bs-dismiss="modal" id="btn-getUserInfoModal-close">
						<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
					</div>
					<div class="modal-header border-0 pb-0 mt-4">
						<div class="w-100 mt-2 text-start">
				            <div class="d-flex justify-content-between mt-5">
				            	<div>
						        	<h1>Information</h1>
				            	</div>
				            	<div class="d-flex gap-2">
				            		<small class="text-danger mt-2" id="uSttsMent">* 현재 탈퇴신청 상태입니다.<br>수정을 원하시면 탈퇴를 철회하세요.</small>
						            <button type="button" class="naver-button text-danger" id="btn-userDelete">탈퇴신청</button>
						            <button type="button" class="naver-button" id="btn-userRefresh" onclick="getUserInfo('${sessionScope.USERSEQ }', 'refresh');">
						            	<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/front-refresh.png" alt="profile img" />
						            </button>
						            <button type="button" class="naver-button" id="btn-userSave">저장</button>
				            	</div>
				            </div>

							<form id="frm-user" enctype="multipart/form-data">
								<div class="row" style="border-top: 1px solid #000; margin-top: 20px;">
								   	<input type="hidden" name="userSeq" id="uNo" value="">
									<div class="col-md-8 mt-1">
								    	<div class="mb-3">
								      		<label for="uId" class="form-label fw-bold">ID</label>
								      		<input type="text" class="form-control my-input" id="uId" disabled>
								    	</div>
										<div class="mb-3" id="div-add-secrt">
									    	<label for="uPwd" class="form-label fw-bold">비밀번호</label>
									      	<small class="text-danger"> *변경을 원할시 입력</small>
									      	<input type="password" class="form-control my-input mb-1" id="uPwd" placeholder="비밀번호">
									      	<input type="password" class="form-control my-input" name="userPwd" id="uPwd-chk" placeholder="비밀번호 확인">
									    </div>
									</div>
								  	<div class="col-md-4 d-flex flex-column align-items-center mt-1">
								    	<label for="profileImg" class="form-label fw-bold">프로필 이미지</label>
								    	<div class="border rounded d-flex align-items-center justify-content-center mb-2" style="width: 150px; height: 150px; background-color:#f8f9fa;">
									      	<span class="text-muted" id="profile-view">
									      		<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/profile.png" alt="profile img" />
									      	</span>
								    	</div>
								    	<div class="d-flex">
								      		<button type="button" id="btn-addProfile" class="btn btn-success me-1">추가</button>
								      		<button type="button" id="btn-delProfile" class="btn btn-danger" onclick="removeProfile('add');" disabled>삭제</button>
								    	</div>
								    	<input type="file" class="d-none" name="thumb" id="profile-file" onchange="profileChk(this, event, 'add');">
								    	<input type="hidden" name="thumbYn" id="profile-thumbYn" value="D" readonly>
								    	<div id="profile-data"></div>
								  	</div>
								</div>
								<div class="row mt-3">
									<div class="col-12">
								    	<div class="mb-3">
								      		<label for="uNm" class="form-label fw-bold">사용자 이름(닉네임)</label>
								      		<input type="text" class="form-control my-input" name="userNm" id="uNm" spellcheck="false" autocomplete="off">
								    	</div>
									</div>
								</div>
						  	</form>
						  	
						</div>
					</div>
				</div>
			</div>
		</div>
        
        <!-- OG -->
        <!-- Portfolio item 1 modal popup-->
        <%-- <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <h2 class="text-uppercase">Project Name</h2>
                                    <p class="item-intro text-muted">Lorem ipsum dolor sit amet consectetur.</p>
                                    <img class="img-fluid d-block mx-auto" src="${pageContext.request.contextPath}/resources/front/main/assets/img/portfolio/1-board-img.jpg" alt="..." />
                                    <p>Use this area to describe your project. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est blanditiis dolorem culpa incidunt minus dignissimos deserunt repellat aperiam quasi sunt officia expedita beatae cupiditate, maiores repudiandae, nostrum, reiciendis facere nemo!</p>
                                    <ul class="list-inline">
                                        <li>
                                            <strong>Client:</strong>
                                            Threads
                                        </li>
                                        <li>
                                            <strong>Category:</strong>
                                            Illustration
                                        </li>
                                    </ul>
                                    <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button">
                                        <i class="fas fa-xmark me-1"></i>
                                        Close Project
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> --%>
        
        
        <!-- <section class="page-section" id="contact">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Contact Us</h2>
                    <h3 class="section-subheading text-muted">Lorem ipsum dolor sit amet consectetur.</h3>
                </div>
                * * * * * * * * * * * * * * *
                * * SB Forms Contact Form * *
                * * * * * * * * * * * * * * *
                This form is pre-integrated with SB Forms.
                To make this form functional, sign up at
                https://startbootstrap.com/solution/contact-forms
                to get an API token!
                <form id="contactForm" data-sb-form-api-token="API_TOKEN">
                    <div class="row align-items-stretch mb-5">
                        <div class="col-md-6">
                            <div class="form-group">
                                Name input
                                <input class="form-control" id="name" type="text" placeholder="Your Name *" data-sb-validations="required" data-sb-can-submit="no">
                                <div class="invalid-feedback" data-sb-feedback="name:required">A name is required.</div>
                            </div>
                            <div class="form-group">
                                Email address input
                                <input class="form-control" id="email" type="email" placeholder="Your Email *" data-sb-validations="required,email" data-sb-can-submit="no">
                                <div class="invalid-feedback" data-sb-feedback="email:required">An email is required.</div>
                                <div class="invalid-feedback" data-sb-feedback="email:email">Email is not valid.</div>
                            </div>
                            <div class="form-group mb-md-0">
                                Phone number input
                                <input class="form-control" id="phone" type="tel" placeholder="Your Phone *" data-sb-validations="required" data-sb-can-submit="no">
                                <div class="invalid-feedback" data-sb-feedback="phone:required">A phone number is required.</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group form-group-textarea mb-md-0">
                                Message input
                                <textarea class="form-control" id="message" placeholder="Your Message *" data-sb-validations="required" data-sb-can-submit="no"></textarea>
                                <div class="invalid-feedback" data-sb-feedback="message:required">A message is required.</div>
                            </div>
                        </div>
                    </div>
                    Submit success message
                   
                    This is what your users will see when the form
                    has successfully submitted
                    <div class="d-none" id="submitSuccessMessage">
                        <div class="text-center text-white mb-3">
                            <div class="fw-bolder">Form submission successful!</div>
                            To activate this form, sign up at
                            <br>
                            <a href="https://startbootstrap.com/solution/contact-forms">https://startbootstrap.com/solution/contact-forms</a>
                        </div>
                    </div>
                    Submit error message
                   
                    This is what your users will see when there is
                    an error submitting the form
                    <div class="d-none" id="submitErrorMessage"><div class="text-center text-danger mb-3">Error sending message!</div></div>
                    Submit Button
                    <div class="text-center"><button class="btn btn-primary btn-xl text-uppercase disabled" id="submitButton" type="submit">Send Message</button></div>
                </form>
            </div>
        </section> -->
        
        
</body>