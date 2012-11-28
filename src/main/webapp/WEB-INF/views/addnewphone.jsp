<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE HTML>
<form:label for="phonetype" class="formlabel" path="employee.phones[${phonecount}].phonetype">Phone Type:</form:label>
<form:select class="select-1" id="phonetype" path="employee.phones[${phonecount}].phonetype">
  <option value="--Phone Type--">--Phone Type--</option>
  <option value="Work">Work</option>
  <option value="Cell">Cell</option>
  <option value="Home">Home</option>
  <option value="Other">Other</option>
</form:select>
<form:label for="phonenumber" class="formlabel" path="employee.phones[${phonecount}].phonenumber">Phone Number:</form:label>
<form:input type="text" placeholder="Phone Number" id="phonenumber" path="employee.phones[${phonecount}].phonenumber"/>
<br>