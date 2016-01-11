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
                                <li><a href="CompetencesManagement.jsp"><span class="glyphicon glyphicon-list-alt textMenu"></span>Manage Competences</a></li>
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
                        <h1 class="Unidad">Competences</h1>
                    </div>
                </div>
                <div class="col-md-6">
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
                <div class="col-md-6">
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
                            <input type="text" class="form-control" placeholder="Name" name="Question" />    
                            <b>Rank:</b>
                            <input type="text" class="form-control" placeholder="Name" name="Value" />    
                            <br/><input type="submit" id="AddQuestion" class="btn btn-success" value="Add Question"/>
                            <br/>
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
        <script src="../Resources/js/Js-AddCompetence.js"></script> 

    </body>
</html>
