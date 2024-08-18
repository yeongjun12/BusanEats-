<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd7467174bce94b954b035b41a5bccf5&libraries=services"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/store/storeList.js'/>"></script>

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <title>Restaurant Listings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .header {
            background-color: #ff6600;
            padding: 10px;
            text-align: center;
        }
        .header a {
            color: white;
            margin: 0 15px;
            text-decoration: none;
            font-weight: bold;
        }
        .header a:hover {
            text-decoration: underline;
        }
        .sort-bar {
            text-align: right;
            margin: 20px 0;
        }
        .sort-bar a {
            color: #333;
            margin: 0 10px;
            text-decoration: none;
            font-weight: bold;
        }
        .sort-bar a:hover {
            text-decoration: underline;
        }
        .grid-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 20px;
        }
        .grid-item {
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        .grid-item img {
            width: 100%;
            height: auto;
        }
        .info {
            padding: 15px;
        }
        .rating {
            font-size: 1.5em;
            color: #ff6600;
        }
        .title {
            font-size: 1.2em;
            margin: 10px 0;
        }
        .description {
            font-size: 0.9em;
            color: #666;
        }
        .stats {
            display: flex;
            justify-content: flex-start;
            gap: 10px;
            margin-top: 10px;
            font-size: 0.8em;
            color: #999;
        }
        .bookmark {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            text-align: center;
            line-height: 30px;
            color: white;
            font-size: 1.2em;
            cursor: pointer;
        }
        .pagination {
            text-align: center;
            margin: 20px 0;
        }
        .pagination a {
            margin: 0 5px;
            text-decoration: none;
            color: #007bff;
        }
        .pagination a.active {
            font-weight: bold;
            color: #000;
        }
    </style>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="container">
    <div class="header">
        <a href="#">전체</a>
        <a href="#">웨신</a>
        <a href="#">양식/스테이크</a>
        <a href="#">고기/구이류</a>
        <a href="#">씨푸드</a>
        <a href="#">일/중/서양음식</a>
        <a href="#">카페/디저트</a>
        <a href="#">나이트라이프</a>
    </div>

    <div class="sort-bar">
        <a href="#">리뷰순</a>
        <a href="#">즐겨찾기순</a>
        <a href="#">조회순</a>
    </div>
    
    <div class="title">
						
	<h3 align="center" id="resturantTitle"> <c:out value="${ requestScope.gugunNm }" /> 식당</h3>
						
	</div>

    <div class="grid-container">
        
        <c:forEach items="${ requestScope.list }" var="s">
        
        
        <div class="grid-item">
        	<input type="hidden" class="ucSeq" name="ucSeq" value="${s.ucSeq }"/>
            <img src="${s.mainImgThumb }" alt="">
            <div class="info">
                <div class="rating">4.0</div>
                <div class="title">${s.mainTitle }</div>
                <div class="description">${s.reprsntvMenu }</div>
                <div class="stats">
                    <span>조회수: 127990</span>
                    <span>즐겨찾기: 270</span>
                    <span>리뷰: 252</span>
                </div>
            </div>
            <div class="bookmark"><img class="like"  alt="${s.ucSeq }" src="resources/images/deleteheart.png" width="20" height="20">2</div>
        </div>
        
        </c:forEach>
        
    </div>

    <div class="pagination">
        <a href="#">&laquo;</a>
        <a href="#">1</a>
        <a href="#" class="active">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">&raquo;</a>
    </div>
</div>

<script>
			
			$(function() {
			    
				
				$('.like').each(function(){
					var check = 0;
					<c:forEach items = "${ likeNoList }" var = "like">
					
					if(${like.ucSeq} == $(this).attr("alt")) { check += 1 }
					
					</c:forEach>
					
					
					if(check > 0) {
                        $(this).attr("src", "resources/images/heart.png");
                    }
                    else {
                        $(this).attr("src", "resources/images/deleteheart.png");
                    }
				});
				
				
				
				
				
				
				
				$(document).on('click', '.grid-item', function() {
			        // 식당 detail정보 보기
			        var ucSeq = $(this).find('input[name="ucSeq"]').val();
			        location.href = "selectStoreDetail.do?ucSeq=" + ucSeq;
			    });
				
			    
			    // 하트 좋아요 / 해제
			    $('.like').click(function() {
			    	event.stopPropagation(); // 클릭 이벤트가 상위 요소로 전파되지 않도록 방지
			        var clickedElement = $(this); // 클릭된 요소를 변수에 저장
			        
			        console.log(clickedElement);
			        var imgPath = $(this).attr('src'); // 클릭된 요소의 src 속성 값을 가져옴

			        // 클릭된 요소의 가장 가까운 부모 <li> 요소에서 ucSeq 값을 가져옴
			        //var ucSeq = $(this).closest('li').find('.ucSeq').val();
			        var ucSeq = $(this).closest('.grid-item').find('.ucSeq').val();

			        console.log(ucSeq);
			        // 만약 클릭된 이미지가 'resources/images/deleteheart.png'라면
			        if (imgPath == 'resources/images/deleteheart.png') {
			            // AJAX 요청을 보냄
			            $.ajax({
			                url: 'insertLike.do', // 요청을 보낼 URL
			                method: 'POST', // HTTP 메서드는 POST
			                data: {
			                    ucSeq: ucSeq // 서버로 전송할 데이터
			                },
			                success: function(response) { // 요청이 성공했을 때의 처리
			                    if (response === 'success') { // 서버로부터의 응답이 성공적인지 확인
			                        clickedElement.attr('src', 'resources/images/heart.png'); // 클릭된 요소의 src 속성을 'resources/images/heart.png'로 변경하여 찬 하트로 교체
			                    } else{
			                    	cosole.log('실패');
			                    }
			                },
			                error: function(xhr, status, error) { // 요청이 실패했을 때의 처리
			                    console.error('AJAX 요청이 실패했습니다:', error); // 콘솔에 에러 메시지 출력
			                }
			            });
			        }else{
			        	$.ajax({
			        		url : 'deleteLike.do',
			        		method: 'POST',
			        		data: { ucSeq: ucSeq },
			        		success: function(response) { // 요청이 성공했을 때의 처리
			                    if (response === 'success') { // 서버로부터의 응답이 성공적인지 확인
			                        clickedElement.attr('src', 'resources/images/deleteheart.png'); 
			                    } else{
			                    	cosole.log('실패');
			                    }
			                },
			                error: function(xhr, status, error) { // 요청이 실패했을 때의 처리
			                    console.error('AJAX 요청이 실패했습니다:', error); // 콘솔에 에러 메시지 출력
			                }
			        	});
			        }
			    });
			});
				
				
			</script>


</body>
</html>

