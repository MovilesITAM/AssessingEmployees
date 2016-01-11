<%-- 
    Document   : Ct-Login
    Created on : 27-dic-2015, 19:10:28
    Author     : Ricardo
--%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<%@ taglib prefix="se" uri="/WEB-INF/tlds/EncodeMD5" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <c:set var="EmailAddress" value="${param.Email}" />   
    <se:encodeMD5 var="PasswordHash" password="${param.Password}"/>
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        select ContactID, FirstName, MiddleName, LastName, Phone from Contact
	where EmailAddress = ? and PasswordHash = ? 
        <sql:param value="${EmailAddress}" />
        <sql:param value="${PasswordHash}" />
    </sql:query>
    <c:set var="isValid" value="-1" /> 
    <c:forEach var="result" items="${rsQuery.rows}">
        <c:set var="ContactID" value="${result.ContactID}" scope="session" />
        <c:set var="FirstName" value="${result.FirstName}" scope="session" />
        <c:set var="MiddleNAme" value="${result.MiddleNAme}" scope="session" />
        <c:set var="LastName" value="${result.LastName}"  scope="session"/>    
        <c:set var="Phone" value="${result.Phone}"  scope="session"/>
        <c:set var="isValid" value="1" /> 
    </c:forEach>
    <c:choose>
        <c:when test="${isValid > 0}">
            
            <c:set var="CompanyID" value="-1" scope="session"/>
            <sql:query var="rsQuery" dataSource="SqlAdmin">
                Select CompanyID,ManageRoles,ManageCompetences,ApplyAssessment,ManageTask from CompanyPermissions where ContactID = ?
                <sql:param value="${sessionScope.ContactID}" />
            </sql:query>
                
            <c:forEach var="result" items="${rsQuery.rows}">
                <c:set var="CompanyID" value="${result.CompanyID}" scope="session" />
                <c:set var="ManageRoles" value="${result.ManageRoles}" scope="session" />
                <c:set var="ManageCompetences" value="${result.ManageCompetences}" scope="session" />
                <c:set var="ApplyAssessment" value="${result.ApplyAssessment}" scope="session" />
                <c:set var="ManageTask" value="${result.ManageTask}" scope="session" />
                <c:set var="SessionType" value="CompanyAdministrator" scope="session"  />
            </c:forEach> 
            <c:redirect url="index.jsp"/>       
        </c:when>
        <c:otherwise>
            <c:set var="Message" value="Email and password don't match" />
            <c:redirect url="index.jsp"/>
        </c:otherwise>
    </c:choose>  
</c:if>