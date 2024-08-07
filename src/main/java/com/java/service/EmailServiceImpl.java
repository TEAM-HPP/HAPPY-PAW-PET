package com.java.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.java.dao.MemberDao;
import com.java.dto.MemberDto;

import jakarta.mail.Message.RecipientType;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailServiceImpl implements EmailService {

	@Autowired JavaMailSender mailSender;
	@Autowired MemberDao memberDao;
	
	
	@Override //이메일 전송
	public void email_send(MemberDto memberDto) {
		String pwCode = getCreateKey();
		System.out.println("랜덤비밀번호 생성: "+pwCode);
		
		//html 형식으로 갖추어 보내기
		MimeMessage message = mailSender.createMimeMessage();
		try {
			message.setSubject("[HappyPawPet]"+memberDto.getName()+"님의 임시비밀번호를 발급하였습니다.","utf-8");
			String htmlData = "<tr>	\r\n"
					+ "<td style='width:700px;height:196px;padding:0;margin:0;vertical-align:top;'> \r\n"
					+ "<table width='618' height='194' cellpadding='0' cellspacing='0' align='center' style='margin:0 0 0 40px;border:1px #D9D9D9 solid;'>\r\n"
					+ "<tr> \r\n"
					+ "	<td style='width:618px;height:194px;padding:0;margin:0;vertical-align:top;font-size:0;line-height:0;background:#f9f9f9;'> \r\n"
					+ "	<p style='width:620px;margin:30px 0 0 0;padding:0;text-align:center;'>\r\n"
					+ "	<img src='http://localhost:8181/image/HappyPawPet.png' />\r\n"
					+ "	</p> \r\n"
					+ "\r\n"
					+ "	<p style='width:620px;margin:10px 0 0 0;padding:0;text-align:center;color:#888888;font-size:12px;line-height:1;'>아래의 PASSWORD는 임시 PASSWORD이므로 홈페이지 로그인 후 다시 수정해 주십시오.</p> \r\n"
					+ "	<p style='width:620px;margin:28px 0 0 0;padding:0;text-align:center;color:#666666;font-size:12px;line-height:1;'><strong>임시 패스워드 : <span style='color:#f7703c;line-height:1;'>"+pwCode+"</span></strong></p> \r\n"
					+ "	<p style='width:620px;margin:30px 0 0 0;padding:0;text-align:center;color:#888888;font-size:12px;line-height:1.4;'>HappyPawPet은 고객님께 보다 나은 서비스를 제공하기 위해 항상 노력하겠습니다.<br/>앞으로 많은 관심 부탁드립니다.</p> \r\n"
					+ "	</td> \r\n"
					+ "</tr> \r\n"
					+ "</table>		\r\n"
					+ "</td>\r\n"
					+ "</tr>";
			message.setText(htmlData,"utf-8","html");
			//보내는 이메일 주소
			message.setFrom(new InternetAddress("ina091412@gmail.com"));
			//받는 이메일 주소
			message.addRecipient(RecipientType.TO, new InternetAddress(memberDto.getEmail()));
			//이메일 전송
			mailSender.send(message);
			
			//set pwcode저장
			//임시 비밀번호 DB저장
			memberDto.setPw(pwCode);
			memberDao.updatePwcode(memberDto);  //새롭게 저장된 pwCode를 가지고 다시 MemberDao로
		
		} catch (MessagingException e) { e.printStackTrace();} //제목
		
		System.out.println("이메일 발송 완료");
		
	}

	@Override //회원가입 환영 이메일
	public void welcome_email_send(String id, String name, String fullEmail) {
		//html 형식으로 갖추어 보내기
		System.out.println(id);
		System.out.println(name);
		System.out.println(fullEmail);
		MimeMessage message = mailSender.createMimeMessage();
		try {
			message.setSubject("[HappyPawPet]"+name+"님의 회원가입을 진심으로 환영합니다.","utf-8");
			String htmlData = "<table style='width: 100%; max-width: 600px; height: 700px; margin: 20px auto; background: #FFFFFF; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);' cellpadding='0' cellspacing='0'>\r\n"
					+ "<tr>\r\n"
					+ "<td style='background: black; color: #FFFFFF; padding: 20px; display: flex; align-items: center;'>\r\n"
					+ "<img src='http://localhost:8181/image/HappyPawPet.png' style='width: 180px; height: auto; margin: 0px 30px;' alt='로고'>\r\n"
					+ "<div style='flex: 1; text-align: center; font-size: 24px; font-weight: 800; letter-spacing: 2px;'>\r\n"
					+ "<h1 style='margin: 0;'>환영합니다!</h1>\r\n"
					+ "</div>\r\n"
					+ "</td>\r\n"
					+ "</tr>\r\n"
					+ "<tr>\r\n"
					+ "<td style='padding: 20px;'>\r\n"
					+ "<p style='font-size: 16px; line-height: 1.5; font-weight: 600; text-align: center;'>안녕하세요, " + name + "님!</p>\r\n"
					+ "<p style='font-size: 16px; line-height: 1.5; font-weight: 600; text-align: center;'>회원가입을 축하드립니다.</p>\r\n"
					+ "<p style='font-size: 16px; line-height: 1.5; font-weight: 600; text-align: center;'>이제 HappyPawPet의 모든 기능을 이용하실 수 있습니다.</p>\r\n"
					+ "<p style='font-size: 16px; line-height: 1.5; font-weight: 600; text-align: center;'>아래 버튼을 클릭하여 지금 바로 시작해 보세요!</p>\r\n"
					+ "<div style='text-align: center;'>\r\n"
					+ "<a href='http://localhost:8181' style='display: inline-block; background-color: black; color: #FFFFFF; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: 800; text-align: center; margin: 10px auto; width: 200px;'>시작하기</a>\r\n"
					+ "</div>\r\n"
					+ "<p style='font-size: 16px; line-height: 1.5; font-weight: 600; text-align: center;'>HappyPawPet은 고객님께 더 나은 서비스를 제공하기 위해 <br>항상 노력하겠습니다.<br/>앞으로 많은 관심 부탁드립니다.</p>\r\n"
					+ "</td>\r\n"
					+ "</tr>\r\n"
					+ "<tr>\r\n"
					+ "<td style='padding: 10px; text-align: center; font-size: 14px; color: #777; letter-spacing: 1px;'>\r\n"
					+ "<p>&copy; 상호 : HappyPawPet&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;대표자 : ***</p>\r\n"
					+ "<p>주소 : (08378) 서울 구로구 디지털로34길 27 (구로동) 1106-7호</p>\r\n"
					+ "</td>\r\n"
					+ "</tr>\r\n"
					+ "</table>\r\n";
			message.setText(htmlData,"utf-8","html");
			//보내는 이메일 주소
			message.setFrom(new InternetAddress("ivy091412@gmail.com"));
			//받는 이메일 주소
			message.addRecipient(RecipientType.TO, new InternetAddress(fullEmail));
			//이메일 전송
			mailSender.send(message);
		} catch (MessagingException e) { e.printStackTrace();} //제목

	}
		
	//임시 비밀번호 생성
	public String getCreateKey() {
		char[] charSet = {
			'0','1','2','3','4','5','6','7','8','9',	
			'A','B','C','D','E','F','G','H','I','J',	
			'K','L','M','N','O','P','Q','R','S','T',	
			'U','V','W','X','Y','Z',
			'a','b','c','d','e','f','g','h','i','j',	
			'k','l','m','n','o','p','q','r','s','t',	
			'u','v','w','x','y','z'
		};
	
		String pwCode = "";
		int idx = 0;
		for (int i=0;i<10;i++) {
			idx = (int)(Math.random()*52);
			pwCode += ""+charSet[idx];
			
		}
		return pwCode;
		
	}
}
