package com.fpjt.upmu.attendance.model.vo;



import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
public class AttendanceExt extends Attendance {

	private Double workHour;
}
