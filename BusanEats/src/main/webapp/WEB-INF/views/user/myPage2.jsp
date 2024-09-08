<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원정보 변경 및 탈퇴</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
    body {
        margin: 0;
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f4f7fa;
    }
    .container {
        width: 100%;
        max-width: 800px;
        margin: 50px auto;
        background: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }
    .tabs {
        display: flex;
        border-bottom: 1px solid #e0e0e0;
        background-color: #f1f3f5;
    }
    .tab {
        flex: 1;
        text-align: center;
        padding: 15px 0;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .tab.active {
        background-color: #ffffff;
        border-bottom: 3px solid #f39c12;
        color: #f39c12;
    }
    .content {
        display: none;
        padding: 30px;
    }
    .content.active {
        display: block;
    }
    .form-group {
        margin-bottom: 20px;
    }
    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: #333;
    }
    .form-group input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        transition: border-color 0.3s;
    }
    .form-group input:focus {
        border-color: #f39c12;
        outline: none;
    }
    .form-check {
        margin-bottom: 15px;
        font-size: 14px;
    }
    .form-check input {
        margin-right: 5px;
    }
    .btn {
        padding: 12px 25px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s, box-shadow 0.3s;
    }
    .btn-save {
        background-color: #f39c12;
        color: #fff;
        box-shadow: 0 2px 5px rgba(243, 156, 18, 0.3);
    }
    .btn-save:hover {
        background-color: #e08e0b;
    }
    .btn-cancel {
        background-color: #e0e0e0;
        color: #555;
        margin-right: 10px;
    }
    .btn-cancel:hover {
        background-color: #d0d0d0;
    }
    .text-center {
        text-align: center;
    }
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <div class="tabs">
        <div class="tab active" data-tab="changeInfo">회원정보변경</div>
        <div class="tab" data-tab="withdraw">회원탈퇴</div>
    </div>
    <div id="changeInfo" class="content active">
        <h2>회원정보 변경</h2>
        <p>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 확인해주세요.</p>
        <div class="userLogin">
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요">
            </div>
            <div class="form-group">
                <label for="userPwd">비밀번호</label>
                <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력하세요">
            </div>
            <button class="btn btn-save" onclick="pwdCheck();">확인</button>
        </div>
        <form action="update.do" method="post">
            <div id="hiddenPage" style="display: none;">
                <input type="hidden" value="${loginUser.userNo }" name="userNo">
                <div class="form-group">
                    <label for="newPwd">새 비밀번호</label>
                    <input type="password" id="newPwd" name="newPwd" placeholder="새 비밀번호를 입력해주세요">
                </div>
                <div class="form-group">
                    <label for="pwdCheck">새 비밀번호 확인</label>
                    <input type="password" id="pwdCheck" name="pwdCheck" placeholder="새 비밀번호를 다시 입력해주세요">
                    <button type="button" class="btn btn-save" onclick="newPwdCheck();">비밀번호 확인</button>
                </div>
                <div class="form-group">
                    <label for="userPhone">전화번호</label>
                    <input type="text" id="userPhone" value="${loginUser.userPhone }" name="userPhone" placeholder="전화번호를 입력하세요">
                </div>
                <div class="form-group">
                    <label for="userEmail">이메일</label>
                    <input type="text" id="userEmail" value="${loginUser.userEmail }" name="userEmail" placeholder="이메일을 입력하세요">
                    <div id="checkResult" style="font-size:0.7em; display:none;"></div>
                </div>
                <div class="form-group">
                    <label for="userBirth">생년월일</label>
                    <input type="text" id="userBirth" value="${loginUser.userBirth }" name="userBirth" placeholder="생년월일을 입력하세요">
                </div>
                <div class="text-center">
                    <button type="button" class="btn btn-cancel">취소</button>
                    <button type="submit" class="btn btn-save" id="updateButton" disabled>회원정보 수정</button>
                </div>
            </div>
        </form>
    </div>

    <div id="withdraw" class="content">
    <h2>회원 탈퇴</h2>
        <div class="userLogin">
            <p>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 확인해주세요.</p>
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="userPwd">비밀번호</label>
                <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력하세요" required>
            </div>
            <button type="button" class="btn btn-save" onclick="pwdCheck();">확인</button>
        </div>
    <form action="deleteUser.do" method="post" onsubmit="return confirmDelete();">
    <input type="hidden" value="${loginUser.userNo }" name="userNo">
        <div id="deletePage" style="display: none;">
            <p>회원 탈퇴 신청 시 아래 사항을 반드시 확인해주세요.</p>
            <ul>
                <li>해당 휴대폰번호로 30일간 재가입 불가능</li>
                <li>회원정보 및 게시물 삭제</li>
            </ul>
            <div class="text-center">
                <button type="button" class="btn btn-cancel" onclick="cancelWithdrawal()">취소</button>
                <button type="submit" class="btn btn-save">탈퇴하기</button>
            </div>
        </div>
    </form>
</div>
</div>

<script>
$(document).ready(function() {
    // 탭 클릭 이벤트 핸들러 추가
    $('.tab').click(function() {
        // 모든 탭과 콘텐츠에서 active 클래스 제거
        $('.tab').removeClass('active');
        $('.content').removeClass('active');

        // 클릭된 탭과 해당하는 콘텐츠에 active 클래스 추가
        $(this).addClass('active');
        const tabId = $(this).data('tab');
        $('#' + tabId).addClass('active');
    });
});

function pwdCheck() {
    $.ajax({
        url: 'pwdCheck.do',
        data: {
            userId: $('#userId').val(),
            userPwd: $('#userPwd').val()
        },
        success: function(result) {
            if (result === 'success') {
                $('#hiddenPage').show();
                $('#deletePage').show();
                $('.userLogin').hide();
            } else {
                alert("아이디와 비밀번호를 확인해주세요.");
            }
        },
        error: function() {
            alert('비밀번호 확인에 실패했습니다.');
        }
    });
}

function newPwdCheck() {
    if ($('#newPwd').val() === $('#pwdCheck').val()) {
        $('#updateButton').prop('disabled', false);
        alert('새 비밀번호가 일치합니다.');
    }else {
        alert('새 비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
    }
}

function confirmDelete() {
	 if (confirm('정말로 탈퇴하시겠습니까?')) {
	        return true; // 폼이 제출됩니다.
	    }
	    return false; // 폼 제출이 취소됩니다.
}
</script>

</body>
</html>