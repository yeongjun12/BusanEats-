<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>
        .content {
            background-color:rgb(247, 245, 245);
            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }
    </style>
</head>
<body>

 <jsp:include page="../common/header.jsp" />
 
 <div class="content">
        <br><br>
        <div class="innerOuter">
        
            <h2>회원가입</h2>
            <br>

            <form action="insertUser" method="post" id="enroll-form">
                <div class="form-group">
                    <label for="userId">* ID : </label>						<!-- userId = setUserId(value값) -->
                    <input type="text" class="form-control" id="userId" placeholder="Please Enter ID" name="userId" required> <br>

					<div id="checkResult" style="font-size:0.7em; display:none;"></div>
					<br>
					
                    <label for="userPwd">* Password : </label>
                    <input type="password" class="form-control" id="userPwd" placeholder="Please Enter Password" name="userPwd" required> <br>

                    <label for="checkPwd">* Password Check : </label>
                    <input type="password" class="form-control" id="checkPwd" placeholder="Please Enter Password" required> <br>

                    <label for="userName">* Name : </label>
                    <input type="text" class="form-control" id="userName" placeholder="Please Enter Name" name="userName" required> <br>

					<label for="phone"> &nbsp; Phone : </label>
                    <input type="number" class="form-control" id="userPhone" placeholder="Please Enter Phone Number" name="userPhone"> <br>

                    <label for="birthDate"> &nbsp; BirthDate : </label>
                     <div class="info" id="info__birth">
					  <select class="box" id="birth-year">
					    <option disabled selected>출생 연도</option>
					  </select>
					  <select class="box" id="birth-month">
					    <option disabled selected>월</option>
					  </select>
					  <select class="box" id="birth-day">
					    <option disabled selected>일</option>
					  </select>
					</div>
                    <input type="text" id="selected-date" placeholder="선택된 날짜" name="userBirth" hidden >
                    
                    
                    
                  <label for="email"> &nbsp; Email : </label>
                    <input type="text" class="form-control" id="userEmail" placeholder="Please Enter Email" name="userEmail"> <br>
                </div> 
                
               
                
                
                <br>
                <div class="btns" align="center">
                    <button type="submit" class="btn btn-primary">회원가입</button>
                    <button type="reset" class="btn btn-danger">초기화</button>
                </div>
            </form>
        </div>
        <br><br>

    </div>

</body>

<script>
		//'출생 연도' 셀렉트 박스 option 목록 동적 생성
		const birthYearEl = document.querySelector('#birth-year')
		// option 목록 생성 여부 확인
		isYearOptionExisted = false;
		birthYearEl.addEventListener('focus', function () {
		  // year 목록 생성되지 않았을 때 (최초 클릭 시)
		  if(!isYearOptionExisted) {
		    isYearOptionExisted = true
		    for(var i = 1940; i <= 2024; i++) {
		      // option element 생성
		      const YearOption = document.createElement('option')
		      YearOption.setAttribute('value', i)
		      YearOption.innerText = i
		      // birthYearEl의 자식 요소로 추가
		      this.appendChild(YearOption);
		    }
		  }
		});
	
	
		//'월' 셀렉트 박스 option 목록 동적 생성
		const birthMonthEl = document.querySelector('#birth-month');
		let isMonthOptionExisted = false;
		
		birthMonthEl.addEventListener('focus', function () {
		// month 목록 생성되지 않았을 때 (최초 클릭 시)
		if (!isMonthOptionExisted) {
		 isMonthOptionExisted = true;
		 for (let i = 1; i <= 12; i++) {
		   const monthOption = document.createElement('option');
		   monthOption.setAttribute('value', i);
		   monthOption.innerText = i;
		   this.appendChild(monthOption);
		 }
		}
		});
		
		//'일' 셀렉트 박스 option 목록 동적 생성
		const birthDayEl = document.querySelector('#birth-day');
		let isDayOptionExisted = false;
		
		birthDayEl.addEventListener('focus', function () {
		// day 목록 생성되지 않았을 때 (최초 클릭 시)
		if (!isDayOptionExisted) {
		 isDayOptionExisted = true;
		 for (let i = 1; i <= 31; i++) {
		   const dayOption = document.createElement('option');
		   dayOption.setAttribute('value', i);
		   dayOption.innerText = i;
		   this.appendChild(dayOption);
		 }
		}
		});

	
	<!-------------------------- 선택된 년도, 월, 날짜를 hidden되어 있는 input에 넣기 ----------------------------------------------->

	
	let selectedYear = "";
	let selectedMonth = "";
	let selectedDay = "";
	
	// '출생 연도' 셀렉트 박스 변경 시
	$('#birth-year').on('change', function(){
		selectedYear =$(this).val();
		updateDateInput();
		
		console.log(selectedYear);
	});
	
	// '월' 셀렉트 박스 변경 시
	$('#birth-month').on('change', function () {
	  selectedMonth = $(this).val();
	  console.log(selectedMonth);
	  
	  updateDateInput();
	});
	
	// '일' 셀렉트 박스 변경 시
	$('#birth-day').on('change', function () {
	  selectedDay = $(this).val();
	  
	  console.log(selectedDay);
	  updateDateInput();
	});
	
	// 선택된 년, 월, 일을 표시할 input 요소
	const dateInput = $('#selected-date');
	
	// 선택된 년, 월, 일을 input에 업데이트하는 함수
	function updateDateInput() {
		
		
	  if (selectedYear != "" && selectedMonth != "" && selectedDay !="") { 
	    // 선택된 년, 월, 일을 하나의 문자열로 연결하여 input에 표시 , 세가지를 선택하지 않으면 안됨
	    dateInput.val(selectedYear + "-" + selectedMonth + "-" + selectedDay);
	  } else {
	    // 아무 값도 선택되지 않았을 때는 빈 문자열로 설정
	    dateInput.val("");
	  }
	}
	
	
	

</script>
</html>