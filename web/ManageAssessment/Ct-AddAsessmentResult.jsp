<%-- 
    Document   : Ct-AddAsessmentResult
    Created on : 20-ene-2016, 13:32:46
    Author     : Ricardo
--%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:choose>
    <c:when test="${sessionScope.ApplyAssessment eq 'true'  }" >
        <c:if test="${pageContext.request.method == 'POST' }">
            <sql:update var="rsQuery" dataSource="SqlAdmin">
                spAddAssessmentResult ?,?,?,?
                <sql:param value="${param.AssessmentID}" />
                <sql:param value="${param.QuestionID}" />
                <sql:param value="${param.Notes}" />
                <sql:param value="${param.Value}" />
            </sql:update>
            <json:object>
                <json:property name="Error" value="0"  />
            </json:object>
        </c:if>
</c:when>
    <c:otherwise>
        <json:object>
                <json:property name="Error" value="1"  />
            </json:object>
    </c:otherwise>
</c:choose>
        
