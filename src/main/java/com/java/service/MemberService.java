package com.java.service;

import java.util.ArrayList;
import java.util.Date;

import com.java.dto.MemberDto;
import com.java.dto.PetDto;

public interface MemberService {

	//로그인하기
	MemberDto selectLogin(MemberDto memberDto);

	//아이디 찾기
	MemberDto findId(String name_v, String fullEmail);

	//중복 아이디 확인
	MemberDto compareId(String id);
	
	//회원가입
	void joinMem(String name, String id, String pw2, String fullEmail, String fullTell, Date birth,String genderC);

	//회원정보 수정을 위한 데이터 가져오기
	MemberDto InfoMem(String sessionId);

	//회원정보 업데이트
	void doUpdateMem(MemberDto mDto);
	
	//관리자 페이지- 멤버리스트
	ArrayList<MemberDto> memList();

	//회원정보삭제
	void deleteMem(String id, String name);
	
	//반려동물 id로 보호자 정보조회
	MemberDto memView(PetDto petDto);

	//프로필 사진 바꾸기
	void mainFile(MemberDto mdto);

	//회원정보 수정을 위한 pw 조회
	boolean checkPw(MemberDto mdto, String check_pw);

}
