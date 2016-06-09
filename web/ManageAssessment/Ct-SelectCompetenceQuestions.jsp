<%-- 
    Document   : SelectCompetenceQuestions
    Created on : 18-ene-2016, 8:14:00
    Author     : Ricardo
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:if test="${pageContext.request.method == 'POST' }">
    <sql:query var="rsCompetences" dataSource="SqlAdmin">
        Select * from Competence as C
            inner join CompetenceJob as CJ on C.CompetenceID = CJ.CompetenceID
            where CJ.JobID = ?
        <sql:param value="${param.JobID}" />
    </sql:query>
    <json:array name="Competences" var="row2" items="${rsCompetences.rows}">
        <json:object>
            <json:property name="CompetenceID" value="${row2.CompetenceID}"  />
            <json:property name="Name" value="${row2.Name}"  />
            <json:property name="ActualQuestion" value="0"  />
            
            <sql:query var="rsQuery" dataSource="SqlAdmin">
                Select QuestionID, Question, Value from Question where CompetenceID = ? and Deleted = 0
                <sql:param value="${row2.CompetenceID}" />
            </sql:query>
            <json:array name="Questions" var="row" items="${rsQuery.rows}">
                <json:object>
                    <json:property name="QuestionID" value="${row.QuestionID}"  />
                    <json:property name="Question" escapeXml="false" value="${row.Question}"  />
                    <json:property name="Value" value="${row.Value}"  />
                    <json:property name="Notes" value=" "  />
                    <json:property name="Rank" value=" "  />
                    <json:property name="Situation" value="false"  />
                    <json:property name="Targets" value="false"  />
                    <json:property name="Actions" value="false"  />
                    <json:property name="Result" value="false"  />
                </json:object>
            </json:array>
        </json:object>
    </json:array>    
        
    
</c:if>
