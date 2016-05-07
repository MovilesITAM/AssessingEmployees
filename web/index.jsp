<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Assessing Employees</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='http://fonts.googleapis.com/css?family=Gilda+Display' rel='stylesheet' type='text/css'>
        <link href="Resources/css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="Resources/css/main.css" rel="stylesheet" media="screen">
        <link href="Resources/css/main.css" rel="stylesheet" media="screen">

    </head>
    <body>

        <!-- Header -->
        <c:if test="${empty sessionScope.SessionType}" >
            <nav class="navbar navbar-default" role="navigation">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <h1 class="blanco">Assessing Employees</h1>
                    </div>
                    <div class="navbar-collapse navbar-fixed-top" id="bs-example-navbar-collapse-1">
                        <form class="navbar-form navbar-right " role="search" method="POST" action="Ct-Login.jsp">
                            <div class="form-group ">
                                <input type="text" class="form-control input-sm"  name="Email" placeholder="Email" required>
                            </div>
                            <div class="form-group">   
                                <input type="password" class="form-control input-sm " name="Password" id="ejemplo_password_1" 
                                       placeholder="Password" required>
                            </div>
                            <button type="submit" class="btn btn-danger btn btn-primary btn-sm">Log In</button>
                        </form>
                    </div>
                </div>
            </nav>
        </c:if>

        <c:if test="${not empty sessionScope.SessionType}" >
            <nav class="navbar navbar-default" id='generalHeader' role="navigation">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <c:if test="${sessionScope.SessionType eq 'CompanyAdministrator'}" >
                            <h1 class="blanco">Assessing Employees<i> / Company Administrator </i></h1> 
                        </c:if>                      
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
                                <li><a href="Ct-Logout.jsp">Log out</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </c:if>



        <nav class="navbar navbar-default NavMenu" >
            <div class="container-fluid">
                <div class="navbar-header">
                    <div class="navbar-fixed-top navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav ">
                            <c:if test="${ sessionScope.ManageCompetences eq 'true' }" >
                                <li><a href="ManageCompetences/CompetencesManagement.jsp">
                                    <span class="glyphicon glyphicon-list-alt textMenu"></span>
                                        Manage Competences and Jobs
                                </a></li>
                                <li><a href="ManageCompetences/AddCompetence.jsp">
                                    <span class="glyphicon glyphicon-pencil textMenu"></span>
                                    Add Competences and Questions
                                </a></li>
                                <li><a href="ManageCompetences/AddDepartmentJob.jsp">
                                    <span class="glyphicon glyphicon-pencil textMenu"></span>
                                    Add Jobs
                                </a></li>
                            </c:if>
                            <c:if test="${ sessionScope.ApplyAssessment eq 'true' }" >
                                <li><a href="ManageAssessment/CreateAssessment.jsp">
                                    <span class="glyphicon glyphicon-file textMenu"></span>
                                        Create Assessment
                                </a></li>
                                <li><a href="ManageAssessment/EmployeeStatistics.jsp">
                                    <span class="glyphicon glyphicon-signal textMenu"></span>
                                    View Statistics
                                </a></li>
                            </c:if>
                            <c:if test="${ sessionScope.ManageTask eq 'true' }" >
                                <li><a href="ManageTask/ManageTask.jsp">
                                    <span class="glyphicon glyphicon-file textMenu"></span>
                                        Manage Tasks
                                </a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Carrucel -->
        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">

            <ol class="carousel-indicators">
                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            </ol>

            <div class="carousel-inner">
                <div class="item active" id="Completo">
                    <img src="Resources/img/banner.jpg" alt="imagen1">
                    <div class="carousel-caption">
                        <h1><b></b></h1>
                        <h3></h3>
                    </div>
                </div>

                <div class="item"><img  src="Resources/img/banner1.png" alt="banner2" />
                    <div class="carousel-caption">
                        <h1><b></b></h1>
                        <h3></h3>
                    </div>
                </div>
            </div>

            <!-- Controls -->
            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
        </div>

        <br>
        <hr>

        <!-- Descripcion de aula virtual -->
        <div class="container">

            <div class="page-header">
                <h1>Assessing Employees</h1>
            </div>
            <p class="lead justificado">Lorem ipsum ad his scripta blandit partiendo</p>

        </div>


        <!-- Elementos imagenes -->
        <div class="row">
            <div class="col-xs-6 col-sm-3">
                <div class="thumbnail">
                    <img src="Resources/img/grid_1.jpg" data-src="holder.js/300x200" alt="...">
                    <div class="caption">
                        <h4><b>Lorem ipsum ad his scripta blandit partiendo</b></h4>
                        <p>...</p>
                    </div>
                </div>
            </div> 
           <div class="col-xs-6 col-sm-3">
                <div class="thumbnail">
                    <img src="Resources/img/grid_2.jpg" data-src="holder.js/300x200" alt="...">
                    <div class="caption">
                        <h4><b>Lorem ipsum ad his scripta blandit partiendo</b></h4>
                        <p>...</p>
                    </div>
                </div>
            </div>
            <div class="clearfix visible-xs"></div>

            <div class="col-xs-6 col-sm-3">
                <div class="thumbnail">
                    <img src="Resources/img/grid_3.jpg" data-src="holder.js/300x200" alt="...">
                    <div class="caption">
                        <h4><b>Lorem ipsum ad his scripta blandit partiendo</b></h4>
                        <p>...</p>
                    </div>
                </div>
            </div>
            <div class="col-xs-6 col-sm-3">
                <div class="thumbnail">
                    <img src="Resources/img/grid_4.jpg" data-src="holder.js/300x200" alt="...">
                    <div class="caption">
                        <h4><b>Lorem ipsum ad his scripta blandit partiendo</b></h4>
                        <p>...</p>
                    </div>
                </div>
            </div>
        </div>




        <!-- Footer -->
        <div id="footer">

        </div>

        <!-- Scripts -->
        <script src="Resources/js/jquery.js"></script>
        <script src="Resources/js/bootstrap.min.js"></script>

    </body>
</html>
