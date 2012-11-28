package com.app.timesheet.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.app.timesheet.domain.Project;

public interface ProjectRepository extends CrudRepository<Project, Long> {
	
	Project findByProjectId(String projectId);
	
}
