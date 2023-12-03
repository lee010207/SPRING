package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.entity.Board;
import kr.spring.entity.Member;

@Mapper    // MyBatis가 interface를 찾기위해 달아주는 부분 : annotation
public interface BoardMapper {


	public List<Board> getLists();
	// MyBatis가 이 메서드를 수행하면서 위의 sql문을 참조함(annotation으로 sql문 달아줬을 때)

	public void boardInsert(Board board);

	public Board boardContent(int idx);

	public void boardDelete(int idx);

	public void boardUpdate(Board board);

	public void boardCount(int idx);
	

}
