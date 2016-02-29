<%-- 
    Document   : Ct-AddAppraisal
    Created on : 07-feb-2016, 22:26:40
    Author     : Ricardo
--%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:choose>
    <c:when test="${sessionScope.ManageTask eq 'true'  }" >
        <c:if test="${pageContext.request.method == 'POST' }">
            <sql:update var="rsQuery" dataSource="SqlAdmin">
                spAddAppraisal ?,?,?,?
                <sql:param value="${param.AssessmentID}" />
                <sql:param value="${param.CompetenceID}" />
                <sql:param value="${param.Weight}" />
                <sql:param value="${param.Comments}" />
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