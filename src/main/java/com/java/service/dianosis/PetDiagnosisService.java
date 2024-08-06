package com.java.service.dianosis;

import com.java.dto.diagnosis.PetDiagnosisDto;

public interface PetDiagnosisService {


	//진단설문지 작성 저장
	void insertPetDiagnosisDB(PetDiagnosisDto petdiagnosisDto);

}
