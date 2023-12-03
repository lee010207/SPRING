package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data   // getter, setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Auth {
	// 권한정보를 저장할 클래스
	private int no; // 일련번호
	private String memId;  // 회원 아이디
	private String auth;   // 회원권한(ROLE_USER : 일반유저 , ROLE_MANAGER : 매니저 , ROLE_ADMIN : 관리자)

	
}
