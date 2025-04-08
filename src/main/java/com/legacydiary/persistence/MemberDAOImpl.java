package com.legacydiary.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

// dao단임을 선언, root-context에서 스캔도 해야 함
@Repository
public class MemberDAOImpl implements MemberDAO {
	
	// 주입방식
	@Autowired
	SqlSession ses; // SqlSessionTemplate 주입받음
	
	private static String ns = "com.legacydiary.mappers.memberMapper.";
	
	
	@Override
	public int selectDuplicateId(String tmpMemberId) {
		
		return ses.selectOne(ns + "selectMemberId",tmpMemberId);
	}

}
