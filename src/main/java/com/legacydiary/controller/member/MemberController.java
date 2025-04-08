package com.legacydiary.controller.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

// 클래스레벨에서 RequestMapping을 할 수 있다.
// 이 컨트롤러는 /member로 시작하는 요청 url을 모두 담당한다.
@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	// void 반환하면, 요청url과 같은 signup을 찾는다.
	@GetMapping("/signup")
	public void registerForm() {
		
	}
}
