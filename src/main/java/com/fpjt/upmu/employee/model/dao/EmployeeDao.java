package com.fpjt.upmu.employee.model.dao;

import java.util.Map;

import com.fpjt.upmu.employee.model.vo.EmpProfile;
import com.fpjt.upmu.employee.model.vo.Employee;

public interface EmployeeDao {

	int insertEmployee(Employee employee);
	
	int insertRole(String empEmail);

	void insertAuth(String email);

	void deleteAuth(String email);
	
	Employee selectOneEmp(String id);

	String selectId(Map<String, String> emp);

	String selectCheckId(String id);

	int insertPwSearch(Map<String, String> map);

	String selectCheckPw(String id);

	void deleteSearchPw(String id);

	String selectPwSearchId(String authVal);

	int updatePw(Map<String, String> map);

	int updateEmp(Map<String, Object> rawEmp);

	void deleteEmp(String empEmail);

	int insertProfile(EmpProfile profile);

	String selectProfileName(int empNo);

	int updateProfile(EmpProfile profile);

	String selectProfile(String param);
	
}
