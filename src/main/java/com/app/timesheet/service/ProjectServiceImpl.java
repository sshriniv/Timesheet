package com.app.timesheet.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.timesheet.domain.Project;
import com.app.timesheet.repository.ProjectRepository;

@Service
@Repository
@Transactional
public class ProjectServiceImpl implements ProjectService {
	
	@Autowired
	private ProjectRepository projectRepository;
	
	public void save(Project project){
		projectRepository.save(project);
	}

	public Project findByProjectId(String projectId) {
		return projectRepository.findByProjectId(projectId);
	}

}
