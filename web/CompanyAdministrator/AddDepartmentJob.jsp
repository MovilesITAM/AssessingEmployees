<%-- 
    Document   : AddDepartmentJob
    Created on : 21-dic-2015, 21:38:40
    Author     : Ricardo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <c:set var="CompanyID" value="7" scope="session"  />
    <c:set var="SessionType" value="CompanyAdministrator" scope="session"  />
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Departments and Jobs</title>
    </head>
    <body>
        Add Department:<br/>
        Department Name: <input type="text" name="DepartmentName"><br/>
        Description: <textarea name="DepartmentDescription" placeholder="Descripcion"></textarea>
        <br/>
        <button id="btnAddDepartment">Add Department</button>
        <hr/>
        
        
    <script src="../Resources/js/jquery.js"></script>
    <script src="../Resources/js/Js-AddDepartmentJob.js"></script>    
    </body>
</html>
