package com.legacydiary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.legacydiary.domain.User;

public interface UserMapper {
  
  List<User> searchUser(@Param("type") String type, @Param("keyword") String keyword);
  
  void insertUser(User user);

}
