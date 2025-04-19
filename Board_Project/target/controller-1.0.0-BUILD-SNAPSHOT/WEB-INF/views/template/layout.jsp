<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" 		prefix="page" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><decorator:title default="Board_Project" /></title>

	<!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/sb-admin-2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/jquery-easing/jquery.easing.min.js"></script>
    
     <!-- Custom fonts for this template-->
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/assets/css/sb-admin-2.min.css" rel="stylesheet">
    
    
    
    
<style>
.toggle-wrapper {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  font-weight: normal;
  cursor: pointer;
  user-select: none;
}

.tiny-toggle {
  display: none;
}

.tiny-slider {
  position: relative;
  width: 36px;
  height: 18px;
  background-color: #ccc;
  border-radius: 999px;
  transition: background-color 0.3s;
}

.tiny-slider::before {
  content: "";
  position: absolute;
  width: 14px;
  height: 14px;
  top: 2px;
  left: 2px;
  background-color: white;
  border-radius: 50%;
  transition: transform 0.3s;
}

.tiny-toggle:checked + .tiny-slider {
  background-color: #0d6efd; /* 부트 파랑 */
}

.tiny-toggle:checked + .tiny-slider::before {
  transform: translateX(18px);
}
</style>
    
</head>

<body id="page-top">

    <div id="wrapper">
		<page:applyDecorator name="leftMenu" />
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <page:applyDecorator name="header" />
                <decorator:body />
            </div>
            <page:applyDecorator name="footer" /> 
        </div>
    </div>

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>
</body>



</html>