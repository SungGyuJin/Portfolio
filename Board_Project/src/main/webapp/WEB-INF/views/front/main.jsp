<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<body>
<script>


$(function(){
	
	$('#frm-board').on('submit', function(e) {
        e.preventDefault();  // 기본 submit 막음
    });
	
 	$('#frm-board').on('keydown', function(e) {
    	if(e.key === 'Enter') {
            e.preventDefault();
    		changeList();
        }
	});
	
	$('#portfolioModal1').modal({
	    backdrop: 'static',   // 바깥 클릭해도 안 꺼짐
	    keyboard: false       // ESC 눌러도 안 꺼짐
	});
	
});


/* ########## BOARD ########## */

function changeList(num){
	getBoardList(num);
}

// 게시물 목록
function getBoardList(num){
	
	$("#searchKeyword").val($("#js-searchKeyword").val());
	
	if($("#js-searchKeyword").val() != null){
		
		if($("#oldKeyword").val() == $("#js-searchKeyword").val() && num != null){
			$("#pageNum").val(num);
		}else{
			$("#pageNum").val('1');
		}
	}
	
	$.ajax({
		url      : "/main/getBoardList.do",
		method   : "get",
		data     : $("#frm-board").serialize(),
		dataType : "json",
		success  : function(res){
			
			let bbsList 		= res.getBbsList;
			let boardList 		= res.getBoardList;
			let boardListCnt 	= res.total;
			let page 			= res.pageMaker;
			let vo 				= res.boardVO;
			let html 			= '';

// 			console.log(boardList);

			html += 	'<div class="mb-3">';
			html += 		'<div class="d-flex justify-content-between">';
			html += 			'<div>';
			html += 				'<select class="form-select cursor-pointer" name="bbsSeq" onchange="changeList('+vo.pageNum+');" id="sel-bbs">';
			html += 					'<option value="0">전체</option>';
									for(let i=0; i < bbsList.length; i++){
			html += 					'<option value="'+bbsList[i].bbsSeq+'">'+bbsList[i].nm+'</option>';
									}
			html += 				'</select>';
			html += 			'</div>';
			html += 			'<div>';
			html += 				'<select class="form-select cursor-pointer" name="amount" onchange="changeList('+vo.pageNum+');" id="sel-amount">';
			html += 					'<option value="10">10개씩</option>';
			html += 					'<option value="20">20개씩</option>';
			html += 					'<option value="50">50개씩</option>';
			html += 					'<option value="100">100개씩</option>';
			html += 				'</select>';
			html += 			'</div>';
			html += 		'</div>';
			html += 	'</div>';
			html += 	'<div class="table-responsive mb-4" style="border-radius: 15px; overflow: hidden; border: 1px solid #ddd;">';
			html += 		'<table class="table table-bordered table-striped table-hover table-lg mb-0 cursor-pointer">';
			html += 			'<colgroup>';
			html += 				'<col width="40">';
			html += 				'<col width="130">';
			html += 				'<col width="40">';
			html += 				'<col width="40">';
			html += 				'<col width="40">';
			html += 			'</colgroup>';
			html += 			'<thead class="table-light">';
			html += 				'<tr>';
			html += 					'<th>No</th>';
			html += 					'<th>제목</th>';
			html += 					'<th>작성자</th>';
			html += 					'<th>작성일</th>';
			html += 					'<th>조회수</th>';
			html += 				'</tr>';
			html += 			'</thead>';
			html += 			'<tbody>';
			
								// 데이터 출력부분
								for(let i=0; i < boardList.length; i++){
			html +=					'<tr>';
										boardList[i].rowNum > 0 ? html += '<td>'+boardList[i].rowNum+'</td>' : html += '<td></td>';
			html +=						'<td class="text-start">';
			
										if(boardList[i].lvl > 0){
											for(let k=0; k < boardList[i].lvl; k++){
												html += "\u00a0";
											}
			html +=							'<img class="mb-1" src="'+contextPath +'/resources/admin/assets/img/arrow-return-right.svg" />\u00a0';
										}
			html +=						boardList[i].title+'</td>';
			
			html +=						'<td>'+boardList[i].userNm+'</td>';
			html +=						'<td>'+boardList[i].regDt.substring(0, 10)+'</td>';
			html +=						'<td>'+boardList[i].readCnt+'</td>';
			html +=					'</tr>';
								}
			
			html += 			'</tbody>';
			html += 		'</table>';
			html += 	'</div>';
			html += 	'<div class="d-flex justify-content-between">';
			
			html += 		'<nav aria-label="Page navigation">';
			html += 			'<ul class="pagination justify-content-center">';
								
							if(boardListCnt > 0){
								if(page.prev){
			html += 				'<li class="page-item"><a class="page-link" href="javascript:changeList('+(page.startPage -1)+');" tabindex="-1">이전</a></li>';
								}

								for(let num=page.startPage; num <= page.endPage; num++){
									if(vo.pageNum == num){
			html += 					'<li class="page-item active"><a class="page-link" href="javascript:void(0);">'+num+'</a></li>';
									}else{
			html += 					'<li class="page-item"><a class="page-link" href="javascript:changeList('+num+');">'+num+'</a></li>';
									}
								}

								if(page.next){
			html += 				'<li class="page-item"><a class="page-link" href="javascript:changeList('+(page.endPage +1)+');">다음</a></li>';
								}
							}else{
			html += 				'<li class="page-item active"><a class="page-link" href="javascript:void(0);">1</a></li>';
							}
			
			
			html += 			'</ul>';
			html += 		'</nav>';
			
			
			html += 		'<div class="row g-3 mb-4 d-flex justify-content-end">';
			html += 			'<div class="input-group">';
			html += 				'<div style="flex: 0 0 25%;">';
			html += 					'<select class="form-select me-1" name="gubun" id="sel-gubun">';
			html += 						'<option value="">전체</option>';
			html += 						'<option value="title">제목</option>';
			html += 						'<option value="cn">내용</option>';
			html += 						'<option value="writer">작성자</option>';
			html += 					'</select>';
			html += 				'</div>';
			
			
			html += 				'<input type="text" class="form-control ms-1 me-1" id="js-searchKeyword" placeholder="검색어 입력" value="'+vo.searchKeyword+'" autocomplete="off" style="flex: 0 0 58%;">';
			html += 				'<button type="button" class="btn btn-success my-primary" onclick="changeList();" style="flex: 0 0 15%;">검색</button>';
			html += 			'</div>';
			html += 		'</div>';
			html += 	'</div>';
			

			$("#append-board").html(html);
			$("#append-cnt").html(boardListCnt+' 개의 글');
			$("#sel-amount").val(vo.amount);
			$("#sel-bbs").val(vo.bbsSeq);
			$("#searchKeyword").val(vo.searchKeyword);
			$("#sel-gubun").val(vo.gubun);
			
			$("#oldKeyword").val(vo.searchKeyword);
			
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

</script>

	<div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered mx-auto" style="max-width: 50%;">
<!--     <div class="modal-dialog modal-dialog-centered modal-lg"> -->
        <div class="modal-content">
            <div class="close-modal" data-bs-dismiss="modal">
                <img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" style="width: 50px; height: 50px; object-fit: cover; border-radius: 50%;" />
            </div>
<!--             <div class="container py-5"> -->
            <div class="container">
            	<img class="img-fluid" src="${pageContext.request.contextPath}/resources/front/main/assets/img/portfolio/1-board-img.jpg" alt="Board Image" style="width: 100px; height: 100px; object-fit: cover; border-radius: 50%;" />
                <div class="row justify-content-center">
                    <div class="col-lg-12">
                        <h2 class="text-uppercase mb-4">Board</h2>
                        <p class="item-intro text-muted mb-4 fs-4">사용자가 원하는 게시판에 글을 쓰고, 수정할 수 있으며 댓글, 비밀 글 등의 옵션이 있는 게시판입니다.</p>

                        <div class="modal-body" id="modal-board">
                            <div class="d-flex justify-content-between">
                            	<span class="mt-2" id="append-cnt"></span>
                            	<div>
		                            <button type="button" class="btn my-danger">내가 쓴 글</button>
		                            <button type="button" class="btn my-success">글쓰기</button>
                            	</div>
                            </div>
							<input type="hidden" id="oldKeyword" value="">
                        	<hr>
                        	<form id="frm-board">
                        		<input type="hidden" name="pageNum" id="pageNum" value="1">
                        		<input type="hidden" name="searchKeyword" id="searchKeyword" autocomplete="off">
                        		<div id="append-board"></div>
                        	</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


		

		


        <!-- Portfolio item 1 modal popup-->
        <%-- <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
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
        <header class="masthead">
            <div class="container">
<!--                 <div class="masthead-subheading">Welcome To Our Studio!</div> -->
                <div class="masthead-subheading">Welcome To Me Portfolio!</div>
<!--                 <div class="masthead-heading text-uppercase">It's Nice To Meet You</div> -->
                <div class="masthead-heading text-uppercase">Nice To Meet You</div>
<!--                 <a class="btn btn-primary btn-xl text-uppercase" href="#services">Tell Me More</a> -->
            </div>
        </header>
        
        
        <!-- Services-->
        <section class="page-section" id="services">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Services</h2>
                    <h3 class="section-subheading text-muted">Lorem ipsum dolor sit amet consectetur.</h3>
                </div>
                <div class="row text-center">
                    <div class="col-md-4">
                        <span class="fa-stack fa-4x">
                            <i class="fas fa-circle fa-stack-2x text-primary"></i>
                            <i class="fas fa-shopping-cart fa-stack-1x fa-inverse"></i>
                        </span>
                        <h4 class="my-3">E-Commerce</h4>
                        <p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.</p>
                    </div>
                    <div class="col-md-4">
                        <span class="fa-stack fa-4x">
                            <i class="fas fa-circle fa-stack-2x text-primary"></i>
                            <i class="fas fa-laptop fa-stack-1x fa-inverse"></i>
                        </span>
                        <h4 class="my-3">Responsive Design</h4>
                        <p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.</p>
                    </div>
                    <div class="col-md-4">
                        <span class="fa-stack fa-4x">
                            <i class="fas fa-circle fa-stack-2x text-primary"></i>
                            <i class="fas fa-lock fa-stack-1x fa-inverse"></i>
                        </span>
                        <h4 class="my-3">Web Security</h4>
                        <p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.</p>
                    </div>
                </div>
            </div>
        </section>
        
        
        <!-- Portfolio Grid-->
        <section class="page-section bg-light" id="portfolio">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Portfolio</h2>
                    <h3 class="section-subheading text-muted">Lorem ipsum dolor sit amet consectetur.</h3>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-sm-6 mb-4">
                        <!-- Portfolio item 1-->
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-bs-toggle="modal" href="#portfolioModal1">
<!--                             <a class="portfolio-link" href="/main.do/1"> -->
                                <div class="portfolio-hover" id="" onclick="getBoardList();">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="${pageContext.request.contextPath}/resources/front/main/assets/img/portfolio/1-board-img.jpg" alt="..." />
                            </a>
                            <div class="portfolio-caption text-center">
                                <div class="portfolio-caption-heading">Board</div>
                                <div class="portfolio-caption-subheading text-muted">Basic</div>
                            </div>
                        </div>
                    </div>
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
        
        
</body>