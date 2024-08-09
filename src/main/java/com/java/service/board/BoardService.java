package com.java.service.board;


import java.util.Map;

import com.java.dto.board.BoardDto;

public interface BoardService {

	//공지사항 list, 검색, 페이지 넘버링
	Map<String, Object> allList(int page, String category, String searchWord);
	
	//관리자 공지사항 쓰기
	void writeBoard(BoardDto boardDto);

	//공지사항 view 페이지(현재글,이전,다음글 가져오기)
	Map<String, Object> selectOne(BoardDto boardDto);

	//공지사항 게시글 삭제하기
	void deleteBoard(BoardDto boardDto);

	//공지사항 게시글 수정하기 페이지
	BoardDto boardUpdate(BoardDto boardDto);

	//공지사항 게시글 수정저장하기
	void doBoardUpdate(BoardDto boardDto);



}
