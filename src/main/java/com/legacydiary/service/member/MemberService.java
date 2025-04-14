package com.legacydiary.service.member;

import com.legacydiary.domain.LoginDTO;
import com.legacydiary.domain.MemberDTO;

public interface MemberService {
	// 멤버 아이디 중복검사 서비스 (로직이 없더라도 MVC니까 서비스단을 거쳐서 감)
	boolean idIsDuplicate(String tmpMemberId);
	// 회원가입
	boolean saveMember(MemberDTO registerMember);
	
	// 로그인
	MemberDTO login(LoginDTO loginDTO);
}
