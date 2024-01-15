package com.busan.eats.store.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.busan.eats.store.model.service.StoreService;
import com.busan.eats.store.model.vo.Store;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

@Controller
public class StoreController {
	
	private static  final String servicekey ="uuL8xSqf7od9a7%2B%2F1Fts9hH2mbbvNeiz5H2D07LX3LbzPcZQoPAm9KHpI3wNDqR28GjIK2paejjt6gFZVMZPmg%3D%3D";
	
	@Autowired //전제조건? 빈등록을 해야 한다?
	private StoreService storeService;
	
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
        String url = "http://apis.data.go.kr/6260000/FoodService/getFoodKr";
        url += "?serviceKey=" + servicekey;
        url += "&numOfRows=" + 1000;
        url += "&resultType=json";
        url += "&pageNo=" + page;

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

            // Parse JSON response
            JSONParser parser = new JSONParser();
            try {
                JSONObject jsonResponse = (JSONObject) parser.parse(responseText);
                JSONObject getFoodKr = (JSONObject) jsonResponse.get("getFoodKr");
                JSONArray itemList = (JSONArray) getFoodKr.get("item");

                // Process and store the extracted data in the database
                for (Object item : itemList) {
                    JSONObject foodItem = (JSONObject) item;
                    String mainTitle = foodItem.get("MAIN_TITLE").toString();
                    String gugunName = (String) foodItem.get("GUGUN_NM");
                     int no =   Integer.valueOf(foodItem.get("UC_SEQ").toString());
                     
                    
                   
                    //JSON객체를 JAVA객체로 변환
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
	

}
