<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link href="https://fonts.googleapis.com/css?family=Limelight%7CFlamenco%7CFedero%7CYesteryear%7CJosefin+Sans%7CSpinnaker%7CSansita+One%7CHandlee%7CDroid+Sans%7COswald:400,300,700"
    media="screen" rel="stylesheet" type="text/css" />
    <c:url value="/resources/styles/bootstrap.css" var="bootstrapurl" />
    <c:url value="/resources/styles/bootstrap-responsive.css" var="bootstrap-responsiveurl" />
    <c:url value="/resources/styles/fontawesome.css" var="fontawesomeurl" />
    <c:url value="/resources/styles/style.css" var="styleurl" />
    <c:url value="/resources/styles/datepicker.css" var="datepickerurl" />
    <link rel="stylesheet" href="${bootstrapurl}" type="text/css" media="screen">
    <link rel="stylesheet" href="${bootstrap-responsiveurl}" type="text/css" media="screen">
    <link rel="stylesheet" href="${fontawesomeurl}" type="text/css" media="screen">
    <link rel="stylesheet" href="${styleurl}" type="text/css" media="screen">
    <link rel="stylesheet" href="${datepickerurl}" type="text/css" media="screen">      
    <!-- Typekit fonts require an account and a kit containing the fonts used. see https://typekit.com/plans
    for details. <script type="text/javascript" src="//use.typekit.net/YOUR-KIT-ID.js"></script>
      <script type="text/javascript">try{Typekit.load();}catch(e){}</script>
    -->
    <title>Teams</title>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery.min.js"></script>
    
    <script type="text/javascript">
    $(document).ready(function(){
    	var projectcount = 0;
    	$('#addproject').click(function(){
    		projectcount++;
    		
    		$.get("addproject", {count : projectcount},callback);
    	    function callback(data){
    	             /*alert('in Callback new');*/
    	             $("#addproject").after(data);
    	    };
    	    return false;
    	});
    });
    </script>
</head>


<body>
  <c:if test="${empty teamcreatedorupdated}">
  
 
  
   
       <h2 class="heading heading-2">Teams</h2>
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span3">
        <div class="well sidebar-nav">
           <ul class="nav nav-list">
             <li class="nav-header">Employee</li>
               <li class="active"><a href="<c:url value="/employeesearchadd" />">Employee Profile</a></li>
             <li class="nav-header">Setup</li>
               <li><a href="<c:url value="/projectsearchadd" />">Projects</a></li>
             <li><a href="<c:url value="/teams" />">Teams</a></li>
           </ul>
        </div>
      </div>
    </div> 
  </div>
       <form:form id="teams" name="teams" action="/Timesheet/teams" method="POST" commandName="team">
         <form:label class="formlabel" for="teamid" path="teamId">Team Id:</form:label>
         <form:input type="text" id="teamid" class="uneditable-input" value="NEXT" path = "teamId"/>
         <form:label class="formlabel" for="description" path="description">Description:</form:label>
         <form:input type="text" id="description" placeholder="Description" path="description"/>
         <fieldset>
            <legend><br>Projects</legend>
            <spring:bind path="team.projects[0].project">
              <form:label for="project" class="formlabel" path="${status.expression}">Project:</form:label>
              <form:select class="select-1" id="project" path="${status.expression}">
                <option value="Chase">Chase</option>
                <option value="Geico">Geico</option>
              </form:select>
            </spring:bind>
            <button class="btn" id="addproject">Add Project</button>
         </fieldset>
         <div class="form-actions">
          <button class="btn btn-primary">Save</button>
          <button class="btn">Cancel</button>
         </div>
       </form:form>
  
</c:if>

<c:if test="${not empty teamcreatedorupdated}">
       <h2 class="heading heading-2">Teams</h2>
         <div class="container-fluid">
    <div class="row-fluid">
      <div class="span3">
        <div class="well sidebar-nav">
           <ul class="nav nav-list">
             <li class="nav-header">Employee</li>
               <li class="active"><a href="<c:url value="/employeesearchadd" />">Employee Profile</a></li>
             <li class="nav-header">Setup</li>
               <li><a href="<c:url value="/projectsearchadd" />">Projects</a></li>
             <li><a href="<c:url value="/teams" />">Teams</a></li>
           </ul>
        </div>
      </div>
    </div> 
  </div>
       <form:form id = "teams" name="teams" action="/Timesheet/teams" method="POST" commandName="team">
         <form:label class="formlabel" for="teamid" path="teamId">Team Id:</form:label>
         <form:input type="text" id="teamid" class="uneditable-input" value='${team.teamId}' path="teamId"/>
         <form:label class="formlabel" for="description" path="description">Description:</form:label>
         <form:input type="text" id="description" value='${team.description}' path="description"/>
         <fieldset>
            <legend><br>Projects</legend>
            <c:forEach items="${team.projects}" varStatus="gridRow">
              <spring:bind path="team.projects[${gridRow.index}].teamProjectId">
                <form:input type="hidden" name="teamProjectId" id="teamProjectId" path="${status.expression}" value='${status.value}' />
              </spring:bind>
              <spring:bind path="team.projects[${gridRow.index}].project">
                <form:label for="project" class="formlabel" path="${status.expression}">Project:</form:label>
                <form:select class="select-1" id = "project" path="${status.expression}">
                  <option value="${status.value}">${status.value}</option>
                  <option value="Chase">Chase</option>
                  <option value="Geico">Geico</option>
                </form:select>
                <c:if test="${gridRow.index eq 0}">
                  <button class="btn" id="addproject">Add Project</button>
                </c:if>
              </spring:bind>
              <br>
            </c:forEach>
         </fieldset>
         <div class="form-actions">
          <button class="btn btn-primary">Save</button>
          <button class="btn">Cancel</button>
         </div>
       </form:form>
</c:if>

</body>
</html>