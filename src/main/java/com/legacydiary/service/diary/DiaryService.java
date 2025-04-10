package com.legacydiary.service.diary;

import java.util.List;

import com.legacydiary.domain.DiaryVO;

public interface DiaryService {
	// 글 등록
	int register(DiaryVO diaryVO);
	
	// 글 전체목록 조회
	List<DiaryVO> viewAll();
	
	
	void updateFinished(int dno, boolean finished);
}
