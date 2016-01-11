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
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <form class="navbar-form navbar-right" role="search" method="POST" action="Ct-Login.jsp">
                            <div class="form-group ">
                                <input type="text" class="form-control input-sm"  name="Email" placeholder="Email">
                            </div>
                            <div class="form-group">   
                                <input type="password" class="form-control input-sm " name="Password" id="ejemplo_password_1" 
                                       placeholder="Password">
                            </div>
                            <button type="submit" class="btn btn-danger btn btn-primary btn-sm">Log In</button>
                        </form>
                    </div>
                </div>
            </nav>
        </c:if>
        
        <c:if test="${not empty sessionScope.SessionType}" >
            <nav class="navbar navbar-default" role="navigation">
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
                                <li><a href="Ct-LogOut.jsp">Log out</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </c:if>



        <nav class="navbar navbar-default NavMenu" >
            <div class="container-fluid">
                <div class="navbar-header">
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav ">


                            <c:if test="${ sessionScope.ssTipo eq 'Profesor' }" >
                                <li><a href="Vt-Inicio.jsp"><span class="glyphicon glyphicon-home" id="subirTarea"></span>Inicio</p></a></li>
                                <li><a href="../Profesor/Vt-CalificarActividades.jsp"><span class="glyphicon glyphicon-save" id="bajarTarea"></span>Revisar Actividades</a></li>
                                <li><a href="../Profesor/Vt-AsignarTareas.jsp"><span class="glyphicon glyphicon-open" id="subirTarea"></span>Crear Actividad</a></li>
                                <li><a href="#"><span class="glyphicon glyphicon-eye-open" id="subirTarea"></span>Asistencia</a></li>
                                <li><a href="#"><span class="glyphicon glyphicon-flag" id="subirTarea"></span>Examenes</a></li> 
                            </c:if>
                            <c:if test="${ sessionScope.ssTipo eq 'Alumno' }" >
                                <li><a href="Vt-Inicio.jsp"><span class="glyphicon glyphicon-home" id="subirTarea"></span>Inicio</p></a></li>
                                <li><a href="../Alumno/Vt-RevisarActividades.jsp"><span class="glyphicon glyphicon-save" id="bajarTarea"></span>Revisar Evaluacion Actividades</a></li>
                                <li><a href="../Alumno/Vt-RealizarTarea.jsp"><span class="glyphicon glyphicon-open" id="subirTarea"></span>Realizar Actividades</a></li>
                                <li><a href="#"><span class="glyphicon glyphicon-eye-open" id="subirTarea"></span>Asistencia</a></li>
                                <li><a href="#"><span class="glyphicon glyphicon-flag" id="subirTarea"></span>Examenes</a></li> 
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
                        <h1><b>Assessing Employees</b></h1>
                        <h3>Lorem ipsum ad his scripta blandit partiendo</h3>
                    </div>
                </div>

                <div class="item"><img  src="Resources/img/banner1.png" alt="banner2" />
                    <div class="carousel-caption">
                        <h1><b>Assessing Employees</b></h1>
                        <h3>Lorem ipsum ad his scripta blandit partiendo</h3>
                    </div>
                </div>
                <div class="item"><img  src="Resources/img/banner2.png" alt="banner2" />
                    <div class="carousel-caption">
                        <h1><b>Assessing Employees</b></h1>
                        <h3>Lorem ipsum ad his scripta blandit partiendo</h3>
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
                <h1>Aula Virtual</h1>
            </div>
            <p class="lead justificado">Lorem ipsum ad his scripta blandit partiendo</p>

        </div>


        <!-- Elementos imagenes -->
        <div class="row">
            <div class="col-xs-6 col-sm-3">
                <div class="thumbnail">
                    <img src="Resources/img/grid_1.jpg" data-src="holder.js/300x200" alt="...">
                    <div class="caption">
                        <h3><b>Subir tareas</b></h3>
                        <p class="justificado">El profesor asigna actividades para realizacion de los alumnos, el alumno respondera con la actividad resuelta y el profesor la evaluara, dando paso a la revision de calificaciones por parte del alumno. </p>
                    </div>
                </div>
            </div>
            <div class="col-xs-6 col-sm-3">
                <div class="thumbnail">
                    <img src="Resources/img/grid_2.jpg" data-src="holder.js/300x200" alt="...">
                    <div class="caption">
                        <h3><b>Pase de asistencia</b></h3>
                        <p class="justificado">Un pase de lista automatizado. El profesor habilitara el pase de asistencia de los alumnos, permitiendo el registro de la asistencia momentaneamente.</p>
                    </div>
                </div>
            </div>
            <div class="clearfix visible-xs"></div>

            <div class="col-xs-6 col-sm-3">
                <div class="thumbnail">
                    <img src="Resources/img/grid_3.jpg" data-src="holder.js/300x200" alt="...">
                    <div class="caption">
                        <h3><b>Realizar examenes</b></h3>
                        <p class="justificado">El profesor elabora un examen para que el alumno lo resuelva y el sistema lo evalue, permitiendo al alumno ver su calificacion al instante.</p>
                    </div>
                </div>
            </div>
            <div class="col-xs-6 col-sm-3">
                <div class="thumbnail">
                    <img src="Resources/img/grid_4.jpg" data-src="holder.js/300x200" alt="...">
                    <div class="caption">
                        <h3><b>Informe</b></h3>
                        <p class="justificado">El sistema generara un reporte de asistencia con base al pase de lista que se incorpora en el software.</p>
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
