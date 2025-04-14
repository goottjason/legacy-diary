package com.legacydiary.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class SampleScheduler {
  
  private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
  
//  @Scheduled(cron = "0 0/1 * * * * ")
  public void sampleSchedule() {
    LocalDateTime now = LocalDateTime.now();
    String fmtNow = now.format(formatter);
    log.info("-------- scheduler -------- {}", fmtNow);
  }

  
}
