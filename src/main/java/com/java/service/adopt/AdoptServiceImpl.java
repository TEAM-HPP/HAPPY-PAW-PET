package com.java.service.adopt;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dao.AdoptDao;
import com.java.dto.AdoptDto;

@Service
public class AdoptServiceImpl implements AdoptService {

	@Autowired AdoptDao adoptDao;
	
	@Override  //게시글 리스트 : 하단넘버링, 검색, 불러오기
	public Map<String, Object> selectList(int page, String category, String searchWord) {

		//----- 하단넘버링 ---------
		int countPerPage = 10; //1페이지당 게시글수
		int bottomPerNum = 10; //하단넘버링 개수
		int countAll = adoptDao.selectCount(category,searchWord); //게시글 총개수

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
		ArrayList<AdoptDto> list = adoptDao.selectList(startRow,endRow,category,searchWord);
		
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

	@Override // 게시글 1개 가져오기 - view
	public Map<String, Object> selectOne(AdoptDto adDto) {

		adoptDao.updateBhit(adDto); //조회수 1증가
		AdoptDto adoptDto = adoptDao.selectOne(adDto);
		AdoptDto prevDto = adoptDao.selectOnePrev(adDto);
		AdoptDto nextDto = adoptDao.selectOneNext(adDto);
		
		Map<String, Object> map = new HashMap<>();
		map.put("adoptDto", adoptDto);
		map.put("prevDto", prevDto);
		map.put("nextDto", nextDto);
		
		return map;
	}

	@Override  //게시글 저장
	public void insertBoard(AdoptDto adDto) {

		adoptDao.insertBoard(adDto);
	}

	@Override //게시글 삭제
	public void deleteBoard(AdoptDto adDto) {

		adoptDao.deleteBoard(adDto);
	}

	@Override //게시글 수정페이지
	public AdoptDto updateBoard(AdoptDto adDto) {

		AdoptDto adoptDto = adoptDao.selectOne(adDto);
		
		return adoptDto;
	}

	@Override //게시글 수정저장
	public void doUpdateBoard(AdoptDto adDto) {
		
		adoptDao.updateBoard(adDto);
		
	}

	@Override //답글페이지 저장
	public void insertReply(AdoptDto adDto) {
		adoptDao.updateBstep(adDto); // 부모보다 큰 step을 1씩 증가
		adoptDao.insertReply(adDto);
	}

	@Override //공지사항 작성 후 저장
	public void insertNotice(AdoptDto adDto) {

		adoptDao.insertNotice(adDto);
	}

	@Override //관리자페이지 - 커뮤니티 모두 불러오기
	public ArrayList<AdoptDto> adoptCommuList() {
		
		ArrayList<AdoptDto> adlist = adoptDao.adoptCommuList(); 
		
		return adlist;
	}

}
