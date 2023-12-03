package kr.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		return "redirect:/boardList.do";
	}
	
	@RequestMapping("/boardList.do") 
	public String boardList(Model model) {
		System.out.println("게시판목록보기");
		
		// 전체 게시글 조회 기능
		// 확장성을 위해 List형태로 : 부모가 같아서(List형) LinkedList로 변경되어도 자동으로 업캐스팅됨
		List<Board> list = mapper.getLists();
		
		// MODEL에 저장 : 딱 한 페이지에서만 가져와서 쓰는(저장해놓는) 공간
		// model이나 request 같은 공간에, 특정 영역 안에 데이터를 넣어놓고 가져다 쓰는 방식 : 객체바인딩(동적바인딩) 
		// -> 매개변수로 받아주고 필요할때 사용
		model.addAttribute("list", list);
		
		return "boardList";       
		// viewName만 리턴함
		//  /WEB-INF/views/boardList.jsp : 이렇게 원래 주소값을 완성해주는 역할(view Resolver)
		// => 포워드 방식(forward)
	}
	
	@RequestMapping("/boardForm.do")
	public String boardForm() {
		// 단순 페이지 이동 ( 요청이 들어오면 boardForm.jsp로 이동!)
		System.out.println("글쓰기 페이지 이동");
		return "boardForm";
	}
	
	@RequestMapping("/boardInsert.do")
	public String boardInsert(Board board) {
		// board 객체 안에 내가 입력한 데이터가 묶여서 알아서 들어감
		// 조건 
		// 1. input태그 name값 = Board(dto, vo) 의 필드명 
		// 2. 기본생성자가 있어야 됨
		// 3. getter, setter 있어야 됨
		
		System.out.println("게시글 등록");
		mapper.boardInsert(board);
		
		// "redirect:/boardList.do" 이렇게 해야 DB연결해서 게시글 목록 불러와진 페이지(boardList.jsp)가 보임
		return "redirect:/boardList.do";
	}
	
	@RequestMapping("/boardContent.do/{idx}")
	public String boardContent(@PathVariable("idx") int idx , Model model) {
		// 요청 시 사용자가 클릭한 게시글의 고유번호(idx)가 넘어옴
		// @RequestParam("idx") int idx : 요청할 때 넘어온 파라미터 idx를 int idx에 담아서 매개변수로 쓰겠다
		// int idx = request.getParameter("idx")
		
		// vo에 데이터가 담기면 model에 잠깐 저장시킬거니까
		// model 쓰기 위해 Model 매개변수로 가져오기
		
		System.out.println("게시글 상세보기");
		Board vo = mapper.boardContent(idx);
		// 하나의 Board 객체는 하나의 게시글을 의미하니까 mapper가 sql구문 실행해서 오면 Board에 담음
		mapper.boardCount(idx);
		
		model.addAttribute("vo", vo);
		
		return "boardContent";
	}   
	
	@RequestMapping("/boardDelete.do/{idx}")
	public String boardDelete(@PathVariable("idx") int idx) {
		System.out.println("게시글 삭제");
		
		mapper.boardDelete(idx);
		return "redirect:/boardList.do";
	}
	
	@RequestMapping("/boardUpdateForm.do/{idx}")
	public String boardUpdateForm(@PathVariable("idx") int idx, Model model){
		// 수정하는 화면으로 이동하는 메서드 : 이동만! 기능X!
		// 수정하고 싶은 게시글(고유번호: idx)의 정보를 가지고 수정 화면으로 이동
		// -> 게시글 상세보기 기능(boardContent() 이용
		
		//@RequestParam("idx") 없어도 int idx만 써도 됌
		// -> name값과 변수명이 동일해야함!!
		
		System.out.println("게시글 수정 화면 이동");
		
		Board vo = mapper.boardContent(idx);
		model.addAttribute("vo", vo);
		
		return "boardUpdateForm";
	}
	
	@RequestMapping("/boardUpdate.do")
	public String boardUpdate(Board board) {
		System.out.println("게시글 수정");
		mapper.boardUpdate(board);
		
		return "redirect:/boardList.do";
	}
	
}
