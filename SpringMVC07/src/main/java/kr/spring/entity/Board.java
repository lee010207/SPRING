package kr.spring.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
@Data
@NoArgsConstructor     // 꼭 있어야 되는 생성자 : 기본 생성자 -> 컨트롤러로 요청할 떄 vo로 묶어줌
@AllArgsConstructor    // 없어도 됨
@ToString
public class Board {
	private int idx;
	private String memId;
	private String title;
	private String content;
	private String writer;
	private Date indate;
	private int count;
	
	private int boardGroup;
	private int boardSequence;
	private int boardLevel;
	private int boardAvailable;
}
