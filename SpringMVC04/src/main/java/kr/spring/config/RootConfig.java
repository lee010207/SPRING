package kr.spring.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@MapperScan(basePackages = {"kr.spring.mapper"}) 
// Mapper Interface 메모리 올리기 위해 경로설정
// sqlsessionfactory가 mapper를 찾아내게 하기 위해서 알려주는 거
@PropertySource({"classpath:persistence-mysql.properties"})
// persistence-mysql.properties 파일을 여기로 연결(위치를 설정해줌)

public class RootConfig {
	// root-context.xml을 대체할 클래스
	
	@Autowired
	Environment env;
	// 내가 만든 properties 파일을 읽어오는 객체
	
	@Bean // 메모리에 자동으로 로딩해주는 어노테이션
	public DataSource myDataSource() {
		// hikariConfig 객체 생성
		HikariConfig hikariConfig = new HikariConfig();
		
		// 히카리컨피그에 값(property:속성값)을 하나씩 넣어주기
		// 드라이버 이름, jdbc URL, 
		// 외부에다 파일(properties) 하나 만들어서 여기다가 불러다 사용할거임
		hikariConfig.setDriverClassName(env.getProperty("jdbc.driver"));
		hikariConfig.setJdbcUrl(env.getProperty("jdbc.url"));
		hikariConfig.setUsername(env.getProperty("jdbc.user"));
		hikariConfig.setPassword(env.getProperty("jdbc.password"));
		
		HikariDataSource myDataSource = new HikariDataSource(hikariConfig);
		// HikariDataSource를 생성할 때 생성자 매개변수로 히카리컨피그를 넣어줌
		
		// datasource를 만들어서 돌려줌
		return myDataSource;
	}
	
	@Bean
	public SqlSessionFactory sessionFactory() throws Exception {
		// 예외처리 필요 : throws Exception
		
		SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
		// sql문 관련 모든 걸 다 알아서 하는 애 -> dataSource 정보가 필요
		sessionFactory.setDataSource(myDataSource());
		
		// SqlSessionFactory 로 다운캐스팅 해주고 sessionFactory 안에 있는 객체를 돌려줌
		return (SqlSessionFactory)sessionFactory.getObject();
	}
}
