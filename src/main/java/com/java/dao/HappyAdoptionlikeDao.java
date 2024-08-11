package com.java.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.java.dto.HappyAdoptionlikeDto;

@Mapper
public interface HappyAdoptionlikeDao {

	//내가 좋아요 누른 게시글 총 개수
	int selectCount(String category, String searchWord,String id);

	//내가 좋아요 누른 게시글 불러오기
	ArrayList<HappyAdoptionlikeDto> selectList(int startRow, int endRow,String category, String searchWord, String id);

}
