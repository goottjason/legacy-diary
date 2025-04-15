package com.legacydiary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.legacydiary.domain.DiaryVO;
import com.legacydiary.domain.SearchDTO;

public interface DiaryMapper {
	String selectNow();
	int insert(DiaryVO diaryVO);
	List<DiaryVO> selectAllList();
	
	void updateFinished(@Param("dno") int dno, @Param("finished") boolean finished);
//	void updateFinished(int dno, boolean finished);
	
	void updateDiary(DiaryVO diaryVO);
	List<DiaryVO> selectAllListById(String memberId);
	List<DiaryVO> selectDiaryDueTommorrow();
	
	List<DiaryVO> selectSearchList(SearchDTO searchDTO);
	
}
