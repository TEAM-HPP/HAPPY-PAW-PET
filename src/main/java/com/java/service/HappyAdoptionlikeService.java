package com.java.service;

import java.util.Map;

public interface HappyAdoptionlikeService {

	//내가 좋아요 누른 게시글 불러오기
	Map<String, Object> selectList(int page, String category, String searchWord, String id);

}
