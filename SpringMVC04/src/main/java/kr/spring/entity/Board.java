package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor       //기본생성자(매개변수없는거)
@ToString
public class Board {
	private int idx;         // 번호
	private String memId;    // 회원아이디(회원제 게시판용)
	private String title;    // 제목
	private String content;  // 내용
	private String writer;   // 작성자
	private String indate;   // 작성일
	private int count;       // 조회수
	
	
	
	
}
