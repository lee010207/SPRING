package kr.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.entity.Board;
import kr.spring.mapper.BoardMapper;

@Controller
// 현재클래스를 핸들러맵핑이 찾기 위해 컨트롤러로 등록하는 부분
public class BoardController {
	
	@Autowired    // Mapper에 객체가 알아서 생김
	private BoardMapper mapper;
	// MyBatis한테 JDBC를 실행하게 요청하는 객체
	// Controller와 MyBatis(기능 수행)를 연결해주는 매개체
	
	@RequestMapping("/")         // 요청 url로 들어왔을 떄 아리 기능을 수행하겠다
	public String home() {
		System.out.println("홈기능");
		
		// redirect방식 : url주소값을 뒤에 붙여줘서 해당 페이지로 이동하게 해줌
		return "main";
	}
	

}
