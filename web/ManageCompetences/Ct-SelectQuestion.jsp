<%-- 
    Document   : Ct-SelectQuestion
    Created on : 01-ene-2016, 14:23:16
    Author     : Ricardo
    Js-AddCompetence
--%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        Select QuestionID, Question, Value, Deleted from Question where CompetenceID = ?
        <sql:param value="${param.CompetenceID}" />
    </sql:query>
    <json:array name="Questions" var="row" items="${rsQuery.rows}">
        <json:object>
            <json:property name="QuestionID" value="${row.QuestionID}"  />
            <json:property name="Question" value="${row.Question}"  />
            <json:property name="Value" value="${row.Value}"  />
            <json:property name="Deleted" value="${row.Deleted}"  />
        </json:object>
    </json:array>
</c:if>
