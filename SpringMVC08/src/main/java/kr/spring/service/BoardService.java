package kr.spring.service;

import java.util.List;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.Member;

// Service 클래스에서 사용할 기능의 이름을 정의하는 인터페이스

public interface BoardService {
	// 기능만 구현 -> BoardServiceImpl 가 실행
	public List<Board> getList(Criteria cri);
	// Controller에 리스트(게시글 전체 목록)를 돌려줌
	
	public Member login(Member vo);
	
	public void register(Board vo);

	public Board get(int idx);

	public void modify(Board vo);

	public void remove(int idx);

	public void reply(Board vo);

	public int totalCount();
	
	
}
