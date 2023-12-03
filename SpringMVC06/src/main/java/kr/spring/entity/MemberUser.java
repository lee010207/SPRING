package kr.spring.entity;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

@Data
public class MemberUser extends User{
	// Spring Security에 Member 객체를 담을 수 있게 해주는 클래스
	//  User를 상속받아야 함
	// Member 를 필드로 가지고 있어야 함
	
	private Member member;
	
	public MemberUser(String username, String password, Collection<? extends GrantedAuthority> authorities ) {
		// Collection<? extends GrantedAuthority> authorities : 권한(배열 형태)을 배열 형태로 받아오겠다
		
		super(username, password, authorities);
		// 부모 메서드(User) 사용하겠다 : super
		// MemberUser 객체 생성 시 아이디, 비밀번호, 권한을 입력받음
		// 실제로 우리는 이 생성자(메소드)를 사용하지 않음 : 이외에 회원정보가 많음(이메일, 나이 등)
		// why? : 추상메소드이기 때문에 무조건(강제성) 구현해야함
		// ID, PW , 권한 3개만 쓸거면 이 메서드 써도 나쁘지 않음
		
	}
	
	
	// 실제로 우리가 사용할 생성자
	public MemberUser(Member mvo) {
		// User 클래스의 생성자를 사용해서 구현할거임
		// 생성자에 아이디, 비밀번호, 권한을 넣어줌
		super(mvo.getMemId(),mvo.getMemPw(),
				/* User 클래스의 생성자에 사용하는 권한정보는 Collection<SimpleGrantedAuthority> 형태로 넣어줘야 함 */
				mvo.getAuthList().stream()   /* 바이트로 변경 */
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
				/* List<Auth> -> Collection 안에 들어갈 수 있게 변경해줌
				/* 배열하나하나에 들어있는 권한정보를 가져와서 Collection형태로 바꿔주는 코드(람다식) */
				.collect(Collectors.toList())
				/* 최종 컬렉션 리스트로 바꿔줌 */				
				);
		this.member = mvo;
	}
	
}
