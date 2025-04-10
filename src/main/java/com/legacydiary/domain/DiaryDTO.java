package com.legacydiary.domain;

import java.time.LocalDate;

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
@Builder
@ToString
public class DiaryDTO {
	private int dno;
	private String title;
	private String dueDateStr;
	private String writer;
	private boolean finished;
	
	public LocalDate getDueDate() {
		return LocalDate.parse(dueDateStr);
	}
	
}
