package com.legacydiary.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.legacydiary.domain.User;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
@Slf4j
public class UserMapperTest {
  
  @Autowired
  private UserMapper userMapper;
  
  @Test
  public void testInsertUser() {
    User user = User.builder()
        .username("tomoong2")
        .email("goottjason2@gmail.com")
        .state("ACTIVE")
        .build();
    userMapper.insertUser(user);
    log.info("▶▶▶▶▶▶▶▶▶▶user : {}",user);
    log.info("▶▶▶▶▶▶▶▶▶▶저장된 id : {}",user.getId());
    
  }
  
  @Test
  public void testSearchByUsername() {
    List<User> list = userMapper.searchUser("username", "tosimi");
    log.info("▶▶▶▶▶▶▶▶▶▶list : {}",list);
  }
  
  @Test
  public void testSearchByEmail() {
    List<User> list = userMapper.searchUser("email", "goottjason@gmail.com");
    log.info("▶▶▶▶▶▶▶▶▶▶list : {}",list);
  }
  
}
