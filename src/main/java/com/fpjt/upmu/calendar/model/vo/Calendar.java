package com.fpjt.upmu.calendar.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Calendar {
	
	private int schNo;
	private int empNo;
	private String schTitle;
	private String schContent;
	private String schStart;
	private String schEnd;
	private String schType;

}
