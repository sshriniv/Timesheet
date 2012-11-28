package com.app.timesheet.domain;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "TS_EMPLOYEE")
public class Employee {

	@Id
	@Column(name = "EMPLID")
	private String emplId;
	
	@Column(name = "FIRST_NAME")
	private String firstName;
	
	@Column(name = "LAST_NAME")
	private String lastName;
	
	@Column(name = "BIRTHDATE",columnDefinition = "DATE")
	private Date dateOfBirth;
	
	@OneToMany(mappedBy = "empl", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@Fetch(value = FetchMode.SUBSELECT)
	private List<Phone> phones = new ArrayList<Phone>();
	
	@OneToMany(mappedBy = "empl", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@Fetch(value = FetchMode.SUBSELECT)
	private List<Email> emailAddresses = new ArrayList<Email>();
	
	@Column(name = "TEAM")
	private String team;
	
	@Column(name = "PROJECT")
	private String project;
	
	@Column(name = "JOINDATE")
	private Date dateOfJoin;

	public String getEmplId() {
		return emplId;
	}

	public void setEmplId(String emplId) {
		this.emplId = emplId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}



	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public Date getDateOfJoin() {
		return dateOfJoin;
	}
	
	public String getDateOfbirthStr() {
		SimpleDateFormat sdfDestination = new SimpleDateFormat("MM/dd/yyyy");
	    return sdfDestination.format(dateOfBirth);
	}
	
	public String getDateOfjoinStr() {
		SimpleDateFormat sdfDestination = new SimpleDateFormat("MM/dd/yyyy");
	    return sdfDestination.format(dateOfJoin);
	}

	public void setDateOfJoin(Date dateOfJoin) {			
		this.dateOfJoin = dateOfJoin;
	}

	public List<Phone> getPhones() {
		return phones;
	}

	public void setPhones(List<Phone> phones) {
		this.phones = phones;
	}

	public List<Email> getEmailAddresses() {
		return emailAddresses;
	}

	public void setEmailAddresses(List<Email> emailAddresses) {
		this.emailAddresses = emailAddresses;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}

	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}


	
	
}
