package com.java.controller;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.java.dto.MemberDto;
import com.java.dto.PetDto;
import com.java.service.ByememService;
import com.java.service.MemberService;
import com.java.service.PetService;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class PController {
	
	@Autowired PetService petService;
	
	@Autowired HttpSession session;
	@Autowired MemberService memberService;
	@Autowired ByememService byememSerivce;

	@RequestMapping("/mypage/myPage")  //마이페이지
	public ModelAndView myPage() {
		String sessionId = (String) session.getAttribute("sessionId");
		ArrayList<PetDto> plist = petService.petAll(sessionId);
		MemberDto mDto = memberService.InfoMem(sessionId);
		ModelAndView mv = new ModelAndView();
		mv.addObject("plist",plist);
		mv.addObject("mDto",mDto);
		mv.setViewName("mypage/myPage");
		return mv;
	}
	
	@RequestMapping("/mypage/sendMainImg")  //마이페이지 회원 프로필 사진 업데이트
	public String sendMainImg(MemberDto mdto, @RequestPart MultipartFile mainFile) {
			String id = (String)session.getAttribute("sessionId");
			mdto.setId(id);
	        String profile="";
	        //파일이 존재할 시
			if(!mainFile.isEmpty()) {
				long time = System.currentTimeMillis();
				profile = String.format("%d_%s", time,mainFile.getOriginalFilename());
				String saveUrl = "c:/upload/";
				File f = new File(saveUrl+profile);
				try {
					mainFile.transferTo(f);
					mdto.setProfile(profile);
				} catch (Exception e) {	e.printStackTrace();} //파일업로드
			}//if
		//정보 등록하기
		memberService.mainFile(mdto);
		return "redirect:/mypage/myPage";
	}
	
	// pet 정보 --------------------------------------------------------------------
	
	@GetMapping("/mypage/petForm")  //반려동물 추가 페이지
	public String petForm() {
		return "mypage/petForm";
	}
	
	@RequestMapping("/mypage/join")  //반려견 정보 등록
	public String petForm(String pname, Double pweight, String pbirth_year, String pgender, String psurgery, @RequestPart MultipartFile petfile) {
		
		String id = (String)session.getAttribute("sessionId");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date pbirth = null;
        try {
        	pbirth = dateFormat.parse(pbirth_year);
		} catch (ParseException e) {e.printStackTrace();}
        String pfile="";
		
        //파일이 존재할 시
		if(!petfile.isEmpty()) {
			long time = System.currentTimeMillis();
			System.out.println("time : "+time);
			
			pfile = String.format("%d_%s", time,petfile.getOriginalFilename());
			String saveUrl = "c:/upload/";
			File f = new File(saveUrl+pfile);
			try {
				petfile.transferTo(f);
			} catch (Exception e) {	e.printStackTrace();} //파일업로드
		}//if
		
		//변경된 파일이름 저장
//		pdto.setBfile(uFile);
		//정보 등록하기
		petService.joinPet(id,pname,pweight,pbirth,pgender,psurgery,pfile);
		
		return "redirect:/mypage/myPage";
	}
	//반려견 정보 조회
	@GetMapping("/mypage/petEdit")
	public ModelAndView petEdit(PetDto pdto) {
		String id = (String) session.getAttribute("sessionId");
		session.setAttribute("sessionPno", pdto.getPno());  //sessionpno 부여
		int pno = (int) pdto.getPno();
		PetDto pDto = petService.InfoPet(id,pno);
		ModelAndView mv = new ModelAndView();
		mv.addObject("pDto",pDto);
		mv.setViewName("mypage/petEdit");
		return mv;
	}
	//반려견 정보 수정 저장
	@RequestMapping("/mypage/doUpdatePet")
	public String doUpdatePet(PetDto pdto, @RequestPart MultipartFile petfile) {
		String id = (String)session.getAttribute("sessionId");
		int pno = (int)session.getAttribute("sessionPno");
		pdto.setId(id);
		pdto.setPno(pno);
		System.out.println("controller pfile: "+pdto.getPfile());
		
        //파일이 존재할 시
		if(!petfile.isEmpty()) {
			long time = System.currentTimeMillis();
			String pfile = String.format("%d_%s", time,petfile.getOriginalFilename());
			String saveUrl = "c:/upload/";
			File f = new File(saveUrl+pfile);
			try {
				petfile.transferTo(f);
				pdto.setPfile(pfile);
			} catch (Exception e) {	e.printStackTrace();} //파일업로드
		}
		petService.doUpdatePet(pdto);
		return "redirect:/mypage/myPage";
	}
	
	//반려견 정보 삭제
	@RequestMapping("/mypage/byePet")
	public String byePet(PetDto pdto) {
		String id = (String)session.getAttribute("sessionId");
		pdto.setId(id);
		petService.byePet(pdto);
		return "redirect:/mypage/myPage";
	}

	//---------------------------------------------------------------------------------
	
	@GetMapping("/mypage/pEdit")  // 회원 정보 조회
	public ModelAndView pEdit() {
		String sessionId = (String) session.getAttribute("sessionId");
		MemberDto mdto = memberService.InfoMem(sessionId);
        
		ModelAndView mv = new ModelAndView();
		mv.addObject("mdto",mdto);
		mv.setViewName("mypage/pEdit");
		return mv;
	}
	
	@RequestMapping("/mypage/doUpdateMem")  //회원정보 수정
	public String doUpdateMem(MemberDto mDto) {
		//회원가입하기
		String id = (String)session.getAttribute("sessionId");
		mDto.setId(id);
		System.out.println("id : "+id);
		System.out.println(mDto.getBirth());
		System.out.println(mDto.getEmail());
		System.out.println(mDto.getGender());
		System.out.println(mDto.getPhone());
		System.out.println(mDto.getPw());
		
		memberService.doUpdateMem(mDto);
		
		return "redirect:/mypage/myPage";
	}
	
	
	//---------------------------------------------------------------------------------------
	@GetMapping("/mypage/byeMem")
	public String byeMem() {
		return "mypage/byeMem";
	}
	
	@RequestMapping("/mypage/byeMem")
	public String byeMem(String id,String name,String genderC, String content) {
		
		//happymem 회원정보 삭제
		memberService.deleteMem(id,name);
		
		//탈퇴 목록에 추가(byemem에 insert)
		byememSerivce.byeMem(id,name,genderC,content);
		
		//로컬서버에서만 섹션 종료
		session.invalidate();
		
		return "redirect:/"; //메인페이지로 이동
	}

	@GetMapping("/mypage/checkPw")
	public String checkPw() {
		return "mypage/checkPw";
	}

	@RequestMapping("/mypage/checkPw") //회원정보 수정을 위한 pw 조회
	public String checkPw(MemberDto mdto, String check_pw, RedirectAttributes rA) {
		String id = (String)session.getAttribute("sessionId");
		//기존 비밀번호 조회
		mdto.setId(id);

		boolean checkPw = memberService.checkPw(mdto, check_pw);
		String url = "";

		//비밀번 호 비교
		if(checkPw) {
			//비밀번호 일치 시 pEdit로 이동
			url =  "redirect:/mypage/pEdit";
		}else {
			//비밀번호 불일치 시
			rA.addFlashAttribute("errorM", "비밀번호를 다시 확인해주세요.");
			url =  "redirect:/mypage/checkPw";
		}
		return url;
	}
}
