package com.app.timesheet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.timesheet.domain.Employee;
import com.app.timesheet.repository.EmployeeRepository;
import com.google.common.collect.Lists;

@Service
@Repository
@Transactional
public class EmployeeServiceImpl implements EmployeeService {
	
	@Autowired
	private EmployeeRepository employeeRepository;

	@Transactional(readOnly=true)
	public List<Employee> findAll() {
		
		return Lists.newArrayList(employeeRepository.findAll());
		
	}

	public void save(Employee employee) {
		employeeRepository.save(employee);
	}

	public Employee findByEmplId(String emplid) {
		return employeeRepository.findByEmplId(emplid);
	}

	public List<Employee> findByFirstName(String firstname) {
		return employeeRepository.findByFirstName(firstname);
	}

	public List<Employee> findByEmplIdAndFirstName(String emplid,
			String firstname) {
		return employeeRepository.findByEmplIdAndFirstName(emplid, firstname);
	}
	


}
