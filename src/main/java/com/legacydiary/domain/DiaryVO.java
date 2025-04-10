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
public class DiaryVO {
	private int dno;
	private String title;
	private LocalDate dueDate;
	private String writer;
	private boolean finished;

}
