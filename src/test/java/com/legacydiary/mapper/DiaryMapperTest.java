package com.legacydiary.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.legacydiary.controller.SessionFactoryTest;
import com.legacydiary.domain.DiaryVO;
import com.legacydiary.domain.SearchDTO;
import com.legacydiary.persistence.MemberDAO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
@Slf4j
public class DiaryMapperTest {
	@Autowired
	private DiaryMapper diaryMapper;
	@Autowired
	private MemberDAO memberDao;
	
//	@Test
//	public void selectNowTest() {
//		log.info("###### selectNow: {}", diaryMapper.selectNow());
//	}
	
	@Test
	public void selectDiaryDueTommorrow() {
    // 내일 마감인 글 조회
    List<DiaryVO> list = diaryMapper.selectDiaryDueTommorrow();
    log.info("{}", list);
    
    // writer의 이메일, 내일 마감인 글들을 보내줘야 함 (key는 writer, value는 내일 마감인 글들
    Map<String, List<DiaryVO>> memberDiaryMap = new HashMap<>();
    
    for(DiaryVO vo : list) {
      if(!memberDiaryMap.containsKey(vo.getWriter())) { 
        memberDiaryMap.put(vo.getWriter(), new ArrayList<DiaryVO>());
        
      }
      memberDiaryMap.get(vo.getWriter()).add(vo);
    }
    
    for (Map.Entry<String, List<DiaryVO>> entry : memberDiaryMap.entrySet()) {
      String memberId = entry.getKey();
      log.info(memberId);
      log.info("$#################### list : {}", entry.getValue());
      
      String email = memberDao.selectEmailByMemberId(memberId);
      log.info("@@@@@@@@@@@@@@@ email : {}", email);
      
      // 메일 본문
      StringBuilder sb = new StringBuilder();
      sb.append("안녕하세요, 내일까지 해야 할 일이 있습니다.");
      for (DiaryVO vo : entry.getValue()) {
        sb.append("-----").append(vo.getTitle());
      }
      sb.append(memberId+"님, 꼭 완료하세요!");
      
      log.info("●●●●●●●●● 내용: {}", sb.toString());
      
    }
	}
	
	@Test
	public void testSearch() {
	  SearchDTO searchDTO = SearchDTO.builder()
	      .writer("hong1111")
	      .searchTypes("title")
	      .searchWord("봄")
	      .finished("0")
	      .from("2025-04-15")
	      .to("2025-04-30")
	      .build();
	  List<DiaryVO> result = diaryMapper.selectSearchList(searchDTO);
	  for (DiaryVO diary : result) {
	    log.info("▶▶▶▶▶▶▶▶▶▶diary : {}", diary);
	  }
	}
}
