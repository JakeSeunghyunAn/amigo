<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<script
  src="https://code.jquery.com/jquery-3.6.3.min.js"
  integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
  crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>게시판01_유저커뮤니티</title>
<!-- 
			사용시 에러발생 
   <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-2/css/all.min.css"
      integrity="sha256-46r060N2LrChLLb5zowXQ72/iKKNiw/lAmygmHExk/o="
      crossorigin="anonymous"
    />
    -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
      <style>
      .card {
       .card {
       box-shadow: 5px 2px 20px rgba(0,0,0,0.2);
      }

      .card {
        position: relative;
        display: flex;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 0 solid rgba(0, 0, 0, 0.125);
        border-radius: 0.25rem;
      }

      .card-body {
        flex: 1 1 auto;
        min-height: 1px;
        padding: 1rem;
      }
      
      .text-body {
     
      }
      }
    </style>
</head>
<body>
<%@include file="/includes/header.jsp" %>

   <!-- far fa icon 불러오기 -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    />


	<div class="container" align="left">
		<div class="mt-4 p-5">
			<h3>유저 커뮤니티</h3>
			<c:if test="${ boardList.isEmpty() }">
				<h5><p class="bg-danger text-white">등록된 게시판 정보가 존재하지 않습니다!!</p></h5>
			</c:if>
		</div> 
		<hr/>
		
			
		<form action="user_board_list.do" method="post" id="boardForm">   
			<input type="hidden" id="curPage" name="curPage" value="${searchVO.getCurPage()}"> 
			<input type="hidden" id="rowSizePerPage" name="rowSizePerPage" value="${searchVO.getRowSizePerPage()}">
			
			<!-- 상단 메뉴 -->
	   		<div class="row mt-3 justify-content-end">
	   			<div class="col-auto">
					<a href="user_board_list.do">전체글</a> 
	   				<a href="user_board_list_Like.do?curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}">인기글</a> 
	   				<a href="">펫시터 커뮤니티</a>
	   			</div>
	   		<div class="row mt-3 justify-content-end">
	   			<div class="col-auto">
					<select class="form-select" id="searchCategory" name="searchCategory" onchange="chageSelect()">
				    	<option value="말머리">말머리</option>							
				    	<option value="자랑글">자랑글</option>						
				    	<option value="자유글">자유글</option>							
				    	<option value="질문">질문</option>										
					</select>
					
					<script type="text/javascript">
					
					function chageSelect(){ 
						
						var selectList = document.getElementById("searchCategory")
						
						if(selectList.options[selectList.selectedIndex].value == "말머리"){
							location.href = "user_board_list.do?";
						}
						if(selectList.options[selectList.selectedIndex].value == "자랑글"){
							location.href = "user_board_cate.do?ubd_cate=자랑글&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}";
						}
						if(selectList.options[selectList.selectedIndex].value == "자유글"){
							location.href = "user_board_cate.do?ubd_cate=자유글&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}";
						}
						if(selectList.options[selectList.selectedIndex].value == "질문"){
							location.href = "user_board_cate.do?ubd_cate=질문&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}";
						}
					}
					</script>
					
				</div> 
			</div>
		</form> 

		<div class="container">					
					<c:forEach  var="board" items="${ boardList }">
                    <div class="container">
            <!-- Forum List -->
         <div class="inner-main-body p-2 p-sm-3 forum-content show"  style="cursor: pointer;" onclick="location.href='user_board_detail.do?ubd_no=${board.getUbd_no()}&user_no=${user.getUser_no()}&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}'">
              <div class="card mb-2">
                <div class="card-body p-2 p-sm-3">
                  <div class="media forum-item">
                  <!-- user profile -->
                    <a
                      href="#"><img 
                      	src="img/reviewProfile.jpg"
                        class="mr-3 rounded-circle"
                        width="50"
                        alt="User"
                    /></a>
                    <!-- user profile/ -->
                    <div class="media-body">
                      <!-- 말머리 -->
                        <a class="text-secondary">${ board.getUbd_cate()}</a>
                      <!-- 말머리/ -->
                      <!-- 제목 -->
                      <h6>
                      <a class="text-body" href="user_board_detail.do?ubd_no=${board.getUbd_no()}&user_no=${user.getUser_no()}">${board.getUbd_title()}</a> [${board.getReply_cnt()}]
                      </h6>
                      <!-- 제목/ -->
                      <p class="text-muted">
                      <!-- 작성자 -->
                        <a class="nickName">${ board.getUser_nick() }</a>
                       <!-- 작성자/ -->
                       <!-- 작성일 -->
                        <span class="text-secondary font-weight-bold">
                        <fmt:formatDate value="${board.ubd_date}" pattern="yyyy-MM-dd"/></span>
                   		<!-- 작성일자/ -->   	
                      </p>
                    </div>
                    <div class="text-muted small text-center align-self-center">
                     <span class=""><i class="fa fa-eye"></i>${ board.ubd_cnt }</span>&nbsp;&nbsp;
                      <span><ii class="fa fa-heart" aria-hidden="true"></i>&nbsp;&nbsp;${ board.getLike_cnt() }</span>
                    	</div>
                 		</div>
                		</div>
              			</div>
 			        </div>
 			    </div>
 			</c:forEach>
 			</div>
		<div class="row align-items-start mt-3">
			<ul class="col pagination justify-content-center">
			
				<c:set var="cp" value="${searchVO.getCurPage()}"/>
				<c:set var="rp" value="${searchVO.getRowSizePerPage()}"/>
				<c:set var="fp" value="${searchVO.getFirstPage()}"/>
				<c:set var="lp" value="${searchVO.getLastPage()}"/>
				<c:set var="ps" value="${searchVO.getPageSize()}"/>
				<c:set var="tp" value="${searchVO.getTotalPageCount()}"/>
				<c:set var="sc" value="${searchVO.getSearchCategory()}"/>
				<c:set var="st" value="${searchVO.getSearchType()}"/>
				<c:set var="sw" value="${searchVO.getSearchWord()}"/>
																
				<c:if test="${ fp != 1 }">
					<li class="page-item"><a href="user_board_cate.do?ubd_cate=${cate}&curPage=1&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-fast-backward"></i></a></li>
					<li class="page-item"><a href="user_board_cate.do?ubd_cate=${cate}&curPage=${fp-1}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-backward"></i></a></li>				
				</c:if>
			
				<c:forEach var="page" begin="${fp}" end="${lp}">
					<li class="page-item ${cp==page ? 'active' : ''}"><a href="user_board_cate.do?ubd_cate=${cate}&curPage=${page}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link">${page}</a></li>
				</c:forEach>
				
				<c:if test="${ lp < tp }">
					<li class="page-item "><a href="user_board_cate.do?ubd_cate=${cate}&curPage=${lp+ps}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-forward"></i></a></li>				
					<li class="page-item"><a href="user_board_cate.do?ubd_cate=${cate}&curPage=${tp}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-fast-forward"></i></a></li>				
				</c:if>
			</ul> <!-- pagination -->	
	
		</div> <!-- 페이징 -->
		
		<div class="col-2 btn-group">
			    <a href="user_board_insert.do" class="col-1 btn btn-primary me-2">글등록</a>
		</div>
		<!-- 하단 검색 시스템 -->
		<form action="user_board_list.do" method="post" id="boardForm">   
				    	<div class="col-3 me-1">
					<select class="form-select" id="searchType" name="searchType">
				    	<option value="">검색</option>							
				    	<option value="ubd_title" ${searchVO.getSearchType()=="ubd_title" ? "selected" : "" }>제목</option>							
				    	<option value="user_nick" ${searchVO.getSearchType()=="user_nick" ? "selected" : ""}>작성자</option>						
				    	<option value="ubd_cont" ${searchVO.getSearchType()=="ubd_cont" ? "selected" : ""}>글내용</option>						
					</select>
				</div>
				<div class="col-3 me-1">			
					<input class="form-control me-2" name="searchWord" type="text" placeholder="내용은 입력하세요." />
				</div>
				<div class="col-3 btn-group">
			    	<input type="submit" class="col-1 btn btn-primary me-2" value="검색">
	        	</div>
	     </form>
							
	</div> <!— main  —>
	    
	    
<%@include file="/includes/footer.jsp" %>
</body>
</html>