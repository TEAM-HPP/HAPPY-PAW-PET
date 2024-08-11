package com.java.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class HappyAdoptionlikeDto {

	private int bno;
	private String id;
	private String btitle;
	private String bcontent;
	private Date bdate;
	private int bgroup;
	private int bstep;
	private int bindent;
	private String bfile;
	private int bhit;
}
