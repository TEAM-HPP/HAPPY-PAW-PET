package com.java.service;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dao.PetDao;
import com.java.dto.MemberDto;
import com.java.dto.PetDto;
import com.java.dto.diagnosis.PetDiagnosisDto;

@Service
public class PetServiceImpl implements PetService {

	@Autowired PetDao petDao;

	@Override
	public ArrayList<PetDto> petList() {

		ArrayList<PetDto> plist = petDao.petList();

		return plist;
	}

	@Override  //메인페이지 petList
	public ArrayList<PetDto> petAll(String sessionId) {

		ArrayList<PetDto> plist = petDao.petAll(sessionId);

		return plist;
	}

	@Override //반려동물정보 추가
	public void joinPet(String id, String pname, Double pweight, Date pbirth, String pgender, String psurgery,
						String pfile) {
		petDao.joinPet(id,pname,pweight,pbirth,pgender,psurgery,pfile);
	}


	@Override //진단설문지 반려견 new 정보등록!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	public void joinPetFromDiagnosis(PetDiagnosisDto petdiagnosisDto) {

		petDao.joinPetFromDiagnosis(petdiagnosisDto);
	}


	//반려견 정보 조회
	@Override
	public PetDto InfoPet(String id, int pno) {
		PetDto pDto = petDao.InfoPet(id, pno);
		return pDto;
	}

	@Override //반려견 정보 수정
	public void doUpdatePet(PetDto pdto) {
		petDao.doUpdatePet(pdto);

	}
	@Override //반려견 정보 삭제
	public void byePet(PetDto pdto) {
		petDao.byePet(pdto);
	}

	@Override  //진단설문지 Pet 이름 비교
	public PetDto comparePet(PetDiagnosisDto petdiagnosisDto) {

		PetDto petDto = petDao.comparePet(petdiagnosisDto);

		return petDto;
	}



}
