package com.fpjt.upmu.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.notice.model.vo.Notice;

@Repository
public class NoticeDaoImpl implements NoticeDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertNotice(Notice notice) {
		return session.insert("notice.insertNotice", notice);
	}

	@Override
	public List<Notice> selectNoticeList(int empNo) {
		return session.selectList("notice.selectNoticeList",empNo);
	}

	@Override
	public int deleteNotice(int no) {
		return session.delete("notice.deleteNotice", no);
	}

	@Override
	public int updateNotice(int no) {
		return session.update("notice.updateNotice", no);
	}

	@Override
	public int countNoticeList(int empNo) {
		return session.selectOne("notice.countNoticeList",empNo);
	}

	@Override
	public int deleteNoticeList(Map<String, Object> map) {
		return session.delete("notice.deleteNoticeList", map);
	}

}
