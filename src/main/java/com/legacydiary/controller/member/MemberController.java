package com.legacydiary.controller.member;

import java.io.IOException;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.legacydiary.domain.LoginDTO;
import com.legacydiary.domain.MemberDTO;
import com.legacydiary.domain.MyResponse;
import com.legacydiary.domain.User;
import com.legacydiary.persistence.MemberDAO;
import com.legacydiary.service.member.MemberService;
import com.legacydiary.util.SendEmailService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 클래스레벨에서 RequestMapping을 할 수 있다.
// 이 컨트롤러는 /member로 시작하는 요청 url을 모두 담당한다.
@Controller
@RequestMapping("/member")
@Slf4j
@RequiredArgsConstructor
public class MemberController {
	
	private final MemberService memberService; // 서비스 객체 주입
	private final SendEmailService sendEmailService; // 메일전송담당객체 주입
	
	// void 반환하면, 요청url과 같은 signup을 찾는다. 
	// (회원가입 클릭하면 GET방식의 요청으로 링크를 열 수 있음)
	// signup.jsp로 직접 접근할 수 없음
	@GetMapping("/signup")
	public void registerForm() {
//		User user = new User.Builder()
//				.id("user1")
//				.name("홍길동")
//				.pwd("1234")
//				.build();
//		System.out.println(user);
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
	@PostMapping("/callSendEmail")
	public ResponseEntity<String> sendEmailAuthCode(@RequestParam String tmpMemberEmail, HttpSession session) {
		log.info("tmpMemberEmail: {}", tmpMemberEmail);
		String authCode = UUID.randomUUID().toString();
		log.info("authCode: {}", authCode);
		String result = "";
		try {
			sendEmailService.sendEmail(tmpMemberEmail, authCode);
			session.setAttribute("authCode", authCode);
			result = "success";
		} catch (IOException | MessagingException e) {
			e.printStackTrace();
			result = "fail";
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@PostMapping("/checkAuthCode")
	public ResponseEntity<String> checkAuthCode(@RequestParam String memberAuthCode, HttpSession session) {
		// 유저가 보낸 AuthCode와 우리가 보낸 AuthCode가 일치하는지 확인
		log.info("memberAuthCode: {}", memberAuthCode);
		log.info("session에 저장된 코드: {}", session.getAttribute("authCode"));
		String result = "fail";
		if (session.getAttribute("authCode") != null ) {
			String sesAuthCode = (String) session.getAttribute("authCode");
			if (memberAuthCode.equals(sesAuthCode)) {
				result = "success";
			}
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@PostMapping("/signup")
	public String registerMember(MemberDTO registerMember, RedirectAttributes rttr) {
		log.info("회원가입하러가자! registerMember: {}", registerMember);
		
		String result ="";
		if(memberService.saveMember(registerMember)) {
			// true면 가입완료 후 index.jsp로 가자.
			// 리다이렉트 할 때 status, success 붙이고 가고싶을때
			// 쿼리스트링 붙어서 감
			rttr.addAttribute("status", "success");
			result = "redirect:/";
		} else {
			// 가입 실패하면 다시 회원가입페이지로 이동하게끔!
			rttr.addAttribute("status", "fail");
			result = "redirect:/member/sinup";
		}
		return result;
	}
	
	@PostMapping("/clearAuthCode")
	public ResponseEntity<String> clearAuthCode(HttpSession session) {
		// 세션에 저장된 인증코드를 삭제
		if(session.getAttribute("authCode") != null) {
			session.removeAttribute("authCode");
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	@GetMapping("/login")
	public String loginForm() {
		return "/member/login";
	}
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		if(session.getAttribute("loginMember") != null) {
			// 세션에 저장된 값들 삭제
			session.removeAttribute("loginMember");
			// 세션 무효화
			session.invalidate();
		}
		
		return "redirect:/";
	}
	
	@PostMapping("/login")
	public String loginPOST(LoginDTO loginDTO, HttpSession session) {
		log.info("로그인하러가자 {}", loginDTO);
		MemberDTO loginMember = memberService.login(loginDTO);
		log.info("loginMember : {}", loginMember);
		
		String result ="";
		if(loginMember != null) {
			// 세션에 저장할 것 (로그인 성공) -> 홈페이지로 보낸다
			session.setAttribute("loginMember", loginMember);
			result = "redirect:/";
		} else {
			// 로그인 실패
			// 
			result = "redirect:/member/login";
		}
		return result;
	}
}
