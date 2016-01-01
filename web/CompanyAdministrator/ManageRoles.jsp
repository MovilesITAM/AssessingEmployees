<%-- 
    Document   : ManageRoles
    Created on : 23-dic-2015, 23:26:13
    Author     : Ricardo
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Roles</title>
    </head>
    <body>
        Add Human Resource Especialist:<br/>
        Employee ID: <input type="text" name="EmployeeEspecialist"/><br/>
        <button id="AddEspecialist">Add Employee</button><br/>
        
        Add Manager:<br/>
        Employee ID: <input type="text" name="EmployeeManager"/><br/>
        <button id="AddManager">Add Employee</button><br/>
        <br/>
        Add Administrator:<br/>
        Contact ID:<input type="text" name="ContactAdministrator"/><br/>
        <button id="AddAdministrator">Add Administrator</button><br/>
         
        <%--MOSTRAR TODOS LOS ESPECIALES EN UNA TABLA CON COLOR--%>    
        <script src="../Resources/js/jquery.js"></script>
        <script src="../Resources/js/Js-ManageRoles.js"></script>  
    </body>
</html>
