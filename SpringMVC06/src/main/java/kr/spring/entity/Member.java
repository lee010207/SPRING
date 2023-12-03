package kr.spring.entity;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor     // 기본생성자(DefaultConstructor)
// lombok API 사용해서 getter, setter, 생성자(기본생성자도) 만들어주기
public class Member {
	// DB 컬럼명 = 필드명 (대소문자 구분X) 
	//  => Mybatis에서 자동으로 가져와서 vo 객체로 만들어줌
	private int memIdx;
	private String memId;
	private String memPw;
	private String memName;
	private int memAge;
	private String memGender;
	private String memEmail;
	private String memProfile;
	
	// 자신의 권한 정보를 저장할 변수 : List<Auth>
	// Why List? : 권한이 여러개가 될 수도 있기 때문
	private List<Auth> authList;
}
