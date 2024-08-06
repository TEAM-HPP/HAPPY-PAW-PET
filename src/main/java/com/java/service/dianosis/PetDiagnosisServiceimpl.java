package com.java.service.dianosis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dao.PetDiagnosisDao;
import com.java.dto.diagnosis.PetDiagnosisDto;

@Service
public class PetDiagnosisServiceimpl implements PetDiagnosisService {

	@Autowired PetDiagnosisDao pdDao;


	@Override  //진단설문지 작성 저장
	public void insertPetDiagnosisDB(PetDiagnosisDto petdiagnosisDto) {

		pdDao.insertPetDiagnosisDB(petdiagnosisDto);
	}

}
