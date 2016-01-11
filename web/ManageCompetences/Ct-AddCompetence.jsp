<%-- 
    Document   : Ct-AddCompetence
    Created on : 01-ene-2016, 13:37:01
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
            <sql:query var="rsQuery" dataSource="SqlAdmin">
                spAddCompetence ?, ?, ?
                <sql:param value="${sessionScope.CompanyID}" />
                <sql:param value="${param.Name}" />
                <sql:param value="${param.Description}" />
            </sql:query>
            <c:forEach var="row" items="${rsQuery.rows}"> <%--Just will be one Record--%>
                <json:object>
                    <json:property name="CompetenceID" value="${row.CompetenceID}"  />
                    <json:property name="Name" value="${row.Name}"  />
                    <json:property name="Description" value="${row.Description}"  />
                    <json:property name="Rank" value="${row.Rank}"  />
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
