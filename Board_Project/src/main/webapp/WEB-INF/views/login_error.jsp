<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


    <script src="${pageContext.request.contextPath}/resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/assets/css/sb-admin-2.min.css" rel="stylesheet">


</head>
<body>
<div class="container-fluid">
         <!-- 404 Error Text -->
         <div class="text-center">
             <div class="error mx-auto" data-text="Fail">Fail</div>
             <p class="lead text-gray-800 mt-1">${errorMsg }</p>
             <p class="text-gray-500">${errorMsgEng }</p>
             <a href="javascript:history.back(-1);">← Go Back</a>
         </div>
     </div>
</body>
</html>