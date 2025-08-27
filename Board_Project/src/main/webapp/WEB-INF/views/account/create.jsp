<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<body class="bg-gradient-primary">

<script>

$(function(){
	
	var confirmNum = 0;
	
	$("input[name='userSe']").on('click', function(){
		
		
		// 인증완료
		if(confirmNum > 0){
			
			if($(this).val() == 'A'){
				$("#cmnChk").prop('checked', false);
				$("#aprvNum-tag").removeClass('d-none');
			}else{
				$("#adminChk").prop('checked', false);
				$("#aprvNum-tag").addClass('d-none');
				$(".init-setting").prop('disabled', false);
			}
		
		// 인증 미완료
		}else{
			
			if($(this).val() == 'A'){
				$("#cmnChk").prop('checked', false);
				$("#aprvNum-tag").removeClass('d-none');
				$("#aprvNum").val('');
				$("#aprvNum").focus();
				$(".init-setting").prop('disabled', true);
				$(".init-setting").val('');
			}else{
				$("#adminChk").prop('checked', false);
				$("#aprvNum-tag").addClass('d-none');
				$(".init-setting").prop('disabled', false);
				$(".init-setting").val('');
				$("#userId").focus();
			}
		}

		if($(this).val() == 'A'){
			$("#adminChk").prop('checked', true);
		}else{
			$("#cmnChk").prop('checked', true);
		}
		
	});
	
	$("#btn-save").on('click', function(){
		infoChk($("input[name='userSe']:checked").val());
	});
	
	$("#btn-confirm").on('click', function(){
		
		
		$.ajax({
			url      : contextPath+"aprvChk.do",
			method   : "GET",
			data     : {"aprvNum" : $("#aprvNum").val() },
			dataType : "json",
			success  : function(res){
				
				if(res.result > 0){
					Swal.fire({
						icon: "success",
						title: "승인완료"
					}).then(function(){
						$("#aprvNum").val('');
						$("#aprvNum").prop('placeholder', '승인완료');
						$("#aprvNum").prop('disabled', true);
						$("#btn-confirm").prop('disabled', true);
						$(".init-setting").prop('disabled', false);
						$("#userId").focus();
						
						confirmNum = 100;
						
					});
				}else{
					Swal.fire({
						icon: "error",
						title: "승인불가"
					}).then(function(){
						$("#aprvNum").val('');
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
		
	});
	
});

// 기본적인 info 체크
function infoChk(gubun){
	
	if($("#userId").val() == '' || $("#userId").val().trim() == ''){
		$("#userId").focus();
		$("#userId").val('');
		alert('아이디를 입력하세요.');
		return false;
	}
	
	if($("#userPwd").val() == '' || $("#userPwd").val().trim() == ''){
		$("#userPwd").focus();
		$("#userPwd").val('');
		alert('비밀번호를 입력하세요.');
		return false;
	}
	
	if($("#userPwdConfirm").val() == '' || $("#userPwdConfirm").val().trim() == ''){
		$("#userPwdConfirm").focus();
		$("#userPwdConfirm").val('');
		alert('비밀번호 확인을 입력하세요.');
		return false;
	}
	
	if($("#userNm").val() == '' || $("#userNm").val().trim() == ''){
		$("#userNm").focus();
		$("#userNm").val('');
		alert('이름을 입력하세요.');
		return false;
	}

	if($("#userPwd").val() !== $("#userPwdConfirm").val()){
		$("#userPwdConfirm").focus();
		$("#userPwdConfirm").val('');
		alert('비밀번호가 일치하지 않습니다.');
		return false;
	}
	
	Swal.fire({
		icon: "success",
		title: "생성완료"
	}).then(function(){
		$("#frm-user").submit();
	});
	
}

</script>

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9 mt-5">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0 fixed-size-box">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image">
                            	
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4 custom-text">Create Account!</h1>
                                    </div>
                                    <form class="user">
                                        <div class="form-group text-center d-flex justify-content-center gap-3 custom-text">
	                                        <div class="custom-control custom-checkbox small"></div>
	                                        <div class="custom-control custom-checkbox small"></div>
                                        </div>
                                        <div class="form-group d-none" id="aprvNum-tag">
                                        
                                            <input type="password" class="form-control form-control-user" name="aprvNum" id="aprvNum" placeholder="관리자 승인번호">
	                                        <button type="button" class="btn btn-danger btn-user btn-block mt-3" id="btn-confirm">Confirm</button>
                                        </div>
                                    </form>
                                </div>
                            
                            </div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Create Account!</h1>
                                    </div>
                                    <form class="user" id="frm-user" method="post">
                                        <div class="form-group text-center d-flex justify-content-center gap-3">
	                                        <div class="custom-control custom-checkbox small">
	                                            <input type="checkbox" class="custom-control-input" name="userSe" id="adminChk" value="A">
	                                            <label class="custom-control-label cursor-pointer" for="adminChk">관리자계정</label>
	                                        </div>
	                                        <div class="custom-control custom-checkbox small ml-3">
	                                            <input type="checkbox" class="custom-control-input" name="userSe" id="cmnChk" value="U" checked="checked">
	                                            <label class="custom-control-label cursor-pointer" for="cmnChk">일반계정</label>
	                                        </div>
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user init-setting" name="userId" id="userId" placeholder="ID" autocomplete="off">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user init-setting" name="userPwd" id="userPwd" placeholder="Password">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user init-setting" id="userPwdConfirm" placeholder="Confirm Password">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user init-setting" name="userNm" id="userNm" placeholder="Name" autocomplete="off">
                                        </div>
                                        <hr>
                                        <button type="button" class="btn btn-success btn-user btn-block init-setting" id="btn-save">JOIN</button>
                                        <button type="button" class="btn btn-secondary btn-user btn-block" onclick="history.back(-1);">Back</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
