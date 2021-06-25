package com.fpjt.upmu.attendance.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.attendance.model.vo.Attendance;
import com.fpjt.upmu.attendance.model.vo.AttendanceExt;

@Repository
public class AttendanceDaoImpl implements AttendanceDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int startWork(int empNo) {
		
		return session.insert("attendance.startWork", empNo);
	}

	@Override
	public int endWork(int empNo) {
	
		return session.update("attendance.endWork", empNo);
	}

	@Override
	public List<Attendance> selectWorkList(Map<String, Object> map) {
		
		return session.selectList("attendance.selectWorkList", map);
	}

	@Override
	public List<AttendanceExt>totalWorkHourList(int empNo) {
		
		return session.selectList("attendance.totalWorkHourList", empNo);
	}

	@Override
	public List<AttendanceExt> weekHourList(Map<String, Object> map) {
		
		return session.selectList("attendance.weekHourList", map);
	}
	
	

}
