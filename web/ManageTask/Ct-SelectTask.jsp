<%-- 
    Document   : Ct-SelectTask
    Created on : 07-feb-2016, 20:11:27
    Author     : Ricardo
--%>


<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        Select * from Task where EmployeeID = ? order by StartDate desc
        <sql:param value="${param.EmployeeID}" />
    </sql:query>
    <json:array name="Tasks" var="row" items="${rsQuery.rows}">
        <json:object>
            <json:property name="TaskID" value="${row.TaskID}"  />
            <json:property name="EmployeeID" value="${row.EmployeeID}"  />
            <json:property name="Name" value="${row.Name}"  />
            <json:property name="Efficiency" value="${row.Efficiency}"  />
            <json:property name="StartDate" value="${row.StartDate}"  />
            <json:property name="EndDate" value="${row.EndDate}"  />
            <json:property name="Done" value="${row.Done}"  />
            <json:property name="Comments" value="${row.Comments}"  />
        </json:object>
    </json:array>
</c:if>
