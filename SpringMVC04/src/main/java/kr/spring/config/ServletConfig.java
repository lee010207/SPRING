package kr.spring.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@EnableWebMvc
// config java클래스가 spring mvc 구조상에서 작동하기 위한 어노테이션
@Configuration
// WebConfig에서 설정파일로 인식될 수 있게 달아주는 어노테이션
@ComponentScan(basePackages = {"kr.spring.controller"})
// controller 패키지가 여러개일 경우 추가 해주면 됨 :(basePackages = {"kr.spring.controller","kr.gg.gg"})

public class ServletConfig implements WebMvcConfigurer {  // servlet-context.xml의 기능을 가지고 있는 interface
	 // servlet-context.xml을 대체할 클래스
	
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		//servlet-context.xml에 있던 ViewResolver 설정부분
		InternalResourceViewResolver bean = new InternalResourceViewResolver();
		bean.setPrefix("/WEB-INF/views/");   // 접두사 : 앞에 붙일 내용
		bean.setSuffix(".jsp");              // 접미사 : 뒤에 붙일 내용
		
		// ViewResolver 설정 값을 가지고 있는 registry에 내가 만든 viewResolver(bean)를 등록 시켜줘야 적용이 됨
		registry.viewResolver(bean);
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// registry에 등록해주기(맵핑값:mapping="").위치
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}

	
	
	
}
