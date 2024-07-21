<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="minhnk.category.CategoryDTO"%>
<%@page import="minhnk.product.ProductDTO"%>
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
            List<CategoryDTO> cList = (List<CategoryDTO>) request.getAttribute("CATEGORY_LIST");
            List<ProductDTO> pList = (List<ProductDTO>) request.getAttribute("PRODUCT_LIST");
        %>
        <div class="container" style="padding-top: 60px;">
            <form action="DispatchServlet?action=DeleteCheckbox&id=Product" method="post">
                <div class="table-wrapper" style="border-radius: 30px;">
                    <div class="table-title" style="border-top-right-radius: 30px; border-top-left-radius: 30px;">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2><b>Manage Product</b></h2>
                            </div>
                            <div class="col-sm-6">
                                <a href="#addEmployeeModal"  class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Product</span></a>
                                <button type="submit" class="btn btn-danger" data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Delete</span></button>	
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th></th>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Image</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Availability</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (ProductDTO p:pList){ %>
                                <tr>
                                    <td>
                                        <span class="custom-checkbox">
                                            <input type="checkbox" id="checkbox1" name="options" value=<%=p.getId()%>>
                                            <label for="checkbox1"></label>
                                        </span>
                                    </td>
                                    <td><%=p.getId()%></td>
                                    <td><%=p.getName()%></td>
                                    <td><img src=<%=p.getImage()%> width="150" height="150"></td>
                                    <td>$<%=p.getPrice()%></td>
                                    <td><%=p.getQuantity()%></td>
                                    <td><%=p.getIsAvailable()? "Available" : "Unavailable" %></td>
                                    <td>
                                        <div style="display: flex;">
                                            <button type="submit" class="btn btn-warning edit" formaction="DispatchServlet?action=Load&index=${TAG}&pid=<%=p.getId()%>" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></button>	
                                            <button type="submit" class="btn btn-danger edit" formaction="DispatchServlet?action=Delete&index=${TAG}&pid=<%=p.getId()%>&id=Product" data-toggle="modal" style="margin-left: 5px;"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></button>
                                        </div>
                                    </td>
                                </tr>
                            <%}%>
                        </tbody>
                    </table>
                        
                    <div class="clearfix">
                        <div class="hint-text">Showing <b>${TAG}</b> out of <b>${END}</b> entries</div>
                        <ul class="pagination">
                            <li class="page-item"><a href="DispatchServlet?action=ManageProduct&index=${TAG-1}" class="page-link" style="${TAG == 1? "pointer-events: none;" : ""}">Previous</a></li>
                            <c:forEach begin="1" end="${END}" var="i">
                                <li class="page-item ${TAG == i? "active":""}"><a href="DispatchServlet?action=ManageProduct&index=${i}" class="page-link">${i}</a></li>
                            </c:forEach>
                            <li class="page-item"><a href="DispatchServlet?action=ManageProduct&index=${TAG+1}" class="page-link" style="${TAG == END? "pointer-events: none;" : ""}">Next</a></li>
                        </ul>
                    </div>
                </div>
            </form>
            <div class="d-flex justify-content-center align-items-center mb-3 p-2">        
                <a href="DispatchServlet?action=Home" style="color:white;"><button type="button" class="btn btn-primary p-3"><b>Back to home</b></a></button>
            </div>
        </div>
        <!-- Add Modal HTML -->
        <div id="addEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content" style="border-radius: 15px">
                    <form action="DispatchServlet" method="post">
                        <div class="modal-header">						
                            <h4 class="modal-title">Add Product</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <div class="form-group">
                                <label>Name</label>
                                <input name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Image</label>
                                <input name="image" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Price</label>
                                <input name="price" type="number" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Quantity</label>
                                <input name="quantity" type="number" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <textarea name="description" class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Category</label>
                                <select name="category" class="form-select" aria-label="Default select example">
                                    <% for (CategoryDTO c:cList){ %>
                                        <option value=<%=c.getCid()%> > <%=c.getCname()%> </option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Available:   </label>
                                <label for="yesRadio">Yes</label>
                                <input type="radio" id="yesRadio" name="available" value="1" checked>
                                <label for="noRadio">No</label>
                                <input type="radio" id="noRadio" name="available" value="0">
                            </div>
                        </div>
                        <div class="modal-footer" style="border-radius: 15px">
                            <input type="button" class="btn btn-secondary" data-dismiss="modal" value="Cancel" style="border-radius: 15px">
                            <input type="submit" class="btn btn-success" value="AddProduct" name="action" style="border-radius: 15px">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    <script src="js/manager.js" type="text/javascript"></script>
    </body>
</html>