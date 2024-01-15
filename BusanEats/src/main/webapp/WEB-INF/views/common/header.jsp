<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        html, body {
            max-width: 1000px;
            margin: 0 auto; /* 화면 중앙 정렬을 위해 auto로 설정 */
            font-family: Arial, sans-serif;
        }

        header {
            background-color: white;
            color: white;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .search-bar {
            flex: 1;
            margin: 0 10px;
        }

        .login-signup {
            display: flex;
            gap: 10px;
        }

        .login-signup a {
            color: black;
            text-decoration: none;
        }

        .login-signup a:hover {
            color: red; /* 변경하고 싶은 색상으로 설정 */
        }

        /* 검색창 스타일 */
        .search {
            position: relative;
            width: 300px;
            display: flex;
            align-items: center;
        }

        .search input {
            width: 100%;
            border: 1px solid #bbb;
            border-radius: 8px;
            padding: 10px 35px 10px 12px; /* 오른쪽 패딩 조절하여 이미지 공간 확보 */
            font-size: 14px;
        }

        .search img {
            position: absolute;
            width: 17px;
            top: 50%;
            right: 15px; /* 우측 여백 조절 */
            margin-top: -8.5px; /* 이미지를 세로 가운데 정렬 */
        }
    </style>
    <title>Header Example</title>
</head>
<body>

<header>
    <div class="logo"><img src="resources/images/mainlogo.PNG" width="220" height="50"></div>
    <div class="search">
        <input type="text" placeholder="검색어 입력">
        <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
    </div>
    <div class="login-signup">
        <a href="#">Login</a>
        <a href="joinEnrollForm">Signup</a>
    </div>
</header>

<!-- Your page content goes here -->

</body>
</html>
