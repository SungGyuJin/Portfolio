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
	
	$('#getBoardListModal').modal({
	    backdrop: 'static',   // 바깥 클릭해도 안 꺼짐
	    keyboard: false       // ESC 눌러도 안 꺼짐
	});

	$('#getBoardModal').modal({
	    backdrop: 'static',   // 바깥 클릭해도 안 꺼짐
	    keyboard: false       // ESC 눌러도 안 꺼짐
	});

	$('#getBoardPostModal').modal({
	    backdrop: 'static',   // 바깥 클릭해도 안 꺼짐
	    keyboard: false       // ESC 눌러도 안 꺼짐
	});
	
	$(document).on('input', '.autosize-textarea', function () {
		$(this).css('height', 'auto');
		$(this).css('height', this.scrollHeight + 'px');
	});
	
});


/* ########## BOARD ########## */

function getBoardPost(){
	  // Bootstrap 모달 인스턴스 생성 및 표시
	  var getBoardPostModal = new bootstrap.Modal($('#getBoardPostModal')[0], {
	    backdrop: true,
	    keyboard: false
	  });
	  getBoardPostModal.show();

	  // z-index 조정 (중첩 모달 문제 방지)
	  $('#getBoardPostModal').css('z-index', '1060');
	  $('.modal-backdrop').last().css('z-index', '1055');
}

function getBoard(no){
	
	// Bootstrap 모달 인스턴스 생성 및 표시
	var getBoardModal = new bootstrap.Modal($('#getBoardModal')[0], {
		backdrop: true,
		keyboard: false
	});
	getBoardModal.show();

	// z-index 조정 (중첩 모달 문제 방지)
	$('#getBoardModal').css('z-index', '1060');
	$('.modal-backdrop').last().css('z-index', '1055');
	  
	$.ajax({
		url      : "/main/getBoard.do",
		method   : "GET",
		data     : {"no" : no},
		dataType : "json",
		success  : function(res){
			
			var data = res.getBoard;
			
			console.log(data)

			$("#brd-bbsNm").html(data.bbsNm);
			$("#brd-ttl").html(data.title);
			$("#brd-userNm").html(data.userNm);
			$("#brd-regDt").html(data.regDt);
			$("#brd-readCnt").html(data.readCnt);

			$("#brd-cn").html(data.cont);
			
			$("#brdReadCnt-"+data.boardSeq).html(data.readCnt);	
			
		},
		error : function(request, status, error){
			Swal.fire({
				icon: "error",
				title: "통신불가"
			})
		}
	});
}

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

			console.log(boardList);

			html += 	'<div class="mb-3">';
			html += 		'<div class="d-flex justify-content-between">';
			html += 			'<div>';
			html += 				'<select class="form-select cursor-pointer" name="bbsSeq" onchange="changeList('+vo.pageNum+');" id="sel-bbs">';
			html += 					'<option value="0">전체</option>';
									for(let i=0; i < bbsList.length; i++){
										if(bbsList[i].bbsSeq != 1){
			html += 						'<option value="'+bbsList[i].bbsSeq+'">'+bbsList[i].nm+'</option>';
										}
									}
			html += 				'</select>';
			html += 			'</div>';
			html += 			'<div>';
			html += 				'<select class="form-select cursor-pointer" name="amount" onchange="changeList('+vo.pageNum+');" id="sel-amount">';
			html += 					'<option value="10">10개씩</option>';
			html += 					'<option value="20">20개씩</option>';
			html += 					'<option value="30">30개씩</option>';
			html += 					'<option value="40">40개씩</option>';
			html += 					'<option value="50">50개씩</option>';
			html += 				'</select>';
			html += 			'</div>';
			html += 		'</div>';
			html += 	'</div>';
			html += 	'<div class="table-responsive mb-4" style="border-radius: 15px; overflow: hidden; border: 1px solid #ddd;">';
