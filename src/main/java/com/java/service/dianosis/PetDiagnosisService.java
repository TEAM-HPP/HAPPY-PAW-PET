package com.java.service.dianosis;

import com.java.dto.diagnosis.PetDiagnosisDto;
import java.util.List;

public interface PetDiagnosisService {
	// 진단설문지 작성 저장
	void insertPetDiagnosisDB(PetDiagnosisDto petdiagnosisDto);

	// 사용자 ID를 기반으로 진단 이력 조회
	List<PetDiagnosisDto> getDiagnosisHistoryByUserId(String userId);
}
