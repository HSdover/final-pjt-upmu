package com.fpjt.upmu.attendance.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attendance {
	
	private int attNo;
	private int empNo;
	private Date attStart;
	private Date attEnd;
	private String empName;
	
}
