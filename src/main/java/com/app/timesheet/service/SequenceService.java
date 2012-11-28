package com.app.timesheet.service;

import java.util.List;

import com.app.timesheet.domain.Employee;
import com.app.timesheet.domain.IdSequence;

public interface SequenceService {
	
	public IdSequence findBySeqName(Object seq);
	
	public void save(IdSequence id);

}
