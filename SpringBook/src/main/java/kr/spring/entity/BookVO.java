package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BookVO {
	private int num;         
	private String title;    
	private String author;  
	private String company;  
	private String isbn;   
	private int count;
}
