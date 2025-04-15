package com.legacydiary.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@ToString
public class SearchDTO {
  private String writer;
  private String searchTypes;
  private String searchWord;
  private String finished;
  private String from;
  private String to;
}
