package com.app.timesheet.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.timesheet.domain.IdSequence;
import com.app.timesheet.repository.SequenceRepository;

@Service
@Repository
@Transactional
public class SequenceServiceImpl implements SequenceService {
	
	@Autowired
	private SequenceRepository sequenceRepository;

	public IdSequence findBySeqName(Object seq) {
		return sequenceRepository.findBySeqName(seq);
	}

	public void save(IdSequence id) {
		sequenceRepository.save(id);
	}

}
