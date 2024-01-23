<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    body {
      margin: 0;
      font-family: 'Arial', sans-serif;
    }

    .container {
      display: flex;
    }

    .sidebar {
      width: 250px; /* Increased width */
      background-color: #2c3e50; /* Darker color */
      padding: 20px;
      box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
      color: #ecf0f1; /* Light text color */
    }

    .sidebar ul {
      list-style: none;
      padding: 0;
    }

    .sidebar li {
      margin-bottom: 10px;
    }

    .sidebar a {
      text-decoration: none;
      color: #ecf0f1;
      font-weight: bold;
      display: block;
      padding: 10px;
      border-radius: 5px;
      transition: background-color 0.3s;
    }

    .sidebar a:hover {
      background-color: #34495e; /* Darker color on hover */
    }

    .content {
      padding: 20px;
      flex: 1;
    }

    /* Additional styling for better aesthetics */
    h2 {
      color: #2c3e50;
    }

    p {
      color: #34495e;
    }
  </style>
</head>
<body>
<div class="container">
    <div class="sidebar">
      <ul>
        <li><a href="#" onclick="showTab('profile')">프로필</a></li>
        <li><a href="#" onclick="showTab('settings')">설정</a></li>
        <li><a href="#" onclick="showTab('orders')">주문 내역</a></li>
      </ul>
    </div>
    <div class="content" id="profileTab">
      <!-- 프로필 내용 -->
      <h2>프로필</h2>
      <p>사용자의 프로필 정보를 여기에 표시합니다.</p>
    </div>
    <div class="content" id="settingsTab" style="display:none;">
      <!-- 설정 내용 -->
      <h2>설정</h2>
      <p>사용자의 설정을 여기에 표시합니다.</p>
    </div>
    <div class="content" id="ordersTab" style="display:none;">
      <!-- 주문 내역 내용 -->
      <h2>주문 내역</h2>
      <p>사용자의 주문 내역을 여기에 표시합니다.</p>
    </div>
  </div>
  <script src="script.js"></script>

  <script>
    function showTab(tabId) {
      // 모든 탭 숨기기
      document.querySelectorAll('.content').forEach(tab => {
        tab.style.display = 'none';
      });

      // 선택한 탭 보이기
      document.getElementById(tabId + 'Tab').style.display = 'block';
    }
  </script>

</body>
</html>