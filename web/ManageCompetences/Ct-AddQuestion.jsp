<%-- 
    Document   : Ct-AddQuestion
    Created on : 01-ene-2016, 15:38:52
    Author     : Ricardo
--%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<c:choose>
    <c:when test="${sessionScope.ManageCompetences eq 'true'  }" >
        <c:if test="${pageContext.request.method == 'POST' }">
            <sql:query var="rsQuery" dataSource="SqlAdmin">
                spAddQuestion ?, ?, ?
                <sql:param value="${param.CompetenceID}" />
                <sql:param value="${param.Question}" />
                <sql:param value="${param.Value}" />
            </sql:query>
            <c:forEach var="row" items="${rsQuery.rows}"> <%--Just will be one Record--%>
                <json:object>
                    <json:property name="QuestionID" value="${row.QuestionID}"  />
                    <json:property name="CompetenceID" value="${row.CompetenceID}"  />
                    <json:property name="Question" value="${row.Question}"  />
                    <json:property name="Value" value="${row.Value}"  />
                </json:object>
            </c:forEach>    
            
        </c:if>
</c:when>
    <c:otherwise>
        <json:object>
                <json:property name="Error" value="1"  />
            </json:object>
    </c:otherwise>
</c:choose>

