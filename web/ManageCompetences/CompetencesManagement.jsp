<%-- 
    Document   : ManageCompetences
    Created on : 02-ene-2016, 21:56:16
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

                            <c:if test="${ sessionScope.SessionType eq 'CompanyAdministrator' }" >
                                <li><a href="../index.jsp"><span class="glyphicon glyphicon-home textMenu"></span>Home</a></li>
                                <li><a href="AddCompetence.jsp"><span class="glyphicon glyphicon-pencil textMenu"></span>Add Competences</a></li>
                                </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Cuerpo -->    
        <section class="leftSide">
            <div class="row" id="row-profesor">           
                <div class="container-profesor">
                    <div class="page-header-profesor generalTitle" >
                        <h1 class="Unidad">Competences Management</h1>
                    </div>
                </div>
                <sql:query var="rsQuery" dataSource="SqlAdmin">
                    Select DepartmentID, Name from Department where CompanyID = ?
                    <sql:param value="${sessionScope.CompanyID}" />
                </sql:query>
                <div class="col-md-6">
                    <div class="thumbnail GeneralDiv" >
                        <div class="caption" id="manageDiv">
                            <h4>Manage Competences</h4>
                            <b>Department:</b>
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
                            <br/>
                            <b>Competences of the selected job:</b>
                            <div class="table-responsive">    
                                <table class="table table-hover" id="CompetencesTable">
                                    <thead>
                                        <tr>
                                            <th> </th>
                                            <th>Name</th>
                                            <th>Rank</th>
                                            <th>Details</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div> 
                            <br/>
                            <b>Select a competence to add:</b>
                            <select class="form-control" name="CompetencesSelect">
                                <option value="0">Choose Competence</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="thumbnail GeneralDiv">

                        <div class="caption">
                            <h4>Competence</h4>
                            <b>Competence Name:</b>
                            <input type="text" class="form-control" placeholder="Name" name="CompetenceName" disabled="true" />
                            <b>Competence Description:</b>
                            <textarea class="form-control"  rows="3" name="CompetenceDescription" placeholder="Description" disabled="true"></textarea>
                            <b>Rank:</b>
                            <input type="text" class="form-control" placeholder="Rank" name="CompetenceRank" disabled="true" />
                            <br/>
                            Questions:
                            <div class="table-responsive">    
                                <table class="table table-hover" id="QuestionsTable">
                                    <thead>
                                        <tr>
                                            <th>Question</th>
                                            <th>Rank</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            <input type="submit" name="AddButton" class="btn btn-success" value="Add Competence" disabled="true"/>
                        </div>
                    </div>
                </div>
            </div>



        </section>

        <section class="rightSide">
            <div id = "instruccion2">
                <div class="thumbnail" id="FondoProfesor">
                    <img src="../Resources/img/banner_profesorVI.jpg" data-src="holder.js/300x200" alt="...">
                    <div class="caption">
                        <div class="Titulos"><h3 class="TitulosInformacion"><i>Lorem ipsum ad his</i></h3></div>
                        <p class="informacion"> Lorem ipsum ad his</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Scripts -->
        <script src="../Resources/js/jquery.js"></script>
        <script src="../Resources/js/bootstrap.min.js"></script>
        <script src="../Resources/js/Js-CompetencesManagement.js"></script>

    </body>
</html>
