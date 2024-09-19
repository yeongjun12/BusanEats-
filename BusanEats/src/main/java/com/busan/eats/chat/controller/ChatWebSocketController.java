package com.busan.eats.chat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.busan.eats.chat.model.service.ChatServiceImpl;
import com.busan.eats.chat.model.vo.ChatVO;
import com.google.gson.Gson;

@Controller
public class ChatWebSocketController {
	
	 @Autowired
	 private ChatServiceImpl chatService;

	@RequestMapping("chat")
	public String chat() {
		return "chat";
	}
	
	
	@ResponseBody
    @PostMapping("getPreviousMessages.do")
    public String getMessages(@RequestParam("roomId") String roomId) {
        
		System.out.println("이전메시지 : " + roomId);
		
		List<ChatVO> list = chatService.getMessages(roomId);
		System.out.println("리스트입니다!!!" + list);
		return new Gson().toJson(list);
    }
}
