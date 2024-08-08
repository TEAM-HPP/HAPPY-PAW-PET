package com.java.service;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Service;

import com.java.dto.AnalyticsDto;
import com.java.dto.DataDto;

@Service
public class AnalyticsServiceImpl implements AnalyticsService {

	@Override
	public AnalyticsDto getData() {
		List<DataDto> data = Arrays.asList(
            new DataDto(LocalDate.of(2024, 8, 6), 1.0, 758.806, 1.0, 7.0),
            new DataDto(LocalDate.of(2024, 8, 7), 1.0, 1.771, 0.0, 2.0),
            new DataDto(LocalDate.of(2024, 8, 8), 1.0, 0.0, 0.0, 0.0)
        );
		
        return new AnalyticsDto(data);
    }
}
