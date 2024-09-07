<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 20px;
        }
        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .profile-header img {
            border-radius: 50%;
            width: 60px;
            height: 60px;
            margin-right: 20px;
        }
        .profile-info {
            flex-grow: 1;
        }
        .profile-info h2 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }
        .profile-info p {
            margin: 5px 0;
            color: #777;
        }
        .profile-edit {
            text-align: right;
        }
        .profile-edit a {
            text-decoration: none;
            color: #007bff;
            font-size: 14px;
        }
        .tabs {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            cursor: pointer;
        }
        .tabs div {
            text-align: center;
            color: #555;
            font-weight: bold;
            flex: 1;
            padding: 10px;
        }
        .tabs div.active {
            color: #ff6600; 
            border-bottom: 2px solid #ff6600; 
        }
        .content-section {
            display: none;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .likes, .reviews, .reservations {
            display: none;
        }
        .likes-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .likes-item img {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            margin-right: 15px;
        }
        .add-folder {
            text-align: right;
        }
        .add-folder button {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            background-color: #ff6600; 
            color: #fff;
            cursor: pointer;
        }
        .reservation, .grid-item, .review-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        .reservation img, .review-item img {
            border-radius: 8px;
            margin-right: 15px;
        }
        .reservation-details, .review-details {
            flex: 1;
        }
        .cancelArea {
            text-align: right;
        }
        .btn-orange {
            background-color: #ff6600;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
        }
        .btn-green {
            background-color: green; 
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
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
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="profile-header">
    <img src="profile-placeholder.png" alt="Profile Picture">
    <div class="profile-info">
        <h2>${sessionScope.loginUser.getUserId() }</h2>
    </div>
    <div class="profile-edit">
        <a href="#">프로필 수정</a>
    </div>
</div>

<div class="tabs">
    <div id="tab-likes" class="active">좋아요<span> (${map.COUNT_STORE_LIKE })</span></div>
    <div id="tab-reviews">리뷰<span> (${map.COUNT_REVIEW })</span></div>
    <div id="tab-reservations">예약<span> (${map.COUNT_RESERVATION })</span></div>
</div>

<div id="likes" class="content-section likes" style="display: block;">
    <h3>1개의 장소를 저장했습니다.</h3>
    <div class="likes-item">
        <img src="favorite-placeholder.png" alt="Favorite">
        <div class="likes-item-details">
            <strong>My 식신 맛집</strong>
            <p>1</p>
        </div>
    </div>
    <div class="add-folder">
        <button class="btn-orange">폴더추가 +</button>
    </div>
</div>

<div id="reviews" class="content-section reviews">
    <h3>리뷰가 없습니다.</h3>
</div>

<div id="reservations" class="content-section reservations">
    <h3>좋아요한 항목이 없습니다.</h3>
</div>

<!-- 리뷰 작성 모달 -->
<div id="my_modal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">리뷰 작성</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="reviewInsert.do" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="storeName">가게 이름</label>
                        <input type="text" class="form-control storeName" name="storeName" value="" readonly>
                        <input type="hidden" name="ucSeq" class="storeNo" value="">
                        <input type="hidden" name="userNo" class="userNo" value="">
                    </div>
                    <div class="form-group">
                        <label for="reviewComment">리뷰 내용</label>
                        <textarea class="form-control reviewComment" name="reviewComment" rows="4"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="upfile">이미지 업로드</label>
                        <input type="file" class="form-control-file upfile" name="upfile">
                    </div>
                    <div class="form-group">
                        <label>별점</label>
                        <div class="star-rating space-x-4 mx-auto">
                            <input type="radio" id="5-stars" class="rating" name="rating" value="5"/>
                            <label for="5-stars" class="star pr-4">★</label>
                            <input type="radio" id="4-stars" class="rating" name="rating" value="4"/>
                            <label for="4-stars" class="star">★</label>
                            <input type="radio" id="3-stars" class="rating" name="rating" value="3"/>
                            <label for="3-stars" class="star">★</label>
                            <input type="radio" id="2-stars" class="rating" name="rating" value="2"/>
                            <label for="2-stars" class="star">★</label>
                            <input type="radio" id="1-star" class="rating" name="rating" value="1" />
                            <label for="1-star" class="star">★</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-orange" onclick="insertReview()">작성</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </form>
        </div>
    </div>
</div>


<c:forEach items="${requestScope.reviewList}" var="r">
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

<script>
function showSection(section) {
    $('#likes, #reviews, #reservations').hide();
    $('#tab-likes, #tab-reviews, #tab-reservations').removeClass('active');
    $('#' + section).show();
    $('#tab-' + section).addClass('active');
}

function insertReview() {
    var fileInput = $('.upfile')[0];
    var formData = new FormData();

    if (fileInput.files.length > 0) {
        formData.append("upfile", fileInput.files[0]);
    }
    formData.append("reviewNo", 999);
    formData.append("mainTitle", $('.storeName').val());
    formData.append("userNo", $('.userNo').val());
    formData.append("ucSeq", $('.storeNo').val());
    formData.append("rating", $('.rating:checked').val());
    formData.append("reviewComment", $('.reviewComment').val());

    $.ajax({
        url: 'reviewInsert.do',
        method: "post",
        data: formData,
        enctype: 'multipart/form-data',
        processData: false,
        contentType: false,
        success: function(result) {
            alert('리뷰가 작성되었습니다.');
            window.location.href = 'myPage.do';
        },
        error: function() {
            console.log('실패');
        }
    });
}

function postFormSubmit(num,reviewNo){
	if(num == 1){ // 삭제하기 클릭 시
		 	var form = $('#editReviewForm-' + reviewNo);
	        
	        // 삭제 확인 메시지
	        if (confirm('정말로 삭제하시겠습니까?')) {
	        	var formData = form.serialize(); // 폼 데이터를 직렬화하여 문자열로 얻음
			    var additionalData = $.param({ reloadPath: "myPage.do" }); // 추가 데이터 문자열로 변환
			    var combinedData = formData + '&' + additionalData; // 문자열을 병합

			    $.ajax({
			        url: 'deleteReview.do', // 폼의 action 속성을 사용
			        type: 'POST',
			        data: combinedData, // 병합된 데이터를 전송
			        success: function(response) {
			            console.log('삭제 성공:', response);
			            window.location.reload(); // 현재 페이지 새로고침
			        },
			        error: function(xhr, status, error) {
			            console.error('삭제 실패:', error);
			            alert('삭제 중 오류가 발생했습니다. 다시 시도해주세요.');
			        }
			    });
	        } else {
	            console.log('삭제 취소됨');
	        }
		
	} else { // 수정하기 클릭 시 
		
		var form = $('#editReviewForm-' + reviewNo);
	
		if (confirm('수정하시겠습니까?')) {
		    var formData = form.serialize(); // 폼 데이터를 직렬화하여 문자열로 얻음
		    var additionalData = $.param({ reloadPath: "myPage.do" }); // 추가 데이터 문자열로 변환
		    var combinedData = formData + '&' + additionalData; // 문자열을 병합

		    $.ajax({
		        url: 'updateReview.do', // 폼의 action 속성을 사용
		        type: 'POST',
		        data: combinedData, // 병합된 데이터를 전송
		        success: function(response) {
		            console.log('수정 성공:', response);
		            window.location.reload(); // 현재 페이지 새로고침
		        },
		        error: function(xhr, status, error) {
		            console.error('수정 실패:', error);
		            alert('수정 중 오류가 발생했습니다. 다시 시도해주세요.');
		        }
		    });
		}else {
            console.log('수정 취소됨');
        }
	}
}

$(document).ready(function () {
    loadLikes();

    function loadLikes() {
        showSection('likes');

        $.ajax({
            url: 'selectLikeList.do',
            method: 'GET',
            success: function (response) {
                var likeHtml = '';

                response.forEach(function (item) {
                    likeHtml +=
                        '<div class="grid-item">' +
                        '<input type="hidden" class="ucSeq" name="ucSeq" value="' + item.ucSeq + '"/>' +
                        '<img src="' + item.mainImgThumb + '" alt="식당 사진" width="200" height="150">' +
                        '<div class="reservation-details">' +
                        '<h3>' + item.mainTitle + '</h3>' +
                        '<p>주소: ' + item.addr1 + '</p>' +
                        '<p>매장 번호: ' + item.cntctTel + '</p>' +
                        '</div>' +
                        '<div class="bookmark"><img class="like" alt="' + item.ucSeq + '" src="resources/images/heart.png" width="20" height="20"></div>' +
                        '</div>';
                });

                $('#likes').html(likeHtml);
            },
            error: function () {
                alert('즐겨찾기 데이터를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }

    $('#likes').on('click', '.like', function (event) {
        event.stopPropagation();
        var clickedElement = $(this);
        var ucSeq = $(this).closest('.grid-item').find('.ucSeq').val();

        var confirmMessage = '좋아요를 취소하시겠습니까?';
        if (confirm(confirmMessage)) {
            $.ajax({
                url: 'deleteLike.do',
                method: 'POST',
                data: { ucSeq: ucSeq },
                success: function(response) {
                    if (response === 'success') {
                        window.location.href = 'myPage.do';
                    } else {
                        console.log('실패');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('AJAX 요청이 실패했습니다:', error);
                }
            });
        }
    });

    $(document).on('click', '.grid-item', function() {
        var ucSeq = $(this).find('input[name="ucSeq"]').val();
        location.href = "selectStoreDetail.do?ucSeq=" + ucSeq;
    });

    var userNo = "${loginUser.userNo}";

    $('#tab-likes').on('click', function () {
        loadLikes();
    });

    $('#tab-reviews').on('click', function () {
        showSection('reviews');
        $.ajax({
            url: 'myReviews.do',
            method: 'GET',
            success: function (response) {
                let reviewHtml = '';

                response.forEach(function (r) {
                    reviewHtml +=
                        '<div class="review-item" style="display: flex; align-items: flex-start; margin-bottom: 20px; padding: 10px; background-color: #fff; border-radius: 8px; box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);">' +
                            '<div style="flex: 1; margin-right: 10px;">' +
                                '<p><strong>' + r.userId + '</strong></p>' +
                                '<p class="rating" style="color: #ff6600;">' +
                                    generateStars(r.rating) + ' (' + r.rating + ')' +
                                '</p>' +
                                '<p>' + r.reviewComment + '</p>' +
                                '<p>' + r.reviewCreateDate + '</p>' +
                            '</div>' +
                            (r.changeName ? 
                                '<div style="flex: 1; max-width: 200px;">' +
                                    '<img src="' + r.changeName + '" alt="Review Image" style="max-width: 100%; height: auto; border: 1px solid #ccc; border-radius: 5px;" />' +
                                '</div>' 
                            : '') +
                            (r.userNo === ${loginUser.userNo} ? 
                                '<div class="edit-icon" style="position: absolute; top: 10px; right: 30px; cursor: pointer;">' +
                                    '<img src="resources/images/pencil.png" alt="Edit" style="width: 80px; height: 30px;" data-toggle="modal" data-target="#editReviewModal-' + r.reviewNo + '" />' +
                                '</div>' 
                            : '') +
                        '</div>';
                });

                $('#reviews').html(reviewHtml);
            },
            error: function () {
                alert('리뷰 데이터를 불러오는 중 오류가 발생했습니다.');
            }
        });
    });

    function generateStars(rating) {
        let stars = '';
        for (let i = 1; i <= 5; i++) {
            stars += i <= rating ? '★' : '☆';
        }
        return stars;
    }

    $('#tab-reservations').on('click', function () {
        showSection('reservations');

        $.ajax({
            url: 'selectReservation.do',
            method: 'GET',
            data: { userNo: userNo },
            success: function (response) {
                var reservationHtml = '';
                var currentDate = new Date();

                response.forEach(function (item) {
                    var reservationDateTime = item.reservation_date + ' ' + item.reservation_time;
                    var reservationDate = new Date(reservationDateTime);

                    var buttonHtml = '';
                    if (reservationDate.getTime() < currentDate.getTime()) {
                        buttonHtml = '<button type="button" class="btn-green" onclick="modal(\'my_modal\', \'' + item.mainTitle + '\',' + item.ucSeq + ',' + item.user_no + ');" data-toggle="modal" data-target="#my_modal">리뷰 작성</button>';
                    } else {
                        buttonHtml = '<button class="btn-orange" onclick="cancelReservation(' + item.reservation_no + ')">예약 취소</button>';
                    }

                    reservationHtml +=
                        '<div class="reservation">' +
                        '<img src="' + item.mainImgThumb + '" alt="식당 사진" width="200" height="150">' +
                        '<div class="reservation-details">' +
                        '<h3>' + item.mainTitle + '</h3>' +
                        '<p>예약 일시: ' + item.reservation_date + ' - ' + item.reservation_time + '</p>' +
                        '<p>매장 번호: ' + item.cntctTel + '</p>' +
                        '<p>인원 수: ' + item.number_of_guest + ' 명</p>' +
                        '</div>' +
                        '<div class="cancelArea">' + buttonHtml + '</div>' +
                        '</div>';
                });

                $('#reservations').html(reservationHtml);
            },
            error: function () {
                alert('예약 데이터를 불러오는 중 오류가 발생했습니다.');
            }
        });
    });
});
</script>

</body>
</html>
