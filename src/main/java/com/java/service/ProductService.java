package com.java.service;

import java.util.List;
import com.java.dto.ProductDto;

public interface ProductService {
    List<ProductDto> getProductsByTypeAndDisease(String type, String disease);
}
