package kr.spring.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.Board;
import kr.spring.repository.BoardRepository;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardRepository boardRepository;
	
	@Override
	public List<Board> getList() {
		List<Board> list = boardRepository.findAll();
		return list;
	}

	@Override
	public void register(Board vo) {
		boardRepository.save(vo);
	}

	@Override
	public Board get(Long idx) {
		Optional<Board> vo = boardRepository.findById(idx);
		// Id(PK)를 기준으로 데이터를 찾아오겠다 -> Optional 이라는 형태로 감싸져서 옴
		return vo.get();
	}

	@Override
	public void delete(Long idx) {
		boardRepository.deleteById(idx);
		
	}

	@Override
	public void update(Board vo) {
		boardRepository.save(vo);
		// JPA -> save 
		// 새로운 pk값 또는 없는 값(해당 PK와 일치하지 않는)이 들어오면 : insert 기능
		// 기존에 존재하는 pk값이 들어오면 : update 기능
	}

}
