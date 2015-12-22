<%-- 
    Document   : Ct-AddCompany
    Created on : 21-dic-2015, 19:39:55
    Author     : Ricardo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="se" uri="/WEB-INF/tlds/EncodeMD5" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <c:set var="CompanyName" value="${param.CompanyName}" />
    <c:set var="AddressLine1" value="${param.AddressLine1}" />
    <c:set var="AddressLine2" value="${param.AddressLine2}" />
    <c:set var="City" value="${param.City}" />
    <c:set var="PostalCode" value="${param.PostalCode}" />
    <c:set var="StateProvinceID" value="${param.State}"/>
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        spAddCompany ?
        <sql:param value="${CompanyName}" />
    </sql:query>
   <c:forEach var="row" items="${rsQuery.rows}">
        <c:set var="CompanyID" value="${row.CompanyID}"/>
    </c:forEach>  
        
   <sql:query var="rsQuery" dataSource="SqlAdmin">
        spAddAddress ?,?,?,?,?
        <sql:param value="${AddressLine1}" />
        <sql:param value="${AddressLine2}" />
        <sql:param value="${City}" />
        <sql:param value="${StateProvinceID}" />
        <sql:param value="${PostalCode}" />
    </sql:query>
    <c:forEach var="row" items="${rsQuery.rows}">
        <c:set var="AddressID" value="${row.AddressID}"/>
    </c:forEach>
    <sql:update dataSource="SqlAdmin">
        spAddCompanyAddress ?,?
        <sql:param value="${CompanyID}" />
        <sql:param value="${AddressID}" />
    </sql:update>
        
    <c:set var="FirstName" value="${param.FirstName}" />   
    <c:set var="MiddleName" value="${param.MiddleName}" />   
    <c:set var="LastName" value="${param.LastName}" />   
    <c:set var="EmailAddress" value="${param.Email}" />   
    <c:set var="Phone" value="${param.Phone}" />
    <se:encodeMD5 var="PasswordHash" password="${param.Password}"/>
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
    <sql:update dataSource="SqlAdmin">
        spAddCompanyAdministrator ?,?
        <sql:param value="${CompanyID}" />
        <sql:param value="${ContactID}" />
    </sql:update>
    <c:redirect url="AddCompany.jsp"/>
</c:if>