// 			html += 		'<table class="table table-bordered table-striped table-hover table-lg mb-0 cursor-pointer">';
			html += 		'<table class="table table-hover mb-0 cursor-pointer">';
// 			html += 		'<table class="table">';
			html += 			'<colgroup>';
			html += 				'<col width="40">';
			html += 				'<col width="130">';
			html += 				'<col width="40">';
			html += 				'<col width="40">';
			html += 				'<col width="40">';
			html += 			'</colgroup>';
// 			html += 			'<thead class="" style="background-color: #f8f9fa;">';
			html += 			'<thead class="table-light">';
			html += 				'<tr>';
			html += 					'<th colspan="2">제목</th>';
			html += 					'<th>작성자</th>';
			html += 					'<th>작성일</th>';
			html += 					'<th>조회수</th>';
			html += 				'</tr>';
			html += 			'</thead>';
			html += 			'<tbody>';
			
								// 데이터 출력부분
								for(let i=0; i < boardList.length; i++){
									
									if(boardList[i].bbsSeq == 1){
// 			html +=						'<tr class="bg-primary" onclick="getBoard();">';
			html +=						'<tr class="" onclick="getBoard('+boardList[i].boardSeq+');">';
			html +=							'<td class="text-danger fw-bolder">공지</td>';
			html +=							'<td class="text-start text-danger fw-bolder"><img class="mb-1" src="'+contextPath +'/resources/front/main/assets/img/spk.png" style="max-width: 20px;"/>\u00a0\u00a0';
									}else{
			html +=						'<tr onclick="getBoard('+boardList[i].boardSeq+');">';
										boardList[i].rowNum > 0 ? html += '<td class="text-secondary"><small>'+boardList[i].rowNum+'</small></td>' : html += '<td></td>';
			html +=							'<td class="text-start">';
										if(boardList[i].lvl > 0){
											for(let k=0; k < boardList[i].lvl; k++){
												html += "\u00a0";
											}
			html +=							'<img class="mb-1" src="'+contextPath +'/resources/admin/assets/img/arrow-return-right.svg" />\u00a0';
										}
									}

			html +=								'<small>'+boardList[i].title+'</small></td>';
			
			html +=						'<td class="text-secondary"><small>'+boardList[i].userNm+'</small></td>';
			html +=						'<td class="text-secondary"><small>'+boardList[i].regDt+'</small></td>';
			html +=						'<td class="text-secondary"><small id="brdReadCnt-'+boardList[i].boardSeq+'">'+boardList[i].readCnt+'</small></td>';
			html +=					'</tr>';
								}
			
			html += 			'</tbody>';
			html += 		'</table>';
			html += 	'</div>';
			
// 			html += 	'<div class="d-flex justify-content-between">';
			html += 	'<div class="">';
			
			html += 		'<nav aria-label="Page navigation">';
			html += 			'<ul class="pagination justify-content-center mb-4">';
								
							if(boardListCnt > 0){
								if(page.prev){
			html += 				'<li class="page-item"><a class="page-link" href="javascript:changeList('+(page.startPage -1)+');" tabindex="-1">＜</a></li>';
								}

								for(let num=page.startPage; num <= page.endPage; num++){
									if(vo.pageNum == num){
			html += 					'<li class="page-item active"><a class="page-link" href="javascript:void(0);">'+num+'</a></li>';
									}else{
			html += 					'<li class="page-item"><a class="page-link" href="javascript:changeList('+num+');">'+num+'</a></li>';
									}
								}

								if(page.next){
			html += 				'<li class="page-item"><a class="page-link" href="javascript:changeList('+(page.endPage +1)+');">＞</a></li>';
								}
							}else{
			html += 				'<li class="page-item active"><a class="page-link" href="javascript:void(0);">1</a></li>';
							}
			
			
			html += 			'</ul>';
			html += 		'</nav>';
			

			html += 		'<div class="row g-3 mb-4 d-flex justify-content-end">';
			html += 			'<div class="input-group justify-content-center">';
			html += 				'<div class="me-1" style="width: 15%;">';
			html += 					'<select class="form-select me-1 my-round" name="gubun" id="sel-gubun">';
			html += 						'<option value="">제목 + 내용</option>';
			html += 						'<option value="cn">내용</option>';
			html += 						'<option value="writer">작성자</option>';
			html += 						'<option value="cmnt">댓글내용</option>';
			html += 					'</select>';
			html += 				'</div>';
			
			
			html += 				'<input type="text" class="form-control me-1 my-round" id="js-searchKeyword" placeholder="검색어 입력" value="'+vo.searchKeyword+'" autocomplete="off" style="flex: 0 0 30%;">';
