package com.java.dao;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Mapper;

import com.java.dto.MemberDto;
import com.java.dto.PetDto;

@Mapper
public interface MemberDao {

	
	
	//로그인확인
	MemberDto selectLogin(MemberDto memberDto);
	//아이디 찾기
	MemberDto findId(String name_v, String fullEmail);
	//중복아이디 찾기
	MemberDto compareId(String id);
	//회원가입
	void joinMem(String name, String id, String pw2, String fullEmail, String fullTell, Date birth,
				String genderC);
	
	//임시비밀번호 발급된 것을 DB에 저장
	void updatePwcode(MemberDto memberDto);
	

	//회원정보 수정을 위한 데이터 가져오기
	MemberDto InfoMem(String sessionId);
		
	//회원정보 수정
	void doUpdateMem(MemberDto mDto);

	//관리자페이지 - 멤버리스트
	ArrayList<MemberDto> memList();
	
	//회원정보삭제(탈퇴)
	void deleteMem(String id, String name);
	
	//반려동물 id로 보호자 정보조회
	MemberDto memView(PetDto petDto);
	
	//프로필 사진 바꾸기
	void mainFile(MemberDto mdto);

	//회원정보 수정을 위한 pw 조회
	MemberDto checkPw(MemberDto mdto);
}
