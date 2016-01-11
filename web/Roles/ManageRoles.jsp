<%-- 
    Document   : ManageRoles
    Created on : 10-ene-2016, 20:43:46
    Author     : Ricardo
--%>

<%-- 
    Document   : ManageCompetences
    Created on : 02-ene-2016, 21:56:16
    Author     : Ricardo
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<c:if test="${ sessionScope.ManageRoles ne 'true' }" >
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
        <section class="centralSide">
            <div class="row" id="row-profesor">           
                <div class="container-profesor">
                    <div class="page-header-profesor generalTitle" >
                        <h1 class="Unidad">Managing Roles</h1>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="thumbnail GeneralDiv" >
                        <div class="caption" id="manageDiv">
                            Please provide some information of the new user: <br/>
                            First Name: <input type="text" class="form-control" name="FirstName"><br/>
                            Middle Name: <input type="text" class="form-control" name="MiddleName"><br/>
                            Last Name: <input type="text" class="form-control" name="LastName"><br/>
                            Email: <input type="text" class="form-control" name="Email"><br/>
                            Phone: <input type="text" class="form-control" name="Phone"><br/>
                            <input type="submit" id="AddQuestion" class="btn btn-success" value="Add Question"/>
                            Change User's Permissions
                            <div class="table-responsive">    
                                <table class="table table-hover" id="CompetencesTable">
                                    <thead>
                                        <tr>
                                            <th> </th>
                                            <th>Complete Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Manage Roles</th>
                                            <th>Manage Competences</th>
                                            <th>Apply Assessment</th>
                                            <th>Manage Task</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
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
        <script src="../Resources/js/Js-CompetencesManagement.js"></script>

    </body>
</html>
