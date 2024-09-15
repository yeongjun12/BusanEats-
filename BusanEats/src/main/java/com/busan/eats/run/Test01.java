package com.busan.eats.run;

import org.springframework.mail.javamail.JavaMailSenderImpl;

//직접 도구를 생성해서 이메일을 보내는 예제
// 필요한 의존성 목록
// -spring-context-support
// - java mail api



public class Test01 {
	
	public static JavaMailSenderImpl sender; //얘는 전송도구
	public static void main(String[] args) {
		
		JavaMailSenderImpl impl = new JavaMailSenderImpl(); 
		
		// - 계정설정
		impl.setHost("smtp.gmail.com");
		impl.setPort(587);
		impl.setUsername("dldudwns4065@gmail.com");
		impl.setPassword("dudwns3252!");

	}

}
