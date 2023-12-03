package kr.spring.entity;

import org.springframework.beans.factory.annotation.Autowired;

import lombok.Data;

@Data
public class PageMaker {
	// 페이지 처리 클래스
	
	@Autowired
	private Criteria cri;
	// 게시판 페이징의 설정 정보를 가지고 있는 Criteria를 가지고 있어야 함
	// => 현재 몇 페이지인지, 정보와 게시글을 몇개씩 볼건지
	//    현재 페이지에서 몇번 글부터 시작해야 하는 정보를 가지고 있는 객체(Criteria)가 있어야
	//    페이징 처리가 가능함
	
	private int totalCount;
	// 총 게시글의 수
	
	private int startPage;
	// 시작페이지 번호 
	// ex) 페이지를 10개씩 보여준다면
	// 1, 10 ,20, 30 ...
	
	private int endPage;
	
	private boolean prev;
	// 이전버튼

	private boolean next;
	// 다음버튼
	
	private int displayPageNum = 5;
	// 하단에 몇개의 페이지를 보여줄 건지
	// 1 2 3 4 5 6 7 8 9 10
	
	// 총 게시글의 수를 구하는 메소드
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		// 매개변수로 받은 총 게시글 개수를 내가 가진 총게시글수에 넣어줌 
		makePagein();
	}
	
	public void makePagein() {
		// 1. 화면에 보여질 마지막 페이지 번호
		// 현재 하단에 보여줄 페이지 개수 : 10개 ( 1 2 3 4 5 6 7 8 9 10 )
		// 내가 현재 보고 있는 페이지가 7이라면 우측 끝에 있는 마지막 페이지 번호는 10
		// 내가 현재 보고 있는 페이지가 13이라면 우측 끝에 있는 마지막 페이지 번호는 20
		// 7 / 10.0(몇개씩 볼건지) -> 소수점이 나오면 올림 -> 1 -> * 10 => 10
		// 13 / 10.0 -> 2 * 10 => 20
		
		// 내부 함수 사용할거임 : Math.ceil -> 소수점이 있으면 알아서 올려버림
		// endPage(끝페이지 번호)에 담아줄거임(저장)
		endPage = (int)(Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		
		// 2. 화면에 보여질 시작 페이지 번호
		// 현재 7페이지 : 10(마지막 페이지 번호) - 10(보여줄 페이지 개수) + 1
		// 현재 15페이지 : 20(마지막) - 10(보여줄 페이지 개수) + 1
		startPage = endPage - displayPageNum + 1;
		
		if(startPage <= 0) {
			// 혹시라도 startPage가 0보다 작거나 같다면 1부터 시작할 수 있게
			startPage = 1;
		}
		
		// 3. 최종페이지가 맞는지 유효성 검사
		// ex) 실제로 게시글이 101개라면 10개 페이지 + 1 페이지
		// 마지막 페이지 계산
		// 소수점이 발생한다 : 나머지가 있다! => 한페이지를 더 만들어줘야 함
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
		
		// 4. 화면에 보여질 마지막 페이지 유효성 체크
		// tempEndPage : 실제 마지막페이지
		if(tempEndPage < endPage) {
			endPage = tempEndPage;
			// 마지막 페이지가 진짜 마지막 페이지(게시글 총 개수에 따른)보다 높으면 치환
		}
		
		// 5. 이전, 다음 페이지 버튼 존재여부
		prev = (startPage == 1) ? false : true;
		next = (endPage < tempEndPage) ? true : false;
		// 실제 게시글이 160개면 실제 마지막 페이지 번호는 16 -> tempEndPage = 16
		// 내가 현재 5페이지를 보고있으면 endPage = 10 
		// 10 < 16 => 다음페이비 버튼 true(있어야해)
		// 내가 현재 13페이지를 보고 있으면 endPage = 16
		// 16 < 16 => false (다음 페이지 버튼 없음)
		
	}
	
}
