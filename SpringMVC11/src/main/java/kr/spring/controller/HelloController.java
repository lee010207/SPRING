package kr.spring.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController    // 비동기 방식
public class HelloController {
	// 테스트용 컨트롤러
	
	@RequestMapping("/hello")
	public String hello() {
		return "Hello! Spring!";
	}
	
}
