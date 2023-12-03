package kr.spring.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;
import lombok.ToString;

@Entity // Board VO가 Database Table로 만들때 설정
@Data
@ToString
public class Board {  // VO <--- ORM ---> TABLE
	
	@Id   // PK 의미
	@GeneratedValue(strategy = GenerationType.IDENTITY)   // 1씩 증가하기 : AUTO_INCRIMENT
	private Long idx;   // 게시글 고유번호 ( 호환을 위해서 long 형으로)
	// Long : 정수 표현방식 중 가장 긴 데이터 타입
	
	private String title;
	
	@Column(length = 2000)      // 길이지정 -> 길이지정 따로 안할 때는 길이 255
	private String content;
	
	@Column(updatable = false)      // 수정할 때 작성자는 안바꿔 주겠다
	private String writer;
	
	@Column(insertable = false, updatable = false, columnDefinition = "datetime default now()")
	// 삽입, 수정은 안되고 기본값으로 현재시간을 넣어주겠다
	private Date indate;    
	
	@Column(insertable = false, updatable = false, columnDefinition = "int default 0")
	private Long count;
	
	
	
	
}
