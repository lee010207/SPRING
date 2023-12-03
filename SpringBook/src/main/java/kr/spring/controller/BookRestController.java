package kr.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.entity.BookVO;
import kr.spring.mapper.BookMapper;

@RequestMapping("/book")
@RestController
public class BookRestController {
	
	@Autowired
	private BookMapper mapper;
	
	@GetMapping("/all")
	public List<BookVO> boardList() {
		// @ResponseBody : 비동기방식의 메서드임을 명시 꼭!
		System.out.println("전체목록");
		List<BookVO> list =  mapper.getLists();
		
		return list;
	}
	
	@PostMapping("/new")
	public void bookInsert(BookVO book) {
		// @ResponseBody : 비동기 방식으로 작동해라 명시
		// return 받을 게 없으니까 void
		System.out.println("등록");
		mapper.bookInsert(book);
	}
	
	@DeleteMapping("/{num}")
	public void bookDelete(@PathVariable("num") int num) {
		System.out.println("삭제");
		//System.out.println(num);
		mapper.bookDelete(num);
	}
	
	@GetMapping("/{num}")
	public BookVO getBook(@PathVariable("num") int num) {
		// PathVariable 방식으로 URL에 붙어서 온 idx를 매개변수로 사용!
		// PathVariable : 경로에 값을 붙여서 보내는 방식
		// URL을 간단하게 만들어서 접근방식을 쉽게 하기 위해서
		
		BookVO vo = mapper.getBook(num);
		// 매개변수로 받은 idx값의 하나의 게시글 정보를 Board 타입(vo)으로 받아서 리턴
		// ajax로 vo를 JSON 형태로 받아서 .content(key값으로 데이터 접근) 내용 데이터만 사용할거임
		return vo;
	}
	
	@PutMapping("/update")
	public void boardUpdate(@RequestBody BookVO book) {
		// @RequestBody : put 방식으로 비동기방식으로 요청할떄만
		// vo형태로 묶을 때만 @RequestBody
		// -> JSON문자열로 넘어오기 때문에 Board 형태로 바꿔주는 작업 필요
		System.out.println("수정");
		mapper.bookUpdate(book);
		
	}
}
