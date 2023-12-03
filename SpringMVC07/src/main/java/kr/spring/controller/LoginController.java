package kr.spring.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.entity.Member;
import kr.spring.service.BoardService;

@Controller
@RequestMapping("/login/*")
public class LoginController {
	
	@Autowired
	private BoardService service;
	
	@RequestMapping("/loginProcess")
	public String login(Member vo, HttpSession session) {
		Member m = service.login(vo);
		if(m != null) {
			session.setAttribute("m",m);
		}
		
		return "redirect:/board/list";
	}
	
	@RequestMapping("/logoutProcess")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/board/list";
	}
}
