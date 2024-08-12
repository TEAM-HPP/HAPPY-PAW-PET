package com.java.dto.diagnosis;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PetDiagnosisDto {
    private int dno;
    private String id;
    private String pname;
    private Date pbirth;
    private int page;
    private String psex;
    private String psurgery; // 중성화 여부 yes or no
    private float pweight;
    private String pbreed;
    private String condition; // 질병 유형 (eye, skin)
    private String pfile;
    private Date diagnosisdate; // 진단 날짜, default=sysdate

    // 안구질환 질문
    private Integer eye1;
    private Integer eye2;
    private Integer eye3;
    private Integer eye4;
    private Integer eye5;
    private String eyecolor;

    // 피부질환 질문
    private Integer skin1;
    private Integer skin2;
    private Integer skin3;
    private Integer skin4;
    private Integer skin5;

    // 추가된 필드들 (진단 이력 관련)
    private String diseaseType;
    private String additionalNotes;
}
