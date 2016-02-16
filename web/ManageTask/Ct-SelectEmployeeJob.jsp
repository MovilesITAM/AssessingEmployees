<%-- 
    Document   : Ct-SelectEmployeeJob
    Created on : 07-feb-2016, 18:21:13
    Author     : Ricardo
--%>


<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        Select E.EmployeeID,C.FirstName, C.MiddleName, C.LastName, C.EmailAddress, C.Phone  from Employee as E
	inner join Contact as C on E.ContactID = C.ContactID 
	where E.JobID = ?
        <sql:param value="${param.JobID}" />
    </sql:query>
    <json:array name="Employees" var="row" items="${rsQuery.rows}">
        <json:object>
            <json:property name="EmployeeID" value="${row.EmployeeID}"  />
            <json:property name="FirstName" value="${row.FirstName}"  />
            <json:property name="MiddleName" value="${row.MiddleName}"  />
            <json:property name="LastName" value="${row.LastName}"  />
            <json:property name="EmailAddress" value="${row.EmailAddress}"  />
            <json:property name="Phone" value="${row.Phone}"  />
        </json:object>
    </json:array>
</c:if>

