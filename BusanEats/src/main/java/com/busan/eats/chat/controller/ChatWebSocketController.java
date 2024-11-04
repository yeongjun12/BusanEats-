package com.busan.eats.chat.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
			
			chat.setUserNo((Integer) null); //mapper에서 null과 비교하기 위해
			
			ArrayList<ChatVO> list = chatService.checkNewChat(chat);
			
			for(ChatVO li : list) {
				int userNo = li.getUserNo(); //받아온 userNo로 이름 조회해옴
				String userNm = chatService.selectUserName(userNo);
				li.setUserName(userNm);
			}
			
			return new Gson().toJson(list);
				
		}
	
	@ResponseBody
	@PostMapping("readMessage.do" )
	public String readMessage(ChatVO chat) {
		
		int result = chatService.readMessage(chat);
		
		return (result > 0 ) ? "success" : "fail" ;
	}
	
	
	@RequestMapping("chatOpen.do")
	public String chatOpen() {
		return "chat/chatList";
	}
	
	//채팅목록 불러오기
	@ResponseBody
	@RequestMapping(value="getChatList.do", produces="application/json; charset=UTF-8")
	public String chatList(ChatVO chat ,HttpSession session) {
		
		
		chat.setUcSeq((Integer) null); //mapper에서 null과 비교하기 위해
		
		
		ArrayList<ChatVO> list = chatService.checkNewChat(chat);
		
		
		System.out.println("리스트 : " + list);
		System.out.println("controller " + chat);
		
		
		return new Gson().toJson(list);
	}
	
	//채팅방
	@RequestMapping("chatRoom.do")
	public String chatRoom(int userNo, String roomId,int ucSeq, String mainTitle, Model model) {
		
		model.addAttribute("userNo", userNo);
		model.addAttribute("roomId", roomId);
		model.addAttribute("ucSeq", ucSeq);
		model.addAttribute("mainTitle", mainTitle);
		
		return "chat/chatRoom";
	}
}
