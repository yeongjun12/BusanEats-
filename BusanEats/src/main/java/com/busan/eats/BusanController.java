package com.busan.eats;

import java.io.BufferedReader;

import com.busan.eats.store.model.vo.Store;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.json.simple.parser.JSONParser;

@Controller
public class BusanController {
	
	private static  final String servicekey ="uuL8xSqf7od9a7%2B%2F1Fts9hH2mbbvNeiz5H2D07LX3LbzPcZQoPAm9KHpI3wNDqR28GjIK2paejjt6gFZVMZPmg%3D%3D";
	
	
	
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
        url += "&numOfRows=" + 5;
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
                    String mainTitle = (String) foodItem.get("MAIN_TITLE");
                    String gugunName = (String) foodItem.get("GUGUN_NM");

                    // Add logic to store the data in the database
                    System.out.println(foodItem);
                    System.out.println(mainTitle);
                    System.out.println(gugunName);
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
