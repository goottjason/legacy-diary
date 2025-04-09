package com.legacydiary.service.member;

import org.springframework.stereotype.Service;

import com.legacydiary.domain.MemberDTO;
import com.legacydiary.persistence.MemberDAO;

import lombok.RequiredArgsConstructor;

// Service단임을 선언
@Service
@RequiredArgsConstructor // 생성자주입방식(롬복), root-context에서 스캔도 해야 함
public class MemberServiceImpl implements MemberService {
	
	private final MemberDAO memberDAO;
	
	@Override
	public boolean idIsDuplicate(String tmpMemberId) {
		// 서비스단에서는 dao를 주입받아야 함
		
		boolean result = false; // 중복 안 됨
		// dao 단에 있는 것을 호출해야 함
		if (memberDAO.selectDuplicateId(tmpMemberId) == 1) { // 중복 됨
			result = true;
		}
		return result;
	}

	@Override
	public boolean saveMember(MemberDTO registerMember) {
		
		boolean result =false;
		if (memberDAO.insertMember(registerMember) == 1) {
			result = true;
		}
		return result;
	}

}
