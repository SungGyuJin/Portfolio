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


function openModal(no){
	if(no == '139'){
		getBoardList('1', 'L', null, 'click', no);
	}else{
		var getFnceListModal = new bootstrap.Modal($('#getModalList-'+no)[0], {
			backdrop: 'static',
			keyboard: false,
			focus: false
		});

		getFnceListModal.show();
	}
}

</script>

	<jsp:include page="board.jsp" flush="false" />
	<jsp:include page="fnce.jsp" flush="false" />
        
	<!-- Masthead-->
 	<c:choose>
 		<c:when test="${not empty getBanner[0].filePath }">
			<header class="masthead mb-4" style="background-image: url('${pageContext.request.contextPath}${getBanner[0].filePath}/${getBanner[0].strgFileNm}');">
	            <div class="container">
	                <div class="masthead-subheading">${getBanner[0].topBnNm}</div>
	                <div class="masthead-heading text-uppercase">${getBanner[0].botmBnNm}</div>
	            </div>
	        </header>
 		</c:when>
 		<c:otherwise>
			<header class="masthead mb-4" style="background-image: url('${pageContext.request.contextPath}/resources/front/main/assets/img/header-bg.jpg');">
	            <div class="container">
	                <div class="masthead-subheading">${getBanner[0].topBnNm}</div>
	                <div class="masthead-heading text-uppercase">${getBanner[0].botmBnNm}</div>
	            </div>
	        </header>
 		</c:otherwise>
 	</c:choose>
        
     <!-- Tech Stack -->
     <section class="page-section" id="techStack">
         <div class="container">
             <div class="text-center">
                 <h2 class="section-heading text-uppercase">Tech Stack</h2>
                 <h3 class="section-subheading text-muted">Tools & Technologies</h3>
             </div>
             <div class="row text-center">
             	<c:forEach var="list" items="${getTechList }">
             		<c:if test="${list.stat eq 1 }">
                   <div class="col-md-3">
                       <span class="fa-stack fa-4x">
						<img class="img-fluid my-round" src="${pageContext.request.contextPath}${list.filePath}/${list.strgFileNm}" alt="${list.techNm }" onerror="this.src='${pageContext.request.contextPath }/resources/admin/assets/img/no-image.png'" />
                       </span>
                       <p class="text-muted my-5">${list.techNm }</p>
                   </div>
             		</c:if>
             	</c:forEach>
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
                <div class="row justify-content-center">
				<c:forEach var="list" items="${getPoList}">
					<c:if test="${list.stat ne 0 }">
	                    <div class="col-lg-4 col-sm-6 mb-4">
	                        <div class="portfolio-item">
<!-- 	                            <a href="javascript:getBoardList(1, 'L', null, 'click');" class="portfolio-link"> -->
	                            <a href="javascript:openModal('${list.mainSeq}');" class="portfolio-link">
	                                <div class="portfolio-hover">
	                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	                                </div>
	                                <img class="img-fluid my-round" src="${pageContext.request.contextPath}${list.filePath}/${list.strgFileNm}" alt="${list.techNm }" onerror="this.src='${pageContext.request.contextPath }/resources/admin/assets/img/no-image.png'" />
	                            </a>
	                            <div class="portfolio-caption text-center my-round">
	                                <div class="portfolio-caption-heading">${list.poforNm }</div>
	                            </div>
	                        </div>
	                    </div>
					</c:if>
				</c:forEach>
                </div>
            </div>
        </section>
        
        
</body>