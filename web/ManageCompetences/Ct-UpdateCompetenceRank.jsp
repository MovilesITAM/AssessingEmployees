<%-- 
    Document   : Ct-UpdateCompetenceRank
    Created on : 01-ene-2016, 18:22:41
    Author     : Ricardo
    This page update the rank of a competence
    Returns error=1 if user doesn't have permissions or if the sesssion is over
    Params: @Question(Text), @Deleted, @Value(Rate), @QuestionID
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:choose>
    <c:when test="${sessionScope.SessionType eq 'CompanyAdministrator' }" >
        <c:if test="${pageContext.request.method == 'POST' }">
            <c:catch var ="catchException">
                <sql:update dataSource="SqlAdmin">
                    update CompetenceJob set Rank = ? where JobID = ? and CompetenceID = ? 
                    <sql:param value="${param.Rank}" />
                    <sql:param value="${param.JobID}" />
                    <sql:param value="${param.CompetenceID}" />
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
                        <sql:param value="Ct-UpdateCompetenceRank.jsp" />
                        <sql:param value="update CompetenceJob" />
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