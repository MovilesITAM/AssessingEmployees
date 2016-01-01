<%-- 
    Document   : Ct-StateProvince
    Created on : 21-dic-2015, 18:57:11
    Author     : Ricardo
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'GET' }">
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        Select StateProvinceID,StateProvinceCode,CountryRegionCode,Name from StateProvince 
        where CountryRegionCode = ?
        <sql:param value="${param.CountryRegionCode}" />
    </sql:query>
    <json:array name="StateProvince" var="row" items="${rsQuery.rows}">
        <json:object>
            <json:property name="StateProvinceID" value="${row.StateProvinceID}"  />
            <json:property name="StateProvinceCode" value="${row.StateProvinceCode}"  />
            <json:property name="CountryRegionCode" value="${row.CountryRegionCode}"  />
            <json:property name="Name" value="${row.Name}"  />
        </json:object>
    </json:array>
    
</c:if>
