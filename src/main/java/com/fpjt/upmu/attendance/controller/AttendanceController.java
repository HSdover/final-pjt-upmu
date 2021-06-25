package com.fpjt.upmu.attendance.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fpjt.upmu.attendance.model.service.AttendanceService;
import com.fpjt.upmu.attendance.model.vo.Attendance;
import com.fpjt.upmu.attendance.model.vo.AttendanceExt;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/attendance")
public class AttendanceController {

	@Autowired
	private AttendanceService attendanceService;

	@GetMapping("/attendanceManage.do")
	public String attendanceManage() {

		return "/attendance/attendanceManage";
	}

	// 업무 시작
	@GetMapping("/startWork/{empNo}")
	public String startWork(@PathVariable int empNo) {
		try {
			log.debug("empNo {}", empNo);
			int result = attendanceService.startWork(empNo);
		} catch (Exception e) {
			log.error("출근 입력 오류", e);
			throw e;
		}
		return "/attendance/attendanceManage";
	}

	// 업무 종료
	@GetMapping("/endWork/{empNo}")
	public String endWork(@PathVariable int empNo) {
		try {
			log.debug("empNo {}", empNo);
			int result = attendanceService.endWork(empNo);
		} catch (Exception e) {
			log.error("퇴근 입력 오류", e);
			throw e;
		}
		return "/attendance/attendanceManage";
	}

	// 주간 근무
	@GetMapping("/workHour")
	@ResponseBody
	public List<AttendanceExt> workHourList(@RequestParam int empNo, @RequestParam int startOfWeek, @RequestParam int endOfWeek) {
		try {
			log.debug("empNo {}, startOfWeek {}", empNo, startOfWeek);
			log.debug("endOfWeek {}", endOfWeek);
			Map<String, Object> map = new HashMap<>();
			map.put("empNo", empNo);
			map.put("startOfWeek", startOfWeek);
			map.put("endOfWeek", endOfWeek);
			
			List<AttendanceExt> weekHourList = attendanceService.weekHourList(map);
			log.debug("weekHourList {}", weekHourList);
			return weekHourList;

		} catch (Exception e) {
			log.error("시간 조회 오류", e);
			throw e;
		}

	}

	// 주간 총 근무 미사용
	@GetMapping("/weekTotalWorkHour/{empNo}")
	@ResponseBody
	public List<AttendanceExt> weekTotalWorkHour(@PathVariable int empNo, @RequestParam int startOfWeek, @RequestParam int endOfWeek) {
		try {
			log.debug("empNo {}", empNo);

			List<AttendanceExt> totalhourList = attendanceService.totalWorkHourList(empNo);
			log.debug("hourList {}", totalhourList);
			return totalhourList;

		} catch (Exception e) {
			log.error("시간 조회 오류", e);
			throw e;
		}

	}

	// 근태내역테이블 조회
	@GetMapping("/workTable")
	@ResponseBody
	public List<Attendance> selectWorkTable(@RequestParam int empNo, @RequestParam String search) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("empNo", empNo);
			map.put("search", search);
			
			List<Attendance> list = attendanceService.selectWorkList(map);
			
			return list;
		} catch (Exception e) {
			log.error("근무 내역 조회 오류", e);
			throw e;
		}
	}
}
