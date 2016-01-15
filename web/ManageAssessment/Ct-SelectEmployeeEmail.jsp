<%-- 
    Document   : Ct-SelectEmployeeEmail
    Created on : 12-ene-2016, 22:41:50
    Author     : Ricardo
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        Select E.EmployeeID, E.ContactID,C.FirstName, C.MiddleName, C.LastName, C.EmailAddress, C.Phone  from Employee as E
	inner join Contact as C on E.ContactID = C.ContactID 
	where EmailAddress = ?
        <sql:param value="${param.Email}" />
    </sql:query>
    <json:array name="Questions" var="row" items="${rsQuery.rows}">
        <json:object>
            <json:property name="EmployeeID" value="${row.EmployeeID}"  />
            <json:property name="ContactID" value="${row.ContactID}"  />
            <json:property name="FirstName" value="${row.FirstName}"  />
            <json:property name="MiddleName" value="${row.MiddleName}"  />
            <json:property name="LastName" value="${row.LastName}"  />
            <json:property name="EmailAddress" value="${row.EmailAddress}"  />
            <json:property name="Phone" value="${row.Phone}"  />
        </json:object>
    </json:array>
</c:if>