// 			html += 				'<button type="button" class="btn btn-success my-primary my-round" onclick="changeList();" style="flex: 0 0 15%;"></button>';
			html += 				'<button type="button" class="btn my-green my-round" onclick="changeList();"><i class="fas fa-search fa-lg"></i></button>';
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

	<!-- getBoardList Modal -->
	<div class="portfolio-modal modal fade" id="getBoardListModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered mx-auto" style="max-width: 100%;">
<!--         <div class="modal-dialog modal-dialog-centered mx-auto" style="max-width: 50%;"> -->
<!--     <div class="modal-dialog modal-dialog-centered"> -->
        <div class="modal-content m-3">
            <div class="close-modal" data-bs-dismiss="modal">
                <img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" style="width: 50px; height: 50px; object-fit: cover; border-radius: 50%;" />
            </div>
<!--             <div class="container py-5"> -->
            <div class="container">
            	<img class="img-fluid" src="${pageContext.request.contextPath}/resources/front/main/assets/img/portfolio/1-board-img.jpg" alt="Board Image" style="width: 100px; height: 100px; object-fit: cover; border-radius: 50%;" />
                <div class="row justify-content-center">
                    <div class="col-lg-12">
<!--                         <h2 class="text-uppercase mb-4">Board</h2> -->
<!--                         <p class="item-intro text-muted mb-4 fs-4">사용자가 원하는 게시판에 글을 쓰고, 수정할 수 있으며 댓글, 비밀 글 등의 옵션이 있는 게시판입니다.</p> -->

                        <div class="modal-body" id="modal-board">
                            <div class="d-flex justify-content-between">
                            	<span class="mt-2" id="append-cnt"></span>
                            	<div>
		                            <button type="button" class="btn my-danger">내가 쓴 글</button>
		                            <button type="button" class="btn my-success" onclick="getBoardPost();">글쓰기</button>
                            	</div>
                            </div>
							<input type="hidden" id="oldKeyword" value="">
                        	<hr>
                        	<form id="frm-board">
                        		<input type="hidden" name="pageNum" id="pageNum" value="1">
                        		<input type="hidden" name="searchKeyword" id="searchKeyword" autocomplete="off">
                        		<div id="append-board">
                        		
                        		
                        		</div>
                        	</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


		

		

        <!-- getBoard Modal -->
        <div class="portfolio-modal modal fade" id="getBoardModal" tabindex="-1" role="dialog" aria-hidden="true">
<!--             <div class="modal-dialog modal-dialog-centered mx-auto" style="max-width: 50%;"> -->
<!--             <div class="modal-dialog modal-dialog-centered"> -->
            <div class="modal-dialog modal-half-right modal-lg">
  <div class="modal-content" id="modal-board">
            <div class="close-modal" data-bs-dismiss="modal">
            	<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
            </div>
    <!-- 상단 툴바 -->
    <div class="modal-header border-0 pb-0 mt-4">
      <div class="w-100 d-flex justify-content-between align-items-start mt-2 text-start">
        <div>
          <small class="text-success fw-bold ms-1"><span id="brd-bbsNm"></span>&gt;</small>
          <h4 class="fw-bold mt-1" id="brd-ttl">매트 교체 완료</h4>
          
          <div class="d-flex align-items-center mt-2 mb-4">
  			<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/profile.png" class="me-2" alt="프로필 이미지" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
            
            <div>
            <span class="me-2 fw-bolder" id="brd-userNm">작성자</span><br>
