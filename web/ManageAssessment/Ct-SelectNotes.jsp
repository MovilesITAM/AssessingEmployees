<%-- 
    Document   : Ct-SelectNotes
    Created on : 30-ene-2016, 15:45:26
    Author     : Ricardo
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <sql:query var="rsQuery" dataSource="SqlAdmin">
        select AR.Notes, C.Name from AssessmentResults as AR
	inner join Question as Q on Ar.QuestionID = Q.QuestionID
	inner join Competence as C on Q.CompetenceID = C.CompetenceID
	inner join Assessment as A on Ar.AssessmentID = A.AssessmentID
	inner join Employee as E on E.EmployeeID = A.EmployeeID
	inner join Contact as CO on E.ContactID = CO.ContactID
	where E.EmployeeID = ? and DATALENGTH(Ar.Notes) > 0 
		and A.StartDate in (
				Select top 1 Assessment.StartDate from Assessment 
					inner join Employee on Assessment.EmployeeID = Employee.EmployeeID
					inner join Contact on Employee.ContactID = Contact.ContactID
					where Employee.EmployeeID = ?
					order by Assessment.StartDate desc
			)
	
	order by C.CompetenceID desc
        <sql:param value="${param.EmployeeID}" />
        <sql:param value="${param.EmployeeID}" />
    </sql:query>
        
        <json:array name="Competences" var="row" items="${rsQuery.rows}">
        <json:object>
            <json:property name="Notes" value="${row.Notes}"  />
            <json:property name="CompetenceName" value="${row.Name}"  />
        </json:object>
    </json:array>
</c:if>