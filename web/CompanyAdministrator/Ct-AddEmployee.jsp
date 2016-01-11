<%-- 
    Document   : Ct-AddEmployee
    Created on : 23-dic-2015, 22:35:19
    Author     : Ricardo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="se" uri="/WEB-INF/tlds/EncodeMD5" %>

<c:if test="${pageContext.request.method == 'POST' }">        
    <c:set var="FirstName" value="${param.FirstName}" />   
    <c:set var="MiddleName" value="${param.MiddleName}" />   
    <c:set var="LastName" value="${param.LastName}" />   
    <c:set var="EmailAddress" value="${param.Email}" />   
    <c:set var="Phone" value="${param.Phone}" />
    <se:encodeMD5 var="PasswordHash" password="${param.Email}"/>
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        spAddContact ?,?,?,?,?, ?
        <sql:param value="${FirstName}" />
        <sql:param value="${MiddleName}" />
        <sql:param value="${LastName}" />
        <sql:param value="${EmailAddress}" />
        <sql:param value="${Phone}" />
        <sql:param value="${PasswordHash}" />
    </sql:query>
    <c:forEach var="row" items="${rsQuery.rows}">
        <c:set var="ContactID" value="${row.ContactID}"/>
    </c:forEach>
        
    <c:set var="JobID" value="${param.JobSelect}" />
    <c:catch var ="catchException">
        <sql:update dataSource="SqlAdmin">
            spAddEmployee ?,?
            <sql:param value="${ContactID}" />
            <sql:param value="${JobID}" />
        </sql:update>
    </c:catch>
    <c:choose>
        <c:when test="${catchException != null}">
            <sql:update dataSource="SqlAdmin">
                spAddError ?, ?, ?
                <sql:param value="${catchException.message}" />
                <sql:param value="Ct-AddEmployee.jsp" />
                <sql:param value="spAddEmployee" />
            </sql:update>
            <%--REDIRECCIONAR PAGINA ERROR--%>
            <c:redirect url="AddEmployee.jsp"/>
        </c:when>
        <c:otherwise>
            <c:redirect url="AddEmployee.jsp"/>
        </c:otherwise>
    </c:choose>          
</c:if>
