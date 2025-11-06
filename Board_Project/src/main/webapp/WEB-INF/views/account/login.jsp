<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<body class="bg-gradient-primary">
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

	if(localStorage.getItem("loginChk") != null){
		$("#userId").val(localStorage.getItem("loginChk"));
		$("#loginChk").prop("checked", true);
	}else{
		$("#loginChk").prop("checked", false);
	}
});

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
                                        <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                                    </div>
                                    <form class="user" method="post">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" name="userId" id="userId" placeholder="ID" autocomplete="off">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" name="userPwd" id="userPwd" placeholder="Password">
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" name="loginChk" id="loginChk" value="Y">
                                                <label class="custom-control-label cursor-pointer" for="loginChk">Remember ID</label>
                                            </div>
                                        </div>
                                        <hr>
                                        <button type="submit" class="btn btn-primary btn-user btn-block">LOGIN</button>
                                        <button type="button" class="btn btn-danger btn-user btn-block" onclick="location.href='create.do'">Create Account</button>
                                        <button type="button" class="btn btn-secondary btn-user btn-block" onclick="location.href='/main.do'">Back</button>
                                    </form>
                                </div>
                            </div>
                            <div class="col-lg-6"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
