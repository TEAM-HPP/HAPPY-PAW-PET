package com.java.dao;

import org.apache.ibatis.annotations.Mapper;

import com.java.dto.diagnosis.PetDiagnosisDto;

import java.util.List;

@Mapper
public interface PetDiagnosisDao {

	//진단 설문지 작성 저장
	void insertPetDiagnosisDB(PetDiagnosisDto petdiagnosisDto);
	// 사용자 ID를 기반으로 진단 이력 조회
	List<PetDiagnosisDto> findDiagnosisHistoryByUserId(String id);

}
