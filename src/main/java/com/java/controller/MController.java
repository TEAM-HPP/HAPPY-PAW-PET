package com.java.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.java.dto.MemberDto;
import com.java.service.EmailService;
import com.java.service.MemberService;

import jakarta.servlet.http.HttpSession;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.java.dto.KakaoDto;
import com.java.dto.LogoutDto;
import com.java.dto.OAuthTokenDto;

@Controller
public class MController {

	@Autowired MemberService memberService;
	@Autowired HttpSession session;
	@Autowired EmailService emailService;
	//토큰키 객체
	OAuthTokenDto oAuthTokenDto = null;
	
	@Value("${kakao.admin_id}")
	private String id;
	
	
	@GetMapping("/login/login")
	public String login() {
		return "login/login";
	}
	
	@PostMapping("/login/doLogin")
	public String doLogin() {
		return "login/doLogin";
	}

	@GetMapping("/login/memberForm")
	public String memberForm() {
		return "login/memberForm";
	}
	
	@GetMapping("/login/findId")
	public String findId() {
		return "login/findId";
	}
	
	@GetMapping("/login/findPw")  //비밀번호 찾기로 이동
	public String findPw() {
		
		return "login/findPw";
	}
	
	@GetMapping("/login/doEmail")
	public String doEmail() {
		return "login/doEmail";
	}
	
	@GetMapping("/login/welcome")
	public String welcome() {
	    return "login/welcome";
	}
	
	//-------------------------------------------------------------------------------------------------------------------------------------
	
	@PostMapping("/login/login")  //로그인 확인
	public ModelAndView login(MemberDto memberDto) {
		//System.out.println("controller id : "+memberDto.getId());
		//System.out.println("controller pw : "+memberDto.getPw());
		
		//db 확인
		int chkLogin = 0; //로그인실패
		MemberDto mDto = memberService.selectLogin(memberDto);
		
		if(mDto != null) { //로그인 시 입력한 id가 db에 존재하면 
			chkLogin = 1; //로그인 성공
			
			session.setAttribute("sessionId", mDto.getId());  //sessionId 부여
			session.setAttribute("sessionPw", mDto.getPw());  //sessionPw 부여
			session.setAttribute("sessionName", mDto.getName()); //myPage 창에 뜨게
		}
		System.out.println("controller chkLogin : "+chkLogin);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("chkLogin",chkLogin);
		mv.setViewName("login/doLogin");
		
		return mv;
	}
	
	@RequestMapping("/login/logout")
	public ModelAndView logout() {
		int chkLogin = 3; //로그아웃
		
		session.invalidate(); //모든 세션 끊어버리기
		
		System.out.println("controller chkLogin : "+chkLogin);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("chkLogin",chkLogin);
		mv.setViewName("login/doLogin");
		
		return mv;
	}
	
	@RequestMapping("/login/findId")  //아이디 찾기
	public ModelAndView findId(String name_v, String fullEmail) {
		
		System.out.println("controller name : "+name_v);
		System.out.println("controller email : "+fullEmail);
		
		//db 확인
		int chkFind = 0; //아이디 못찾음
		MemberDto mDto = memberService.findId(name_v,fullEmail);
		
		if(mDto != null) { //찾고자하는 id가 db에 존재하면 
			chkFind = 1; //아이디 찾음
			
		}
		System.out.println("controller chkFind : "+chkFind);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("chkFind",chkFind);
		mv.addObject("mDto",mDto);
		mv.setViewName("login/findPw");
		
		return mv;
	}
	
	
	@PostMapping("/login/emailSend") // 임시비밀번호 생성 후 이메일 발송
	public String emailSend(MemberDto memberDto) {
		System.out.println("controller name : "+memberDto.getName());
		System.out.println("controller email : "+memberDto.getEmail());
		
		//이메일 전송
		emailService.email_send(memberDto);
		
		return "login/login";
	}
	
