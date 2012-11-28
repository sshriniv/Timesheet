package com.app.timesheet.seqgen;

import java.io.Serializable;

import org.hibernate.HibernateException;
import org.hibernate.engine.SessionImplementor;
import org.hibernate.id.IdentifierGenerator;
import org.springframework.beans.factory.annotation.Autowired;

import com.app.timesheet.domain.IdSequence;
import com.app.timesheet.service.SequenceService;

public class Sequencegenerator implements IdentifierGenerator {
	
	@Autowired
	private SequenceService sequenceService;

	public Serializable generate(SessionImplementor arg0, Object arg1)
			throws HibernateException {
		IdSequence idsequence = sequenceService.findBySeqName(arg1);
		String code = idsequence.getPrefix() + "" + idsequence.getSeqCount()+"000";
		return code;
	}

}
