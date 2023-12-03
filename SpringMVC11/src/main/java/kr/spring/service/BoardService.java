package kr.spring.service;

import java.util.List;
import kr.spring.entity.Board;

public interface BoardService {
	
	public List<Board> getList();   // 전체 게시글 목록 가져오기(select)
	
	public void register(Board vo);     // 게시글 등록(insert)

	public Board get(Long idx);

	public void delete(Long idx);

	public void update(Board vo);
}
