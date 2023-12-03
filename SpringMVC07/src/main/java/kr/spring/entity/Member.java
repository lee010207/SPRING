package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Member {
	private String memId;
	private String memPw;
	private String memName;
	private String memPhone;
	private String memAddr;
	private String latitude;
	private String longitude;
}
