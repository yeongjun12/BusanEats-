package com.busan.eats.store.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.busan.eats.chat.model.vo.ChatVO;
import com.busan.eats.common.model.PageInfo;
import com.busan.eats.common.template.Pagination;
import com.busan.eats.review.model.service.ReviewService;
import com.busan.eats.review.model.vo.Review;
import com.busan.eats.store.model.service.StoreService;
import com.busan.eats.store.model.vo.Store;
import com.busan.eats.store.model.vo.StoreUser;
import com.busan.eats.user.model.vo.User;
import com.google.gson.Gson;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

@Controller
public class StoreController {
	
	private static  final String servicekey ="uuL8xSqf7od9a7%2B%2F1Fts9hH2mbbvNeiz5H2D07LX3LbzPcZQoPAm9KHpI3wNDqR28GjIK2paejjt6gFZVMZPmg%3D%3D";
	
	@Autowired //전제조건? 빈등록을 해야 한다?
	private StoreService storeService;
	@Autowired
	private ReviewService reviewService;
	
	/*
	@ResponseBody
	@RequestMapping(value ="taste.do", produces="application/json; charset=UTF-8")
	public String busanFood(int page ) throws IOException {
		
		String url ="http://apis.data.go.kr/6260000/FoodService/getFoodKr";
			url += "?serviceKey=" + servicekey;
			url += "&numOfRows=" + 1;
			url += "&resultType=json";
			url += "&pageNo=" + page;
		
		//System.out.println(url);
			
			URL requestUrl = new URL(url);
			HttpURLConnection urlConnection = (HttpURLConnection)requestUrl.openConnection();
			urlConnection.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
			
			String responseText = br.readLine();
			
			br.close();
			urlConnection.disconnect();
			
			System.out.println(responseText);
			
			
			 
			
			return responseText;
	}*/
	
	
	
