<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE HTML>
<br>
<form:label for="project" class="formlabel" path="team.projects[${projectcount}].project">Project:</form:label>
<form:select class="select-1" id="project" path="team.projects[${projectcount}].project">
      <option value="Chase">Chase</option>
      <option value="Geico">Geico</option>
</form:select>