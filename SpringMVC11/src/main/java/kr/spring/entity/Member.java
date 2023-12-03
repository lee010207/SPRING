package kr.spring.entity;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;

import javax.persistence.Id;

import lombok.Data;
import lombok.ToString;

@Entity
@Data
@ToString
public class Member {
	
	@Id
	private String username;
	// Spring Security에서는 id가 아니라 username으로 지정(스프링시큐리티가 쓰는 이름을 맞춰줘야함)
	
	private String password;
	// 비밀번호도 지정된 이름으로 해야함(반드시 꼭 맞춰줘야함)
	
	@Enumerated(EnumType.STRING)   // @Enumerated : 열거형(권한이 여러개이기 때문에)
	private Role role; // 권한정보
		
	private String name;
	
	private boolean ebled; // 계정 활성화 or 비활성화 부분
	
	
}
