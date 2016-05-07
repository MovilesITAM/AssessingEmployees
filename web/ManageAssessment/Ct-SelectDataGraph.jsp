<%-- 
    Document   : Ct-SelectDataGraph
    Created on : 30-ene-2016, 12:11:06
    Author     : Ricardo
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        select CO.FirstName, CO.LastName, A.AssessmentID, C.Name, Q.CompetenceID, round(sum(AR.Value)*10/count(AR.Value),2) as Rate from AssessmentResults as AR
	inner join Question as Q on Ar.QuestionID = Q.QuestionID
	inner join Competence as C on Q.CompetenceID = C.CompetenceID
	inner join Assessment as A on Ar.AssessmentID = A.AssessmentID
	inner join Employee as E on E.EmployeeID = A.EmployeeID
	inner join Contact as CO on E.ContactID = CO.ContactID
	where E.EmployeeID = ?
		and A.StartDate in (
				Select top 1 Assessment.StartDate from Assessment 
					inner join Employee on Assessment.EmployeeID = Employee.EmployeeID
					inner join Contact on Employee.ContactID = Contact.ContactID
					where Employee.EmployeeID = ?
					and Assessment.EndDate is not Null
					order by Assessment.StartDate desc
			)
	group by Q.CompetenceID, A.AssessmentID, C.Name, A.StartDate, CO.LastName, CO.FirstName
	order by A.StartDate desc
        <sql:param value="${param.EmployeeID}" />
        <sql:param value="${param.EmployeeID}" />
    </sql:query>
        
        <json:array name="Competences" var="row" items="${rsQuery.rows}">
        <json:object>
            <json:property name="FirstName" value="${row.FirstName}"  />
            <json:property name="LastName" value="${row.LastName}"  />
            <json:property name="AssessmentID" value="${row.AssessmentID}"  />
            <json:property name="CompetenceName" value="${row.Name}"  />
            <json:property name="CompetenceID" value="${row.CompetenceID}"  />
            <json:property name="Rate" value="${row.Rate}"  />
        </json:object>
    </json:array>
</c:if>