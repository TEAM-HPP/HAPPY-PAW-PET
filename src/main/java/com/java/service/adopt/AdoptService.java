package com.java.service.adopt;

import java.util.ArrayList;
import java.util.Map;

import com.java.dto.AdoptDto;

public interface AdoptService {

	//게시판 리스트 가져오기, list & 검색
	Map<String, Object> selectList(int page, String category, String searchWord);

	//게시글 1개 가져오기 - 현재글,이전글,다음글
	Map<String, Object> selectOne(AdoptDto adDto);

	//게시글 작성 후 저장
	void insertBoard(AdoptDto adDto);

	//게시글 삭제
	void deleteBoard(AdoptDto adDto);

	//수정페이지
	AdoptDto updateBoard(AdoptDto adDto);

	//수정페이지 저장
	void doUpdateBoard(AdoptDto adDto);

	//답글페이지 저장
	void insertReply(AdoptDto adDto);

	//공지사항 작성 후 저장
	void insertNotice(AdoptDto adDto);

	//관리자페이지 - 커뮤니티 모두 불러오기
	ArrayList<AdoptDto> adoptCommuList();

}
