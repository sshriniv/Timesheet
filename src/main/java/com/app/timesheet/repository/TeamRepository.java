package com.app.timesheet.repository;

import org.springframework.data.repository.CrudRepository;
import com.app.timesheet.domain.Team;

public interface TeamRepository extends CrudRepository<Team, Long> {
	
	Team findByTeamId(String teamId);

}
