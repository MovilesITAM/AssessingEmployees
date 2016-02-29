<%-- 
    Document   : ManageCompetences
    Created on : 02-ene-2016, 21:56:16
    Author     : Ricardo
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<c:if test="${ sessionScope.ApplyAssessment ne 'true' }" >
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
                        <h1 class="Unidad">Create Assessment</h1>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="thumbnail GeneralDiv" >
                        <div class="caption" id="manageDiv">
                            <h4>Create Assessment</h4>
                            <form id="formAssessment" action="ApplyAssessment.jsp" method="POST">
                            
                            <b>Employee's Email:</b><br/>
                            <input type="text" class="form-control" placeholder="Email" name="Email"/>
                            <br/>
                            <b>Name of the Employee:</b><br/>
                            <input type="text" class="form-control" placeholder="Name of the Employee" name="EmployeeName" readonly/>
                            <input type="hidden" class="form-control" name="EmployeeID" readonly />
                            <input type="hidden" class="form-control" name="JobID" readonly/>
                            <br/>
                            <b>Phone of the Employee:</b><br/>
                            <input type="text" class="form-control" placeholder="Phone of the Employee" name="EmployeePhone" readonly/>
                            <br/>
                            <b>Job of the Employee:</b><br/>
                            <input type="text" class="form-control" placeholder="Job of the Employee" name="JobName" readonly/>
                            <br/>
                            <input type="submit" id="createAssessment" class="btn btn-success" value="Create Assessment" />
                            <br/><br/>
                            <div class="alert alert-danger" id="message">
                                <ul id="errorList">
                                </ul>
                             </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="thumbnail GeneralDiv">

                        <div class="caption">
                            <h4>Competence</h4>
                            <b>Competences of the job:</b>
                            <select class="form-control" name="CompetencesJob">
                                <option value="-1">Choose Competence</option>
                            </select>
                            <b> Competence Description:</b>
                            <textarea class="form-control"  rows="3" name="CompetenceDescription" placeholder="Description" disabled="true"></textarea>
                            <b>Rank:</b>
                            <input type="text" class="form-control" placeholder="Rank" name="CompetenceRank" disabled="true" />
                            <br/>
                            <b>Questions:</b>
                            <div class="table-responsive">    
                                <table class="table table-hover" id="QuestionsTable">
                                    <thead>
                                        <tr>
                                            <th>Question</th>
                                            <th>Weight</th>
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
        <script src="../Resources/js/Js-CreateAssessment.js"></script>


    </body>
</html>
