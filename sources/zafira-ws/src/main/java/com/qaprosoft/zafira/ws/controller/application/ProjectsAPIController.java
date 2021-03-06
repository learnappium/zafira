/*******************************************************************************
 * Copyright 2013-2018 QaProSoft (http://www.qaprosoft.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *******************************************************************************/
package com.qaprosoft.zafira.ws.controller.application;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import com.qaprosoft.zafira.ws.controller.AbstractController;

import org.dozer.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.qaprosoft.zafira.models.db.Project;
import com.qaprosoft.zafira.models.dto.ProjectType;
import com.qaprosoft.zafira.services.exceptions.ProjectNotFoundException;
import com.qaprosoft.zafira.services.exceptions.ServiceException;
import com.qaprosoft.zafira.services.services.application.ProjectService;
import com.qaprosoft.zafira.ws.swagger.annotations.ResponseStatusDetails;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

@Controller
@Api(value = "Projects API")
@CrossOrigin
@RequestMapping("api/projects")
public class ProjectsAPIController extends AbstractController {
	@Autowired
	private Mapper mapper;

	@Autowired
	private ProjectService projectService;

	@ResponseStatusDetails
	@ApiOperation(value = "Create project", nickname = "createProject", httpMethod = "POST", response = ProjectType.class)
	@ResponseStatus(HttpStatus.OK)
	@ApiImplicitParams({ @ApiImplicitParam(name = "Authorization", paramType = "header") })
	@PreAuthorize("hasPermission('MODIFY_PROJECTS')")
	@RequestMapping(method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ProjectType createProject(@RequestBody @Valid ProjectType project) throws ServiceException {
		Project newProject = projectService.createProject(mapper.map(project, Project.class));
		return mapper.map(newProject, ProjectType.class);
	}

	@ResponseStatusDetails
	@ApiOperation(value = "Delete project", nickname = "deleteProject", httpMethod = "DELETE")
	@ResponseStatus(HttpStatus.OK)
	@ApiImplicitParams({ @ApiImplicitParam(name = "Authorization", paramType = "header") })
	@PreAuthorize("hasPermission('MODIFY_PROJECTS')")
	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public void deleteProject(@PathVariable(value = "id") long id) throws ServiceException {
		projectService.deleteProjectById(id);
	}

	@ResponseStatusDetails
	@ApiOperation(value = "Update project", nickname = "updateProject", httpMethod = "PUT", response = ProjectType.class)
	@ResponseStatus(HttpStatus.OK)
	@ApiImplicitParams({ @ApiImplicitParam(name = "Authorization", paramType = "header") })
	@PreAuthorize("hasPermission('MODIFY_PROJECTS')")
	@RequestMapping(method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ProjectType updateProject(@RequestBody @Valid ProjectType project) throws ServiceException {
		Project updatedProject = projectService.updateProject(mapper.map(project, Project.class));
		return mapper.map(updatedProject, ProjectType.class);
	}

	@ResponseStatusDetails
	@ApiOperation(value = "Get all projects", nickname = "getAllProjects", httpMethod = "GET", response = List.class)
	@ResponseStatus(HttpStatus.OK)
	@ApiImplicitParams({ @ApiImplicitParam(name = "Authorization", paramType = "header") })
	@RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody List<ProjectType> getAllProjects() throws ServiceException {
		List<ProjectType> projects = new ArrayList<>();
		for (Project project : projectService.getAllProjects()) {
			projects.add(mapper.map(project, ProjectType.class));
		}
		return projects;
	}
	
	@ResponseStatusDetails
	@ApiOperation(value = "Get project by name", nickname = "getProjectByName", httpMethod = "GET", response = ProjectType.class)
	@ResponseStatus(HttpStatus.OK)
	@ApiImplicitParams({ @ApiImplicitParam(name = "Authorization", paramType = "header") })
	@RequestMapping(value = "{name}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ProjectType getProjectByName(@PathVariable(value = "name") String name) throws ServiceException {
		Project project = projectService.getProjectByName(name);
		if(project == null) {
			throw new ProjectNotFoundException();
		}
		return mapper.map(project, ProjectType.class);
	}
}
