<%-- 
    Document   : AddCompany
    Created on : 21-dic-2015, 18:26:01
    Author     : Ricardo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Company</title>
    </head>
    <body>
        <form action="Ct-AddCompany.jsp" method="POST">
            <sql:query var="rsQuery" dataSource="SqlAdmin">
                Select CountryRegionCode, Name from CountryRegion 
            </sql:query>
            Company Name: <input type="text" name="CompanyName">
            <br />
            Address Line 1: <input type="text" name="AddressLine1" /><br/>
            Address Line 2: <input type="text" name="AddressLine2" /><br/>
            City: <input type="text" name="City" /><br/>
            Postal Code: <input type="text" name="PostalCode" /><br/>
            Country:
            <select class="form-control" name="Country" id="CountrySelect">
                <option value="0">Choose Country</option>
                <c:forEach var="result" items="${rsQuery.rows}">
                    <option value="<c:out value="${result.CountryRegionCode}" />"><c:out value="${result.Name}" /></option>
                </c:forEach>
            </select>
            <br/>
            State Province:
            <select class="form-control" name="State" id="StateProvinceSelect">
                <option value="0">Choose State</option>
            </select>
            <br/>
            
            Please provide some information of the Company's Administrator<br/>
            First Name: <input type="text" name="FirstName"><br/>
            Middle Name: <input type="text" name="MiddleName"><br/>
            Last Name: <input type="text" name="LastName"><br/>
            Email: <input type="text" name="Email"><br/>
            Phone: <input type="text" name="Phone"><br/>
            Password: <input type="password" name="Password"><br/>
            Repeat Password: <input type="password" name="RepeatPassword"><br/>
            <input type="submit" value="Submit" />
        </form>
    </body>
    <script src="../Resources/js/jquery.js"></script>
    <script src="../Resources/js/Js-AddCompany.js"></script>
</html>
