package com.fpjt.upmu.attendance.model.dao;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.attendance.model.vo.Attendance;
import com.fpjt.upmu.attendance.model.vo.AttendanceExt;

public interface AttendanceDao {

	int startWork(int empNo);

	int endWork(int empNo);

	List<Attendance> selectWorkList(Map<String, Object> map);

	List<AttendanceExt> totalWorkHourList(int empNo);

	List<AttendanceExt> weekHourList(Map<String, Object> map);

}
