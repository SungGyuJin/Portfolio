<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" 		prefix="page" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title><decorator:title default="Portfolio" /></title>

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/admin/assets/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/admin/assets/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- sweetalert2 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/admin/assets/vendor/sweetalert2/sweetalert2.min.css"/>
<script src="${pageContext.request.contextPath}/resources/admin/assets/vendor/sweetalert2/sweetalert2.all.min.js"></script>

<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/front/main/assets/favicon.ico" />

<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />

<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/resources/front/main/css/styles.css" rel="stylesheet" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/front/main/js/scripts.js"></script>
<!-- <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script> -->

<script type="text/javascript">
var contextPath = '${pageContext.request.contextPath}';
</script>

<style>

.my-round{
  border-radius: .375rem !important;
}

.my-textarea:focus {
  outline: none;
  box-shadow: none;
  border-color: transparent;
}

.cursor-pointer {
	cursor: pointer;
}

.my-primary {
  color: #fff;
  background-color: #4e73df;
  border-color: #4e73df;
}

.my-primary:hover {
  color: #fff;
  background-color: #2e59d9;
  border-color: #2653d4;
}


.my-green {
  color: #fff;
  background-color: #03c75a;
  border-color: #03c75a;
}

.my-green:hover {
  color: #fff;
  background-color: #03c75a;
  border-color: #03c75a;
}


.my-success {
  color: #fff;
  background-color: #1cc88a;
  border-color: #1cc88a;
}

.my-success:hover {
  color: #fff;
  background-color: #17a673;
  border-color: #169b6b;
}

.my-danger {
  color: #fff;
  background-color: #e74a3b;
  border-color: #e74a3b;
}

.my-danger:hover {
  color: #fff;
  background-color: #e02d1b;
  border-color: #d52a1a;
}


</style>
        
        
</head>
<body id="page-top">
	<page:applyDecorator name="headerFront" />
		<decorator:body />
	<page:applyDecorator name="footerFront" />
</body>
</html>
