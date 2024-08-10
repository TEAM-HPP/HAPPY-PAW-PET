package com.java.service.adopt;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dao.AdoptLikelistDao;
import com.java.dto.AdoptLikelistDto;

@Service
public class AdoptLikelistServiceImpl implements AdoptLikelistService {

	@Autowired AdoptLikelistDao adlikelistDao;
	
	@Override //게시글 좋아요 누르기
	public void likeOn(String id, int bno) {
		adlikelistDao.likeOn(id, bno);
	}

	@Override  //게시글 좋아요 취소
	public void likeOff(String id, int bno) {
		adlikelistDao.likeOff(id, bno);
	}

	@Override //게시글 당 좋아요 개수 세기
	public int selectLikeCountByBno(int bno) {
		return adlikelistDao.selectLikeCountByBno(bno);
	}

	@Override //사용자가 좋아요를 눌렀는지 확인하는 메소드
	public boolean isLikedByUser(String id, int bno) {
		return adlikelistDao.isLikedByUser(id, bno);
	}



}
