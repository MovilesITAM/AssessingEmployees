<%-- 
    Document   : Ct-AddTask
    Created on : 07-feb-2016, 19:40:14
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
                spAddTask ?,?,?,?,?
                <sql:param value="${param.EmployeeID}" />
                <sql:param value="${param.Name}" />
                <sql:param value="${param.StarDate}" />
                <sql:param value="${param.EndDate}" />
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
        
