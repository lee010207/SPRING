package kr.spring.entity;

import lombok.Data;

@Data
public class Criteria {
	// 기준이라는 뜻
	// 게시판의 기준점이 될 클래스 :페이징기법 옵션 설정
	
	// 검색기능에 필요한 변수 추가
	private String type;
	// 이름, 제목, 내용
	private String keyword;
	
	private int page;
	// 현재 페이지 번호를 저장할 변수
	
	private int perPageNum;
	// 한 페이지에 보여줄 게시글 개수
	
	// Criteria 기본 셋팅 : 생성자를 통해서 하기
	public Criteria() {
		this.page = 1;   // 기본 페이지 : 1
		this.perPageNum = 5;
	}
	
	// 현재 페이지의 게시글의 시작번호를 구하는 메소드
	// ex) 한 페이지에 10개씩 
	// 1page -> 1 ~ 10 , 2page -> 11 ~ 20 , 3page -> 21 ~ 30
	// 예외! : mySQL에서는 시작값을 0으로 인식함
	// 1page -> 0 ~ 9 , 2page -> 10 ~ 19 , 3page -> 20 ~ 29
	public int getPageStart() {
		// 몇번 페이지가 몇번부터 시작하냐를 구함
		// 3번 페이지 : (3-1)*10 = 20 -> 20부터 3번페이지가 시작함
		return (page - 1)* perPageNum;
	}
}
