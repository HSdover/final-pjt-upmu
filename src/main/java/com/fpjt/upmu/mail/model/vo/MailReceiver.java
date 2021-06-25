package com.fpjt.upmu.mail.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MailReceiver {
	
	private int empNo;
	private String empName;
	private String jobName;
	private String depName;

}