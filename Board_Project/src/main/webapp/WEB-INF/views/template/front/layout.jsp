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
<title><decorator:title default="Portfolio Collection" /></title>

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/admin/assets/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/admin/assets/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- parsley -->
<script src="${pageContext.request.contextPath }/resources/admin/assets/vendor/parsley.js/parsley.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/admin/assets/vendor/parsley.js/i18n/ko.js"></script>

<!-- CKeditor -->
<script src="${pageContext.request.contextPath }/resources/lib/ckeditor/ckeditor.js"></script>

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

.custom-link {
  color: #afaeb4;
  text-decoration: none;
  transition: color 0.2s;
}

.custom-link:hover {
  color: #8b8992;
  text-decoration: underline;
}

.comments-section{
	margin: 0 1.5rem 1.5rem 1.5rem;
}

.my-modal-body {
  position: relative;
/*   flex: 1 1 auto; */
  padding: var(--bs-modal-padding);
  margin-bottom: 1rem;
}

.editor-preview {
  background-color: #ffffff;
  border-radius: 0.5rem;
  padding: 1rem;
  overflow: auto;
/*   min-height: 200px; */
/*   overflow: auto; */
/*   height: 200px; */

  font-family: Arial, sans-serif;
  line-height: 1.6;
  white-space: normal;
}

.editor-preview img {
  max-width: 100%;
  height: auto;
}

.cke_notification_warning {
    display: none !important;
}

.my-writer{
  display: inline-block;
  background-color: #e6f5ec;   /* 연한 민트/녹색 계열 */
  color: #00a862;              /* 글자색: 네이버 녹색 느낌 */
  font-size: 12px;             /* 작고 단정한 글자 */
  padding: 2px 8px;            /* 좌우 넉넉한 여백 */
  border-radius: 999px;        /* pill 형태: 최대치 둥글기 */
  font-weight: bold;       
}

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
/*   background-color: #1cc88a; */
  background-color: #03c75a;
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
  border-radius: 0.25rem;
  font-size: 12px;
}

.my-danger:hover {
  color: #fff;
  background-color: #e02d1b;
  border-color: #d52a1a;
}

.my-danger-reply {
  color: #fff;
  background-color: #e74a3b;
  border-color: #e74a3b;
  border-radius: 0.25rem;
  font-size: 20px;
}

.tr-hover:hover{
/*   --bs-table-accent-bg: var(--bs-table-hover-bg); */
  --bs-table-accent-bg: #f8f9fa;
  color: var(--bs-table-hover-color);
}

.register_box {
  text-align: right; /* 오른쪽 정렬 예시 */
  margin-top: 10px;
}

