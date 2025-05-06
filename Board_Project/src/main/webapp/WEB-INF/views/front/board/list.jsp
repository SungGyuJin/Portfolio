<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
          <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content" id="modal-board">
            <div class="close-modal" data-bs-dismiss="modal">
                <img src="${pageContext.request.contextPath}/resources/front/main/assets/img/close-icon.svg" alt="Close modal" />
            </div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-12">
                        <div class="modal-body">
                            <!-- 제목 -->
                            <h2 class="text-uppercase">Board</h2>
                            <p class="item-intro text-muted">사용자가 원하는 게시판에 글을 쓰고, 수정할 수 있으며 댓글, 비밀 글 등의 옵션이 있는 게시판입니다.</p>

                            <!-- 📌 게시판 선택 옵션 (테이블 위) -->
                            <div class="mb-3">
                                <select class="form-select">
                                    <option value="">게시판 선택</option>
                                    <option value="notice">공지사항</option>
                                    <option value="qna">Q&A</option>
                                    <option value="free">자유게시판</option>
                                </select>
                            </div>

                            <!-- 📌 테이블 -->
                            <div class="table-responsive mb-3">
                                <table class="table table-striped table-bordered">
                                    <thead class="table-dark">
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
                                    </tbody>
                                </table>
                            </div>

                            <!-- 📌 검색창 + 옵션 (테이블 아래) -->
                            <form class="row g-3 mb-3">
                                <div class="col-md-5">
                                    <input type="text" class="form-control" placeholder="검색어 입력">
                                </div>
                                <div class="col-md-4">
                                    <select class="form-select">
                                        <option value="">검색 옵션 선택</option>
                                        <option value="title">제목</option>
                                        <option value="writer">작성자</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <button type="submit" class="btn btn-primary w-100">검색</button>
                                </div>
                            </form>

                            <!-- 📌 페이지네이션 -->
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

                            <!-- 닫기 버튼 -->
                            <button type="button" class="btn btn-danger btn-xl text-uppercase btn-opt" data-bs-dismiss="modal">
                                닫기
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



</body>
