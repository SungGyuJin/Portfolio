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