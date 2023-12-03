package kr.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	// get 방식이든 post 방식이든 / URL로 요청이 들어오면 메인페이지(index.jsp)으로 연결시켜줄거임
	// @RequestMapping : get, post 둘다 가능
	@RequestMapping("/")
	public String main() {
		return "index";
	}
}
