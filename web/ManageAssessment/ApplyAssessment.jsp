<%-- 
    Document   : ApplyAssessment
    Created on : 13-ene-2016, 21:28:34
    Author     : Ricardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<c:if test="${pageContext.request.method ne 'POST' }">
    <c:redirect url="CreateAssessment.jsp"/>
</c:if>
<c:if test="${ sessionScope.ApplyAssessment ne 'true' }" >
    <c:redirect url="../index.jsp"/>
</c:if>
<sql:query var="rsQuery" dataSource="SqlAdmin">
    spAddAssessment ?,?
    <sql:param value="${param.EmployeeID}" />
    <sql:param value="${sessionScope.ContactID}" />
</sql:query>
<c:forEach var="result" items="${rsQuery.rows}">
    <c:set var="AssessmentID" value="${result.AssessmentID}"/>
    <c:set var="StartDate" value="${result.StartDate}"/>
</c:forEach>
<html>
    <head>
        <title>Assessing Employees</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='http://fonts.googleapis.com/css?family=Gilda+Display' rel='stylesheet' type='text/css'>
        <link href="../Resources/css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="../Resources/css/main.css" rel="stylesheet" media="screen">

    </head>
    <body>

        <!-- Header -->
        <nav class="navbar navbar-default" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <h1 class="blanco">Assessing Employees<i> / Company Administrator </i></h1>                     
                </div>
                <div class="navbar-form navbar-right" role="search">
                    <div class="btn-group">
                        <button type="button" class="btn btn-danger dropdown-toggle"
                                data-toggle="dropdown">
                            <span class="glyphicon glyphicon-user"></span>
                            <c:out value="${sessionScope.FirstName}${' '}${sessionScope.LastName}"/>
                            <span class="caret"></span>

                        </button>
                        <ul class="dropdown-menu" role="menu">

                            <li><a href="#">Change password </a></li>
                            <li class="divider"></li>
                            <li><a href="../Ct-Logout.jsp">Log out</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>

        <nav class="navbar navbar-default NavMenu" >
            <div class="container-fluid">
                <div class="navbar-header">
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav ">

                            <c:if test="${ sessionScope.ManageCompetences eq 'true' }" >
                                <li><a href="../ManageCompetences/CompetencesManagement.jsp">
                                    <span class="glyphicon glyphicon-list-alt textMenu"></span>
                                        Manage Competences and Jobs
                                </a></li>
                                <li><a href="../ManageCompetences/AddCompetence.jsp">
                                    <span class="glyphicon glyphicon-pencil textMenu"></span>
                                    Add Competences and Questions
                                </a></li>
                            </c:if>
                            <c:if test="${ sessionScope.ApplyAssessment eq 'true' }" >
                                <li><a href="../ManageAssessment/CreateAssessment.jsp">
                                    <span class="glyphicon glyphicon-file textMenu"></span>
                                        Create Assessment
                                </a></li>
                                <li><a href="../ManageAssessment/EmployeeStatistics.jsp">
                                    <span class="glyphicon glyphicon-signal textMenu"></span>
                                    View Statistics
                                </a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Cuerpo -->   
        <sql:query var="rsQuery" dataSource="SqlAdmin">
            Select * from Competence as C
            inner join CompetenceJob as CJ on C.CompetenceID = CJ.CompetenceID
            where CJ.JobID = ? 
            <sql:param value="${param.JobID}" />
        </sql:query>
        <section class="centralSide">
            <div class="row" id="row-profesor">           
                <div class="container-profesor">
                    <div class="page-header-profesor generalTitle" >
                        <h1 class="Unidad">Apply Assessment</h1>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="thumbnail GeneralDiv" >
                        <div class="caption" id="manageDiv">
                            <h4>Assessment</h4>

                            <b>Competences:</b>
                            <select class="form-control" name="CompetenceSelect">
                                <option value="0">Choose a competence</option>
                                <c:forEach var="result" items="${rsQuery.rows}">
                                    <option value="<c:out value="${result.CompetenceID}" />"><c:out value="${result.Name}" /></option>
                                </c:forEach>
                            </select>
                            <b>Questions:</b>
                            <select class="form-control" name="QuestionsSelect">
                                <option value="0">Choose Question</option>
                            </select>
                            <br/>
                            <b>Questions:</b>
                            <textarea readonly class="form-control"  id="QuestionText"rows="3" name="QuestionText" placeholder="Question"></textarea>
                            <br/>
                            <table>
                                <tr>
                                    <td class='tdCheck' ><input type="checkbox"  name="Situation" value="Situation"/><b>&nbsp&nbsp&nbspSituation<b/></td>
                                    <td class='tdCheck' ><input type="checkbox" name="Targets" value="Targets"/><b>&nbsp&nbsp&nbspTargets</b></td>
                                    <td class='tdCheck'> <input type="checkbox" name="Actions" value="Actions"/><b>&nbsp&nbsp&nbspActions</b></td>
                                    <td class='tdCheck'><input type="checkbox" name="Result" value="Result"/><b>&nbsp&nbsp&nbspResult</b></td>
                                    
                                </tr>
                            </table>
                            <br/>
                            <b>Rate the answer(Probability Bounds):</b>
                            <br/>
                            <input type="number" min="0" max="10" class="form-control" id="Rate1" name="AnswerRate"/>
                            <input type="number" min="0" max="10" class="form-control" id="Rate2" name="AnswerRate"/>
                            <input type="number" min="0" max="10" class="form-control" id="Rate3" name="AnswerRate"/>
                            <b>Notes:</b>
                            <textarea class="form-control"  rows="3" name="Notes" placeholder="Notes"></textarea>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="thumbnail GeneralDiv">

                        <div class="caption">
                            <h4>Assessment</h4>
                        <input type="hidden" value="<c:out value="${AssessmentID}"/>" name="AssessmentID" />
                        <b>Name of the Job:</b>
                        <input type="text" class="form-control" value="<c:out value="${param.JobName}"/>" readonly />
                        <input type="hidden" name="JobID" class="form-control" value="<c:out value="${param.JobID}"/>" />
                        <br/>
                        <b>Name of the Employee:</b>
                        <input type="text" class="form-control" value="<c:out value="${param.EmployeeName}"/>" readonly />
                        <br/>
                        Email of the Employee:
                        <input type="text" name='Email' class="form-control" value="<c:out value="${param.Email}"/>" readonly />
                        <b>Time when you started: </b>
                        <input type="text" class="form-control" value="<c:out value="${StartDate}"/>" readonly /><br/>
                        <input type="submit" id="saveAssessment" class="btn btn-success" value="Finish Assessment" />
                        </div>
                    </div>
                </div>
            </div>
        </section>


    <!-- Scripts -->
    <script src="../Resources/js/jquery.js"></script>
    <script src="../Resources/js/bootstrap.min.js"></script>
    <script src="../Resources/js/Js-ApplyAssessment.js"></script>


</body>
</html>
