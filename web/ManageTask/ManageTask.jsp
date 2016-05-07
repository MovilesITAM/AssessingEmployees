<%-- 
    Document   : ManageTaks
    Created on : 07-feb-2016, 18:03:28
    Author     : Ricardo
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<c:if test="${ sessionScope.ManageTask ne 'true' }" >
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
                        <h1 class="Unidad">Manage Tasks</h1>
                    </div>
                </div>
                <sql:query var="rsQuery" dataSource="SqlAdmin">
                    Select DepartmentID, Name from Department where CompanyID = ?
                    <sql:param value="${sessionScope.CompanyID}" />
                </sql:query>
                <div class="col-md-6 small">
                    <div class="thumbnail GeneralDiv" >
                        <div class="caption" id="manageDiv">
                            <h4>Statistics</h4>
                            <b>Department</b>
                            <select class="form-control" name="DepartmentSelect">
                                <option value="0">Choose Department</option>
                                <c:forEach var="result" items="${rsQuery.rows}">
                                    <option value="<c:out value="${result.DepartmentID}" />"><c:out value="${result.Name}" /></option>
                                </c:forEach>
                            </select>
                            <b>Job:</b>
                            <select class="form-control" name="JobSelect">
                                <option value="0">Choose Job</option>
                            </select>
                            <b>Employee Name:</b>
                            <select class="form-control" name="EmployeeSelect">
                                <option value="0">Choose Employee</option>
                            </select>
                            <canvas id="myChart1" width="380" height="400"></canvas>
                            <div id="chartjs-tooltip"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 big">
                    <div class="thumbnail GeneralDiv">

                        <div class="caption">
                            <div class="table-responsive">    
                                <table class="table table-hover" id="TaskTable">
                                    <thead>
                                        <tr>
                                            <th width="2%" ></th>
                                            <th>Name</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Efficiency</th>
                                            <th>Comments</th>
                                            <th width="2%" >Done</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            <div id='leftRight'> 
                                <h4>Add Task  <button id="btnTask" type="button" class="btn btn-default btn-sm"><span class="caret"></span></button></h4>
                                <div id="taskDiv">
                                    <b>Task Name:</b>
                                    <input type="text" class="form-control" placeholder="Name" name="TaskName" />
                                    <b class='input5Right' >Star Date:</b>
                                    <b class='input5Right'>End Date:</b>
                                    <br/>
                                    <input type="date"  class="form-control input5Right" name="StartDate" />

                                    <input type="date" class="form-control input5Right" name="EndDate" />
                                    <br/><br/>
                                    <b>Comments:</b>
                                    <textarea class="form-control"  rows="3" name="Comments" placeholder="Comments"></textarea>
                                    <br/>
                                    <input type="submit" id='addTask'  class="btn btn-success" value="Add Task"/>
                                </div>
                            </div>
                            <div id='rightRight'>
                                <h4>Add Appraisal  <button id="btnAppraisal" type="button" class="btn btn-default btn-sm"><span class="caret"></span></button></h4>
                                <div id="appraisalDiv">
                                    <b>Choose a competence to modify:</b>
                                    <select class="form-control" name="CompetenceSelect">
                                        <option value="0">Choose competence</option>
                                    </select>
                                    <b>Weight to add:</b>
                                    <input type="number" step='2' class="form-control" name="Weight" />
                                    <b>Comments:</b>
                                    <textarea class="form-control"  rows="3" name="CommentsAppraisal" placeholder="Comments"></textarea><br/>
                                    <input type="submit" id='addWeight'  class="btn btn-success" value="Add Appraisal"/>
                                </div>
                            </div>
                                                            <br/>
                            
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Scripts -->
        <script src="../Resources/js/jquery.js"></script>
        <script src="../Resources/js/bootstrap.min.js"></script>
        <script src="../Resources/js/Chart.js"></script>
        <script src="../Resources/js/Js-ManageTask.js"></script>
        <script src="../Resources/js/Js-GeneralAJAX.js"></script>


    </body>
</html>
