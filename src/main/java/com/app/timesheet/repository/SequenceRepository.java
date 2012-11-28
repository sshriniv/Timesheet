package com.app.timesheet.repository;

import org.springframework.data.repository.CrudRepository;

import com.app.timesheet.domain.IdSequence;

public interface SequenceRepository extends CrudRepository<IdSequence, Long> {
	
	IdSequence findBySeqName(Object seq);

}
