package com.legacydiary.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.legacydiary.domain.LoginDTO;
import com.legacydiary.domain.MemberDTO;

// dao단임을 선언, root-context에서 스캔도 해야 함
@Repository
public class MemberDAOImpl implements MemberDAO {
	
	// 주입방식
	@Autowired
	SqlSession ses; // SqlSessionTemplate 주입받음
	
	private static String ns = "com.legacydiary.mappers.memberMapper.";
	
	
	@Override
	public int selectDuplicateId(String tmpMemberId) {
		
		// "selectMemberId" id값으로 호출, tmpMemberId 값을 넘겨줌
		return ses.selectOne(ns + "selectMemberId",tmpMemberId);
	}


	@Override
	public int insertMember(MemberDTO registerMember) {
		return ses.insert(ns + "insertMember", registerMember);
	}


	@Override
	public MemberDTO login(LoginDTO loginDTO) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "loginWithLoginDTO", loginDTO);
	}


  @Override
  public String selectEmailByMemberId(String memberId) {
    
    return ses.selectOne(ns + "selectEmailByMemberId", memberId);
  }

}
