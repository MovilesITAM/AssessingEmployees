<%-- 
    Document   : Ct-AddJob
    Created on : 22-dic-2015, 22:58:23
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
            <c:set var="DepartmentID" value="${param.DepartmentID}" />
            <c:set var="Name" value="${param.Name}" />
            <c:set var="Description" value="${param.Description}" />
            <c:catch var ="catchException">
                <sql:update dataSource="SqlAdmin">
                    spAddJob ?, ?, ?
                    <sql:param value="${DepartmentID}" />
                    <sql:param value="${Name}" />
                    <sql:param value="${Description}" />
                </sql:update>
            </c:catch>
            <c:choose>
                <c:when test="${catchException != null}">
                    <json:object>
                        <json:property name="Error" value="9287"  />
                    </json:object>
                    <sql:update dataSource="SqlAdmin">
                        spAddError ?, ?, ?
                        <sql:param value="${catchException.message}" />
                        <sql:param value="Ct-AddJob.jsp" />
                        <sql:param value="spAddJob" />
                    </sql:update>
                </c:when>
                <c:otherwise>
                    <json:object>
                        <json:property name="Error" value="0"  />
                    </json:object>
                </c:otherwise>
            </c:choose>            
        </c:if>
</c:when>
    <c:otherwise>
        <json:object>
                <json:property name="Error" value="-1"  />
            </json:object>
    </c:otherwise>
</c:choose>

