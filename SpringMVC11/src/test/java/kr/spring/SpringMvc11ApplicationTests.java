package kr.spring;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.spring.entity.Member;
import kr.spring.entity.Role;
import kr.spring.repository.MemberRepository;

@SpringBootTest
class SpringMvc11ApplicationTests {
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private PasswordEncoder pwEncoder;
	// 비밀번호 암호화해주는 애
	

	@Test
	void contextLoads() {
		// 회원가입 테스트
		Member m = new Member();
		m.setUsername("monday");
		m.setPassword(pwEncoder.encode("mon123"));
		m.setName("월요일");
		m.setRole(Role.MEMBER);
		m.setEbled(true);
		System.out.println(m.toString());
		memberRepository.save(m);
	}

}
