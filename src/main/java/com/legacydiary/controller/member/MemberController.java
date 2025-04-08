package com.legacydiary.controller.member;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.legacydiary.domain.MyResponse;
import com.legacydiary.persistence.MemberDAO;
import com.legacydiary.service.member.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 클래스레벨에서 RequestMapping을 할 수 있다.
// 이 컨트롤러는 /member로 시작하는 요청 url을 모두 담당한다.
@Controller
@RequestMapping("/member")
@Slf4j
@RequiredArgsConstructor
public class MemberController {
	
	private final MemberService memberService;
	
	// void 반환하면, 요청url과 같은 signup을 찾는다.
	@GetMapping("/signup")
	public void registerForm() {
		
	}
	
	@PostMapping("/isDuplicate")
	// MyResponse라는 객체를 만들어서 전달할 수 있다.
	public ResponseEntity<MyResponse> idIsDuplicate(@RequestParam("tmpMemberId") String tmpMemberId) {
		log.info("tmpMemberId : {}", tmpMemberId +"가 중복되는지 확인해보자.");
		
		MyResponse myResponse = null;
		ResponseEntity<MyResponse> result = null;
		
		if(memberService.idIsDuplicate(tmpMemberId)) { // true면 중복 됨
			// json으로 응답해주어야 함 -> ResponseBody
			myResponse = new MyResponse(200, tmpMemberId, "duplicate");
			
		} else { // false면 중복 안 됨, 가입 가능
			myResponse = MyResponse.builder()
					.code(200)
					.data(tmpMemberId)
					.msg("not duplicate")
					.build();			
		}
		log.info("myResponse: {}", myResponse);
		
		result = new ResponseEntity<MyResponse>(myResponse, HttpStatus.OK);
		
		return result;
	}
}
