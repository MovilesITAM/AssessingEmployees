<%-- 
    Document   : EmployeeStatistics
    Created on : 20-ene-2016, 21:43:37
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
        <section class="centralSide">
            <div class="row" id="row-profesor">           
                <div class="container-profesor">
                    <div class="page-header-profesor generalTitle" >
                        <h1 class="Unidad">Employee's Statistics</h1>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="thumbnail GeneralDiv" >
                        <div class="caption" id="manageDiv">
                            <h4>Employee Statistics</h4>
                            Please write the employee's email of which you want to see statistics
                            Email:
                            <input class="form-control" id='email1' type="email" employee="1" value="${param.Email}" />
                            Name: 
                            <input class="form-control" type="text" id="Name1" disabled="true" />
                            <br/>
                            <canvas id="myChart1" width="500" height="390"></canvas>
                            <div id="chartjs-tooltip"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="thumbnail GeneralDiv">

                        <div class="caption">
                            <h4>Employee Statistics</h4>
                            Email:
                            <input class="form-control" type="email" employee="2" />
                            Name: 
                            <input class="form-control" type="text" id="Name2" disabled="true" />
                            <br/>
                            <canvas id="myChart2" width="500" height="390"></canvas>
                            <div id="chartjs-tooltip2"></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Scripts -->
        <script src="../Resources/js/jquery.js"></script>
    <script src="../Resources/js/bootstrap.min.js"></script>
    <script src="../Resources/js/Chart.js"></script>
    <script src="../Resources/js/Js-EmployeeStatistics.js"></script>


    </body>
</html>