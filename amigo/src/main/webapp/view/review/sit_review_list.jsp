<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script
      src="https://code.jquery.com/jquery-3.6.3.min.js"
      integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
      crossorigin="anonymous"
    ></script>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="/amigo/resources/css/style.css" />
    <style>
    	
    	.star-rating {
    		width:100%;
    		text-align: center;
    	}
    	.text-uppercase {
    	 font-family: "Jalnan";
      	 font-size:40px; 
    	}
    </style>
<title>후기01_실시간 후기</title>

</head>
<%

%>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container">
		  <section class="main-content">
      <br />
      <div class="container">
        <h1 class="text-uppercase">펫시터 리뷰</h1>
        <br />
        <br />
        <div class="row">
          <div
            class="col-sm-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4"
          >
            <div class="rating-card">
              <div class="text-center m-b-30">
                <!-- 몇마리의 표현은 정보를 가져와줘야함. 02/09 백단에서 가져옴 -->
                <div class="review-member">
                  <a href="#">${rev.getUser_name()}</a>펫시터 후기
                </div>
                <br />
                <!-- 점수 -->
                <h1 class="rating-number">${starsAverage}<small>/5</small></h1>
                <div class="rating-stars d-inline-block position-relative mr-2">
                  <!-- 별 이미지 일뿐 구동은 백엔드쪽에서 만들어 줘야할거 같습니다. -->
                  <img src="amigo/resources/img/grey-star.svg" alt="" />
                  <div class="filled-star" style="width: 86%"></div>
                </div>
                <!-- 총 레이팅 -->
                <div class="text-muted">${starsTotalCount } ratings</div>
              </div>
              <div class="rating-divided">
                <div class="rating-progress">
                  <span class="rating-grade"
                    >5 <img src="/amigo/resources/img/star.svg" alt=""
                  /></span>
                  <div class="progress">
                    <div
                      class="progress-bar bg-warning"
                      role="progressbar"
                      style="width: 75%"
                      aria-valuenow="75"
                      aria-valuemin="0"
                      aria-valuemax="100"
                    ></div>
                  </div>
                  <span class="rating-value">${ssrc5}</span>
                </div>
                <div class="rating-progress">
                  <span class="rating-grade"
                    >4 <img src="/amigo/resources/img/star.svg" alt=""
                  /></span>
                  <div class="progress">
                    <div
                      class="progress-bar bg-warning"
                      role="progressbar"
                      style="width: 10%"
                      aria-valuenow="10"
                      aria-valuemin="0"
                      aria-valuemax="100"
                    ></div>
                  </div>
                  <span class="rating-value">${ssrc4}</span>
                </div>
                <div class="rating-progress">
                  <span class="rating-grade"
                    >3 <img src="/amigo/resources/img/star.svg" alt=""
                  /></span>
                  <div class="progress">
                    <div
                      class="progress-bar bg-warning"
                      role="progressbar"
                      style="width: 8%"
                      aria-valuenow="8"
                      aria-valuemin="0"
                      aria-valuemax="100"
                    ></div>
                  </div>
                  <span class="rating-value">${ssrc3}</span>
                </div>
                <div class="rating-progress">
                  <span class="rating-grade"
                    >2 <img src="/amigo/resources/img/star.svg" alt=""
                  /></span>
                  <div class="progress">
                    <div
                      class="progress-bar bg-warning"
                      role="progressbar"
                      style="width: 6%"
                      aria-valuenow="6"
                      aria-valuemin="0"
                      aria-valuemax="100"
                    ></div>
                  </div>
                  <span class="rating-value">${ssrc2}</span>
                </div>
                <div class="rating-progress">
                  <span class="rating-grade"
                    >1 <img src="/amigo/resources/img/star.svg" alt=""
                  /></span>
                  <div class="progress">
                    <div
                      class="progress-bar bg-warning"
                      role="progressbar"
                      style="width: 3%"
                      aria-valuenow="3"
                      aria-valuemin="0"
                      aria-valuemax="100"
                    ></div>
                  </div>
                  <span class="rating-value">${ssrc1}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- 리뷰 종합 end -->
    <!-- 유저 실시간 리뷰 -->
    <div class="container">
      <div class="row">
      <c:choose>
         <c:when test="${ revList.isEmpty() || revList == null }">
            <h6>등록된 게시판 정보가 존재하지 않습니다. 다시 확인해주세요.</h6>
         </c:when>
      <c:otherwise>
     	 <c:forEach var="rev" items="${ revList }">
        <div
          class="col-sm-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4"
        >
          <div class="review-user-card">
            <div class="review-divided">
              <div class="row">
                <div class="col-sm-3">
                  <div class="review-img">
                  <!-- 유저 프로필 -->
                  	<c:choose>
                  	<c:when test="${rev.getUser_photo()!=null and rev.getUser_photo()!=''}">
                    <img
                      src="/img/${rev.getUser_photo() }"
                      class="review-user-photo"
                      alt="userProfile"
                      width="50px"
                      class="mr-3 rounded-circle"
                    />
                    </c:when>
                    <c:otherwise>
                    <img src="resources/img/logo2.png" alt="logo2" width="50px" class="mr-3 rounded-circle" alt="logo2"/>
                    </c:otherwise>
                    </c:choose>
                    <span class="nickName" style="color:#498dcc; font-weight:bold">${ rev.getUser_nick() }</span>&nbsp;
                    <!-- 유저 프로필 end -->
                  </div>
                  
                  <!-- 별 
                 
                  <div class="star-ratings">
                    <div 
                      class="star-ratings-fill space-x-2 text-lg"
                      :style="{ width: ratingToPercent + '%' }"
                    >
                      <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                    </div>
                    <div class="star-ratings-base space-x-2 text-lg">
                      <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                    </div>
                  -->
                  <div class="text-center">
                    <div class="wrap-star">
                      <!-- 100 % -->
                      <div class="star-rating">
                        <span style="width: 100%">"${ rev.getStar_cnt() }"</span>
                        <input type="hidden" class="form-control" name="sit_no" value="${ rev.getSit_no() }">
                        <input type="hidden" class="form-control" name="user_no" value="${ sessionScope.user.getUser_no() }">
                        <input type="hidden" class="form-control" name="user_no" value="${ rev.getUser_no() }">
                        <input type="hidden" class="form-control" name="star_cnt" value="${ rev.getStar_cnt() }">
                        <input type="hidden" class="form-control" name="rev_content" value="${ rev.getRev_content() }">
                        <input type="hidden" class="form-control" name="rev_date" value="${ rev.getRev_date() }">
                        <input type="hidden" class="form-control" name="user_addr" value="${ rev.getUser_addr() }">
                        <input type="hidden" class="form-control" name="user_nick" value="${ rev.getUser_nick() }">
                        <input type="hidden" class="form-control" name="user_name" value="${ rev.getUser_name() }">
                        <input type="hidden" class="form-control" name="user_photo" value="${ rev.getUser_photo() }"> 
                        
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 별 end -->
              </div>
              <br />
              <div class="reviewMain text-center">
                <div class="review-user-addr">
                  <a href="#">${ rev.getUser_addr() }</a>
                </div>
                <br />
                <br />
                <div class="review-main">
                  <a href="#"></a>${ rev.getRev_content() }
                </div>
              </div>
            </div>
          </div>
        </div>
         </c:forEach>
       </c:otherwise>
       </c:choose>
      </div>
    </div>
	</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>