<%-- 
    Document   : Ct-UpdateAssessment
    Created on : 20-ene-2016, 13:50:49
    Author     : Ricardo
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <sql:update var="rsQuery" dataSource="SqlAdmin">
        spFinishAssessment ?
        <sql:param value="${param.AssessmentID}" />
    </sql:update>
    <sql:update var="rsQuery" dataSource="SqlAdmin">
        Update Assessment set GeneralNote = ?
        where AssessmentId = ?
        <sql:param value="${param.GeneralNote}" />
        <sql:param value="${param.AssessmentID}" />
    </sql:update>
    <json:object>
        <json:property name="Error" value="0"  />
    </json:object>
</c:if>
