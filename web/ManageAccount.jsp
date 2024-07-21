<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="minhnk.account.AccountDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Product</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                text-align: center;
            }
        </style>
    </head>
    <body style="background-color: #FFC107;">
        <jsp:include page="Menu.jsp"></jsp:include>
        <%
            List<AccountDTO> aList = (List<AccountDTO>) request.getAttribute("ACCOUNT_LIST");
        %>
        <div class="container" style="padding-top: 60px;">
            <form action="DispatchServlet?action=DeleteCheckbox&id=Account" method="post">
                <div class="table-wrapper" style="border-radius: 30px;">
                    <div class="table-title" style="border-top-right-radius: 30px; border-top-left-radius: 30px;">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2><b>Manage Account</b></h2>
                            </div>
                            <div class="col-sm-6">
                                <button type="submit" class="btn btn-danger" data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Delete</span></button>	
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th></th>
                                <th>ID</th>
                                <th>UserName</th>
                                <th>Password</th>
                                <th>Seller</th>
                                <th>Admin</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (AccountDTO acc:aList){ %>
                                <tr>
                                    <td>
                                        <span class="custom-checkbox">
                                            <input type="checkbox" id="checkbox1" name="options" value=<%= acc.getId() %> />
                                            <label for="checkbox1"></label>
                                        </span>
                                    </td>
                                    <td><%= acc.getId() %></td>
                                    <td><img src="https://cdn-icons-png.flaticon.com/512/287/287226.png" alt="Pokemon Trainer" width="70" height="70"> <%= acc.getUser() %></td>
                                    <td><%= acc.getPass()%></td>
                                    <td>
                                        True <input type ="radio" value="true" name=<%= acc.getId()+"sell" %> <%= acc.getIsSell()? "checked" : "" %> /></br>
                                        False <input type ="radio" value="false" name=<%= acc.getId()+"sell" %> <%= !acc.getIsSell()? "checked" : "" %> />
                                    </td>
                                    <td>
                                        True <input type ="radio" value="true" name=<%= acc.getId()+"admin" %> <%= acc.getIsAdmin()? "checked" : "" %> /></br>
                                        False <input type ="radio" value="false" name=<%= acc.getId()+"admin" %> <%= !acc.getIsAdmin()? "checked" : "" %> />
                                    </td>
                                    <td>
                                        <div style="display: flex;">
                                            <button type="submit" class="btn btn-success edit" formaction="DispatchServlet?action=Save&pid=<%=acc.getId()%>" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Save">&#xE161;</i></button>	
                                            <button type="submit" class="btn btn-danger edit" formaction="DispatchServlet?action=Delete&pid=<%=acc.getId()%>&id=Account" data-toggle="modal" style="margin-left: 5px;"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></button>
                                        </div>
                                    </td>
                                </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
            </form>
            <div class="d-flex justify-content-center align-items-center mb-3 p-2">        
                <a href="DispatchServlet?action=Home" style="color:white;"><button type="button" class="btn btn-primary p-3"><b>Back to home</b></a></button>
            </div>
        </div>
    <script src="js/manager.js" type="text/javascript"></script>
    </body>
</html>