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
        
/* Location bar at the top */
.location-bar {
    background-color: #f8f8f8;
    padding: 10px;
    display: flex;
    align-items: center;
    gap: 10px;
    border-bottom: 1px solid #ddd;
}

.location-btn {
    background-color: #ff6600;
    color: white;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
    border-radius: 5px;
}


.location-modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.8); 
    display: flex;
    justify-content: center; 
    align-items: center; 
    z-index: 1000; 
    padding: 0; 
    margin: 0; 
    overflow: hidden; 
}

.modal-content {
    background-color: #f4f4f9; 
    width: 90%;
    max-width: 600px;
    padding: 20px 30px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); 
    position: relative;
    color: #333; 
}

.close {
    position: absolute;
    top: 10px;
    right: 15px;
    font-size: 20px;
    cursor: pointer;
    border: none;
    background: none;
    color: #333;
    transition: color 0.3s ease; 
}

.close:hover {
    color: #ff6600; 
}

.location-tabs {
    display: flex;
    justify-content: space-around;
    margin-bottom: 20px;
}

.tab-btn {
    background-color: #ddd;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    transition: background-color 0.3s ease, color 0.3s ease;
}

.tab-btn.active {
    background-color: #ff6600;
    color: #fff;
}

.tab-btn:hover {
    background-color: #ff884d;
    color: white;
}

.location-categories,
.location-list {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    justify-content: center;
}

.category-btn,
.location-item {
    background-color: #f0f0f0;
    border: 1px solid #ddd;
    padding: 8px 12px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease, border-color 0.3s ease;
}

.category-btn.active,
.location-item:hover {
    background-color: #ff6600;
    color: #fff;
    border-color: #ff6600;
}

        
    </style>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>
<body>

<jsp:include page="../common/header.jsp" />
<div class="header">
        <a href="selectStoreList.do?storeType=한식&gugunNm=${requestScope.gugunNm }">한식</a>
        <a href="selectStoreList.do?storeType=양식&gugunNm=${requestScope.gugunNm }">양식/레스토랑</a>
        <a href="selectStoreList.do?storeType=고기&gugunNm=${requestScope.gugunNm }">고기/구이류</a>
        <a href="selectStoreList.do?storeType=씨푸드&gugunNm=${requestScope.gugunNm }">씨푸드</a>
        <a href="selectStoreList.do?storeType=세계&gugunNm=${requestScope.gugunNm }">일/중/세계음식</a>
        <a href="selectStoreList.do?storeType=카페&gugunNm=${requestScope.gugunNm }">카페/디저트</a>
    </div>
<div class="location-bar">
    <span>현재 보고있는 맛집 지역은</span>
    <button class="location-btn" onclick="toggleLocationModal()">${requestScope.gugunNm }</button>
    <span>입니다</span>
</div>

<!-- Modal for selecting location -->
<div id="location-modal" class="location-modal" style="display: none;">
    <div class="modal-content" style ="background-color:white;">
        <span class="close" onclick="toggleLocationModal()">&times;</span>
        <h2>지역 선택</h2>
        
        <div id="domestic" class="tab-content">
            
            <div class="location-list">
                 <button class="location-item" data-gugun="기장군" onclick="selectLocation(this)">기장군</button>
                 <button class="location-item" data-gugun="금정구" onclick="selectLocation(this)">금정구</button>
                 <button class="location-item" data-gugun="북구" onclick="selectLocation(this)">북구</button>
                 <button class="location-item" data-gugun="동래구" onclick="selectLocation(this)">동래구</button>
                 <button class="location-item" data-gugun="해운대구" onclick="selectLocation(this)">해운대구</button>
                 <button class="location-item" data-gugun="연제구" onclick="selectLocation(this)">연제구</button>
                 <button class="location-item" data-gugun="수영구" onclick="selectLocation(this)">수영구</button>
                 <button class="location-item" data-gugun="강서구" onclick="selectLocation(this)">강서구</button>
                 <button class="location-item" data-gugun="사상구" onclick="selectLocation(this)">사상구</button>
                 <button class="location-item" data-gugun="부산진구" onclick="selectLocation(this)">부산진구</button>
                 <button class="location-item" data-gugun="동구" onclick="selectLocation(this)">동구</button>
                 <button class="location-item" data-gugun="남구" onclick="selectLocation(this)">남구</button>
                 <button class="location-item" data-gugun="중구" onclick="selectLocation(this)">중구</button>
                 <button class="location-item" data-gugun="사하구" onclick="selectLocation(this)">사하구</button>
                 <button class="location-item" data-gugun="서구" onclick="selectLocation(this)">서구</button>
                 <button class="location-item" data-gugun="영도구" onclick="selectLocation(this)">영도구</button>
            </div>
        </div>
        
    </div>
</div>


<div class="container">

    <div class="sort-bar">
        <a href="selectStoreList.do?gugunNm=${ requestScope.gugunNm }&orderBy=review">리뷰순</a>
        <a href="selectStoreList.do?gugunNm=${ requestScope.gugunNm }&orderBy=like">좋아요순</a>
        <a href="selectStoreList.do?gugunNm=${ requestScope.gugunNm }&orderBy=count">조회순</a>
    </div>
    
    <div class="title">
						
	<h3 align="center" id="resturantTitle"> <c:out value="${ requestScope.gugunNm }" /><c:out value="${ requestScope.storeType }" /> 식당</h3>
						
	</div>

    <div class="grid-container">
        
        <c:forEach items="${ requestScope.list }" var="s">
        
        
        <div class="grid-item" >
        	<input type="hidden" class="ucSeq" name="ucSeq" value="${s.ucSeq }"/>
            <img src="${s.mainImgThumb}" alt="" style="width: 298.67px; height: 229.2px;">
            <div class="info">
                <div class="rating">${averageRatingMap[s.ucSeq]}</div>
                <div class="title">${s.mainTitle }</div>
                <div class="description">${s.reprsntvMenu }</div>
                <div class="stats">
                    <span>조회수: ${s.count}</span>
                    <span id="likeCount${s.ucSeq}">좋아요: ${likeCountMap[s.ucSeq]}</span>
                    <span>리뷰: ${reviewCountMap[s.ucSeq]}</span>
                </div>
            </div>
            <div class="bookmark"><img class="like"  alt="${s.ucSeq }" src="resources/images/deleteheart.png" width="20" height="20"></div>
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

function toggleLocationModal() {
    const modal = document.getElementById('location-modal');
    modal.style.display = modal.style.display === 'none' || modal.style.display === '' ? 'flex' : 'none';
}


function selectLocation(button) {
	
    // Get the gugunNm from the button's data attribute
    const gugunNm = button.getAttribute('data-gugun');
	
    console.log(gugunNm);
    // Construct the URL with the selected region
    const url = `selectStoreList.do?gugunNm=`+gugunNm;

    // Redirect to the constructed URL
    window.location.href = url;
}


			
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
			                        var likeCountElement = $('#likeCount'+ucSeq);
			                        var currentCount = parseInt(likeCountElement.text().replace(/[^0-9]/g, ''), 10); // 숫자만 추출하여 파싱
			                        likeCountElement.text('좋아요: ' + (currentCount + 1)); // 숫자를 증가시키고 텍스트로 설정
			                        console.log('좋아요');
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
			                        var likeCountElement = $('#likeCount'+ucSeq);
			                        var currentCount = parseInt(likeCountElement.text().replace(/[^0-9]/g, ''), 10); // 숫자만 추출하여 파싱
			                        likeCountElement.text('좋아요: ' + (currentCount - 1)); // 숫자를 증가시키고 텍스트로 설정
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

