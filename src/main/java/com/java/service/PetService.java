package com.java.service;

import java.util.ArrayList;
import java.util.Date;

import com.java.dto.MemberDto;
import com.java.dto.PetDto;
import com.java.dto.diagnosis.PetDiagnosisDto;

public interface PetService {
	//관리자페이지 petList
	ArrayList<PetDto> petList();

	//mypage petList
	ArrayList<PetDto> petAll(String sessionId);

	//반려견 정보 등록
	void joinPet(String id, String pname, Double pweight, Date pbirth, String pgender, String psurgery, String pfile);

	//진단설문지 반려견 new 정보등록!!!!!!!!!!!!!!!!!
	void joinPetFromDiagnosis(PetDiagnosisDto petdiagnosisDto);

	//반려견 정보 조회
	PetDto InfoPet(String id, int pno);

	//반려견 정보 수정
	void doUpdatePet(PetDto pdto);

	//반려견 정보 삭제
	void byePet(PetDto pdto);

	//진단설문지 Pet 이름 비교
	PetDto comparePet(PetDiagnosisDto petdiagnosisDto);


}
