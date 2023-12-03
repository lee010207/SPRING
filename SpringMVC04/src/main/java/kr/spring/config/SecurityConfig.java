package kr.spring.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

@Configuration        // "환경설정파일 입니다" WebConfig.java에서 SecurityConfig를 읽어오기 위한 어노테이션
@EnableWebSecurity    // web에서 security를 쓰겠다
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	// Spring Security 환경설정(상세설정)하는 클래스
	// WebSecurityConfigurerAdapter
	// 요청에 대한 보안 설정을 해주는 클래스
	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// 요청에 대한 보안 설정하는 곳
		// 로그인은 어떻게 할건지 , 로그아웃은 어떻게 할 건지 등등
		// 여기를 먼저 들렸다가 요청 처리하러 내부로 이동
		
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter, CsrfFilter.class);
		// CsrfFilter.class : 토큰에 필터가 있는데 거기에 적용하겠다
	}

	
	
	
	
}
