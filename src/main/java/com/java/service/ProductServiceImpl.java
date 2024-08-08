package com.java.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.java.dao.ProductDao;
import com.java.dto.ProductDto;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    @Override
    public List<ProductDto> getProductsByTypeAndDisease(String type, String disease) {
        return productDao.findProductsByTypeAndDisease(type, disease);
    }
}
