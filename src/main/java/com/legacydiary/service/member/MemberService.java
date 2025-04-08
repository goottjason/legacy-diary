package com.legacydiary.service.member;

public interface MemberService {
	// 멤버 아이디 중복검사 서비스 (로직이 없더라도 MVC니까 서비스단을 거쳐서 감)
	boolean idIsDuplicate(String tmpMemberId);
}
