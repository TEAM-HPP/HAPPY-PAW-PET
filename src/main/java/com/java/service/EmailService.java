package com.java.service;

import com.java.dto.MemberDto;

public interface EmailService {

	//html 형식 이메일 전송
	void email_send(MemberDto memberDto);
	//회원가입 환영 이메일 보내기
	void welcome_email_send(String id,String name, String fullEmail);

}
