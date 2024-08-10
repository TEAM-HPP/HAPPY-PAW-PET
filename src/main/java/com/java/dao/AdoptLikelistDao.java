package com.java.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.java.dto.AdoptLikelistDto;

@Mapper
public interface AdoptLikelistDao {

	//게시글 좋아요 누르기
	void likeOn(String id, int bno);

	//게시글 좋아요 취소
	void likeOff(String id, int bno);

	//bno당 좋아요 개수세기 
	int selectLikeCountByBno(int bno);

	//사용자가 좋아요를 눌렀는지 확인하는 메소드
	boolean isLikedByUser(String id, int bno);

}
