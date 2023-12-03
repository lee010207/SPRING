package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import kr.spring.security.MemberUserDetailsService;

@Configuration        // "환경설정파일 입니다" WebConfig.java에서 SecurityConfig를 읽어오기 위한 어노테이션
@EnableWebSecurity    // web에서 security를 쓰겠다
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	// Spring Security 환경설정(상세설정)하는 클래스
	// WebSecurityConfigurerAdapter
	// 요청에 대한 보안 설정을 해주는 클래스
	
	@Bean //우리가 만들어놓은 MemberUserDetailsService 를 메모리에 올려 사용하겠다
	public UserDetailsService memberUserDetailsService() {
	//MemberUserDetailsService는 UserDetailsService를 상속받음
	// -> 업캐스팅해서 MemberUserDetailsService 객체를 돌려주겠다
		return new MemberUserDetailsService();
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		// 내가 만든 MemberUserDetailsService와
		// 암호화 및 복호화를 해주는 패스워드 인코더를
		// Spring Security에 등록하는 메소드
		auth.userDetailsService(memberUserDetailsService()).passwordEncoder(pwEncoder());
	}

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
		
		
		
		/* SPRING SECURITY ver.3 */
		// 클라이언트가 요청을 했을 때 권한 설정
		// 회원인증부분
		http
			.authorizeRequests()   /* 요청에 따른 권한을 처리하겠따 */
				.antMatchers("/")       /* 어떠한 경로로 왔을 때( / 로 왔을 때) 어떻게 권한 처리를 할 건지 */
					.permitAll()        /* 누구나 접근 가능하게 전체권한 처리 하겠다 */
						.and()         /* 권한을 추가하겠다 */
					.formLogin()         /* 로그인 보안 기능 추가 */
						.loginPage("/loginForm.do")  
						/* Spring Security에서 제공하는 로그인 폼이 아닌 우리가 만든 로그인 폼을 사용하겠다 */
						.loginProcessingUrl("/login.do")   
						/* 해당 url로 요청이 들어왔을 때 Spring Security 자체 로그인 기능을 수행하겠따 */
						.permitAll()             /* 로그인 기능 누구나 사용해야하기 때문에 권한 모두 줌 */
						.and()      /* 권한 추가 */
					.logout()          /* 로그아웃 기능 */
						.invalidateHttpSession(true)     
						/* 세션에 저장된 로그인 정보 전체 삭제하겠다(Spring Security가 알아서 세션을 만료시키겠다) */
						.logoutSuccessUrl("/")            /* 로그아웃 성공 후 이동할 URL 작성 */
						.and()  /* 권한 추가 */
					.exceptionHandling().accessDeniedPage("/access-denied");
					/* 로그인도 안하고 특정 페이지에 접근하려고 할 때 막기(특정 URL : access-denied.jsp 로 요청해버리겠따) */
					/* 로그인 안하면 게시판 접근 못하게 할 때 */
		
	}

	@Bean  // 비밀번호 인코딩 기능을 메모리에 올리겠다, 등록해서 자동으로 로딩되게 해서 쓰겠다
	public PasswordEncoder pwEncoder() {
		// 비밀번호 암호화 메소드
		return new BCryptPasswordEncoder();
	}
	
	
	
}
