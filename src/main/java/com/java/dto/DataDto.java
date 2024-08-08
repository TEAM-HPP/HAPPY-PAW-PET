package com.java.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class DataDto {

	private LocalDate date;
	private double activeuser;
	private double sessionduration;
	private double newuser;
	private double pageview;
}
