<%-- 
    Document   : AddDepartmentJob
    Created on : 28-feb-2016, 18:19:26
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
                        <h1 class="Unidad">Add Departments and Jobs</h1>
                    </div>
                </div>
                <div class="col-md-6 shortWidth">
                    <div class="thumbnail GeneralDiv" >
                        <div class="caption" id="manageDiv">
                            <h4>Add Deparment</h4>
                            <b>Department Name:</b> 
                            <input class="form-control" type="text" required placeholder="Deparment Name" name="DepartmentName"><br/>
                            <b>Description: </b> 
                            <textarea class="form-control" required name="DepartmentDescription" placeholder="Description"></textarea>
                            <br/>
                            <input type="submit" id="btnAddDepartment" class="btn btn-success" value="Add Department"/>
                            <hr/>
                            <h4>Add Job</h4>
                            <b>Select one department:</b> 
                            <sql:query var="rsQuery" dataSource="SqlAdmin">
                                Select DepartmentID, Name from Department where CompanyID = ?
                                <sql:param value="${sessionScope.CompanyID}" />
                            </sql:query>
                            <select class="form-control" name="DepartmentSelect">
                                <option value="0">Choose Department</option>
                                <c:forEach var="result" items="${rsQuery.rows}">
                                    <option value="<c:out value="${result.DepartmentID}" />"><c:out value="${result.Name}" /></option>
                                </c:forEach>
                            </select>    
                            <b>Job Name: </b> <input required class="form-control" type="text" name="JobName">
                                <b>Description:</b> <textarea required class="form-control" name="JobDescription" placeholder="Descripcion"></textarea>
                            <br/>
                            <input type="submit" id="btnAddJob" class="btn btn-success" value="Add Job"/>


                        </div>
                    </div>
                </div>
                <div class="col-md-6 largeWidth">
                    <div class="thumbnail GeneralDiv" >

                        <div class="caption">
                            <h4>Jobs</h4>
                            <b>Select a department:</b>
                            <select class="form-control" name="DepartmentSelectJob">
                                <option value="0">Choose Department</option>
                                <c:forEach var="result" items="${rsQuery.rows}">
                                    <option value="<c:out value="${result.DepartmentID}" />"><c:out value="${result.Name}" /></option>
                                </c:forEach>
                            </select>
                            <br/>
                            <div class="table-responsive">    
                                <table class="table table-hover" id="JobTable" >
                                    <thead>
                                        <tr>
                                            <th>Job Name</th>
                                            <th>Job Description</th>
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
        <script src="../Resources/js/Js-AddDepartmentJob.js"></script> 

    </body>
</html>
