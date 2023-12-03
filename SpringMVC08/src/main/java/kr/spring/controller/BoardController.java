package kr.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.PageMaker;
import kr.spring.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	@Autowired
	private BoardService service;
	// BoardService -> 인터페이스
	// 실제 기능 구현해놓은 곳은 BoardServiceImpl
	// BoardService를 Autowired 해놓으면 자동으로 자식객체인 BoardServiceImpl로 업캐스팅됨
	// 여러가지 데이터 타입을 하나로 받을 수 있게 하기 위해 부모 객체로 받아줌(다형성을 위해)
	
	@GetMapping("/list")
	public String boardList(Model model , Criteria cri) {
		// 게시판 페이지 열기(게시글 전체 목록 조회)
		List<Board> list = service.getList(cri);
		// 자동으로 업캐스팅돼서 자식 타입의 getList() (부모타입의 추상메서드가 아니라)가 실행됨
		
		// 페이징 처리에 필요한 PageMaker객체 생성
		PageMaker pageMaker = new PageMaker();
		// Criteria cri는 계속해서 유지되어야 하는 정보 : 매개변수로 받아줌
		// PageMaker는 필요할 때마다 그때그때 쓸거라 밑에서 객체를 따로 생성 (페이지 계산 기능)
		pageMaker.setCri(cri);
		// pageMaker가 페이징 기법을 하기 위한 cri객체 전달
		pageMaker.setTotalCount(service.totalCount());
		// 페이징 기법을 하려면 전체 게시글 개수를 알려줘야 함
		
		model.addAttribute("list",list);
		model.addAttribute("pageMaker", pageMaker);
		return "board/list";
	}
	
	@GetMapping("/register")
	public String register() {
		return "board/reg";
	}
	
	@PostMapping("/register")
	public String register(Board vo, RedirectAttributes rttr) {
		// System.out.println(vo.toString());
		service.register(vo);
		// System.out.println(vo.toString());
		rttr.addFlashAttribute("result", vo.getIdx());
		
		// board/list 화면으로만 가는 게 아니라 전체목록조회 요청도 해야함
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public String get(@RequestParam ("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		// @ModelAttribute("cri") Criteria cri : model.addAttribute(cri)와 같은 역할
		// -> 받아온 매개변수를 model안에 넣어주는 것 까지 해주는 방식
		Board vo = service.get(idx);
		
		model.addAttribute("vo", vo);
		return "board/get";
	}
	
	@GetMapping("/modify")
	public String modify(@RequestParam("idx") int idx, Model model,  @ModelAttribute("cri") Criteria cri) {
		// 게시글 수정 : 수정해야될 게시글 정보를 가지고 modify.jsp로 이동
		// get.jsp에서 수정하면 modify.jsp로 올 때 Criteria정보(form태그 안에 있는)를 넘겨주는 거
		Board vo = service.get(idx);
		model.addAttribute("vo", vo);
		return "board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(Board vo, Criteria cri, RedirectAttributes rttr) {
		service.modify(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		return "redirect:/board/list";
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("idx") int idx, Criteria cri, RedirectAttributes rttr) {
		service.remove(idx);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		return "redirect:/board/list";
	}
	
	@GetMapping("/reply")
	public String reply(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		// 답글 페이지로 이동(원본글 정보 가지고)
	
		Board vo = service.get(idx);
		// 답글을 달고 싶은 게시글(원본글)의 정보 가져오기
		model.addAttribute("vo", vo);
		return "board/reply";
	}
	
	@PostMapping("/reply")
	public String reply(Board vo, Criteria cri, RedirectAttributes rttr) {
		service.reply(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		return "redirect:/board/list";
	}
}
