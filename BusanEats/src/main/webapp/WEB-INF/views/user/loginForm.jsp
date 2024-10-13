<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- Bootstrap CSS 추가 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
    <title>로그인</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap');
        * {
            font-family: 'Noto Sans KR', sans-serif;
        }

        body {
            background-color: #f9f9f9;
            margin: 0;
        }

        .header-container {
            width: 100%;
        }

        .login-container-wrapper {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: calc(100vh - 100px);
            padding-top: 30px;
        }

        .login-container {
            width: 400px;
            background-color: #fff;
            padding: 40px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 20px;
            font-size: 18px;
            color: #333;
            font-weight: bold;
        }

        .form-group {
            text-align: left;
        }

        .form-control {
            border-radius: 5px;
            height: 45px;
            font-size: 14px;
        }

        .btn-primary {
            background-color: #ff6600;
            border: none;
            height: 45px;
            font-size: 16px;
            margin-top: 10px;
            width: 100%;
        }

        .btn-primary:hover {
            background-color: #e65c00;
        }

        .forgot-link, .register-link {
            display: inline-block;
            margin-top: 15px;
            color: #666;
            font-size: 13px;
            text-decoration: none;
        }

        .forgot-link:hover, .register-link:hover {
            text-decoration: underline;
        }

        .social-login {
            margin-top: 20px;
        }

        .social-login p {
            margin-bottom: 10px;
            font-size: 14px;
            color: #333;
            font-weight: bold;
        }

        .nav-tabs {
            border-bottom: 2px solid #ddd;
        }

        .nav-tabs .nav-item {
            margin-bottom: 0;
        }

        .nav-tabs .nav-link {
            border: none;
            border-bottom: 2px solid transparent;
            padding: 10px 20px;
            font-weight: bold;
            color: #666;
        }

        .nav-tabs .nav-link.active {
            color: #ff6600;
            border-bottom-color: #ff6600;
        }
    </style>
</head>
<body>

    <!-- Header Section -->
    <div class="header-container">
        <jsp:include page="../common/header.jsp" />
    </div>
    <!-- Login Form Section -->
    <div class="login-container-wrapper">
        <div class="login-container">

            <!-- 탭 메뉴 추가 -->
            <ul class="nav nav-tabs" id="loginTabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="user-login-tab" data-toggle="tab" href="#user-login" role="tab" aria-controls="user-login" aria-selected="true">일반 사용자 로그인</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="restaurant-login-tab" data-toggle="tab" href="#restaurant-login" role="tab" aria-controls="restaurant-login" aria-selected="false">식당 로그인</a>
                </li>
            </ul>

            <!-- 탭 내용 -->
            <div class="tab-content" id="loginTabContent">
                <!-- 일반 사용자 로그인 -->
                <div class="tab-pane fade show active" id="user-login" role="tabpanel" aria-labelledby="user-login-tab">
                    <form action="login.do" method="post">
                        <div class="form-group">
                            <c:choose>
                                <c:when test="${not empty cookie.saveId}">
                                    <input type="text" class="form-control mb-2" value="${cookie.saveId.value}" placeholder="아이디" name="userId">
                                    <input type="password" class="form-control mb-2" placeholder="비밀번호" name="userPwd">
                                    <div class="form-check text-left mb-3">
                                        <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe" checked>
                                        <label class="form-check-label" for="rememberMe">아이디 저장</label>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <input type="text" class="form-control mb-2" placeholder="아이디" name="userId">
                                    <input type="password" class="form-control mb-2" placeholder="비밀번호" name="userPwd">
                                    <div class="form-check text-left mb-3">
                                        <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                                        <label class="form-check-label" for="rememberMe">아이디 저장</label>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <button type="submit" class="btn btn-primary">로그인</button>
                        </div>
                    </form>
                    <a href="joinEnrollForm" class="register-link">회원가입 하기</a>
                </div>

                <!-- 식당 사용자 로그인 -->
                <div class="tab-pane fade" id="restaurant-login" role="tabpanel" aria-labelledby="restaurant-login-tab">
                    <form action="storeLogin.do" method="post">
                        <div class="form-group">
                            <input type="text" class="form-control mb-2" placeholder="식당 아이디" name="storeId">
                            <input type="password" class="form-control mb-2" placeholder="비밀번호" name="storePwd">
                        </div>
                        <button type="submit" class="btn btn-primary">식당 로그인</button>
                    </form>
                    <a href="restaurantJoinForm" class="register-link">식당 회원가입 하기</a>
                </div>
            </div>

            <!-- SNS 로그인 -->
            <div class="social-login">
                <p>사용하시는 SNS계정으로 로그인 하세요.</p>
                <div id="naverIdLogin"></div>
                <div class="col-lg-12 text-center mt-3">
                    <a href="javascript:kakaoLogin()"><img src="resources/images/kakao_login.png" style="width: 300px"></a>
                </div>
            </div>

        </div>
    </div>

</body>

<!-- 네아로 SDK -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<!-- 카카오 로그인 -->
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<!-- Bootstrap JS 및 jQuery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
    Kakao.init('baf41b3f50d76c8b3aefa017c15e2227');
    function kakaoLogin() {
        Kakao.Auth.login({
            success: function (response) {
                Kakao.API.request({
                    url: '/v2/user/me',
                    success: function (response) {
                        sendUserInfoToServer(response);
                    },
                    fail: function (error) {
                        console.log(JSON.stringify(error));
                    },
                })
            },
            fail: function (error) {
                alert(JSON.stringify(error));
            },
        })
    }

    function sendUserInfoToServer(userInfo) {
        const userId = userInfo.id;
        const userName = userInfo.properties.nickname;
        $.ajax({
            type: 'POST',
            url: 'kakaoLogin',
            data: { userId, userName },
            success: function (response) {
                if (response === "success") {
                    window.location.href = 'main';
                }
            },
            error: function (error) {
                alert("서버 로그인 처리 실패: " + JSON.stringify(error));
            }
        });
    }

    var naverLogin = new naver.LoginWithNaverId({
        clientId: "jYGV_3JxrOJKOChrhITh",
        callbackUrl: "http://localhost:8051/eats/callback",
        isPopup: false,
        loginButton: {color: "green", type: 4, height: 63}
    });
    naverLogin.init();
</script>
</html>
