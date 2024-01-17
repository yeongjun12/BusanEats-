<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
</head>
	<style>
	 @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap');
 * {
            font-family: 'Noto Sans KR', sans-serif;
        }

        

    	    #loginArea {
            margin: auto;
            width: 300px;
            background-color: #EEEFF1;
            border-radius: 5px;
            text-align: center;
            padding: 20px;
        	}

        #area > input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border-radius: 5px;
            border: none;
        }

        .in {
            margin-bottom: 10px;
        }

        #btn {
            background-color: #1BBC9B;
            margin-bottom: 30px;
            color: white;
        }

        #loginArea > a {
            text-decoration: none;
            color: #9B9B9B;
            font-size: 12px;
        }
    </style>

<body>
 <jsp:include page="../common/header.jsp" />
    <div id="loginArea">
        <form id="area" action="login.do" method="post">
            <input type="text" placeholder="아이디" class="in" name="userId">
            <input type="password" placeholder="비밀번호" class="in" name="userPwd">
            <input type="submit" id="btn" value="로그인"><br>
        </form>
        <a href="#none">비밀번호를 잊어버리셨나요?</a>
    </div>
</body>


</html>