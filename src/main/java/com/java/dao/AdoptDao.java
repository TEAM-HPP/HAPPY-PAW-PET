package com.java.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.java.dto.AdoptDto;

@Mapper
public interface AdoptDao {

	//게시판리스트 가져오기 - 리스트,검색포함
	ArrayList<AdoptDto> selectList(int startRow, int endRow, String category, String searchWord);
	//게시글 총개수 - 리스트,검색포함
	int selectCount(String category, String searchWord);
	
	//게시글1개 가져오기 - 현재글,이전글,다음글
	AdoptDto selectOne(AdoptDto adDto);
	AdoptDto selectOnePrev(AdoptDto adDto);
	AdoptDto selectOneNext(AdoptDto adDto);
	// 조회수1증가
	void updateBhit(AdoptDto adDto);
	
	//게시글 저장
	void insertBoard(AdoptDto adDto);
	
	//게시글 삭제
	void deleteBoard(AdoptDto adDto);
	
	//게시글 수정저장
	void updateBoard(AdoptDto adDto);
	
	//답글페이지 저장
	void updateBstep(AdoptDto adDto);
	
	//step 1씩 증가
	void insertReply(AdoptDto adDto);
	
	//공지사항 작성 후 저장
	void insertNotice(AdoptDto adDto);
	
	//관리자페이지 - 커뮤니티 모두 불러오기
	ArrayList<AdoptDto> adoptCommuList();

	

}
