package com.java.service;

import java.util.List;
import java.util.Map;

public interface AbandonedService {
    // Existing method declarations...
    int getFilteredTotalCount(String uprCd, String orgCd) throws Exception;
    List<Map<String, String>> getAnimalListByPage(int page, int pageSize, String uprCd, String orgCd) throws Exception;
    List<Map<String, String>> getSidoList() throws Exception;
    List<Map<String, String>> getSigunguList(String uprCd) throws Exception;

    // New method to get animal details by ID
    Map<String, String> getAnimalById(String animalId) throws Exception;
}
