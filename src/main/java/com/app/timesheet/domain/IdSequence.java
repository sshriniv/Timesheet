package com.app.timesheet.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "TS_ID_SEQUENCE")
public class IdSequence {
	
	@Id
	/*@GeneratedValue*/
	@Column(name = "SEQID")
	private int seqId;
	
	@Column(name = "PREFIX")
	private String prefix;
	
	@Column(name = "SEQ_NAME")
	private String seqName;
	
	@Column(name = "SEQ_COUNT")
	private int seqCount;

	public int getSeqId() {
		return seqId;
	}

	public void setSeqId(int seqId) {
		this.seqId = seqId;
	}

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public String getSeqName() {
		return seqName;
	}

	public void setSeqName(String seqName) {
		this.seqName = seqName;
	}

	public int getSeqCount() {
		return seqCount;
	}

	public void setSeqCount(int seqCount) {
		this.seqCount = seqCount;
	}
	

}