	//---------------------------------------------------------------------------------------------------------
	@RequestMapping("/login/compareId")
	@ResponseBody
	public String compareId(String id) {
		System.out.println("controller id : "+id);
		
		//아이디 비교
		MemberDto mDto = memberService.compareId(id);
		int chk = 0; //중복 아이디 없음
		if(mDto != null) {
			chk = 1; //중복되는 아이디 있음
		}
		System.out.println("controller chk : "+chk);
		
		return ""+chk;
	}
	
	@RequestMapping("/login/join")  //회원가입
	public String join(String name, String id, String pw2, String fullEmail, String fullTell, String birth_year, String genderC) {
		System.out.println("controller birth : "+birth_year);
		System.out.println("controller gender : "+genderC);
		System.out.println("controller email : "+fullEmail);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date birth = null;
        
        try {
			birth = dateFormat.parse(birth_year);
		} catch (ParseException e) {e.printStackTrace();}
        
		//회원가입하기
		memberService.joinMem(name,id,pw2,fullEmail,fullTell,birth,genderC);
		//회원가입 환영 이메일
		emailService.welcome_email_send(id,name,fullEmail);

		return "/login/welcome";

	}
	
	
	
	//카카오 로그인
	@RequestMapping("/kakao/oauth")
	//@ResponseBody  //데이터 넘겨주기
	public String oauth(String code) {
		    try {
		        // ... 기존 코드 (카카오 로그인 처리 부분) ...
		
		// [ 카카오 로그인 ]
		//1차 code 받는 주소
		System.out.println("oauth code : "+code);
		
		//2차 토큰 키 요청
		String oauthUrl = "https://kauth.kakao.com/oauth/token";
		String content_type = "application/x-www-form-urlencoded;charset=utf-8";
		String grant_type = "authorization_code";
		String client_id = "d6f5da98cfbe26c292397ddc4ff2a30b";
		String redirect_uri = "http://localhost:8181/kakao/oauth";
		
		
		//2-1. header오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", content_type);
		
		//2-2. body오브젝트 map 생성
		MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
		map.add("grant_type", grant_type);
		map.add("client_id", client_id);
		map.add("redirect_uri", redirect_uri);
		map.add("code", code);
		
		//2-3. HttpEntity - header, body를 1개로 묶음.
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest =
				new HttpEntity<>(map,headers);
		
		//2-4. http요청 오브젝트 생성,전송
		RestTemplate rt = new RestTemplate();
		ResponseEntity<String> response = rt.exchange(oauthUrl, HttpMethod.POST,kakaoTokenRequest,String.class);
		
		System.out.println("2. kakaoToken response Json타입 :  "+response);
		
		//2-5. Json타입을 java오브젝트 타입으로 변경
		ObjectMapper objectMapper = new ObjectMapper();
		//상단에 선언
		//OAuthTokenDto oAuthTokenDto = null;
		
		try {
			//json타입 -> java클래스타입
			oAuthTokenDto = objectMapper.readValue(response.getBody(),OAuthTokenDto.class);
		} catch (Exception e) {e.printStackTrace();} 
		
		System.out.println("2-2. kakaoToken class  :  "+oAuthTokenDto.getAccess_token());
		
		
		//---------------------------------------------------------------
		// 3. 사용자 정보 가져오기
		String oauthUserUrl = "https://kapi.kakao.com/v2/user/me";
		String authorization = "Bearer "+oAuthTokenDto.getAccess_token();
		content_type = "application/x-www-form-urlencoded;charset=utf-8";
		
		//2-1. header오브젝트 생성
		HttpHeaders headers_user = new HttpHeaders();
		headers_user.add("Authorization", authorization);
		headers_user.add("Content-type", content_type);
		
		//2-2. body는 없음 - body오브젝트 map 생성
		
		//2-3. HttpEntity - header, body를 1개로 묶음.
		HttpEntity<MultiValueMap<String, String>> kakaoTokenUserRequest =
				new HttpEntity<>(headers_user);
		
		//2-4. http요청 오브젝트 생성,전송
		RestTemplate rt_user = new RestTemplate();
		ResponseEntity<String> response_user = rt_user.exchange(oauthUserUrl, HttpMethod.POST,kakaoTokenUserRequest,String.class);
		
		System.out.println("3. kakaoUserToken user정보 Json타입 :  "+response_user);
		
		//2-5. Json타입을 java오브젝트 타입으로 변경
		ObjectMapper objectMapper_user = new ObjectMapper();
		KakaoDto kakaoDto = null;
		
		try {
			//json타입 -> java클래스타입
			kakaoDto = objectMapper_user.readValue(response_user.getBody(),KakaoDto.class);
		} catch (Exception e) {e.printStackTrace();} 
		
//		System.out.println("3-2. kakaoUserToken class id  :  "+kakaoDto.getId());
//		System.out.println("3-2. kakaoUserToken class Nickname  :  "+kakaoDto.getProperties().getNickname());
		
		
		//로그인의 섹션 생성후 로그인 완료
		session.setAttribute("sessionId", String.valueOf(kakaoDto.getId()));
		session.setAttribute("sessionName", kakaoDto.getProperties().getNickname());
		session.setAttribute("session_email", kakaoDto.getKakao_account().getEmail());
		
		//return "1. code : "+code;
		//return "2. response : "+response;
		//return "2-2. kakaoToken class : "+oAuthTokenDto.getAccess_token();
		
		    } catch (Exception e) {
		        e.printStackTrace();
		        
		        // 세션 무효화
		        session.invalidate();
		        
		        // 에러 페이지로 리다이렉트 또는 다른 처리
		        return "redirect:/error";  // 또는 원하는 경로로 리다이렉트
		    }
		    
		return "redirect:/";

	}
	
	
	
