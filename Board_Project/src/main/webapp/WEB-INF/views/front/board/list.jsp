<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
          <div class="container">
            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/front/main/assets/img/portfolio/1-board-img.jpg" alt="Board Image" style="width: 100px; height: 100px; object-fit: cover; border-radius: 50%;" />
                <div class="row justify-content-center">
                    <div class="col-lg-12">
                        <h2 class="text-uppercase mb-4">Board</h2>
                        <p class="item-intro text-muted mb-4 fs-4">사용자가 원하는 게시판에 글을 쓰고, 수정할 수 있으며 댓글, 비밀 글 등의 옵션이 있는 게시판입니다.</p>

                        <div class="modal-body" id="modal-board">
                        	<div class="text-end">
	                            <button type="submit" class="btn my-danger">내가 쓴 글</button>
	                            <button type="submit" class="btn my-success">글쓰기</button>
                        	</div>
                        	<hr>
                        	
                        	<div id="append-board">
                        	
	                            <form id="frm-board">
		                            <div class="mb-3">
		                            	<div class="d-flex justify-content-between">
			    							<div>
				                                <select class="form-select cursor-pointer">
				                                    <option value="">전체</option>
				                                    <option value="notice">공지사항</option>
				                                    <option value="qna">Q&A</option>
				                                    <option value="free">자유게시판</option>
				                                </select>
			    							</div>
		    								<div>
				                                <select class="form-select cursor-pointer">
				                                    <option value="10">10개씩</option>
				                                    <option value="20">20개씩</option>
				                                    <option value="50">50개씩</option>
				                                    <option value="100">100개씩</option>
				                                </select>
										    </div>
										</div>
		                            </div>
	
		                            <div class="table-responsive mb-4" style="border-radius: 15px; overflow: hidden; border: 1px solid #ddd;">
		                                <table class="table table-bordered table-striped table-hover table-lg mb-0 cursor-pointer">
		                                    <colgroup>
		                                        <col width="10"> <!-- 게시판명 -->
		                                        <col width="100"> <!-- 등록일시 -->
		                                        <col width="40"> <!-- 수정일시 -->
		                                        <col width="40"> <!-- 상태 -->
		                                        <col width="10"> <!-- 상태 -->
		                                    </colgroup>
		                                    <thead class="table-light">
		                                        <tr>
		                                            <th>No</th>
		                                            <th>제목</th>
		                                            <th>작성자</th>
		                                            <th>작성일</th>
		                                            <th>조회수</th>
		                                        </tr>
		                                    </thead>
		                                    <tbody>
		                                        <tr>
		                                            <td>1</td>
		                                            <td>첫 번째 게시글</td>
		                                            <td>홍길동</td>
		                                            <td>2025-05-06</td>
		                                            <td>123</td>
		                                        </tr>
		                                        <tr>
		                                            <td>2</td>
		                                            <td>두 번째 게시글</td>
		                                            <td>김철수</td>
		                                            <td>2025-05-05</td>
		                                            <td>98</td>
		                                        </tr>
		                                        <tr>
		                                            <td>3</td>
		                                            <td>세 번째 게시글</td>
		                                            <td>이영희</td>
		                                            <td>2025-05-04</td>
		                                            <td>76</td>
		                                        </tr>
		                                        <tr>
		                                            <td>3</td>
		                                            <td>세 번째 게시글</td>
		                                            <td>이영희</td>
		                                            <td>2025-05-04</td>
		                                            <td>76</td>
		                                        </tr>
		                                        <tr>
		                                            <td>3</td>
		                                            <td>세 번째 게시글</td>
		                                            <td>이영희</td>
		                                            <td>2025-05-04</td>
		                                            <td>76</td>
		                                        </tr>
		                                        <tr>
		                                            <td>3</td>
		                                            <td>세 번째 게시글</td>
		                                            <td>이영희</td>
		                                            <td>2025-05-04</td>
		                                            <td>76</td>
		                                        </tr>
		                                        <tr>
		                                            <td>3</td>
		                                            <td>세 번째 게시글</td>
		                                            <td>이영희</td>
		                                            <td>2025-05-04</td>
		                                            <td>76</td>
		                                        </tr>
		                                        <tr>
		                                            <td>3</td>
		                                            <td>세 번째 게시글</td>
		                                            <td>이영희</td>
		                                            <td>2025-05-04</td>
		                                            <td>76</td>
		                                        </tr>
		                                        <tr>
		                                            <td>3</td>
		                                            <td>세 번째 게시글</td>
		                                            <td>이영희</td>
		                                            <td>2025-05-04</td>
		                                            <td>76</td>
		                                        </tr>
		                                        <tr>
		                                            <td>3</td>
		                                            <td>세 번째 게시글</td>
		                                            <td>이영희</td>
		                                            <td>2025-05-04</td>
		                                            <td>76</td>
		                                        </tr>
		                                    </tbody>
		                                </table>
		                            </div>
	
									<div class="d-flex justify-content-between">
								    	<nav aria-label="Page navigation">
								            <ul class="pagination justify-content-center">
								                <li class="page-item disabled">
								                    <a class="page-link" href="#" tabindex="-1">이전</a>
								                </li>
								                <li class="page-item active">
								                    <a class="page-link" href="#">1</a>
								                </li>
								                <li class="page-item">
								                    <a class="page-link" href="#">2</a>
								                </li>
								                <li class="page-item">
								                    <a class="page-link" href="#">3</a>
								                </li>
								                <li class="page-item">
								                    <a class="page-link" href="#">다음</a>
								                </li>
								            </ul>
								        </nav>
			                            <div class="row g-3 mb-4 d-flex justify-content-end">
											<div class="input-group">
												<div style="flex: 0 0 20%;">
										            <select class="form-select me-1">
										                <option value="">전체</option>
										                <option value="title">제목</option>
										                <option value="cn">내용</option>
										                <option value="writer">작성자</option>
										            </select>
												</div>
										        <input type="text" class="form-control ms-1 me-1" style="flex: 0 0 60%;" placeholder="검색어 입력" autocomplete="off">
										        <button type="submit" class="btn btn-success my-primary" style="flex: 0 0 18%;">검색</button>
										    </div>
										</div>
									</div>
								
								</form>
                        	</div>
							
                        </div>
                    </div>
                </div>
            </div>



</body>
