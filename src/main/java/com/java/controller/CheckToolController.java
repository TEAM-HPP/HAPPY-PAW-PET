package com.java.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.java.dto.PetDto;
import com.java.dto.diagnosis.PetDiagnosisDto;
import com.java.service.PetService;
import com.java.service.dianosis.PetDiagnosisService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CheckToolController {

	@Autowired PetDiagnosisService pdService;
	@Autowired PetService petService;
	@Autowired HttpSession session;

	@GetMapping("/diagnosis/CheckTool")
	public String CheckTool() {
		return "diagnosis/CheckTool";
	}

	@GetMapping("/diagnosis/resultEye")
	public String resultEye() {
		return "diagnosis/resultEye";
	}

	@GetMapping("/diagnosis/resultSkin")
	public String resultSkin() {
		return "diagnosis/resultSkin";
	}


	@RequestMapping("/diagnosis/checkForm") //진단내역 DB저장
	public String checkForm(PetDiagnosisDto petdiagnosisDto, @RequestPart MultipartFile files) {

		String id = (String)session.getAttribute("sessionId");
		System.out.println("id : "+id);

		String uFile="";  //파일이 존재하지 않으면 null값으로 들어감
		//파일이 존재할 시
		if (!files.isEmpty()) {
			//jsp
			long time = System.currentTimeMillis();

			uFile = String.format("%d_%s", time,files.getOriginalFilename());
			String saveUrl = "c:/upload/";
			File f = new File(saveUrl+uFile);
			try {
				files.transferTo(f);
			} catch (Exception e) { e.printStackTrace(); } //파일업로드
		}//if

		//변경된 파일이름 저장
		petdiagnosisDto.setPfile(uFile);

		//진단 설문지 DB저장
		petdiagnosisDto.setId(id);
		pdService.insertPetDiagnosisDB(petdiagnosisDto);


		return "redirect:/index";
	}

	@RequestMapping("/diagnosis/comparePet") // 진단 설문지 작성 시 반려등물 등록현황 비교
	@ResponseBody
	public String comparePet(PetDiagnosisDto petdiagnosisDto) {

		//반려동물 등록 비교
		PetDto petDto = petService.comparePet(petdiagnosisDto);

		int chk = 0; //중복 반려동물 정보 없음
		if(petDto != null) {
			chk = 1; //중복 반려동물 정보 없음
		}
		System.out.println("controller chk : "+chk);

		return ""+chk;
	}

	@RequestMapping("/diagnosis/joinPet")
	@ResponseBody
	public String joinPet(PetDiagnosisDto petdiagnosisDto) {
		//${sessionId}에 저장되어있는 반려동물 정보랑 비교해서, 없으면 자동저장
		petService.joinPetFromDiagnosis(petdiagnosisDto);
		System.out.println("반려동물 정보 저장 완료");
		String chk = "OK";

		return chk;
	}

	@GetMapping("/diagnosis/food")
	public String food() {
		return "diagnosis/food";
	}
	@GetMapping("/diagnosis/skin")
	public String skin() {
		return "diagnosis/skin";
	}

	@GetMapping("/diagnosis/eye")
	public String eye() {
		return "diagnosis/eye";
	}

	@GetMapping("/diagnosis/diagnosis")
	public String diagnosis() {
		return "diagnosis/diagnosis";
	}
}