	@ResponseBody
    @RequestMapping(value = "taste.do", produces = "application/json; charset=UTF-8")
    public String busanFood(@RequestParam int page) throws IOException, org.json.simple.parser.ParseException {
		//API 요청을 위한 URL 생성
        String url = "http://apis.data.go.kr/6260000/FoodService/getFoodKr";
        url += "?serviceKey=" + servicekey;
        url += "&numOfRows=" + 1000;
        url += "&resultType=json";
        url += "&pageNo=" + page;

        
        // URL에 연결하여 데이터를 읽어오기 위한 HTTPURLConnection 설정
        URL requestUrl = new URL(url);
        HttpURLConnection urlConnection = (HttpURLConnection) requestUrl.openConnection();
        urlConnection.setRequestMethod("GET");

        try (BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()))) {
            StringBuilder responseTextBuilder = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                responseTextBuilder.append(line);
            }
            String responseText = responseTextBuilder.toString();

            // JSON 응답을 파싱
            JSONParser parser = new JSONParser();
            try {
                JSONObject jsonResponse = (JSONObject) parser.parse(responseText);
                JSONObject getFoodKr = (JSONObject) jsonResponse.get("getFoodKr");
                JSONArray itemList = (JSONArray) getFoodKr.get("item");

                // 추출한 데이터를 처리하고 데이터베이스에 저장
                for (Object item : itemList) {
                    JSONObject foodItem = (JSONObject) item;
                    String mainTitle = foodItem.get("MAIN_TITLE").toString();
                    String gugunName = (String) foodItem.get("GUGUN_NM");
                     int no =   Integer.valueOf(foodItem.get("UC_SEQ").toString());
                     
                    
                   
                     // JSON 객체를 Store 객체로 변환
                    Store s = new Store(
                    		  Integer.valueOf(foodItem.get("UC_SEQ").toString())
                    		,foodItem.get("MAIN_TITLE").toString()
                    		,foodItem.get("GUGUN_NM").toString()
                    		,foodItem.get("ADDR1").toString()
                    		,foodItem.get("CNTCT_TEL").toString()
                    		,foodItem.get("USAGE_DAY_WEEK_AND_TIME").toString()
                    		,foodItem.get("RPRSNTV_MENU").toString()
                    		,foodItem.get("MAIN_IMG_NORMAL").toString()
                    		,foodItem.get("MAIN_IMG_THUMB").toString()
                    		,foodItem.get("ITEMCNTNTS").toString()
                    		,Double.parseDouble(foodItem.get("LAT").toString())
                    		,Double.parseDouble(foodItem.get("LNG").toString())
                    		,0
                    		);
                   int result =  storeService.saveToDataBase(s);
                   if(result>0) {
                	   System.out.println("성공");
                   } else {
                	   System.out.println("실패");
                   }
                    
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }

            return responseText;
        } finally {
            urlConnection.disconnect();
        }
    }
	
	
	
	@RequestMapping("map.do")
	public String map(String LAT,String LNG, Model model) {
		
		model.addAttribute("LAT",LAT);
		model.addAttribute("LNG",LNG);
		
		return "map";
	}
	
	
	@RequestMapping("storeList.do")
	public String storeList() {
		
		return "store/storeList";
	}
	
	@PostMapping("storeLogin.do")
	public ModelAndView storeLogin(ModelAndView mv, HttpSession session,StoreUser s_user) {
		
		StoreUser storeUser = storeService.storeLogin(s_user);
		
		if(storeUser != null) {
			
			Store loginStore = storeService.selectStoreDetail(storeUser.getUcSeq());
			session.setAttribute("loginStore",loginStore);
		}
		
		mv.setViewName("storeMain");
		return mv;
	}
	
	
	@RequestMapping("selectStoreList.do")
	public ModelAndView selectStoreList(ModelAndView mv, String gugunNm , HttpSession session) {
		
		ArrayList<Store> list = storeService.selectStoreList(gugunNm);
		
	    // Store의 ucSeq와 평균 평점을 매핑하기 위한 Map을 생성합니다.
	    Map<Integer, Double> averageRatingMap = new HashMap<>();
	    Map<Integer, Integer> reviewCountMap = new HashMap<>();
	    Map<Integer, Integer> likeCountMap = new HashMap<>();

		
	    // 각 Store 객체에 대해 평균 평점을 조회
		for(Store store : list) {
			int ucSeq = store.getUcSeq();
			double average_rating = storeService.selectAvgRating(ucSeq); //리스트에서 뽑은 ucSeq로 평점 평균 조회
			int reviewCount = storeService.selectReviewCount(ucSeq);
			int likeCount = storeService.selectLikeCount(ucSeq);
			averageRatingMap.put(ucSeq,average_rating); // key:식당번호, value: 리뷰 평균으로 담음
			reviewCountMap.put(ucSeq,reviewCount);
			likeCountMap.put(ucSeq,likeCount);
		}
		
	    if(session.getAttribute("loginUser") != null) {
	    	int userNo = ((User)session.getAttribute("loginUser")).getUserNo(); //먼저 현재 userNo로 좋아요 누른 식당 번호를 조회해와서 화면에 뿌려줌.
	    	
	    	if(storeService.selectLikeList(userNo) != null) {
	    		
	    		mv.addObject("likeNoList",storeService.selectLikeList(userNo));
	    	}
	    }
		
		mv.addObject("list",list)
		.addObject("averageRatingMap",averageRatingMap)
		.addObject("reviewCountMap",reviewCountMap)
		.addObject("likeCountMap",likeCountMap)
		.addObject("gugunNm",gugunNm)
		.setViewName("store/storeList");
		
		return mv;
		
	}
	
	/*
	@RequestMapping("detail.do")
	public String detail(){
		return "store/storeDetailView";
		
	}
	*/
	
	
	@GetMapping("search.do")
    public ModelAndView searchStore(String query, ModelAndView mv, HttpSession session) {
		 // Store의 ucSeq와 평균 평점을 매핑하기 위한 Map을 생성합니다.
	    Map<Integer, Double> averageRatingMap = new HashMap<>();
	    Map<Integer, Integer> reviewCountMap = new HashMap<>();
	    Map<Integer, Integer> likeCountMap = new HashMap<>();
	    ArrayList<Store> list = storeService.searchStore(query);
		
	    // 각 Store 객체에 대해 평균 평점을 조회
		for(Store store : list) {
			int ucSeq = store.getUcSeq();
			double average_rating = storeService.selectAvgRating(ucSeq); //리스트에서 뽑은 ucSeq로 평점 평균 조회
			int reviewCount = storeService.selectReviewCount(ucSeq);
			int likeCount = storeService.selectLikeCount(ucSeq);
			averageRatingMap.put(ucSeq,average_rating); // key:식당번호, value: 리뷰 평균으로 담음
			reviewCountMap.put(ucSeq,reviewCount);
			likeCountMap.put(ucSeq,likeCount);
		}
		
		 if(session.getAttribute("loginUser") != null) {
		    	int userNo = ((User)session.getAttribute("loginUser")).getUserNo(); //먼저 현재 userNo로 좋아요 누른 식당 번호를 조회해와서 화면에 뿌려줌.
		    	
		    	if(storeService.selectLikeList(userNo) != null) {
		    		
		    		mv.addObject("likeNoList",storeService.selectLikeList(userNo));
		    	}
		    	
		    }
		
		
        mv.addObject("searchResults", storeService.searchStore(query))
        .addObject("query",query)
        .addObject("averageRatingMap",averageRatingMap)
		.addObject("reviewCountMap",reviewCountMap)
		.addObject("likeCountMap",likeCountMap)
		.setViewName("store/searchStore");
        
        return mv; 
    }
	
	@RequestMapping("selectStoreDetail.do")
	public ModelAndView selectStoreDetail(
	        @RequestParam(value="ucSeq") int ucSeq, 
	        @RequestParam(value="cpage", defaultValue="1") int currentPage, 
	        HttpSession session,
	        HttpServletResponse response,
	        HttpServletRequest request) {
	    
	    ModelAndView mv = new ModelAndView();

	    // 로그인한 사용자가 있을 경우
	    if(session.getAttribute("loginUser") != null) {
	        int userNo = ((User)session.getAttribute("loginUser")).getUserNo(); // 현재 userNo로 좋아요 누른 식당 번호를 조회
	        List<Integer> likeNoList = storeService.selectLikeList(userNo);
	        
	        // 사용자가 좋아요 누른 식당 목록을 가져와서 모델에 추가
	        if (likeNoList != null) {
	            mv.addObject("likeNoList", likeNoList);
	        }
	    }

	    // 조회수 증가 성공 시
	    if(storeService.increaseCount(ucSeq) > 0) {
	        Store s = storeService.selectStoreDetail(ucSeq); // 식당 정보 조회
	        PageInfo pi = Pagination.getPageInfo(reviewService.reviewCount(ucSeq), currentPage, 10, 5);
	        List<Review> reviewList = reviewService.selectReview(ucSeq, pi);
	        int likeCount = storeService.selectStoreLike(ucSeq);
	        double average_rating = storeService.selectAvgRating(ucSeq);
	        
	        // 최근 본 식당을 쿠키에 추가
	        Cookie recentStoreCookie = new Cookie("recentStores", getUpdatedRecentStoresCookieValue(ucSeq, request));
	        recentStoreCookie.setMaxAge(1 * 24 * 60 * 60); // 쿠키 만료 시간 설정: 1일
	        recentStoreCookie.setPath("/"); // 쿠키 경로 설정
	        response.addCookie(recentStoreCookie);
	        
	        // 최근 본 식당 쿠키 값을 모델에 추가
	        List<String> recentStoresList = parseRecentStoresCookieValue(request);
	        mv.addObject("recentStoresList", recentStoresList);

	        // ModelAndView에 객체와 뷰 이름을 설정
	        mv.addObject("s", s)
	          .addObject("pi", pi)
	          .addObject("reviewList", reviewList)
	          .addObject("likeCount", likeCount)
	          .addObject("average_rating", average_rating)
	          .setViewName("store/storeDetailView");
	    } else {
	        mv.addObject("errorMsg", "게시글 조회 실패").setViewName("common/errorPage");
	    }

	    return mv;
	}

	// 최근 본 식당 쿠키 값을 업데이트하는 메서드
	private String getUpdatedRecentStoresCookieValue(int ucSeq, HttpServletRequest request) {
	    Cookie[] cookies = request.getCookies();
	    LinkedHashSet<String> recentStoresSet = new LinkedHashSet<>();
	    
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("recentStores".equals(cookie.getName())) {
	                String cookieValue = cookie.getValue();
	                if (cookieValue != null) {
	                    // 기존 쿠키 값을 읽어서 업데이트
	                    recentStoresSet.addAll(Arrays.asList(cookieValue.split("\\|")));
	                }
	                break;
	            }
	        }
	    }
	    
	    // 기존에 있으면 제거하고 현재 식당을 추가
	    recentStoresSet.remove(String.valueOf(ucSeq));
	    recentStoresSet.add(String.valueOf(ucSeq));
	    
	    // 5개를 초과하면 가장 오래된 것을 제거
	    if (recentStoresSet.size() > 5) {
	        Iterator<String> iterator = recentStoresSet.iterator();
	        while (iterator.hasNext() && recentStoresSet.size() > 5) {
	            iterator.next();
	            iterator.remove();
	        }
	    }
	    
	    // 최종 쿠키 값 생성 (구분 문자를 콤마 대신 파이프 문자 | 사용)
	    return String.join("|", recentStoresSet);
	}

	// 쿠키 값을 리스트로 변환하는 메서드
	private List<String> parseRecentStoresCookieValue(HttpServletRequest request) {
	    Cookie[] cookies = request.getCookies();
	    List<String> recentStoresList = new ArrayList<>();
	    
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("recentStores".equals(cookie.getName())) {
	                String cookieValue = cookie.getValue();
	                if (cookieValue != null && !cookieValue.isEmpty()) {
	                    recentStoresList = Arrays.asList(cookieValue.split("\\|"));
	                }
	                break;
	            }
	        }
	    }
	    
	    return recentStoresList;
	}
	
	//TOP5
	@ResponseBody
	@RequestMapping(value="selectRegionTop5.do", produces="application/json; charset=UTF-8")
	public String selectRegionTop5(String region) {
		
		ArrayList<Store> top5List = storeService.selectRegionTop5(region);
		
		return new Gson().toJson(top5List);
	}
	
	//store회원 채팅 조호
	@ResponseBody
	@RequestMapping(value="checkNewChat.do", produces="application/json; charset=UTF-8")
	public String checkNewChat(int ucSeq) {
		ArrayList<ChatVO> list = storeService.checkNewChat(ucSeq);
		return new Gson().toJson(list);
			
	}
	

}
