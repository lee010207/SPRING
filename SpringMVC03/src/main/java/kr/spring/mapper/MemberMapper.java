package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.entity.Board;
import kr.spring.entity.Member;

@Mapper 
public interface MemberMapper {

	public Member idCheck(String id);

	public int join(Member mem);

	public Member login(Member m);
	
	public int update(Member member);

	public void profileUpdate(Member mvo);

	public Member getMember(String memId);

	

}
