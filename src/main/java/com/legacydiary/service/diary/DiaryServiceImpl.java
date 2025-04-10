package com.legacydiary.service.diary;

import java.util.List;

import org.springframework.stereotype.Service;

import com.legacydiary.domain.DiaryVO;
import com.legacydiary.mapper.DiaryMapper;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor // 필수적인 것들은 생성자로 만들어줌
public class DiaryServiceImpl implements DiaryService {
	
	private final DiaryMapper diaryMapper;
	
	@Override
	public int register(DiaryVO diaryVO) {
		
		return diaryMapper.insert(diaryVO);
	}

	@Override
	public List<DiaryVO> viewAll() {
		
		return diaryMapper.selectAllList();
	}

	@Override
	public void updateFinished(int dno, boolean finished) {
		diaryMapper.updateFinished(dno, finished);
	}

}