<!--             <span class="badge bg-secondary me-2">올림피아</span> -->
            <span class="text-muted small"><span id="brd-regDt">2025.05.09. 19:25</span>&nbsp;&nbsp;조회 <span id="brd-readCnt">366</span></span>
            </div>
          </div>
          
          
          
        </div>
      </div>
<hr>
    </div>


    <!-- 본문 -->
    <div class="modal-body text-start">
    	<pre  id="brd-cn"></pre>
    </div>

    <!-- <div class="modal-footer border-0 d-flex justify-content-between align-items-center">
      <div>
        <button class="btn btn-sm btn-outline-danger"><i class="bi bi-heart"></i> 좋아요</button>
        <span class="ms-2">댓글 12</span>
      </div>
      <div>
        <button class="btn btn-sm btn-light">공유</button>
        <button class="btn btn-sm btn-light">신고</button>
      </div>
    </div> -->
    
     <!-- 댓글 -->
    <div class="comments-section m-3 text-start">
  <h6 class="fw-bold mb-3">댓글 <span class="text-danger">12</span></h6>
  
  <ul class="list-unstyled mt-4">
  
    <li class="mb-3 border-bottom pb-2 d-flex align-items-start">
  <img src="${pageContext.request.contextPath}/resources/front/main/assets/img/profile.png" alt="프로필 이미지" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
  <div class="ms-2 flex-grow-1">
    <div class="mb-1">
    	<span class="fw-bold">박아무개</span>
    	<small class="text-muted ms-2">2025.05.09. 19:43</small>
    	<small class="text-muted ms-2 cursor-pointer">답글쓰기</small>
    </div>
    <div class="text-body">매트 교체하시면서 운동 다 하셨겠네요 ㅎㅎ<br>축하드립니다!</div>
  </div>
</li>


    <li class="mb-3 border-bottom pb-2 d-flex align-items-start">
  <img src="${pageContext.request.contextPath}/resources/front/main/assets/img/profile.png" alt="프로필 이미지" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
  <div class="ms-2 flex-grow-1">
      <div class="mb-1">
    	<span class="fw-bold">하하하</span>
       <small class="text-muted ms-2">2025.05.09. 20:09</small>
    	<small class="text-muted ms-2 cursor-pointer">답글쓰기</small>
       </div>
      <div class="text-body">매트 크기 단차 없나요? 매트 공유 좀 해주세요</div>
  </div>
</li>


    <li class="mb-3 border-bottom pb-2 d-flex align-items-start">
  <img src="${pageContext.request.contextPath}/resources/front/main/assets/img/profile.png" alt="프로필 이미지" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
  <div class="ms-2 flex-grow-1">
	      <div class="mb-1"> 
    		<span class="fw-bold">닉네임</span>
	      <span class="badge bg-success">작성자</span>
	       <small class="text-muted ms-2">2025.05.09. 21:09</small>
    	<small class="text-muted ms-2 cursor-pointer">답글쓰기</small>
	      
	    </div>
      <div class="text-body">기존에는 5t 고무매트를 사용했는데요.<br>
        고무별로 땡위치에는 눌림이 생기긴 합니다.<br>
        지금은 eva 고강도매트(18t)로 밀바닥에 깔고...</div>
  </div>
</li>

<!-- 댓글 없을때 -->
    <li class="mb-3 border-bottom pb-2 d-flex align-items-start">
  <div class="flex-grow-1 mb-2">
      <div class="text-body text-center m-3">등록된 댓글이 없습니다. 댓글을 작성해주세요.</div>
  </div>
