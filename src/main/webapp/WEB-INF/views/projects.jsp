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
    <title>Projects</title>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery.min.js"></script>
    
</head>

<body>
  <c:if test="${empty projectcreatedorupdated}">
      <h2 class="heading heading-2">Projects</h2>
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
      <form:form id="projects" name="projects" action="/Timesheet/projects" method="POST" commandName="project">
          <form:label class="formlabel" for="projectId" path="projectId">Project Id:</form:label>
          <form:input type="text" id="projectId" class="uneditable-input" value="NEXT" path = "projectId"/>
          <fieldset>
            <legend><br>Client Information</legend>
            <form:label class="formlabel" for="clientName" path="clientName">Client Name:</form:label>
            <form:input type="text" placeholder="ClientName" id="clientName" path="clientName"/>
            <form:label class="formlabel" for="type" path="type">Type:</form:label>
            <form:select class="select-1" id="type" path="type">
              <option value="Banking">Banking</option>
              <option value="Insurance">Insurance</option>
              <option value="Manufacturing">Manufacturing</option>
              <option value="Education">Education</option>
            </form:select>
            <br>
            <form:label class="formlabel" for="country" path="country">Country:</form:label>
            <form:input type="text" placeholder="Country" id="country" path="country"/>
            <form:label class="formlabel" for="state" path="state">State:</form:label>
            <form:input type="text" placeholder="State" id="state" path="state"/>
            <form:label class="formlabel" for="city" path="city">City:</form:label>
            <form:input type="text" placeholder="City" id="city" path="city"/>
          </fieldset>
          <div class="form-actions">
            <button class="btn btn-primary">Save</button>
            <button class="btn">Cancel</button>
            <button class="btn btn-primary" VALUE="Back" onClick="history.go(-1);return true;">Return to Search</button>
          </div>
      </form:form>
  </c:if>
  
  <c:if test="${not empty projectcreatedorupdated}">
      <h2 class="heading heading-2">Projects</h2>
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
      <form:form id = "projects" name="projects" action="/Timesheet/projects" method="POST" commandName="project">
          <form:label class="formlabel" for="projectId" path="projectId">Project Id:</form:label>
          <form:input type="text" id="projectId" class="uneditable-input" value='${project.projectId}' path="projectId"/>
          <fieldset>
            <legend><br>Client Information</legend>
            <form:label class="formlabel" for="clientName" path="clientName">Client Name:</form:label>
            <form:input type="text" id="clientName" path="clientName" value='${project.clientName}'/>
            <form:label class="formlabel" for="type" path="type">Type:</form:label>
            <form:select class="select-1" id="type" path="type">
              <option value="${project.type}">${project.type}</option>
              <option value="Banking">Banking</option>
              <option value="Insurance">Insurance</option>
              <option value="Manufacturing">Manufacturing</option>
              <option value="Education">Education</option>
            </form:select>
            <br>
            <form:label class="formlabel" for="country" path="country">Country:</form:label>
            <form:input type="text" id="country" path="country" value='${project.country}'/>
            <form:label class="formlabel" for="state" path="state">State:</form:label>
            <form:input type="text" id="state" path="state" value='${project.state}'/>
            <form:label class="formlabel" for="city" path="city">City:</form:label>
            <form:input type="text" id="city" path="city" value='${project.city}'/>
          </fieldset>
          <div class="form-actions">
            <button class="btn btn-primary">Save</button>
            <button class="btn">Cancel</button>
            <button class="btn btn-primary" VALUE="Back" onClick="history.go(-1);return true;">Return to Search</button>
          </div>
      </form:form>
  </c:if>

</body>

</html>