package com.legacydiary.service.diary;

import java.util.List;

import com.legacydiary.domain.DiaryVO;
import com.legacydiary.domain.SearchDTO;

public interface DiaryService {
	// 글 등록
	int register(DiaryVO diaryVO);
	
	// 글 전체목록 조회
	List<DiaryVO> viewAll();
	
	// 완료여부 수정
	void updateFinished(int dno, boolean finished);
	
	// 글 수정(title, dueDate)
	void modify(DiaryVO diaryVO);

	// 로그인한 유저의 글만 조회
	List<DiaryVO> viewAll(String memberId);

  List<DiaryVO> searchDiary(SearchDTO searchDTO);
}
