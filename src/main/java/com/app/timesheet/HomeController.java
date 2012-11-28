
package com.app.timesheet;

import java.security.Principal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.timesheet.domain.EmployeeSearch;
import com.app.timesheet.domain.Project;
import com.app.timesheet.domain.Team;
import com.app.timesheet.domain.TeamProject;
import com.app.timesheet.domain.Email;
import com.app.timesheet.domain.Employee;
import com.app.timesheet.domain.IdSequence;
import com.app.timesheet.domain.Phone;
import com.app.timesheet.service.EmployeeService;
import com.app.timesheet.service.ProjectService;
import com.app.timesheet.service.SequenceService;
import com.app.timesheet.service.TeamService;

import org.codehaus.jackson.map.JsonSerializer;
import flexjson.JSONSerializer;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private EmployeeService employeeService;
	
	@Autowired
	private SequenceService sequenceService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private TeamService teamService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/employeeprofile", method = RequestMethod.GET)
	public String employeeprofile(Locale locale, Model model) {
		logger.info("Welcome home! the client locale is "+ locale.toString());
		model.addAttribute("employeecreated", "");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		/*return "home";*/
		Employee employee = new Employee();
		model.addAttribute(employee);
		return "employeeprofile";
	}
	
	@RequestMapping(value = "/employeeprofile", method = RequestMethod.POST)
	public String addemployee(@ModelAttribute("employee") Employee employee, Model model){
		
		String emplid;
		
		String currentEmplId = employee.getEmplId();
		System.out.println("currentemplid new Before Save: "+currentEmplId);
		List<Phone> phones1 = employee.getPhones();
		List<Email> emailAddresses = employee.getEmailAddresses();
		for(Phone eachPhone: phones1){
			eachPhone.setEmpl(employee);
		}
		for(Email eachEmail: emailAddresses){
			eachEmail.setEmpl(employee);
		}
		
		if(currentEmplId.equals("NEXT")){
			IdSequence id = sequenceService.findBySeqName("EMPLID");
			int seqCount = id.getSeqCount();
			emplid = "TS"+seqCount;
			employee.setEmplId(emplid);
			/*Update Count on TS_ID_SEQUENCE*/
			seqCount++;
			id.setSeqCount(seqCount);
			sequenceService.save(id);
			/*Update Count on TS_ID_SEQUENCE*/
			
		}
		employeeService.save(employee);
		/*Fetch Saved Employee*/
		IdSequence id = sequenceService.findBySeqName("EMPLID");
		int seqCount = id.getSeqCount();
		seqCount = seqCount-1;
		emplid = "TS"+seqCount;
		System.out.println("Emplid being searched: "+emplid);
		employee = employeeService.findByEmplId(emplid);
		/*Fetch Saved Employee*/
		model.addAttribute("employeecreatedorupdated", "true");
		/*Add fetched employee to model*/
		model.addAttribute(employee);
		List<Phone> phones = employee.getPhones();
		/*Add fetched employee to model*/
		String DateOfbirthStr = employee.getDateOfbirthStr();
		model.addAttribute(DateOfbirthStr);
		String DateOfjoinStr = employee.getDateOfjoinStr();
		model.addAttribute(DateOfjoinStr);
		System.out.println("Emplid after adding to model: "+employee.getEmplId());
		List<Phone> testPhones = employee.getPhones();
		for(Phone eachphone: testPhones){
			System.out.println("Phoneid after adding to model: "+eachphone.getId());
		}
		return "employeeprofile";
	}
	
	@RequestMapping(value = "/addphone", method = RequestMethod.GET)
	public String addphone(@RequestParam(value="count") int phoneCount,ModelMap model){
		Employee employee = new Employee();
		model.addAttribute("employee", employee);
		model.addAttribute("phonecount", phoneCount);
		return "addnewphone";
	}
	
	@RequestMapping(value = "/employeesearch", method = RequestMethod.GET)
	public @ResponseBody String searchemployee(@RequestParam(value="emplid") String searchEmplId,@RequestParam(value="firstname") String searchFirstName){
		
		List<Employee> searchEmployeeList = new ArrayList<Employee>();
		System.out.println("searchemplid= "+searchEmplId);
		System.out.println("searchfirstname= "+searchFirstName);
		if(!searchEmplId.isEmpty()){
            if(!searchFirstName.isEmpty()){
				/*emplid has value*/
				/*firstname has value*/
				System.out.println("Value of search emplid: "+searchEmplId);
				System.out.println("Value of search firstname: "+searchFirstName);
				searchEmployeeList = employeeService.findByEmplIdAndFirstName(searchEmplId, searchFirstName);
			}else{
				/*emplid has value*/
				/*firstname has no value*/
				System.out.println("Value of search emplid: "+searchEmplId);
				System.out.println("Value of search firstname: "+searchFirstName);
				Employee searchEmployee = employeeService.findByEmplId(searchEmplId);
				searchEmployeeList.add(searchEmployee);
				System.out.println("Employee returned: "+searchEmployee.getFirstName());
			}
		}else 
			if(!searchFirstName.isEmpty()){
			/*emplid has no value*/
			/*firstname has value*/
				System.out.println("Value of search emplid: "+searchEmplId);
				System.out.println("Value of search firstname: "+searchFirstName);
				/*System.out.println("Employee returned: "+searchemployee.getFirstname());*/
				searchEmployeeList = employeeService.findByFirstName(searchFirstName);
		    }else{
		    /*emplid has no value*/
			/*firstname has no value*/	
		    }
		return new JSONSerializer().include("phones").serialize(searchEmployeeList);
	}
	
	/*@RequestMapping(value = "/employeesearch", method = RequestMethod.GET)
	public @ResponseBody String searchemployee(@RequestParam(value="emplid") String searchemplid){
		List<employee> searchemployeelist = new ArrayList<employee>();
		employee searchemployee = employeeservice.findByEmplid(searchemplid);
		searchemployeelist.add(searchemployee);
		System.out.println("Value of emplid: "+searchemplid);
		System.out.println("Employee returned: "+searchemployee.getFirstname());
		return new JSONSerializer().include("phones").serialize(searchemployeelist);
	}*/
	
	/*@RequestMapping(value = "/employeesearch", method = RequestMethod.GET)
	public @ResponseBody String searchemployee(@RequestParam(value="emplid") String searchemplid){
		employee searchemployee = employeeservice.findByEmplid(searchemplid);
		System.out.println("Value of emplid: "+searchemplid);
		System.out.println("Employee returned: "+searchemployee.getFirstname());
		return new JSONSerializer().include("phones").serialize(searchemployee);
	}*/
	
	/*@RequestMapping(value = "/employeesearch", method = RequestMethod.GET)
	public @ResponseBody employee searchemployee(@RequestParam String searchEmplId){
        System.out.println("In controller : " + searchEmplId);		
		employee searchemployee = employeeservice.findByEmplid(searchEmplId);
		System.out.println("Employee returned: "+searchemployee.getFirstname());
		return searchemployee;
	}*/
	
	
	
	@RequestMapping(value = "/employeesearchadd", method = RequestMethod.GET)
	public String employeesearchaddpage(Model model){
		EmployeeSearch employeeSearch = new EmployeeSearch();
		model.addAttribute("employeesearch",employeeSearch);
		return "employeesearchadd";
	}
	
	@RequestMapping(value = "/employeesearchaddnew", method = RequestMethod.POST)
	public String employeesearchaddpagenew(Model model){
		EmployeeSearch employeeSearch = new EmployeeSearch();
		model.addAttribute("employeesearch",employeeSearch);
		return "employeesearchadd";
	}
	
	@RequestMapping(value = "/fetchsearchemployee", method = RequestMethod.GET)
	public String fetchsearchemployee(String emplid,Model model){
		System.out.println("In fetchsearchemployee: "+emplid);
		Employee employee = employeeService.findByEmplId(emplid);
		model.addAttribute(employee);
		model.addAttribute("employeecreatedorupdated", "true");
		List<Phone> phones = employee.getPhones();
		return "employeeprofile";
	}
	
	/*@RequestMapping(value = "/employeesearch", method = RequestMethod.POST)
	public String employeesearch(@ModelAttribute("employeesearch") EmployeeSearch employeesearch, Model model){
		String searchemplid = employeesearch.getEmplid();
		employee employee = employeeservice.findByEmplid(searchemplid);
		model.addAttribute(employee);
		model.addAttribute("employeecreatedorupdated", "true");
		System.out.println("Fetched emplid: "+employee.getEmplid());
		List<phone> phones = employee.getPhones();	
		return "employeeprofile";
	}*/
	
	@RequestMapping(value = "/projects", method = RequestMethod.GET)
	public String projects(Locale locale, Model model){
		model.addAttribute("projectcreatedorupdated", "");
		Project project = new Project();
		model.addAttribute(project);
		return "projects";
	}
	
	@RequestMapping(value = "/projects", method = RequestMethod.POST)
	public String addprojects(@ModelAttribute("project") Project project, Model model){
        String currentProjectId;
        currentProjectId = project.getProjectId();
        if(currentProjectId.equals("NEXT")){
        	IdSequence id = sequenceService.findBySeqName("PROJECTID");
        	int seqCount = id.getSeqCount();
        	currentProjectId = "TS_P"+seqCount;
        	project.setProjectId(currentProjectId);
			/*Update Count on TS_ID_SEQUENCE*/
			seqCount++;
			id.setSeqCount(seqCount);
			sequenceService.save(id);
			/*Update Count on TS_ID_SEQUENCE*/	
        }
        projectService.save(project);
        /*Retrieve Saved Project*/
        IdSequence id = sequenceService.findBySeqName("PROJECTID");
        int seqCount = id.getSeqCount();
        seqCount = seqCount-1;
        currentProjectId = "TS_P"+seqCount;
        project = projectService.findByProjectId(currentProjectId);
        /*Retrieve Saved Project*/
        model.addAttribute("projectcreatedorupdated", "true");
        /*Add fetched Project to model*/
        model.addAttribute(project);
        /*Add fetched Project to model*/
		return "projects";
	}

	@RequestMapping(value = "/projectsearchadd", method = RequestMethod.GET)
	public String projectsearchaddpage(Model model){
		return "projectsearchadd";
	}
	
	@RequestMapping(value = "/projectsearch", method = RequestMethod.GET)
	public @ResponseBody String searchproject(@RequestParam(value="projectId") String searchProjectId){
		System.out.println("Project Id: "+searchProjectId);
		Project searchProject = projectService.findByProjectId(searchProjectId);
		System.out.println("Project Id Found: "+searchProject.getProjectId());
		System.out.println("Project Id Found: "+searchProject.getClientName());
		return new JSONSerializer().serialize(searchProject);
	}
	
	@RequestMapping(value = "/fetchsearchproject", method = RequestMethod.GET)
	public String fetchsearchproject(String projectId,Model model){
		System.out.println("In fetchsearchproject: "+projectId);
		Project project = projectService.findByProjectId(projectId);
		model.addAttribute(project);
		model.addAttribute("projectcreatedorupdated", "true");
		return "projects";
	}
	
	@RequestMapping(value = "/fetchsearchproject", method = RequestMethod.POST)
	public String fetchsearchproject(String projectId,@ModelAttribute("project") Project project, Model model){
		System.out.println("In fetchsearchproject - POST2:");
		String currentProjectId = project.getProjectId();
		System.out.println("In fetchsearchproject - POST2 - currentprojectId: "+currentProjectId);
		System.out.println("In fetchsearchproject - POST2 - projectId: "+projectId);
		projectService.save(project);
        /*Retrieve Saved Project*/
        project = projectService.findByProjectId(currentProjectId);
        System.out.println("In fetchsearchproject - POST2 - found project id: "+project.getProjectId());
        /*Retrieve Saved Project*/
        model.addAttribute("projectcreatedorupdated", "true");
        /*Add fetched Project to model*/
        model.addAttribute(project);
        /*Add fetched Project to model*/
		return "projects";
	}
	
	@RequestMapping(value = "/teams", method = RequestMethod.GET)
	public String teams(Locale locale, Model model){
		model.addAttribute("teamcreatedorupdated", "");
		Team team = new Team();
		model.addAttribute(team);
		return "teams";
	}
	
	@RequestMapping(value = "/teams", method = RequestMethod.POST)
	public String addteams(@ModelAttribute("team") Team team, Model model){
		String currentTeamId;
		currentTeamId = team.getTeamId();
		List<TeamProject> projects = team.getProjects();
		for(TeamProject eachProject: projects){
			eachProject.setTeam(team);
		}
        if(currentTeamId.equals("NEXT")){
        	IdSequence id = sequenceService.findBySeqName("TEAMID");
        	int seqCount = id.getSeqCount();
        	currentTeamId = "TS_T"+seqCount;
        	team.setTeamId(currentTeamId);
			/*Update Count on TS_ID_SEQUENCE*/
			seqCount++;
			id.setSeqCount(seqCount);
			sequenceService.save(id);
			/*Update Count on TS_ID_SEQUENCE*/
        }
		teamService.save(team);
		/*Retrieve Saved Team*/
		IdSequence id = sequenceService.findBySeqName("TEAMID");
        int seqCount = id.getSeqCount();
        System.out.println("seqcount: "+seqCount);
        seqCount = seqCount-1;
        currentTeamId = "TS_T"+seqCount;
        System.out.println("currentteamId: "+currentTeamId);
        team = teamService.findByTeamId(currentTeamId);
        System.out.println("Retrieved Team Id: "+team.getTeamId());
		/*Retrieve Saved Team*/
        model.addAttribute("teamcreatedorupdated", "true");
        /*Add fetched Project to model*/
        model.addAttribute(team);
        /*Add fetched Project to model*/
        return "teams";
	}
	
	@RequestMapping(value = "/addproject", method = RequestMethod.GET)
	public String addproject(@RequestParam(value="count") int projectCount,ModelMap model){
		Team team = new Team();
		model.addAttribute("team",team);
		model.addAttribute("projectcount",projectCount);
		return "addnewproject";
	}
	
	
	
	@InitBinder
	public void initBinder(WebDataBinder webDataBinder) {
	 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	 dateFormat.setLenient(false);
	 webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
}