	//카카오 로그아웃
	@RequestMapping("/kakao/logout")
	public ModelAndView kakaoLogout() {
		int chkLogin = 3; //로그아웃
		
		System.out.println("controller chkLogin : "+chkLogin);
		
		//로컬서버에서만 섹션 종료
		session.invalidate();
		
		try {
			// 1. 카카오섹션 종료 - 로그아웃
			String oauthLogoutUrl = "https://kapi.kakao.com/v1/user/unlink";
			String authorization = "Bearer "+oAuthTokenDto.getAccess_token();
			
			//2-1. header오브젝트 생성
			HttpHeaders headers_logout = new HttpHeaders();
			headers_logout.add("Authorization", authorization);
			
			//2-2. body는 없음 - body오브젝트 map 생성
			//2-3. HttpEntity - header, body를 1개로 묶음.
			HttpEntity<MultiValueMap<String, String>> kakaoTokenLogoutRequest =
					new HttpEntity<>(headers_logout);
			
			//2-4. http요청 오브젝트 생성,전송
			RestTemplate rt_logout = new RestTemplate();
			ResponseEntity<String> response = rt_logout.exchange(oauthLogoutUrl, HttpMethod.POST,kakaoTokenLogoutRequest,String.class);
			
			System.out.println("1. kakaoTokenLogout response Json타입 :  "+response);
			
			//2-5. Json타입을 java오브젝트 타입으로 변경
			ObjectMapper objectMapper = new ObjectMapper();
			LogoutDto logoutDto = null;
			
			try {
				//json타입 -> java클래스타입
				logoutDto = objectMapper.readValue(response.getBody(),LogoutDto.class);
			} catch (Exception e) {e.printStackTrace();} 
			
			System.out.println("1. logoutDto class  :  "+logoutDto.getId());
			System.out.println("카카오 로그아웃 완료");
			
		} catch (Exception e2) { e2.printStackTrace(); }
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("chkLogin",chkLogin);
		mv.setViewName("login/doLogin");
		
		
		return mv;
	}
	
	
	
}
