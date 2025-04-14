package com.legacydiary.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.legacydiary.domain.DiaryVO;
import com.legacydiary.mapper.DiaryMapper;
import com.legacydiary.persistence.MemberDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@RequiredArgsConstructor
@Slf4j
public class EmailReminderScheduler {
  private final DiaryMapper diaryMapper;
  private final MemberDAO memberDAO;
  private final SendEmailService sendEmailService;
  
//  @Scheduled(cron = "0 0/1 * * * * ")
  public void reminderSchedule() throws AddressException, FileNotFoundException, IOException, MessagingException {
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
      
      String email = memberDAO.selectEmailByMemberId(memberId);
      log.info("@@@@@@@@@@@@@@@ email : {}", email);
      
      // 메일 본문
      StringBuilder sb = new StringBuilder();
      sb.append("안녕하세요, 내일까지 해야 할 일이 있습니다.");
      for (DiaryVO vo : entry.getValue()) {
        sb.append("-----").append(vo.getTitle());
      }
      sb.append(memberId+"님, 꼭 완료하세요!");
      
      log.info("●●●●●●●●● 내용: {}", sb.toString());
      
      sendEmailService.sendReminder(email, sb.toString());
      
    }
  }
}
