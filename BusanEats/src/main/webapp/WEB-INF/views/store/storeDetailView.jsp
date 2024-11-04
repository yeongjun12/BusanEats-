<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Details</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <!-- Bootstrap JavaScript 로드 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .headerArea {
            display: flex;
            align-items: center;
        }
        .header-left {
            display: flex;
            align-items: center;
            margin-right: 15px;
        }
        .header-left img {
            border-radius: 50%;
            margin-right: 10px;
        }
        .title-container {
            display: flex;
            align-items: center;
        }
        .title {
            font-size: 1.8em;
            font-weight: bold;
            margin-right: 10px;
        }
        .rating {
            font-size: 1.5em;
            color: #ff6600;
            margin-right: 10px;
        }
        .tag {
            background-color: #ff3333;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.9em;
            margin-right: 5px;
        }
        .stats {
            display: flex;
            align-items: center;
            font-size: 0.9em;
            color: #555;
            margin: 5px 0;
        }
        .stats span {
            margin-right: 15px;
            display: flex;
            align-items: center;
        }
        .stats span i {
            margin-right: 5px;
        }
        .location {
            font-size: 1em;
            color: #007bff;
            margin-top: 10px;
        }
        .navigation {
            margin: 20px 0;
            background-color: #ff6600;
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }
        .navigation a {
            color: white;
            margin: 0 10px;
            text-decoration: none;
            font-weight: bold;
        }
        .content {
            margin-top: 20px;
        }
        .content h2 {
            font-size: 1.2em;
            margin-bottom: 10px;
            border-bottom: 2px solid #ff6600;
            padding-bottom: 5px;
        }
        .store-intro, .store-info {
            background-color: #f5f5f5;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
        }
        .store-info {
            display: flex;
            justify-content: space-between;
        }
        .store-info-left {
            flex: 1;
            margin-right: 20px;
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 5px;
        }
        .store-info-left p {
            margin: 5px 0;
        }
        .map {
            flex: 1;
            min-width: 300px;
            height: 200px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #e0e0e0;
        }
        .review-section {
            margin-top: 20px;
        }
        .review-section h3 {
            font-size: 1.1em;
            margin-bottom: 10px;
        }
        .review-form {
            display: none;
            margin-bottom: 20px;
        }
        .review-form textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 10px;
        }
        .review-form .rating {
            font-size: 1.5em;
            color: #ff6600;
            margin-bottom: 10px;
        }
        .review-form .submit-btn {
            background-color: #ff6600;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .review-list {
            margin-top: 20px;
        }
        .review-list .review-item {
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }
        .review-list .review-item:last-child {
            border-bottom: none;
        }
        .review-list .review-item .rating {
            color: #ff6600;
            font-weight: bold;
        }
        .review-toggle {
            cursor: pointer;
            color: #ff6600;
            font-weight: bold;
            margin-top: 20px;
        }
           .review-form img {
            max-width: 100%;
            height: auto;
            margin-top: 10px;
        }
        
        /* 별점 스타일 */

             .star-rating {
            display: flex;
            flex-direction: row-reverse;
            font-size: 2.25rem;
            line-height: 2.5rem;
            justify-content: space-around;
            padding: 0 0.2em;
            text-align: center;
            width: 5em;
            }
            
            .star-rating input {
            display: none;
            }
            
            .star-rating label {
            -webkit-text-fill-color: transparent; 
            -webkit-text-stroke-width: 2.3px;
            -webkit-text-stroke-color: #2b2a29;
            cursor: pointer;
            }
            
             .star-rating :checked ~ label {
            -webkit-text-fill-color: gold;
            } 
            
            .star-rating label:hover,
            .star-rating label:hover ~ label {
            -webkit-text-fill-color: #fff58c;
            } 
        #pagingArea {width:fit-content; margin:auto;}
        
        /*내비게이션 바*/
        .toast_good_on, .toast_good_off {
		    opacity: 0;
		    transition: opacity 0.5s ease-in-out;
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    background: rgba(0, 0, 0, 0.7);
		    padding: 20px;
		    border-radius: 10px;
		    color: white;
		    z-index: 10;
		}
		
		.toast_good_on.show, .toast_good_off.show {
		    display: block;
		    opacity: 1;
		}
        
        /* 숨기기 위한 CSS */
		#toggle_good {
		    display: none; /* 체크박스를 화면에서 숨깁니다 */
		}
		
		.btn-red {
		    background-color: red;
		    border-color: red; /* 버튼 테두리 색상도 설정할 수 있음 */
		    color: white; /* 버튼 텍스트 색상 */
		}
		
		.btn-primary {
		    background-color: #ff6600;
		    border-color: #ff6600; /* 버튼 테두리 색상도 설정할 수 있음 */
		    color: white; /* 버튼 텍스트 색상 */
		}
		
		/* 채팅 모달 스타일 */
	    #chatModal .modal-dialog {
	        max-width: 600px;
	        margin: 30vh auto;
	    }
	
	    #messageList {
	        height: 300px;
	        overflow-y: auto;
	        border: 1px solid #ccc;
	        padding: 5px;
	        margin-bottom: 10px;
	        background-color: #f9f9f9;
	    }
	
	    #messageList li {
	        margin-bottom: 5px;
	    }
	
	    input[type="text"] {
	        width: 80%;
	        padding: 10px;
	        margin-right: 10px;
	    }
	
	    button {
	        padding: 10px;
	    }
	    
	    /* 채팅 2222*/
	    .chat-messages {
	        padding: 10px;
	        overflow-y: scroll; /* 항상 스크롤바 표시 */
	        max-height: 800px;
	        height : 685px;
	    }
	    .chat-message {
	        margin-bottom: 10px;
	        display: flex;
	        align-items: center;
	    }
	    .chat-message.received .message-bubble {
	        background-color: #e1e1e1;
	        max-width: 60%; /* 버블 최대 너비 설정 */
	        word-wrap: break-word; /* 긴 단어 줄바꿈 처리 */
	    }
	    .chat-message.sent .message-bubble {
		    background-color: #ff6600;
		    color: #fff;
		    margin-left: 0; /* 왼쪽 여백 제거 */
		    margin-right: 0; /* 오른쪽 여백 필요 시 추가 */
		    max-width: 60%; /* 버블 최대 너비 설정 */
		    word-wrap: break-word; /* 긴 단어 줄바꿈 처리 */
		    text-align: left; /* 텍스트 정렬 왼쪽 */
		}
		
		.chat-message.sent {
		    justify-content: flex-end; /* 버블을 오른쪽에 배치 */
		    width: 100%; /* 부모 요소가 전체 너비를 가짐 */
		}
	    .message-bubble {
	        display: inline-block;
	        padding: 8px 12px;
	        border-radius: 20px;
	        margin-left : 0;
	    }
	    
	    
	     .date-separator {
	        text-align: center;
	        color: #555;
	        font-weight: bold;
	        margin: 10px 0;
	    }
	    
	     .message-time {
	        font-size: 0.85em;
	        color: #888;
	        margin-left: 10px;
	        vertical-align: bottom;
	    }
		
		.message-time-left {
	        font-size: 0.85em;
	        color: #888;
	        margin-right: 10px; /* 버블과 시간 간격 */
	    }	
				
		.message-time-right {
	        font-size: 0.85em;
	        color: #888;
	        margin-left: 10px; /* 버블과 시간 간격 */
	        margin-right: 0; /* 오른쪽 여백 제거 */
	    }
	    
	    /*메시지 전송버튼*/
	    .send-button {
		    background-color: #ff6600;
		    color: white;
		    border: none;
		    padding: 10px 20px;
		    border-radius: 5px;
		    font-size: 16px;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		}
		
		.send-button:hover {
		    background-color: #e65c00; /* 마우스 오버 시 색상 변경 */
		}
		
		.send-button:focus {
		    outline: none; /* 버튼 포커스 시 외곽선 제거 */
		}
		
		.send-button:active {
		    background-color: #cc5200; /* 클릭 시 색상 변경 */
		}
	    
        
      
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
	



    <div class="headerArea">
        <div class="header-left">
            <img src="${requestScope.s.mainImgThumb }" alt="Restaurant Logo" width="80" height="80">
        </div>
        <div>
            <div class="title-container">
                <div class="title">${requestScope.s.mainTitle }</div>
                <div class="rating">${requestScope.average_rating }</div>
                <div class="tag" style="background-color: #ff6600;">HOT</div>
            </div>
            <div class="stats">
                <span><img src="resources/images/bg_ico_s_click.png">&nbsp ${requestScope.s.count }</span>
                 <span><img src="resources/images/bg_ico_s_like.png" alt="Like">&nbsp;<span id="likeCount">${requestScope.likeCount}</span></span>
            </div>
        </div>
    </div>
    
    <c:set var="isLiked" value="false" />
	<c:forEach items="${likeNoList}" var="like">
	    <c:if test="${like.ucSeq == s.ucSeq}">
	        <c:set var="isLiked" value="true" />
	    </c:if>
	</c:forEach>
	
	<div class="navigation" id="navigation">
	    <a href="#">홈으로</a>
	    <a href="#" id="reserveLink" data-toggle="modal" data-target="#reservationModal">예약하기</a>
	    <a href="#" id="writeReviewLink">리뷰쓰기</a>
	    
	    
	    <label for="toggle_good" data-like-yn="${isLiked ? 'Y' : 'N'}">
	        <a>좋아요</a>
	        <input type="checkbox" id="toggle_good" value="on" <c:if test="${isLiked}">checked</c:if>>
	    </label>
	    <div class="toast_good_on" id="toastGoodOn" style="display: none;">
	        <span>
	            <img src="" alt="좋아요 활성">
	        </span>
	    </div>
	    <div class="toast_good_off" id="toastGoodOff" style="display: none;">
	        <span>좋아요를 취소하였습니다.</span>
	    </div>
	</div>

    <div class="content">
        <h2>매장소개</h2>
        <div class="store-intro">
            <p>${requestScope.s.itemCntnts }</p>
        </div>

        <h2>매장정보</h2>
        <div class="store-info">
            <div class="store-info-left">
                <p><strong>영업시간:</strong> ${requestScope.s.usageDayWeekAndTime }</p>
                <p><strong>메뉴:</strong> ${requestScope.s.reprsntvMenu }</p>
                <p><strong>주소:</strong> ${requestScope.s.addr1 }</p>
                <p><strong>전화번호:</strong> ${requestScope.s.cntctTel }</p>
            </div>
            <input type="hidden" id="lat" value="${requestScope.s.lat}">
			<input type="hidden" id="lng" value="${requestScope.s.lng}">
            	        <!-- 지도를 표시할 div 입니다 -->
		<div id="map" style="width:50%;height:350px;"></div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=baf41b3f50d76c8b3aefa017c15e2227"></script>
		<script>
		
				var mapContainer = document.getElementById('map'); // 지도를 표시할 div
				var lat = $('#lat').val();  // Parse the latitude value to float
				var lng = $('#lng').val();  // Parse the longitude value to float
				
				
				var mapOption = {
				    center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
				    level: 1 // 지도의 확대 레벨
				};
				
				// 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다
				var map = new kakao.maps.Map(mapContainer, mapOption);
				
				// 마커가 표시될 위치입니다 
				var markerPosition  = new kakao.maps.LatLng(lat, lng); 
		
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});
		
				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
		</script>
        </div>
        
         <!-- 1:1 채팅 버튼 -->
    <button class="btn btn-primary" data-toggle="modal" data-target="#chatModal">1:1 문의</button>

    <!-- 1:1 채팅 모달 -->
    <div class="modal fade" id="chatModal" tabindex="-1" role="dialog" aria-labelledby="chatModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="chatModalLabel">1:1 문의</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="chat">
                        <h2>${requestScope.s.mainTitle }</h2>
                        <div class="chat-messages" id="chatMessages">
					        <!-- 채팅 메시지가 여기에 표시됩니다. -->
					        <div class="chat-message received">            
					        </div>
					        <div class="chat-message sent">
					        </div>
					        <!-- 이하 생략 -->
					    </div>
                        <input type="text" id="messageInput" placeholder="메시지를 입력하세요" />
                        <button  class="send-button" onclick="sendMessage()">전송</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

        <div class="review-section">
            <div class="review-toggle"  id="reviewToggle" onclick="toggleReviewForm()">리뷰 작성 ^</div>
            <div class="review-form" id="reviewForm">
                <h3>이 가게를 추천하시겠어요? </h3>
                <!-- 별점 -->
                <div class="star-rating space-x-4 mx-auto">
                
                		<td><input name="ucSeq"  class="storeNo" type="hidden" value="${requestScope.s.ucSeq }" ></td>
                        <td><input name="userNo"  class="userNo" type="hidden" value="${sessionScope.loginUser.userNo }" ></td>
                        <input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
                        <label for="5-stars" class="star pr-4">★</label>
    
    
                        <input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
                        <label for="4-stars" class="star">★</label>
    
    
                        <input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
                        <label for="3-stars" class="star">★</label>
    
    
                        <input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"/>
                        <label for="2-stars" class="star">★</label>
    
    
                        <input type="radio" id="1-star" name="rating" value="1" v-model="ratings" />
                        <label for="1-star" class="star">★</label>
                 </div>
                <textarea rows="5" name="reviewComment" placeholder="매장에 대한 리뷰를 작성해주세요. (필수)"></textarea>
                 <input type="file" class="upfile" name="upfile" id="imageInput" accept="image/*" />
                <button type="button" onclick="insertReview()">등록</button>
            </div>
            
            <!-- 리뷰 리스트 -->
            <div class="review-list">
            
     <c:forEach items="${requestScope.reviewList}" var="r">
    <div class="review-item" style="position: relative; display: flex; align-items: flex-start; margin-bottom: 20px;">
        <!-- 리뷰 내용 영역 -->
        <div style="flex: 1; margin-right: 10px;">
            <p><strong>${r.userId}</strong></p>
            <p class="rating">
                <c:forEach begin="1" end="5" var="i">
                    <c:if test="${i <= r.rating}">
                     	   ★
                    </c:if>
                    <c:if test="${i > r.rating}">
                                                                     ☆
                    </c:if>
                </c:forEach>
                (${r.rating})
            </p>
            <p>${r.reviewComment}</p>
            <p>${r.reviewCreateDate}</p>
        </div>

        <!-- 이미지 영역 -->
        <c:if test="${not empty r.changeName}">
            <div style="flex: 1; max-width: 200px;">
                <img src="${r.changeName}" alt="Review Image" style="max-width: 100%; height: auto; border: 1px solid #ccc; border-radius: 5px;" />
            </div>
        </c:if>

        <c:if test="${loginUser.userNo == r.userNo}">
            <!-- 수정 아이콘 영역 -->
            <div class="edit-icon" style="position: absolute; top: 10px; right: 30px; cursor: pointer;">
                <img src="resources/images/pencil.png" alt="Edit" style="width: 80px; height: 30px;" data-toggle="modal" data-target="#editReviewModal-${r.reviewNo}" />
            </div>
        </c:if>
    </div>

    <!-- 리뷰 수정 모달 -->
    <div class="modal fade" id="editReviewModal-${r.reviewNo}" tabindex="-1" role="dialog" aria-labelledby="editReviewModalLabel-${r.reviewNo}" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editReviewModalLabel-${r.reviewNo}">리뷰 수정</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="" method="post" id="editReviewForm-${r.reviewNo}">
                        <!-- 숨겨진 입력 필드: 리뷰와 사용자의 고유 번호 -->
                        <input type="hidden" name="ucSeq" value="${r.ucSeq}" />
                        <input type="hidden" name="reviewNo" value="${r.reviewNo}" />
                        <input type="hidden" name="userNo" value="${loginUser.userNo}" />
                        <input type="hidden" name="filePath" value="${ r.changeName }" />
            	<!-- EL특성상 없으면 빈문자열이 ?????  -->

                        <!-- 별점 입력 -->
                        <div class="form-group">
                            <label for="editRating-${r.reviewNo}">별점</label>
                            <div class="star-rating space-x-4 mx-auto">
                                <input type="radio" id="5-stars-${r.reviewNo}" name="rating" value="5" ${r.rating == 5 ? 'checked' : ''} />
                                <label for="5-stars-${r.reviewNo}" class="star pr-4">★</label>

                                <input type="radio" id="4-stars-${r.reviewNo}" name="rating" value="4" ${r.rating == 4 ? 'checked' : ''} />
                                <label for="4-stars-${r.reviewNo}" class="star">★</label>

                                <input type="radio" id="3-stars-${r.reviewNo}" name="rating" value="3" ${r.rating == 3 ? 'checked' : ''} />
                                <label for="3-stars-${r.reviewNo}" class="star">★</label>

                                <input type="radio" id="2-stars-${r.reviewNo}" name="rating" value="2" ${r.rating == 2 ? 'checked' : ''} />
                                <label for="2-stars-${r.reviewNo}" class="star">★</label>

                                <input type="radio" id="1-star-${r.reviewNo}" name="rating" value="1" ${r.rating == 1 ? 'checked' : ''} />
                                <label for="1-star-${r.reviewNo}" class="star">★</label>
                            </div>
                        </div>

                        <!-- 리뷰 내용 입력 -->
                        <div class="form-group">
                            <label for="editComment-${r.reviewNo}">리뷰 내용</label>
                            <textarea id="editComment-${r.reviewNo}" name="reviewComment" class="form-control" rows="4">${r.reviewComment}</textarea>
                        </div>
                        
                        <c:if test="${not empty r.changeName}">
				            <div style="flex: 1; max-width: 200px;">
				                <img src="${r.changeName}" alt="Review Image" style="max-width: 100%; height: auto; border: 1px solid #ccc; border-radius: 5px;" />
				            </div>
				        </c:if>

                        <!-- 수정 완료 버튼 -->
                        <button type="button" class="btn btn-primary" onclick="postFormSubmit(2,${r.reviewNo})">수정</button>
                        <button type="button" class="btn btn-red" onclick="postFormSubmit(1,${r.reviewNo});">삭제</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
            
            	<div id="pagingArea">
				    <ul class="pagination">
				        <c:choose>
				            <c:when test="${pi.currentPage eq 1}">
				                <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
				            </c:when>
				            <c:otherwise>
				                <li class="page-item"><a class="page-link" href="#" onclick="loadReviews(${pi.currentPage - 1}); return false;">Previous</a></li>
				            </c:otherwise>
				        </c:choose>
				
				        <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="p">
				            <li class="page-item"><a class="page-link" href="#" onclick="loadReviews(${p}); return false;">${p}</a></li>
				        </c:forEach>
				
				        <c:choose>
				            <c:when test="${pi.currentPage eq pi.maxPage}">
				                <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
				            </c:when>
				            <c:otherwise>
				                <li class="page-item"><a class="page-link" href="#" onclick="loadReviews(${pi.currentPage + 1}); return false;">Next</a></li>
				            </c:otherwise>
				        </c:choose>
				    </ul>
				</div>
				
            </div>
        </div>
    </div>
