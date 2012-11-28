package com.app.timesheet.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.timesheet.domain.Team;
import com.app.timesheet.repository.TeamRepository;

@Service
@Repository
@Transactional
public class TeamServiceImpl implements TeamService {

	@Autowired
	private TeamRepository teamRepository;
	
	public Team findByTeamId(String teamId) {
		return teamRepository.findByTeamId(teamId);
	}

	public void save(Team team) {
		teamRepository.save(team);
	}

}
