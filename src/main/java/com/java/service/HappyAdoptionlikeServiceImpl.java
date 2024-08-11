package com.java.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dao.HappyAdoptionlikeDao;
import com.java.dto.HappyAdoptionlikeDto;

@Service
public class HappyAdoptionlikeServiceImpl implements HappyAdoptionlikeService {

	@Autowired HappyAdoptionlikeDao halikeDao;
	
	@Override  //내가 좋아요 누른 게시글 리스트 : 하단넘버링, 검색, 불러오기
	public Map<String, Object> selectList(int page, String category, String searchWord, String id){
		//----- 하단넘버링 ---------
		int countPerPage = 24; //1페이지당 게시글수
		int bottomPerNum = 10; //하단넘버링 개수
		int countAll = halikeDao.selectCount(category,searchWord,id); //게시글 총개수

		// 최대페이지
		int maxPage = (int)Math.ceil((double)countAll/countPerPage);
		int startPage = ((page-1)/bottomPerNum)*bottomPerNum+1;
		int endPage = (startPage+bottomPerNum)-1;
		// 마지막넘버링이 최대페이지 숫자보다 크면
		if(endPage>maxPage) endPage = maxPage;
		// 게시글페이지에서 가져올 게시글번호
		int startRow = (page-1)*countPerPage+1;
		int endRow = startRow+countPerPage-1;
		//----- 하단넘버링 ---------
		
		//mybatis연결해서 list 가져오기 - 게시글,검색포함
		ArrayList<HappyAdoptionlikeDto> list = halikeDao.selectList(startRow,endRow,category,searchWord,id);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list",list);
		map.put("countAll",countAll);
		map.put("startPage",startPage);
		map.put("endPage",endPage);
		map.put("maxPage",maxPage);
		map.put("page",page);
		map.put("category",category);
		map.put("searchWord",searchWord);
		
		return map; //리턴해야 할 데이터가 개수가 2개이상 -> map
	}
}
