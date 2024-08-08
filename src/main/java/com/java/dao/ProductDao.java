package com.java.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.java.dto.ProductDto;

@Mapper
public interface ProductDao {
    List<ProductDto> findProductsByTypeAndDisease(@Param("type") String type, @Param("disease") String disease);
}
