package kr.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.mapper.BookMapper;

@Controller
public class BookController {
	@Autowired
	private BookMapper mapper;
	
	@RequestMapping("/")         // 요청 url로 들어왔을 떄 아리 기능을 수행하겠다
	public String home() {
		System.out.println("홈기능");
		
		// redirect방식 : url주소값을 뒤에 붙여줘서 해당 페이지로 이동하게 해줌
		return "main";
	}
}
