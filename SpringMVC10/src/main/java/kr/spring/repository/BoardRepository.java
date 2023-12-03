package kr.spring.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.spring.entity.Board;

@Repository   // 메모리로 올리기 위한 어노테이션(생략가능)
public interface BoardRepository extends JpaRepository<Board, Long>{
	// JPA 기능이 모두 들어있는 JpaRepository 인터페이스를 상속받아야 함
	// <받아올 데이터 타입(테이블명) , 기본키(PK)에 대한 데이터 타입>
}
