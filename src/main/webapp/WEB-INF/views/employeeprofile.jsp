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
    <title>Employee Profile</title>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/bootstrap-datepicker.js"></script>
    
    <script type="text/javascript">
    $(document).ready(function(){
    	/*$("#datepicker").datepicker()*/
    	var phonecount = 0;
    	$('#addphone').click(function(){	
    		phonecount++;
    		
    		/*alert('Adding phone '+phonecount);*/
    		$.get("addphone", {count : phonecount},callback);
    	    function callback(data){
    	             /*alert('in Callback new');*/
    	             $("#emailtypelabel").before(data);
    	    };
    	    return false;
    	});
    });
    </script>
    
  </head>

  <body>
   <c:if test="${empty employeecreatedorupdated}">
      <h2 class="heading heading-2">Employee Profile</h2>
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
      <form:form id = "employeeprofile" name="employeeprofile" action="/Timesheet/employeeprofile" method="POST" commandName="employee">
        <form:label class="formlabel" for="emplid" path="emplid">Emplid:</form:label>
        <form:input type="text" id = "emplid" class="uneditable-input" value="NEXT" path="emplid"/>
          <fieldset>
            <legend><br>Personal Information</legend>
			<form:label class="formlabel" for="firstname" path="firstname">First Name:</form:label>
			<form:input type="text" placeholder="First Name" id="firstname" path="firstname"/>
			<form:label class="formlabel" for="lastname" path="lastname">Last Name:</form:label>
			<form:input type="text" placeholder="Last Name" id="lastname" path="lastname"/>
			<br>
			<form:label for="dob" class="formlabel" path="dateofbirth">Date of Birth:</form:label>
			<form:input type="date" placeholder="Date of Birth" id="dob" path="dateofbirth"/>
		  </fieldset>
		  <fieldset>
				<legend><br>Contact Information</legend>
				  <spring:bind path="employee.phones[0].phonetype">
				    <form:label for="phonetype" class="formlabel" path="${status.expression}">Phone Type:</form:label>
		            <form:select class="select-1" id="phonetype" path="${status.expression}">
				      <option value="--Phone Type--">--Phone Type--</option>
				      <option value="Work">Work</option>
				      <option value="Cell">Cell</option>
				      <option value="Home">Home</option>
				      <option value="Other">Other</option>
				    </form:select>
				  </spring:bind>
				  <spring:bind path="employee.phones[0].phonenumber">
				     <form:label for="phonenumber" class="formlabel" path="${status.expression}">Phone Number:</form:label>
				     <form:input type="text" placeholder="Phone Number" id="phonenumber" path="${status.expression}"/>
				  </spring:bind>
				<button class="btn" id="addphone">Add Phone</button>
				  <spring:bind path="employee.emailaddresses[0].emailtype">
				     <form:label id="emailtypelabel" for="emailtype" class="formlabel" path="${status.expression}">Email Type:</form:label>
				     <form:select class="select-1" id="emailtype" path="${status.expression}">
				       <option value="--Email Type--">--Email Type--</option>
				       <option value="Work">Work</option>
				       <option value="Home">Home</option>
				       <option value="Other">Other</option>
				     </form:select>
				  </spring:bind>
				  <spring:bind path="employee.emailaddresses[0].emailaddress">
				     <form:label for="emailaddress" class="formlabel" path="${status.expression}">Email Address:</form:label>
				     <form:input type="text" placeholder="Email Address" id="emailaddress" path="${status.expression}"/>
				  </spring:bind>
				<button class="btn" id="addemail">Add Email</button>
		    </fieldset>
		    <fieldset>
		        <legend><br>Employment Information</legend>
				<form:label for="teamid" class="formlabel" path="team">Team:</form:label>
				<form:input type="text" placeholder="Team" id="teamid" path = "team"/>
				<br>
				<form:label for="projectid" class="formlabel" path="project">Project:</form:label>
				<form:input type="text" placeholder="Project" id="projectid" path = "project"/>
				<form:label for="dateofjoining" class = "formlabel" path="dateofjoin">Date of Joining:</form:label>
				<form:input type="date" placeholder="Date of Joining" id="datepicker" path="dateofjoin"/>
			</fieldset>
        <div class="form-actions">
          <button class="btn btn-primary">Save</button>
          <button class="btn">Cancel</button>
        </div>
      </form:form>
   </c:if>
   
   <c:if test="${not empty employeecreatedorupdated}">
   
     <h2 class="heading heading-2">Employee Profile</h2>
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
     <form:form id = "employeeprofile" name="employeeprofile" action="/Timesheet/employeeprofile" method="POST" commandName="employee">
          <form:label class = "formlabel" for = "emplid" path = "emplid">Emplid:</form:label>
          <form:input type="text" id="emplid" class="uneditable-input" value='${employee.emplid}' path = "emplid"/>
          <fieldset>
            <legend><br>Personal Information</legend>
			<form:label class="formlabel" for="firstname" path="firstname">First Name:</form:label>
			<form:input type="text" placeholder="First Name" id = "firstname" path="firstname" value='${employee.firstname}'/>
			<form:label class="formlabel" for="lastname" path="lastname">Last Name:</form:label>
			<form:input type="text" placeholder="Last Name" id="lastname" path="lastname" value='${employee.lastname}'/>
			<br>
			<form:label for="dob" class="formlabel" path="dateofbirth">Date of Birth:</form:label>
			<form:input type="date" placeholder="Date of Birth" id="dob" path="dateofbirth" value='${DateOfbirthStr}'/>
		  </fieldset>
		  <fieldset>
		    <legend><br>Contact Information</legend>
		    <c:forEach items="${employee.phones}" varStatus="gridRow">
		      <spring:bind path="employee.phones[${gridRow.index}].id">
                <form:input type="hidden" name="phoneid" id="phoneid" path = "${status.expression}" value='${status.value}' />
              </spring:bind>
              <spring:bind path="employee.phones[${gridRow.index}].phonetype">
                <form:label for="phonetype" class="formlabel" path="${status.expression}">Phone Type:</form:label>
		            <form:select class="select-1" id="phonetype" path="${status.expression}">
				      <option value="${status.value}">${status.value}</option>
				      <option value="Work">Work</option>
				      <option value="Cell">Cell</option>
				      <option value="Home">Home</option>
				      <option value="Other">Other</option>
				    </form:select>
              </spring:bind>
              <spring:bind path="employee.phones[${gridRow.index}].phonenumber">
				    <form:label for="phonenumber" class="formlabel" path="${status.expression}">Phone Number:</form:label>
				    <form:input type="text" placeholder="Phone Number" id="phonenumber" path="${status.expression}" value='${status.value}'/>
		      </spring:bind>
		      <button class="btn" id="addphone">Add Phone</button>
		    </c:forEach>
		    <c:forEach items="${employee.emailaddresses}" varStatus="gridRow">
		      <spring:bind path="employee.emailaddresses[${gridRow.index}].id">
                <form:input type="hidden" name="emailid" id="emailid" path = "${status.expression}" value='${status.value}' />
              </spring:bind>
              <spring:bind path="employee.emailaddresses[${gridRow.index}].emailtype">
                <form:label id="emailtypelabel" for="emailtype" class = "formlabel" path="${status.expression}">Email Type:</form:label>
                <form:select class="select-1" id="emailtype" path="${status.expression}">
				     <option value="${status.value}">${status.value}</option>
				     <option value="Work">Work</option>
				     <option value="Home">Home</option>
				     <option value="Other">Other</option>
				</form:select>
              </spring:bind>
              <spring:bind path="employee.emailaddresses[${gridRow.index}].emailaddress">
				  <form:label for="emailaddress" class = "formlabel" path="${status.expression}">Email Address:</form:label>
				  <form:input type="text" placeholder="Email Address" id="emailaddress" path="${status.expression}" value='${status.value}'/>
		      </spring:bind>
		      <button class="btn" id="addemail">Add Email</button>
		    </c:forEach>
		  </fieldset>
		  
		  <fieldset>
		        <legend><br>Employment Information</legend>
				<form:label for="teamid" class="formlabel" path="team">Team:</form:label>
				<form:input type="text" placeholder="Team" id="teamid" path="team" value='${employee.team}'/>
				<br>
				<form:label for="projectid" class="formlabel" path="project">Project:</form:label>
				<form:input type="text" placeholder="Project" id="projectid" path="project" value='${employee.project}'/>
				<form:label for="dateofjoining" class="formlabel" path="dateofjoin">Date of Joining:</form:label>
				<form:input type="date" placeholder="Date of Joining" id="dateofjoining" path="dateofjoin" value='${DateOfjoinStr}'/>
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