package com.fpjt.upmu.calendar.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/calendar")
@Slf4j
public class CalendarController {

	@GetMapping("/calendar.do")
	public String calendar() {
		
		
		return "calendar/calendar";
	}
	
	@PostMapping("/calendarEnroll.do")
	public String calendarEnroll(@RequestParam Map<String, Object> calMap) {
		log.debug("calMap = {}", calMap);
		
		return "";
	}
}
