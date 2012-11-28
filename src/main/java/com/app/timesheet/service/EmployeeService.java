package com.app.timesheet.service;

import java.util.List;

import com.app.timesheet.domain.Employee;

public interface EmployeeService {
	
	public List<Employee> findAll();
	
	public void save(Employee employee);
	
	public Employee findByEmplId(String emplId);
	
	public List<Employee> findByFirstName(String firstName);
	
	public List<Employee> findByEmplIdAndFirstName(String emplId, String firstName);

}
