package com.legacydiary.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.legacydiary.controller.SessionFactoryTest;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
@Slf4j
public class DiaryMapperTest {
	@Autowired
	private DiaryMapper diaryMapper;
	
	@Test
	public void selectNowTest() {
		log.info("###### selectNow: {}", diaryMapper.selectNow());
	}
}