</div>


<!-- Reservation Modal -->
<div class="modal fade" id="reservationModal" tabindex="-1" role="dialog" aria-labelledby="reservationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reservationModalLabel">예약 정보 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="insertReservation.do" method="post">
                    <input type="hidden" name="user_no" value="${loginUser.userNo}">
                    <input type="hidden" name="ucSeq" value="${s.ucSeq}">
                    
                    <div class="form-group">
                        <label for="guestCount">손님 수:</label>
                        <input type="number" id="guestCount" name="number_of_guest" class="form-control" min="1" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="reservationDate">날짜:</label>
                        <input type="date" id="reservationDate" name="reservation_date" class="form-control" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="reservationTime">시간:</label>
                        <input type="time" id="reservationTime" name="reservation_time" class="form-control" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">예약 완료</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script>

    function toggleReviewForm() {
        var form = document.getElementById('reviewForm');
        if (form.style.display === "none" || form.style.display === "") {
            form.style.display = "block";
        } else {
            form.style.display = "none";
        }
    }

    // 지도 API를 삽입하는 스크립트 예시
    function initMap() {
        var mapOptions = {
            center: new naver.maps.LatLng(37.5665, 126.9780),
            zoom: 10
        };
        var map = new naver.maps.Map('map', mapOptions);
    }
    
    function insertReview() {
	    var fileInput = $('.upfile')[0];
	    var formData = new FormData();
	    
	    //별점 가져오기
	    var StringRating = $("input[name='rating']:checked").val(); 
	    var IntegerRating = parseInt(StringRating, 10); // 10진수로 변환
	    
		 console.log(StringRating);
		 console.log(IntegerRating);
	    // 파일이 선택되었는지 확인하고 FormData에 파일 추가
	    if (fileInput.files.length > 0) {
	        formData.append("upfile", fileInput.files[0]);
	    }

	    // 다른 필드들도 FormData에 추가
	    formData.append("reviewNo", 999); // reviewNo필드에 null값이 들어가는걸 방지하기 위해 임의 값
	    formData.append("mainTitle", $('.storeName').val());
	    formData.append("userNo", $('.userNo').val());
	    formData.append("ucSeq", $('.storeNo').val());
	    formData.append("rating", IntegerRating );
	    formData.append("reviewComment",  $('textarea[name="reviewComment"]').val());
	    $.ajax({
	        url: 'reviewInsert.do',
	        method: "post",
	        data: formData,
	        enctype: 'multipart/form-data',
	        processData: false,
	        contentType: false,
	        success: function(result) {
	            alert('리뷰가 작성되었습니다.');
	             window.location.href = 'selectStoreDetail.do?ucSeq='+${requestScope.s.ucSeq};
				 
	        },
	        error: function(xhr, status, error) {
	            console.error('실패:', xhr.responseText); // 자세한 오류 메시지 출력
	            console.error('상태:', status);
	            console.error('에러:', error);
	        }
	    });
	}
    
    function loadReviews(page) {
        $.ajax({
            url: 'selectStoreDetail.do',
            method: 'GET',
            data: {
                ucSeq: ${requestScope.s.ucSeq},
                cpage: page
            },
            success: function(response) {
                // 서버에서 받은 데이터로 리뷰 리스트 영역만 업데이트
                var newReviewList = $(response).find('.review-list').html();
                $('.review-list').html(newReviewList);

                // 페이징 영역도 업데이트 필요시 업데이트
                var newPagingArea = $(response).find('#pagingArea').html();
                $('#pagingArea').html(newPagingArea);
            },
            error: function() {
                console.log('리뷰 로딩 실패');
            }
        });
    }
    
    $(document).ready(function () {
    	 // "리뷰 쓰기" 링크를 클릭했을 때 리뷰 폼으로 부드럽게 스크롤
        $('#writeReviewLink').on('click', function (e) {
            e.preventDefault(); // 기본 링크 동작을 막음
            $('html, body').animate({
                scrollTop: $('#reviewToggle').offset().top - 20 // 리뷰 작성 영역 바로 위로 스크롤 (위치 조정)
            }, 800); // 스크롤 애니메이션 시간 (800ms로 부드럽게)
            toggleReviewForm(); // 스크롤 후 리뷰 작성 폼 열기
        });
    	
    	
        const $toggleGood = $('#toggle_good');
        const $toastGoodOn = $('#toastGoodOn');
        const $toastGoodOff = $('#toastGoodOff');
        const $label = $('label[for="toggle_good"]');

        // 초기 상태 설정
        if ($toggleGood.is(':checked')) {
            $label.attr('data-like-yn', 'Y');
            $toastGoodOn.hide();
            $toastGoodOff.hide();
        } else {
            $label.attr('data-like-yn', 'N');
            $toastGoodOn.hide();
            $toastGoodOff.hide();
        }

        $toggleGood.on('change', function () {
            if ($toggleGood.is(':checked')) {
                // 좋아요를 눌렀을 때
                $label.attr('data-like-yn', 'Y');
                $toastGoodOff.hide();
                $toastGoodOn.show().addClass('show');

                // AJAX 요청으로 좋아요 추가
                $.ajax({
                    url: 'insertLike.do',  // 서버에서 좋아요를 추가하는 URL
                    method: 'POST',
                    data: {
                        ucSeq: '${requestScope.s.ucSeq}'  // 해당 가게의 고유 번호
                    },
                    success: function(response) {
                        // 성공 시 처리 (예: 성공 메시지 표시)
                        var likeCountElement = $('#likeCount');
                        var currentCount = parseInt(likeCountElement.text(), 10);
                        likeCountElement.text(currentCount + 1);
                        console.log('좋아요가 추가되었습니다.');
                    },
                    error: function() {
                        console.log('좋아요 추가 실패');
                    }
                });

                setTimeout(() => {
                    $toastGoodOn.removeClass('show');
                }, 2000); // 하트 이미지가 2초 동안 표시됨
            } else {
                // 좋아요를 취소했을 때
                $label.attr('data-like-yn', 'N');
                $toastGoodOn.hide();
                $toastGoodOff.show().addClass('show');

                // AJAX 요청으로 좋아요 취소
                $.ajax({
                    url: 'deleteLike.do',  // 서버에서 좋아요를 취소하는 URL
                    method: 'POST',
                    data: {
                        ucSeq: '${requestScope.s.ucSeq}'  // 해당 가게의 고유 번호
                    },
                    success: function(response) {
                        // 성공 시 처리 (예: 성공 메시지 표시)
                        var likeCountElement = $('#likeCount');
                        var currentCount = parseInt(likeCountElement.text(), 10);
                        likeCountElement.text(currentCount - 1);
                        console.log('좋아요가 취소되었습니다.');
                    },
                    error: function() {
                        console.log('좋아요 취소 실패');
                    }
                });

                setTimeout(() => {
                    $toastGoodOff.removeClass('show');
                }, 2000); // 취소 메시지가 2초 동안 표시됨
            }
        });
        
    	 // 모달이 열릴 때 실행될 이벤트 핸들러
        $('#chatModal').on('shown.bs.modal', function () {
            // 모달이 열리면 getMessages() 함수 실행
            getMessages();
            triggerFakeMessage();
        });
        
        
    });
    
    
    function postFormSubmit(num,reviewNo){
		if(num == 1){ // 삭제하기 클릭 시
			var form = $('#editReviewForm-' + reviewNo);
			form.attr('action', 'deleteReview.do'); // 서버에 전송할 URL을 설정
			
			// 삭제 확인 메시지
	        if (confirm('정말로 삭제하시겠습니까?')) {
	            form.submit(); // 확인 후 폼 제출
	        } else {
	            console.log('삭제 취소됨');
	        }
			
		} else { // 수정하기 클릭 시 
			var form = $('#editReviewForm-' + reviewNo);
			form.attr('action','updateReview.do');
			
			if (confirm('수정하시겠습니까?')) {
	            form.submit(); // 확인 후 폼 제출
	        } else {
	            console.log('수정 취소됨');
	        }
		}
	}
    
    //***********************  채팅  ******************************
    // USER_NO 및 UC_SEQ 설정
    const userNo = ${sessionScope.loginUser.userNo};  // 현재 로그인 사용자 번호
    const ucSeq = ${requestScope.s.ucSeq}; // 식당 ID

    // WebSocket 연결 설정
    const socket = new WebSocket("ws://" + location.host +"/eats/sc/"+userNo+"-"+ucSeq);

    // WebSocket 연결 성공
    socket.onopen = function(event) {
        console.log("WebSocket 연결 성공!!!");
    };
    // WebSocket으로부터 메시지를 수신
    socket.onmessage = function(event) {
        const message = JSON.parse(event.data);
        console.log('수신!!!');
        console.log(message);
     	// 임의의 조건으로 화면에 표시하지 않음
        if (message.senderType !== "fake") { //fake메시지가 아니면 화면표시
            displayMessage(message.senderType, message.message, message.sentAt, message.userNo);  // 수신된 메시지 표시
        }
    };
    // WebSocket 연결 종료
    socket.onclose = function(event) {
        console.log("WebSocket 연결 종료");
    };
    // WebSocket 에러 처리
    socket.onerror = function(event) {
        console.error("WebSocket 에러: ", event);
    };
    
 	// 메시지 입력 필드에서 엔터 키를 누르면 메시지 전송
    $('#messageInput').keypress(function(event) {
        if (event.which === 13) {  // 'Enter' 키의 keycode는 13
            event.preventDefault(); // 기본 엔터 동작(줄바꿈) 방지
            sendMessage(); // 메시지 전송 함수 호출
        }
    });
 	
 	// 임의로 onmessage 이벤트 실행
    function triggerFakeMessage() {
 		console.log('전송');
        const message = {
                roomId: ucSeq.toString() + "-" + userNo.toString(),  // UC_SEQ와 USER_NO로 채팅방 식별
                senderType: "fake",        // 사용자 발신
                userNo: userNo,            // 발신자의 USER_NO
                ucSeq: ucSeq,
                message: "fake",            // 메시지 내용
                sentAt: "fake"  // 메시지 전송 날짜 및 시간
            };
 
            // 메시지를 서버로 전송
            socket.send(JSON.stringify(message));
    }

    // 메시지 전송 함수
    function sendMessage() {
        const input = $("#messageInput").val();
        if (input.trim() === "") {
            alert("메시지를 입력하세요");
            return;
        }
        
        const now = new Date();                  
        const year = now.getFullYear();  // 연도
        const month = String(now.getMonth() + 1).padStart(2, '0');  // 월 (0부터 시작하므로 +1), 2자리로 변환
        const day = String(now.getDate()).padStart(2, '0');  // 일, 2자리로 변환
        const hours = String(now.getHours()).padStart(2, '0');  // 시, 2자리로 변환
        const minutes = String(now.getMinutes()).padStart(2, '0');  // 분, 2자리로 변환
        const seconds = String(now.getSeconds()).padStart(2, '0');  // 초, 2자리로 변환

        // 로컬 시간으로 YYYY-MM-DD HH:MM:SS 형식 만들기
        const formattedDateTime = `\${year}-\${month}-\${day} \${hours}:\${minutes}:\${seconds}`;
        
        // 서버로 보낼 메시지 객체
        const message = {
            roomId: ucSeq.toString() + "-" + userNo.toString(),  // UC_SEQ와 USER_NO로 채팅방 식별
            senderType: "user",        // 사용자 발신
            userNo: userNo,            // 발신자의 USER_NO
            ucSeq: ucSeq,
            message: input,            // 메시지 내용
            sentAt: formattedDateTime  // 메시지 전송 날짜 및 시간
        };

        // 메시지를 서버로 전송
        socket.send(JSON.stringify(message));

        // 입력 필드를 비우기
        document.getElementById("messageInput").value = "";
    }
    
 	// 날짜 구분을 위한 변수 저장
    let lastDate = '';

    // 메시지를 화면에 표시하는 함수
    function displayMessage(senderType, message, sentAt ,userNo) {
        let msg = '';
        const currentDate = sentAt.split(' ')[0]; // YYYY-MM-DD 형식에서 날짜 부분만 추출
        const time = formatTime(sentAt.split(' ')[1]);
        
        // 새로운 메시지마다 이전 메시지와 날짜를 비교하여 날짜가 달라지면 날짜 구분선을 추가
        if (lastDate !== currentDate) {
            msg += `<div class="date-separator"><strong>\${formatDate(currentDate)}</strong></div>`;
            lastDate = currentDate; // 마지막 메시지 날짜 업데이트
        }
        //채팅정보에  senderType이 'user'이면 내가보낸영역
        if (senderType == 'user') {
        	msg += `<div class="chat-message sent">
				<span class="message-time-left">\${time}</span> <!-- 시간 왼쪽 -->
				<span class="message-bubble">\${ message }</span>
			</div>`;
        } else {
        	msg += `<div class="chat-message received">
				<span class="sender">${data.USR_NM}</span>
				<span class="message-bubble">\${message}</span>
				<span class="message-time-right">\${time}</span> <!-- 시간 오른쪽 -->
			</div>`;
        }
        
        $("#chatMessages").append(msg);
     // 스크롤을 최신 메시지로 이동
        const chatMessages = document.getElementById("chatMessages");
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }
    
    
 	// 모달이 닫힐 때 실행..
    $('#chatModal').on('hidden.bs.modal', function () {
    	 if (socket) {
             socket.close();
         }
    	
    	// 메시지 영역을 비우기
        $('#chatMessages').empty();  // 채팅 메시지 리스트를 비움
        $('#messageInput').val('');  // 입력 필드를 비움
        
        lastDate = ''; //모달 닫으면 날짜 초기화
    });
 	
 	// 날짜 형식을 'YYYY-MM-DD'에서 'YYYY년 MM월 DD일' 형식으로 변환
	 function formatDate(dateString) {
	     const date = new Date(dateString);
	     const year = date.getFullYear(); // 연도
	     const month = date.getMonth() + 1; // 월 (0부터 시작하므로 +1)
	     const day = date.getDate(); // 일
	
	     return `\${year}년 \${month}월 \${day}일`; // 'YYYY년 MM월 DD일' 형식으로 반환
	 }
 	
 	
 	
 	// 시간을 'HH:MM' 형식에서 '오전/오후 HH:MM'으로 변환
    function formatTime(timeString) {
        const [hours, minutes] = timeString.split(':'); // HH:MM:SS 중에서 HH와 MM 추출
        const hoursInt = parseInt(hours); // 정수형으로 변환
        const period = hoursInt >= 12 ? '오후' : '오전'; // 12시 이상이면 오후, 아니면 오전
        const formattedHours = hoursInt % 12 || 12; // 12시간제로 변환 (0시는 12시로 표시)
        return `\${period} \${formattedHours}:\${minutes}`; // '오전/오후 HH:MM' 형식으로 반환
    }
    
    //이전 메시지 조회하는 함수
    function getMessages() {
    $.ajax({
        url: 'getPreviousMessages.do',  // 메시지를 가져오는 서버의 엔드포인트
        type: 'POST',                   // 요청 방식 (POST)
        dataType: 'json',               // 서버 응답을 JSON으로 기대
        data: {                         // 서버로 전송할 데이터
            roomId: ucSeq + "-" + userNo // 채팅방 ID (userNo-ucSeq)
        },
        success: function(response) {

            // 응답이 배열이면 forEach로 처리
                if (response.length > 0) {
		        response.forEach(function(message) {
		            displayMessage(message.senderType, message.message, message.sentAt, message.userNo);
		        });
    }
        },
        error: function(xhr, status, error) {
            console.error('이전 메시지를 가져오는 중 오류 발생:', status, error);
        }
    });
}

    

</script>

<!-- FontAwesome 사용을 위한 링크 추가 -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<!-- 네이버 지도 API 스크립트 추가 -->
<script>initMap();</script>

</body>
</html>

