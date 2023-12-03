package kr.spring.config;

import javax.servlet.Filter;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

// web.xml의 기능을 담고 있는 클래스를 상속 받음
// -> 빨간줄 : 추상 클래스! : 추상 메서드 구현 해줘야함
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{
	// web.xml을 대체할 java class
	
	@Override
	protected Class<?>[] getRootConfigClasses() {
		// DB 설정관련 RootConfig.java 파일을 가져옴
		// 리턴타입은 Class의 배열 형태
		// Why? : 나중에 설정파일을 여러개 추가할 수 있기 때문
		return new Class[] {RootConfig.class, SecurityConfig.class};
		// webConfig에 SecurityConfig.class(보안 환경설정 파일) 추가 
	}

	@Override
	protected Filter[] getServletFilters() {
		// 인코딩 설정하는 부분
		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
		// 인코딩 필터링해주는 객체 생성
		
		encodingFilter.setEncoding("UTF-8");
		// 객체에 값(param) 넣어주기
		
		encodingFilter.setForceEncoding(true);
		// 인코딩 적용하기
		
		// 내가 만든 인코딩필터를 배열에 담아서 보내기
		return new Filter[] {encodingFilter};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		// Servlet 설정 관련 ServletConfig.java 파일을 가져옴
		return new Class[] {ServletConfig.class};
	}

	@Override
	protected String[] getServletMappings() {
		// root Url 뒤에 뭘로 시작할 건지("/") 설정해 주는 부분
		return new String[] {"/"};
	}
	
	
}
