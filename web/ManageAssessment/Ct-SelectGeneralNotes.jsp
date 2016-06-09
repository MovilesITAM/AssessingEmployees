<%-- 
    Document   : Ct-SelectGeneralNotes
    Created on : 02-jun-2016, 11:27:20
    Author     : Ricardo
--%>


<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        Select GeneralNote, AssessmentID from Assessment where AssessmentID = ?
        <sql:param value="${param.AssessmentID}" />
    </sql:query>
    <json:array name="Employees" var="row" items="${rsQuery.rows}">
        <json:object>
            <json:property name="GeneralNote" escapeXml="false" value="${row.GeneralNote}"  />
            <json:property name="AssessmentID" value="${row.AssessmentID}"  />
        </json:object>
    </json:array>
</c:if>
