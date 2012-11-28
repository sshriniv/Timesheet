package com.app.timesheet.service;

import com.app.timesheet.domain.Project;
import com.app.timesheet.domain.Team;

public interface TeamService {
	
	public void save(Team team);
	
	public Team findByTeamId(String teamId);

}
