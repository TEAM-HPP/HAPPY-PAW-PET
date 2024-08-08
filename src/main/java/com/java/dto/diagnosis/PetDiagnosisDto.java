package com.java.dto.diagnosis;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

import lombok.AllArgsConstructor;

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
    private String psurgery; //중성화 여부 yes or no
    private float pweight;
    private String pbreed;
    private String condition; // 질병 유형 (eye, skin)
    private String pfile;
    private Date diagnosisdate; //진단날짜, default=sysdate

    // 안구질환 질문
    private Integer eye1; //int 1/0
    private Integer eye2; // Integer로 변경
    private Integer eye3; // Integer로 변경
    private Integer eye4; // Integer로 변경
    private Integer eye5; // Integer로 변경
    private String eyecolor; // 녹색, 빨간색, 흰색, 검은색

    // 피부질환 질문
    private Integer skin1;
    private Integer skin2; // Integer로 변경
    private Integer skin3; // Integer로 변경
    private Integer skin4; // Integer로 변경
    private Integer skin5; // Integer로 변경
}
