<%-- 
    Document   : Ct-UpdateQuestion
    Created on : 31-ene-2016, 22:21:12
    Author     : Ricardo

    This page is the one who update questions of the assessment.
    Returns error=1 if user doesn't have permissions or if the sesssion is over
    Params: @Question(Text), @Deleted, @Value(Rate), @QuestionID
--%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<c:choose>
    <c:when test="${sessionScope.ApplyAssessment eq 'true'  }" >
        <c:if test="${pageContext.request.method == 'POST' }">
            <sql:update var="rsQuery" dataSource="SqlAdmin">
                Update Question set Question=?, Deleted = ?, Value = ?
                    where QuestionID = ?
                <sql:param value="${param.Question}" />
                <sql:param value="${param.Deleted}" />
                <sql:param value="${param.Value}" />
                <sql:param value="${param.QuestionID}" />
            </sql:update>
            <json:object>
                <json:property name="Error" value="0"  />
            </json:object>
        </c:if>
</c:when>
    <c:otherwise>
        <json:object>
                <json:property name="Error" value="1"  />
            </json:object>
    </c:otherwise>
</c:choose>
