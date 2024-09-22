package com.busan.eats.chat.controller;

import java.util.ArrayList;
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
        
		List<ChatVO> list = chatService.getMessages(roomId);
		return new Gson().toJson(list);
    }
	
	//store회원 채팅 조호
		@ResponseBody
		@RequestMapping(value="checkNewChat.do", produces="application/json; charset=UTF-8")
		public String checkNewChat(ChatVO chat) {
			
			ArrayList<ChatVO> list = chatService.checkNewChat(chat);
			
			
			return new Gson().toJson(list);
				
		}
	
	@ResponseBody
	@PostMapping("readMessage.do" )
	public String readMessage(ChatVO chat) {
		
		int result = chatService.readMessage(chat);
		
		return (result > 0 ) ? "success" : "fail" ;
	}
}