</li>
    

    
    
  </ul>
  
  
<div class="comment-box border rounded p-3 position-relative text-start mb-3" style="min-height: 100px;">
  <div class="fw-bold mb-1">호돈신</div>
  <textarea class="form-control border-0 p-0 my-textarea autosize-textarea" placeholder="댓글을 남겨보세요" rows="2" style="resize: none;"></textarea>

  <!-- 아이콘 btn -->
  <!-- <div class="mt-2">
    <button class="btn btn-light btn-sm"><i class="bi bi-camera"></i></button>
    <button class="btn btn-light btn-sm"><i class="bi bi-emoji-smile"></i></button>
  </div> -->

  <button class="btn text-muted position-absolute" style="bottom: 10px; right: 10px;">등록</button>
</div>
</div>


    
  </div>
</div>

        </div>
        
        <!-- getBoardPost Modal -->
        <div class="portfolio-modal modal fade" id="getBoardPostModal" tabindex="-1" role="dialog" aria-hidden="true">
<!--             <div class="modal-dialog modal-dialog-centered mx-auto" style="max-width: 50%;"> -->
<!--             <div class="modal-dialog modal-dialog-centered"> -->
            <div class="modal-dialog modal-half-left">
                <div class="modal-content" id="modal-board">
                    <div class="close-modal" data-bs-dismiss="modal">
                    	<img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" />
                    </div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <h2 class="text-uppercase">왼쪽</h2>
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
        </div>
        
        
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
        <header class="masthead">
            <div class="container">
<!--                 <div class="masthead-subheading">Welcome To Our Studio!</div> -->
                <div class="masthead-subheading">Welcome To Me Portfolio!</div>
<!--                 <div class="masthead-heading text-uppercase">It's Nice To Meet You</div> -->
                <div class="masthead-heading text-uppercase">Nice To Meet You</div>
<!--                 <a class="btn btn-primary btn-xl text-uppercase" href="#services">Tell Me More</a> -->
            </div>
        </header>
        
        
        <!-- Tech Stack -->
        <section class="page-section" id="techStack">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Tech Stack</h2>
                    <h3 class="section-subheading text-muted">Tools & Technologies</h3>
                </div>
                <div class="row text-center">
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/java.png" alt="javaLogo" />
                        </span>
<!--                         <h5 class="my-5"></h5> -->
                        <p class="text-muted my-5">Java</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/springframework.png" alt="springframeworkLogo" />
                        </span>
                        <p class="text-muted my-5">Spring Framework</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/html.png" alt="htmlLogo" />
                        </span>
                        <p class="text-muted my-5">HTML</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/javascript.png" alt="javascriptLogo" />
                        </span>
                        <p class="text-muted my-5">JavaScript</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/bootstrap.png" alt="bootstrapLogo" />
                        </span>
                        <p class="text-muted my-5">Bootstarp</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/jquery.png" alt="jqueryLogo" style="max-width: 135px;"/>
                        </span>
                        <p class="text-muted my-5">jQuery</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/mysql.png" alt="mysqlLogo" />
                        </span>
                        <p class="text-muted my-5">MySQL</p>
                    </div>
                    <div class="col-md-3">
                        <span class="fa-stack fa-4x">
							<img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/lnglogos/git.png" alt="gitLogo" />
                        </span>
                        <p class="text-muted my-5">Git</p>
                    </div>
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
                <div class="row">
                    <div class="col-lg-12 col-sm-6 mb-4">
                        <!-- Portfolio item 1-->
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-bs-toggle="modal" href="#getBoardListModal">
<!--                             <a class="portfolio-link" href="/main.do/1"> -->
                                <div class="portfolio-hover" id="" onclick="getBoardList();">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid my-round" src="${pageContext.request.contextPath}/resources/front/main/assets/img/portfolio/1-board-img.jpg" alt="..." />
                            </a>
                            <div class="portfolio-caption text-center my-round">
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