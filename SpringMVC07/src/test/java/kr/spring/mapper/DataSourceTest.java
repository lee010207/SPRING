package kr.spring.mapper;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import kr.spring.controller.BoardController;
import kr.spring.entity.Board;
import kr.spring.entity.Member;
import kr.spring.service.BoardServiceImpl;
import lombok.extern.log4j.Log4j;

@Log4j   // 테스트 실행결과를 콘솔창에 나오게 하기 위함
@RunWith(SpringJUnit4ClassRunner.class)  // 실행하기 위해 스프링컨테이너에 올리는 코드
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
// dispatherServlet이 있는 위치를 추가해줘야함
// 배열 형태로 만들어서 위치 여러개 넣어주기

// root-context.xml 경로를 잡아주는 과정

@WebAppConfiguration
// 컨트롤러를 테스트(실행)하기 위해서 필요한 어노테이션 : Servlet 컨테이너를 사용하기 위한 어노테이션
public class DataSourceTest {
	// root-context.xml이 이상없는지 test하는 클래스
	
	// Connection이 잘되는지 테스트
	@Autowired  // root-context.xml에 있는 id가 dataSource(Connection 관리하는)인 녀석을 사용하겠다
	private DataSource dataSource;
	
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private BoardServiceImpl service;
	
	@Autowired
	private WebApplicationContext ctx;
	// Spring Container 메모리 공간 객체
	private MockMvc mockMvc;
	// 가상의 MVC환경을 만들어주는 객체, 뷰, 핸들러, 맵핑 등등 실행해줌
	
	@Before // Test 실행하기 전에 먼저 실행하는 부분
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	
	
//	@Test
//	public void testlogin() {
//		Member vo = new Member();
//		vo.setMemId("ME");
//		vo.setMemPw("meme123");
//		Member m = mapper.login(vo);
//		System.out.println(m.toString());
//	}
	
	
	@Test
	public void testController() throws Exception{
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/modify?idx=6")) 
				//perform - 해당 url 요청
				.andReturn()     
				// return값 "board/list" 을 받아오겠다
				.getModelAndView()      
				// Controller의 model값과 view경로를 다 받아오겠다
				);
	}
	
	
	
//	@Test
//	public void testList() {
//		List<Board> list = service.getList();
//		for(Board vo : list) {
//			System.out.println(vo.toString());
//		}
//	}
	
	
//	@Test
//	public void testgetList() {
//		List<Board> list = mapper.getList();
//		for(Board vo : list) {
//			System.out.println(vo.toString());
//		}
//	}
	
//	@Test
//	public void testConnection() {
//		try(Connection conn = dataSource.getConnection()
//				// Connection 정보 가져오기
//			){
//			log.info(conn);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		
//	}
}
