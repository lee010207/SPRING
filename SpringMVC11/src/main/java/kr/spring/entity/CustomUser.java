package kr.spring.entity;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

@Data
public class CustomUser extends User{
	// 우리가 만든 회원정보 -> Member를 
	// Spring Context Holder에 저장하기 위해서는
	// User형태로 변환해서 넣어줘야함(바로 Member 형태로 못넣어)
	// 그걸 해주는 클래스가 바로 CustomUser 클래스

	private Member member;
	
	public CustomUser(Member member) {
		super(member.getUsername(), member.getPassword(), 
				AuthorityUtils.createAuthorityList("ROLE_"+ member.getRole().toString()));
				// 권한을 배열 형태로 넣어줄건데 매개변수에 문자열이 들어가니까
				// toString()으로 형변환
		
		this.member = member;
	}
	
	
}
