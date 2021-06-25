package com.fpjt.upmu.calendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/calendar")
@Slf4j
public class CalendarController {

	@GetMapping("/calendar.do")
	public String calendar() {
		
		
		return "calendar/calendar";
	}
}
