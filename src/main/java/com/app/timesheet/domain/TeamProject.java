package com.app.timesheet.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "TS_TEAM_PROJECT")
public class TeamProject {
	
	@Id
	@GeneratedValue
	@Column(name = "TEAM_PROJECT_ID")
	private int teamProjectId;
	
	@Column(name = "PROJECT")
	private String project;
	
	@ManyToOne()
	@JoinColumn(name = "TEAMID")
	private Team team;

	
	public int getTeamProjectId() {
		return teamProjectId;
	}

	public void setTeamProjectId(int teamProjectId) {
		this.teamProjectId = teamProjectId;
	}

	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}

	public Team getTeam() {
		return team;
	}

	public void setTeam(Team team) {
		this.team = team;
	}
	
	

}
