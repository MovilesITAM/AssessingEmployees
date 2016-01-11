<%-- 
    Document   : AddRoles
    Created on : 23-dic-2015, 21:49:00
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
        <title>JSP Page</title>
    </head>
    <body>
        <form action="Ct-AddEmployee.jsp" method="POST"> 
            Add Employee:
            Please provide some information of the new Employee <br/>
            First Name: <input type="text" name="FirstName"><br/>
            Middle Name: <input type="text" name="MiddleName"><br/>
            Last Name: <input type="text" name="LastName"><br/>
            Email: <input type="text" name="Email"><br/>
            Phone: <input type="text" name="Phone"><br/>
            <%--
            We have to send an email to the employee giving a random password.
            Currently, the password will be the email
            --%>
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
            Select one job:
            <select class="form-control" name="JobSelect">
                <option value="0">Choose Job</option>
            </select>
            <input type="submit" value="Submit" />
        </form>
        
        <script src="../Resources/js/jquery.js"></script>
        <script src="../Resources/js/Js-AddEmployee2.js"></script>   
    </body>
</html>
