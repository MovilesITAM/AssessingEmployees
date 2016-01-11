<%-- 
    Document   : Ct-SelectJob
    Created on : 23-dic-2015, 22:19:02
    Author     : Ricardo
    Js-CompetencesManagement
    Js-AddEmployee2
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        Select * from Job where DepartmentID = ?
        <sql:param value="${param.DepartmentID}" />
    </sql:query>
    <json:array name="Jobs" var="row" items="${rsQuery.rows}">
        <json:object>
            <json:property name="JobID" value="${row.JobID}"  />
            <json:property name="DepartmentID" value="${row.DepartmentID}"  />
            <json:property name="Name" value="${row.Name}"  />
            <json:property name="Description" value="${row.Description}"  />
            <json:property name="ModifiedDate" value="${row.ModifiedDate}"  />
        </json:object>
    </json:array>
</c:if>

