package com.app.timesheet.domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "TS_TEAM")
public class Team {
	
	@Id
	@Column(name = "TEAMID")
	private String teamId;
	
	@Column(name = "DESCR")
	private String description;
	
	@OneToMany(mappedBy = "team", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	private List<TeamProject> projects = new ArrayList<TeamProject>();
	

	public List<TeamProject> getProjects() {
		return projects;
	}

	public void setProjects(List<TeamProject> projects) {
		this.projects = projects;
	}

	public String getTeamId() {
		return teamId;
	}

	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
}
