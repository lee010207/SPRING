package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.entity.BookVO;

@Mapper
public interface BookMapper {

	public List<BookVO> getLists();

	public void bookInsert(BookVO book);

	public void bookDelete(int num);

	public BookVO getBook(int num);

	public void bookUpdate(BookVO book);
	
}
