<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="utf-8">
        <link href="https://fonts.googleapis.com/css?family=Limelight%7CFlamenco%7CFedero%7CYesteryear%7CJosefin+Sans%7CSpinnaker%7CSansita+One%7CHandlee%7CDroid+Sans%7COswald:400,300,700"
    media="screen" rel="stylesheet" type="text/css" />
    <c:url value="/resources/styles/bootstrap.css" var="bootstrapurl" />
    <c:url value="/resources/styles/bootstrap-responsive.css" var="bootstrap-responsiveurl" />
    <c:url value="/resources/styles/fontawesome.css" var="fontawesomeurl" />
    <c:url value="/resources/styles/style.css" var="styleurl" />
    <link rel="stylesheet" href="${bootstrapurl}" type="text/css" media="screen">
    <link rel="stylesheet" href="${bootstrap-responsiveurl}" type="text/css" media="screen">
    <link rel="stylesheet" href="${fontawesomeurl}" type="text/css" media="screen">
    <link rel="stylesheet" href="${styleurl}" type="text/css" media="screen">      

    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery-1.7.1.js"></script> 
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/bootstrap.min.js"></script>
    
        <script type="text/javascript">
    $(document).ready(function(){
    	
    	$('#employeesearchbtn').click(function(){
    		
    		alert('clicked: '+$('#emplid').val());
    		/*alert('clicked: '+$('#firstname').val());*/
    		
    		/*$.getJSON("employeesearch",{emplid: $('#emplid').val()},callback);
    		
    		function callback(textreceived){
    			alert('In Callback. JSON 2: '+textreceived.firstname);
    		};
    		return false;*/
    		
    		$.getJSON("employeesearch",{emplid: $('#emplid').val(),firstname: $('#firstname').val()},callback);
    		
    		function callback(textreceived){
    			var searchresults = '<thead> <tr> <th>Employee Id</th> <th>First Name</th> <th>Last Name</tr> </thead>';
    			$.each(textreceived,function(employeeIndex, employeeInfo){
    				alert('In JSON Callback array empl received: '+employeeInfo.emplid);
    				/*searchresults+= '<tr><td id = "restltemplid">'+employeeInfo.emplid+'</td><td id = "restltfirstname">'+employeeInfo.firstname+'</td><td id = "restltlastname">'+employeeInfo.lastname+'</td></tr>';*/
    				/*searchresults+= '<tr><td id = "restltemplid">'+'<a href="<c:url value="/employeeprofile" />" >'+employeeInfo.emplid+'</a>'+'</td><td id = "restltfirstname">'+employeeInfo.firstname+'</td><td id = "restltlastname">'+employeeInfo.lastname+'</td></tr>';*/
    				searchresults+= '<tr><td id = "restltemplid">'+'<a href="<c:url value="/fetchsearchemployee?emplid='+employeeInfo.emplid+'" />" >'+employeeInfo.emplid+'</a>'+'</td><td id = "restltfirstname">'+employeeInfo.firstname+'</td><td id = "restltlastname">'+employeeInfo.lastname+'</td></tr>';
    				/*searchresults+= '<tr><td id = "restltemplid">'+'<form name = "fetchsearchemployee" method="POST"><input type="hidden" id="employeeid" name="employeeid" value='+employeeInfo.emplid+'/><a href="<c:url value="/fetchsearchemployee" />" onclick="document.fetchsearchemployee.submit()">'+employeeInfo.emplid+'</a></form>'+'</td><td id = "restltfirstname">'+employeeInfo.firstname+'</td><td id = "restltlastname">'+employeeInfo.lastname+'</td></tr>';*/
    				/*$('table.striped').html(searchresulttable);*/
    			});
    			$('#searchrestlttable').html(searchresults);
    		};
    		return false;
    	});
    });


    </script>
      
</head>
<title>Search or Add Employee</title>
  <body>

<h2 class="heading heading-2">Employee Search or Add</h2>

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


     <ul id = "searchtabs" class="nav nav-tabs">
       <li class="active"> <a href="#1" data-toggle="tab">Search Employee</a> </li>
       <li><a href="#2" data-toggle="tab">Add New Employee</a></li>
     </ul>
     
     <div class="tab-content">
     
        <div class="tab-pane active" id="1">
          <form id="searchform" name="employeesearch">
             <br>
             <label class="formlabel" for="emplid">Emplid:</label>
             <input type="text" placeholder="Employee Id" id="emplid"/>
             <br>
             <label class="formlabel" for="firstname">First Name:</label>
             <input type="text" placeholder="First Name" id="firstname"/>
             <br>
             <label class="formlabel" for="lastname" >Last Name:</label>
             <input type="text" placeholder="Last Name" id="lastname"/>
             <br>
             <div class="form-actions">
                <button class="btn btn-primary" id="employeesearchbtn">Search</button>
             </div>
             <br>
             <div class="searchresults">
                <table id="searchrestlttable" class="table table-striped">
                </table>
             </div>
          </form>
        </div>
        
        <div class="tab-pane" id="2">
          <form id="searchform" name="employeeadd">
          <br>
             <label class="formlabel" for="addemplid">Emplid:</label>
             <input type="text" value="NEXT" class="uneditable-input" id = "addemplid"/>
             <br>
             <button class="btn btn-primary" id="employeesearchbtn">Add</button>          
          </form>
        </div>
        
     </div>


</body>
</html>