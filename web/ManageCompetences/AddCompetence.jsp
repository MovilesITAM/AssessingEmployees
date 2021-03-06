<%-- 
    Document   : AddCompetences2
    Created on : 03-ene-2016, 21:36:28
    Author     : Ricardo
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<c:if test="${ sessionScope.ManageCompetences ne 'true' }" >
    <c:redirect url="../index.jsp"/>
</c:if>
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
                    <h1 class="blanco">Assessing Employees</h1>                     
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
                                <li><a href="../ManageCompetences/AddDepartmentJob.jsp">
                                    <span class="glyphicon glyphicon-pencil textMenu"></span>
                                    Add Jobs
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
                                <c:if test="${ sessionScope.ManageTask eq 'true' }" >
                                <li><a href="../ManageTask/ManageTask.jsp">
                                    <span class="glyphicon glyphicon-file textMenu"></span>
                                        Manage Tasks
                                </a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Cuerpo -->    
        <section class="centralSide">
            <div class="row" id="row-profesor">           
                <div class="container-profesor">
                    <div class="page-header-profesor generalTitle" >
                        <h1 class="Unidad">Add Competences and Questions</h1>
                    </div>
                </div>
                <div class="col-md-6 shortWidth">
                    <div class="thumbnail GeneralDiv" >
                        <div class="caption" id="manageDiv">
                            <h4>Add Competences</h4>
                            <b>Competence Name:</b>
                            <input type="text" class="form-control" placeholder="Name" name="CompetenceName" />
                            <br/><b>Competence Description:</b>
                            <br/>
                            <textarea class="form-control"  rows="3" name="CompetenceDescription" placeholder="Description"></textarea>
                            <br/>
                            <input type="submit" id="AddCompetence" class="btn btn-success" value="Add Competence"/>
                            <br/>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 largeWidth">
                    <div class="thumbnail GeneralDiv" >

                        <div class="caption">
                            <h4>Add Questions</h4>
                            <sql:query var="rsQuery" dataSource="SqlAdmin">
                                Select CompetenceID, Name from Competence where CompanyID = ?
                                <sql:param value="${sessionScope.CompanyID}" />
                            </sql:query>
                             Add question to Competence:
                            <select class="form-control" name="CompetenceSelect">
                                <option value="0">Choose Competence</option>
                                <c:forEach var="result" items="${rsQuery.rows}">
                                    <option value="<c:out value="${result.CompetenceID}" />"><c:out value="${result.Name}" /></option>
                                </c:forEach>
                            </select><br/>
                            <b>Question:</b>
                            <input type="text" class="form-control" placeholder="Question" name="Question" />    
                            <b>Weight</b>
                            <input type="number"  step=".1" min="0" max="1" class="form-control" placeholder="Weight" name="Value" />    
                            <br/><input type="submit" id="AddQuestion" class="btn btn-success" value="Add Question"/>
                            <br/>
                            <div class="table-responsive">    
                                <table class="table table-hover" id="QuestionsTable">
                                    <thead>
                                        <tr>
                                            <th  width="2%" ></th>
                                            <th>Question</th>
                                            <th  width="2%">Weight</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



        </section>

        <!-- Scripts -->
        <script src="../Resources/js/jquery.js"></script>
        <script src="../Resources/js/bootstrap.min.js"></script>
        <script src="../Resources/js/Js-AddCompetence.js"></script> 

    </body>
</html>
