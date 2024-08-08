package com.java.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductDto {
    private String type;
    private String disease;
    private String name;
    private String price;
    private String url;
    private String imgFile;
}

