package com.java.service.dianosis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dao.PetDiagnosisDao;
import com.java.dto.diagnosis.PetDiagnosisDto;

import java.util.List;

@Service
public class PetDiagnosisServiceimpl implements PetDiagnosisService {


	@Autowired PetDiagnosisDao pdDao;


	@Override
	public void insertPetDiagnosisDB(PetDiagnosisDto petdiagnosisDto) {
		pdDao.insertPetDiagnosisDB(petdiagnosisDto);
	}

	@Override
	public List<PetDiagnosisDto> getDiagnosisHistoryByUserId(String userId) {
		return pdDao.findDiagnosisHistoryByUserId(userId);
	}

}
