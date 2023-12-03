package kr.spring.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.spring.entity.Member;
import kr.spring.entity.MemberUser;
import kr.spring.mapper.MemberMapper;

public class MemberUserDetailsService implements UserDetailsService{
	// Spring Security에서 Mapper를 사용하기 위한 연결 클래스 -> Service
	
	
	@Autowired
	private MemberMapper mapper;
	
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// loadUserByUsername : 유저 네임(아이디)을 통해서 유저 정보를 가져온다
		// 아이디(username)를 기준으로 로그인 정보를 가져오는 메소드
		// 내부적으로 보이지는 않지만 스프링 시큐리티가
		// 해당 아이디를 가진 계정을 가져오고
		// 암호화된 비밀번호 비교까지 해서 로그인을 체크하는 메소드
		
		// 로그인 처리하기 : 내부에서 자체적으로 로그인 기능 수행
		// 알아서 이미 Spring Security가 로그인기능을 다 끝마친 상태
		// 이제 개발자는 진짜로 중간에 비밀번호를 알 수 있는 방법이 없다
		Member mvo = mapper.login(username);
		// Spring Security 내부 보안 규정상 우리가 직접만든 클래스 객체(vo)는
		// 규정상 바로 담을 수 없음
		// 내가 원하는 vo를 담을 수 있게 변환해주는 User class가 필요함
		
		if(mvo != null) {
			// 해당 사용자가 존재 : 로그인 성공
			return new MemberUser(mvo);
			// mvo를 변환해줄 담아줄 클래스
			// SPRING Security Context holder에 접근 -> Security Context 안에 회원정보 저장
		}else {
			// 해당 사용자 없음 : 로그인 실패
			throw new UsernameNotFoundException("user with username" + username + "does not exist.");
			// -> 이 문구를 띄우겠다
		}
				
	}
	

}
