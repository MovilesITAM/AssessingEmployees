<%-- 
    Document   : Ct-SeñectCompetencesJob
    Created on : 01-ene-2016, 17:51:31
    Author     : Ricardo
--%>


<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        select C.CompanyID, C.CompetenceID, C.Name, C.Description, CJ.Rank from Competence as C
            inner join CompetenceJob as CJ on C.CompetenceID = CJ.CompetenceID
                where CJ.JobID = ? order by CJ.Rank asc
        <sql:param value="${param.JobID}" />
    </sql:query>
    
    <json:array name="Competences" var="row" items="${rsQuery.rows}">
        <json:object>
            <json:property name="CompanyID" value="${row.CompanyID}"  />
            <json:property name="CompetenceID" value="${row.CompetenceID}"  />
            <json:property name="Name" value="${row.Name}"  />
            <json:property name="Description" value="${row.Description}"  />
            <json:property name="Rank" value="${row.Rank}"  />
        </json:object>
    </json:array>
</c:if>
