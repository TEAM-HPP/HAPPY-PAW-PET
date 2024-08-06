package com.java.dao;

import org.apache.ibatis.annotations.Mapper;

import com.java.dto.diagnosis.PetDiagnosisDto;

@Mapper
public interface PetDiagnosisDao {

	//진단 설문지 작성 저장
	void insertPetDiagnosisDB(PetDiagnosisDto petdiagnosisDto);

}
