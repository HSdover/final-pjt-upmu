package com.fpjt.upmu.attendance.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.attendance.model.dao.AttendanceDao;
import com.fpjt.upmu.attendance.model.vo.Attendance;
import com.fpjt.upmu.attendance.model.vo.AttendanceExt;

@Service
public class AttendanceServiceImpl implements AttendanceService {

	@Autowired
	AttendanceDao attendanceDao;
	
	@Override
	public int startWork(int empNo) {
		
		return attendanceDao.startWork(empNo);
	}

	@Override
	public int endWork(int empNo) {
		
		return attendanceDao.endWork(empNo);
	}


	@Override
	public List<Attendance> selectWorkList(Map<String, Object> map) {
		
		return attendanceDao.selectWorkList(map);
	}

	@Override
	public List<AttendanceExt> totalWorkHourList(int empNo) {
		
		return attendanceDao.totalWorkHourList(empNo);
	}

	@Override
	public List<AttendanceExt> weekHourList(Map<String, Object> map) {
		
		return attendanceDao.weekHourList(map);
	}

	
}