.btn_cancel {
  display: inline-block;
  padding: 6px 12px;   /* 살짝 작게 */
  font-size: 13px;     /* 기본보다 살짝 작음 */
  line-height: 1.4;
  color: #a0a0a0;
  background-color: #ffffff;
  border: none;
  border-radius: 4px;
  text-decoration: none;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn_cancel:hover {
/*   background-color: #a0a0a0; */
}
.btn_cancel:active {
  background-color: #d2d2d2;
}

.btn_register {
  display: inline-block;
  padding: 6px 12px;   /* 살짝 작게 */
  font-size: 13px;     /* 기본보다 살짝 작음 */
  line-height: 1.4;
  color: white;
  background-color: #03c75a;
  border: none;
  border-radius: 4px;
  text-decoration: none;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn_register:hover {
  background-color: #02b14d;
}

.btn_register:active {
  background-color: #029740;
}

.btn_register.is_active {
  opacity: 1;
}

.btn_register.disabled {
  pointer-events: none;   /* 클릭 안 되게 */
  background-color: #ccc; /* 회색 처리 */
  color: #999;
  cursor: not-allowed;
}

textarea:disabled {
  background-color: #FFFFFF !important;  /* 배경색 변경 */
/*   color: #555;                /* 글자색 변경 */ */
/*   border: 1px solid #ccc;     /* 테두리 색 변경 */ */
/*   cursor: not-allowed;        /* 마우스 커서 변경 */ */
}

.my-thead{
	background-color: #ffffff;
	border-top: 1px solid black;
/*     border-bottom: 1px solid black; /* 여기서 맨 위 선 굵게 */ */
}

.badge {
/*   display: inline-block; */
  background-color: #ffe3e4;
  color: #ff4e59;
  border: 1px solid #ffc6c9;
  padding: 2px 6px;
  font-size: 12px;
  font-weight: bold;
  border-radius: 4px;
  margin-right: 5px;
}

tr.notice td.title {
  color: #d30000;
/*   font-weight: bold; */
}

.my-notice{
	display: inline-block; 
  	background-color: #ffe3e4;
  	color: #ff4e59;
  	border: 1px solid #ffc6c9;
  	padding: 2px 6px;
 	font-size: 12px;
 	font-weight: bold;
 	border-radius: 4px;
  	margin-right: 5px;
  	width: 56px;
}

img.blocking-hover {
  pointer-events: none;
}

.my-a{
	text-decoration: none;
  	color: black; /* 글자색 검정 */
}
.my-a:hover .underline {
 	text-decoration: underline;
}

.my-a:hover .no-underline {
	text-decoration: none; /* 특정 부분만 밑줄 제거 */
}

.lock-icon {
  position: absolute;
  top: 10px;   /* 카드 위에서 10px 떨어짐 */
  left: 10px;  /* 카드 왼쪽에서 10px 떨어짐 */
  width: 18px; /* 필요시 크기 조절 */
}


.tr-notice{
	background-color: #f9f9f8;
}

.cmnt-cnt {
	color: #FF7A85;
}

.my-td{
/* 	font-size: 0.875rem; */
}

.board-img {
  width: 100%;         /* 부모 너비에 맞춤 */
/*   max-width: 200px;    /* 최대 너비 제한 */ */
  height: 150px;       /* 고정 높이 */
  object-fit: cover;   /* 비율 유지하며 꽉 채우기 */
  border-radius: 3%;
  margin-bottom: 0.325rem !important;
/*   position: fixed; */
	
}

.naver-button {
  display: inline-block;
  padding: 10px 20px;
  background-color: #e6f6ed; /* 연한 연두색 배경 */
  color: #03c75a; /* 네이버 초록색 */
  font-weight: 600;
  border-radius: 12px;
  text-decoration: none;
  font-size: 16px;
  text-align: center;
  border: none;
}
/* 마우스 호버시 조금 어둡게 */
.naver-button:hover {
  background-color: #d2f0e1;
}

/* 버튼 눌렀을 때 더 어둡게 */
.naver-button:active {
  background-color: #bfe7d3;
}

.parsley-errors-list{
	list-style: none;
	padding-left: 0;
	color:#f3616d;
	font-size: 14px;
}

.sticky-sidebar {
	position: sticky;
	top: 100px;
	z-index: 1;
}

.admin-page{
	color: #8bc34a !important;
/* 	color: #f4511e !important; */
}

.admin-page:hover{
	color: #ffc800 !important;
}

.fixed-image {
  width: 100%;
  height: 143px;
  border-radius: 0.5rem;
/*   object-fit: cover; */
}

#upd-thumb-view {
  position: relative;
  width: 100%;
  height: auto;
  overflow: hidden;
}

#upd-thumb-view img {
  display: block;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

#upd-thumb-view .thumb-close {
  position: absolute;
  top: 5px;
  right: 5px;
  color: white;
  background-color: rgba(0,0,0,0.5);
  border-radius: 50%;
  padding: 2px 7px;
  cursor: pointer;
  font-size: 23px;
  line-height: 1;
  z-index: 10;
}

#upd-thumb-view .thumb-close:hover {
  background-color: rgba(0,0,0,0.8);
}


</style>
        
        
</head>
<body id="page-top">
<input type="hidden" id="uno" value="${sessionScope.USERSEQ }"> 
<input type="hidden" id="unm" value="${sessionScope.USERNM }"> 

	<page:applyDecorator name="headerFront" />
		<decorator:body />
	<page:applyDecorator name="footerFront" />
</body>
</html>
