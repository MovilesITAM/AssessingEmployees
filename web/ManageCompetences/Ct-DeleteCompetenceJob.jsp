<%-- 
    Document   : Ct-DeleteCompetenceJob
    Created on : 03-ene-2016, 19:58:15
    Author     : Ricardo
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<c:choose>
    <c:when test="${sessionScope.SessionType eq 'CompanyAdministrator' }" >
        <c:if test="${pageContext.request.method == 'POST' }">
            <sql:update var="rsQuery" dataSource="SqlAdmin">
                spDeleteCompetenceJob ?, ?
                <sql:param value="${param.CompetenceID}" />
                <sql:param value="${param.JobID}" />
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

