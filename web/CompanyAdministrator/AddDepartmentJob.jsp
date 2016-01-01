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
        Add Job:<br/>
        Select one department:
        <sql:query var="rsQuery" dataSource="SqlAdmin">
            Select DepartmentID, Name from Department where CompanyID = ?
            <sql:param value="${sessionScope.CompanyID}" />
        </sql:query>
        <select class="form-control" name="DepartmentSelect">
            <option value="0">Choose Department</option>
            <c:forEach var="result" items="${rsQuery.rows}">
                <option value="<c:out value="${result.DepartmentID}" />"><c:out value="${result.Name}" /></option>
            </c:forEach>
        </select>    
        Job Name: <input type="text" name="JobName"><br/>
        Description: <textarea name="JobDescription" placeholder="Descripcion"></textarea>
        <br/>
        <button id="btnAddJob">Add Job </button>
        
    <script src="../Resources/js/jquery.js"></script>
    <script src="../Resources/js/Js-AddDepartmentJob.js"></script>    
    </body>
</html>
