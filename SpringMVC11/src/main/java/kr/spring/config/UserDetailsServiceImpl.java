package kr.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.spring.entity.CustomUser;
import kr.spring.entity.Member;
import kr.spring.repository.MemberRepository;

@Service   // Service로 작동하게 어노테이션
public class UserDetailsServiceImpl implements UserDetailsService{

	@Autowired
	private MemberRepository memberRepository; 
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// 로그인 기능 : 스프링 내부에서 로그인기능 알아서 실행하고 이쪽으로 옴
		Member member = memberRepository.findById(username).get();
		// findById(username) -> Optional 형태로 받아오니까 .get()해주면 그 안에 있는 값 가져올 수 있음
		
		if(member == null) {
			throw new UsernameNotFoundException(username + "is not exist");
			// 내부 오류 알림 작동
		}
		return new CustomUser(member);
	}

}
