package com.app.timesheet.service;

import com.app.timesheet.domain.Project;

public interface ProjectService {
	
	public void save(Project project);
	
	public Project findByProjectId(String projectId);

}
