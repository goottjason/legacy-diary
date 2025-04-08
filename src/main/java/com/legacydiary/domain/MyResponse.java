package com.legacydiary.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder // 
public class MyResponse { // 응답하는 형식을 정함

	private int code;
	private String data;
	private String msg;
	
}
