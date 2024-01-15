<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>

	<h1>부산의 맛집</h1>
	
	<button onclick="taste(1);">맛집은 어디인가?</button>
	<input placeholder="페이지 번호 입력" id="num" /> <button onclick="taste(2);">이동</button>
	

	<table id="result1" border="1" align="center">
		<thead>
		<tr>
			<th>가게명</th>
			<th>구/군</th>
			<th>상세내용</th>
			<th>전화번호</th>
			<th>주소</th>
			<th width=150px;>썸네일이미지</th>
			<th>위치보기</th>
		</tr>
		</thead>
		<tbody>
		</tbody>
	
	
	</table>
	
	<script>
	
		function taste(num){
			if(num != 1){
				
				num = $('#num').val();
			}
			
			$.ajax({
				url : 'taste.do',
				data : { page : num },
				success : data => {
					
					//console.log(data.getFoodKr.item);
					
					const itemArr = data.getFoodKr.item;
					
					let value = '';
					for(let i in itemArr){
						//console.log(itemArr[i]);
						
						let item = itemArr[i];
						console.log(item);
						let thumb = item.MAIN_IMG_THUMB;
						
						value += '<tr>' 
							  + '<td>' + item.MAIN_TITLE+'</td>'
							  + '<td>' + item.GUGUN_NM+'</td>'
							  + '<td>' + item.ITEMCNTNTS+'</td>'
							  + '<td>' + item.CNTCT_TEL+'</td>'
							  + '<td>' + item.ADDR1+'</td>'
							  + '<td><img src="' +thumb + '"/></td>'
							  + '<td><form action="map.do" method="POST"><button> 어디있지?</button>'
							  +'<input type="hidden" name="LAT" value="' +item.LAT + '"/>'
							  +'<input type="hidden" name="LNG" value="' +item.LNG + '"/>'
							  + '</form></td>'
							  +'</td>'
							  +'</tr>'
						
					}
					
					$('#result1 tbody').html(value);
					$('#num').val(num);
					
					
					
				},
				error : () =>{
					
					console.log('요건조금...');
				}
				
			});
			
			
		}
	
	
	
	
	
	</script>
	
</body>
</html>