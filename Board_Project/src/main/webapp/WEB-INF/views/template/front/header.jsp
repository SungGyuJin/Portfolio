<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<body>

<!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="#page-top">
<%--                 	<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/navbar-logo.svg" alt="..." /> --%>
                	Portfolio Collection
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars ms-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0 fw-bolder">
                        <li class="nav-item"><a class="nav-link" href="#techStack">Tech Stack</a></li>
                        <li class="nav-item"><a class="nav-link" href="#portfolio">Portfolio</a></li>
<!--                         <li class="nav-item"><a class="nav-link" href="#about">About</a></li> -->
<!--                         <li class="nav-item"><a class="nav-link" href="#team">Team</a></li> -->
<!-- 		                 <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li> -->

						<c:choose>
							<c:when test="${empty sessionScope.USERID }">
		                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/login.do">Login</a></li>
							</c:when>
							<c:otherwise>
		                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/logout.do">Logout</a></li>
							</c:otherwise>
						</c:choose>
                        
                        
                    </ul>
                </div>
            </div>
        </nav>
        
</body>
