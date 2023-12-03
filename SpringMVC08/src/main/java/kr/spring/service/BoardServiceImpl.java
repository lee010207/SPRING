package kr.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.Member;
import kr.spring.mapper.BoardMapper;

//Service 라고 알려주기 위해 명시
@Service
public class BoardServiceImpl implements BoardService{
	// 실질적으로 일은 여기서 수행함
	// 여태까지는 클래스(컨트롤러)에서 mapper에 요청해서 viewname 돌려주고 다함
	// 이제는 Service(BoardServiceImpl)가 함
	
	@Autowired
	private BoardMapper mapper;
	
	@Override
	public List<Board> getList(Criteria cri) {
		// 게시글 전체목록 가져오기 기능
		List<Board> list = mapper.getList(cri);
		return list;
	}

	@Override
	public Member login(Member vo) {
		// 로그인 기능
		Member mvo = mapper.login(vo);
		// Service는 data를 돌려줌(viewName이 아니라 -> Controller)
		return mvo;
	}

	@Override
	public void register(Board vo) {
		// 게시글 등록
		mapper.insertSelectKey(vo);
	}

	@Override
	public Board get(int idx) {
		// 게시글 상세보기
		Board vo = mapper.read(idx);
		return vo;
	}

	@Override
	public void modify(Board vo) {
		// 게시글 수정
		mapper.update(vo);
	}

	@Override
	public void remove(int idx) {
		// 게시글 삭제
		mapper.delete(idx);
	}

	@Override
	public void reply(Board vo) {
		// 댓글 달기
		// vo - 부모글의 번호, 로그인한 아이디, 제목, 답글, 작성자 이름
		
		// 부모글의 정보 가져오기 : get(idx) -> read(idx)
		Board parent = mapper.read(vo.getIdx());
		
		// 부모글의 boardGroup의 값을 -> 답글 vo에 저장하기
		vo.setBoardGroup(parent.getBoardGroup());
		// boardSequence, boardLevel -> 부모글 + 1
		vo.setBoardSequence(parent.getBoardSequence() + 1);
		vo.setBoardLevel(parent.getBoardLevel() + 1);
		
		// 댓글 저장 전에
		// 현재 넣으려는 답글을 제외한 기존 같은 그룹의 댓글의 시퀀스 값을 1씩 올려줘야 함
		mapper.replySeqUpdate(parent);
		
		// 댓글(시퀀스 값 : 1) 저장 
		mapper.replyInsert(vo);
	}

	@Override
	public int totalCount() {
		// 게시글 총개수 가져오기
		return mapper.totalCount();
	}

}
