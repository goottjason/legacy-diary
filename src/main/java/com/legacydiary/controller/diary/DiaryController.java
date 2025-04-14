package com.legacydiary.controller.diary;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.legacydiary.domain.DiaryDTO;
import com.legacydiary.domain.DiaryVO;
import com.legacydiary.domain.MemberDTO;
import com.legacydiary.service.diary.DiaryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/diary")
@Slf4j
@RequiredArgsConstructor // 서비스단 주입받음
public class DiaryController {
	
	private final DiaryService diaryService;
	
	@GetMapping("/register")
	public String registerForm(HttpSession session) {
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		
		if (loginMember == null) {
			// 로그인 되어있지 않으면 로그인페이지로 이동
			return "redirect:/member/login";
		}
		return "/diary/register";
	}
	@PostMapping("/register")
	public String regester(DiaryDTO diaryDTO, RedirectAttributes rttr, HttpSession session) {
		log.info("diaryDTO: {}", diaryDTO);
		String resultPage = "redirect:/diary/list";
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		
		if (loginMember == null) {
			// 로그인 되어있지 않으면 로그인페이지로 이동
			return "redirect:/member/login";
		} else {
			// 서비스에 넘길 VO객체 생성 & 저장
			DiaryVO diaryVO = DiaryVO.builder()
					.title(diaryDTO.getTitle())
					.dueDate(diaryDTO.getDueDate())
					.writer(diaryDTO.getWriter())
					.finished(diaryDTO.isFinished())
					.build();
			try {
				if (diaryService.register(diaryVO) == 1) {
					log.info("■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ 등록성공");
					rttr.addFlashAttribute("status", "success");
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.info("■ ■ ■ ■ ■ ■ ■ 예외발생");
				resultPage = "redirect:/diary/register";
			}
		}
		return resultPage;
	}
	
//	@GetMapping("/list")
//	public String viewAll(Model model) {
//		
//		List<DiaryVO> list = diaryService.viewAll();
//		log.info("{}", list);
//		// DB에서 받아온 것을 jsp 뷰단으로 전달하고자 함 (모델객체)
//		model.addAttribute("diaryList", list); // 리스트를 뷰로 보내줌		
//		
//		return "/diary/list";
//	}
	@GetMapping("/list")
	public String viewAll(Model model, HttpSession session) {
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if(loginMember == null) {
			return "redirect:/member/login"; // 로그인 하지 않은 경우 로그인 페이지로 리다이렉트
		} else {
			// 로그인 한 경우
			List<DiaryVO> list = diaryService.viewAll(loginMember.getMemberId());
			model.addAttribute("diaryList", list);
			
			return "/diary/list";
		}
		
	}

	
	@PostMapping("/updateFinished")
	@ResponseBody
	public String updateFinished(@RequestParam("dno") int dno, @RequestParam("finished") boolean finished) {
		log.info("dno: {}", dno);
		log.info("finished: {}", finished);
		diaryService.updateFinished(dno, finished);
		
		return "success";
	}
	@PostMapping("/modify")
	@ResponseBody // success는 뷰 이름이 아니다. 값 자체를 응답해야하므로 어노테이션 붙여준다!
	public String modifyDiary(@RequestParam int dno, @RequestParam String title, @RequestParam String dueDateStr) {
		log.info("dno : {}", dno);
		log.info("title : {}", title);
		log.info("duaDateStr : {}", dueDateStr);
		
		LocalDate dueDate = LocalDate.parse(dueDateStr);
		
		DiaryVO diaryVO = DiaryVO.builder()
								.dno(dno)
								.title(title)
								.dueDate(dueDate)
								.build();
		
		diaryService.modify(diaryVO);
		
		return "success";
	}
	
}
