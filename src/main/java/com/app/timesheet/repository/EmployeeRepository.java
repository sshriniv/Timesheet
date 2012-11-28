package com.app.timesheet.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.app.timesheet.domain.Employee;
import com.app.timesheet.domain.IdSequence;

public interface EmployeeRepository extends CrudRepository<Employee, Long> {
	
	Employee findByEmplId(String emplId);
	
	List<Employee> findByFirstName(String firstName);
	
	List<Employee> findByEmplIdAndFirstName(String emplId, String firstName);

}
