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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.entity.Board;
import kr.spring.mapper.BoardMapper;

@RequestMapping("/board")
// 이걸 달아주면 앞으로 URL에 /board 가 붙으면서 통일성이 생김
@RestController
// Rest 방식의 컨트롤러 import 및 annotation
public class BoardRestController {
	
	@Autowired    // Mapper에 객체가 알아서 생김
	private BoardMapper mapper;
	
	
	@GetMapping("/all")
	public List<Board> boardList() {
		// @ResponseBody : 비동기방식의 메서드임을 명시 꼭!
		System.out.println("게시글 전체목록");
		List<Board> list =  mapper.getLists();
		
		return list;
	}
	
	@PostMapping("/new")
	public void boardInsert(Board board) {
		// @ResponseBody : 비동기 방식으로 작동해라 명시
		// return 받을 게 없으니까 void
		System.out.println("게시글 작성 기능수행");
		mapper.boardInsert(board);
	}
	
	@GetMapping("/{idx}")
	public Board boardContent(@PathVariable("idx") int idx) {
		// PathVariable 방식으로 URL에 붙어서 온 idx를 매개변수로 사용!
		// PathVariable : 경로에 값을 붙여서 보내는 방식
		// URL을 간단하게 만들어서 접근방식을 쉽게 하기 위해서
		
		Board vo = mapper.boardContent(idx);
		// 매개변수로 받은 idx값의 하나의 게시글 정보를 Board 타입(vo)으로 받아서 리턴
		// ajax로 vo를 JSON 형태로 받아서 .content(key값으로 데이터 접근) 내용 데이터만 사용할거임
		return vo;
	}
	
	@DeleteMapping("/{idx}")
	public void boardDelete(@PathVariable("idx") int idx) {
		System.out.println("게시글 삭제");
		//System.out.println(idx);
		mapper.boardDelete(idx);
	}
	
	@PutMapping("/update")
	public void boardUpdate(@RequestBody Board board) {
		// @RequestBody : put 방식으로 비동기방식으로 요청할떄만
		// vo형태로 묶을 때만 @RequestBody
		// -> JSON문자열로 넘어오기 때문에 Board 형태로 바꿔주는 작업 필요
		System.out.println("게시글 수정");
		mapper.boardUpdate(board);
	}
	
	@PutMapping("/count/{idx}")
	public void boardCount(@PathVariable("idx") int idx) {
		System.out.println("조회수 기능");
		mapper.boardCount(idx);
	}
	
	
	
	
}
