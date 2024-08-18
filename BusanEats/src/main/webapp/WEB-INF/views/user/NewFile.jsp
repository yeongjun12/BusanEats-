<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>매장 추천</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px 0;
        }
        .title {
            font-size: 1.2em;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .recommendation-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }
        .recommendation-item {
            background-color: white;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: calc(50% - 7.5px);
            box-sizing: border-box;
            display: flex;
            padding: 10px;
            align-items: flex-start;
        }
        .recommendation-item img {
            border-radius: 5px;
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 10px;
        }
        .recommendation-content {
            flex: 1;
        }
        .recommendation-title {
            font-size: 1.2em;
            font-weight: bold;
            margin: 5px 0;
            color: #e67e22;
        }
        .recommendation-location {
            font-size: 0.9em;
            color: #888;
            margin-bottom: 10px;
        }
        .recommendation-menu {
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        .recommendation-info {
            font-size: 0.8em;
            color: #888;
            display: flex;
            align-items: center;
        }
        .recommendation-info span {
            margin-right: 15px;
            display: flex;
            align-items: center;
        }
        .recommendation-info span::before {
            content: '👁️';
            margin-right: 5px;
        }
        .recommendation-info span:nth-child(2)::before {
            content: '⭐';
        }
        .recommendation-info span:nth-child(3)::before {
            content: '📞';
        }
        .page-indicator {
            text-align: center;
            margin-top: 15px;
        }
        .page-indicator span {
            display: inline-block;
            width: 8px;
            height: 8px;
            margin: 0 3px;
            background-color: #ccc;
            border-radius: 50%;
        }
        .page-indicator span.active {
            background-color: #e67e22;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="title">당신을 위한 이 지역 HOT 매장추천</div>
        <div class="recommendation-grid">

            <!-- Recommendation 1 -->
            <div class="recommendation-item">
                <img src="image1.jpg" alt="미 피아체">
                <div class="recommendation-content">
                    <div class="recommendation-title">4.0 미 피아체</div>
                    <div class="recommendation-location">청담동</div>
                    <div class="recommendation-menu">인기 메뉴<br>런치 코스, 디너 코스</div>
                    <div class="recommendation-info">
                        <span>35742</span>
                        <span>99</span>
                        <span>164</span>
                    </div>
                </div>
            </div>

            <!-- Recommendation 2 -->
            <div class="recommendation-item">
                <img src="image2.jpg" alt="파볼라">
                <div class="recommendation-content">
                    <div class="recommendation-title">4.9 파볼라</div>
                    <div class="recommendation-location">청담동</div>
                    <div class="recommendation-menu">인기 메뉴<br>Cold 구수계, Cold 부채편</div>
                    <div class="recommendation-info">
                        <span>15733</span>
                        <span>24</span>
                        <span>26</span>
                    </div>
                </div>
            </div>

            <!-- Recommendation 3 -->
            <div class="recommendation-item">
                <img src="image3.jpg" alt="권숙수">
                <div class="recommendation-content">
                    <div class="recommendation-title">4.2 권숙수</div>
                    <div class="recommendation-location">청담동</div>
                    <div class="recommendation-menu">인기 메뉴<br>점심미식상, 저녁미식상</div>
                    <div class="recommendation-info">
                        <span>41448</span>
                        <span>130</span>
                        <span>166</span>
                    </div>
                </div>
            </div>

            <!-- Recommendation 4 -->
            <div class="recommendation-item">
                <img src="image4.jpg" alt="울프강 스테이크하우스">
                <div class="recommendation-content">
                    <div class="recommendation-title">4.2 울프강 스테이크하우스</div>
                    <div class="recommendation-location">청담동</div>
                    <div class="recommendation-menu">인기 메뉴<br>포터하우스스테이크</div>
                    <div class="recommendation-info">
                        <span>38852</span>
                        <span>62</span>
                        <span>80</span>
                    </div>
                </div>
            </div>

            <!-- Recommendation 5 -->
            <div class="recommendation-item">
                <img src="image5.jpg" alt="뜨락">
                <div class="recommendation-content">
                    <div class="recommendation-title">3.9 뜨락</div>
                    <div class="recommendation-location">청담동</div>
                    <div class="recommendation-menu">인기 메뉴<br>(1인)코스</div>
                    <div class="recommendation-info">
                        <span>27876</span>
                        <span>34</span>
                        <span>124</span>
                    </div>
                </div>
            </div>

            <!-- Recommendation 6 -->
            <div class="recommendation-item">
                <img src="image6.jpg" alt="코지마">
                <div class="recommendation-content">
                    <div class="recommendation-title">4.0 코지마</div>
                    <div class="recommendation-location">청담동</div>
                    <div class="recommendation-menu">인기 메뉴<br>Dineer Counter, Dinner Room</div>
                    <div class="recommendation-info">
                        <span>26880</span>
                        <span>51</span>
                        <span>38</span>
                    </div>
                </div>
            </div>

        </div>

        <div class="page-indicator">
            <span class="active"></span>
            <span></span>
            <span></span>
        </div>
    </div>

</body>
</html>
    