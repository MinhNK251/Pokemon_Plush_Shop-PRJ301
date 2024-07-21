<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="minhnk.category.CategoryDTO"%>
<%@page import="minhnk.product.ProductDTO"%>
<%@page import="minhnk.account.AccountDTO"%>
<%@page import="minhnk.cart.CartDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body style="background-color: #FFC107;">
        <c:set var="isHomePage" value="true" scope="request"/>
        <jsp:include page="Menu.jsp"></jsp:include>
        <%
            List<CategoryDTO> cList = (List<CategoryDTO>) request.getAttribute("CATEGORY_LIST");
            List<ProductDTO> pList = (List<ProductDTO>) request.getAttribute("PRODUCT_LIST");
            ProductDTO last = (ProductDTO) request.getAttribute("LAST_PRODUCT");
            String txt = (String) request.getAttribute("TEXT_SEARCH");
        %>
            <div class="container">
                <div class="row">
                    <div class="col">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb" style="border-radius: 30px">
                                <li class="breadcrumb-item"><a href="DispatchServlet?action=Home">Home</a></li>
                                <li class="breadcrumb-item"><a href="#">Category</a></li>
                                <li class="breadcrumb-item active" aria-current="#">Sub-category</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
            
            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="card bg-light mb-3" style="border-radius: 30px; overflow: hidden;">
                            <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>
                            <ul class="list-group category_block">
                                <% for (CategoryDTO c:cList){ %>
                                    <li class="list-group-item text-white" style="background-color:powderblue;"><a href="DispatchServlet?action=Category&cid=<%= c.getCid()%>"><%= c.getCname()%></a></li>
                                <%}%>
                            </ul>
                        </div>
                        <div class="card bg-light mb-3" style="border-radius: 30px; overflow: hidden;">
                            <div class="card-header bg-success text-white text-uppercase">Last product</div>
                            <div class="card-body">
                                <img class="img-fluid" src=<%= last.getImage()%> width="250" height="250"/>
                                <h5 class="card-title show_txt"><a href="DispatchServlet?action=Detail&pid=<%= last.getId()%>" title="View Product"><%= last.getName()%></a></h5>
                                <p class="card-text">Available: <%= last.getQuantity()%></p>
                                <p class="bloc_left_price">$<%= last.getPrice()%></p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-sm-9">
                        <div id="content" class="row"> 
                            <% for (ProductDTO p:pList){ %>
                                <div class="product col-12 col-md-6 col-lg-4">
                                    <div class="card mb-3" style="border-radius: 30px; overflow: hidden;">
                                        <img class="card-img-top" src=<%= p.getImage()%> alt="Card image cap" width="250" height="250">
                                        <div class="card-body">
                                            <h4 class="card-title show_txt"><a href="DispatchServlet?action=Detail&pid=<%= p.getId()%>" title="View Product"><%= p.getName()%></a></h4>
                                            <p class="card-text show_txt">Available: <%= p.getQuantity()%></p>
                                            <div class="row">
                                                <div class="col">
                                                    <p class="btn btn-danger btn-block">$<%= p.getPrice()%></p>
                                                </div>
                                                <div class="col">
                                                    <form action="DispatchServlet?action=AddCart&index=${TAG}&pid=<%= p.getId() %>" method="post">
                                                        <button type="submit" class="btn btn-success btn-block" <%= (!p.getIsAvailable() || p.getQuantity()==0)? "disabled":"" %>>Catch It</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${not empty TAG}">
                <%
                    if(txt==null){
                %>
                    <div class="container">
                        <div class="clearfix">
                            <div class="hint-text">Showing <b>${TAG}</b> out of <b>${END}</b> entries</div>
                            <ul class="pagination">
                                <li class="page-item"><a href="DispatchServlet?action=Home&index=${TAG-1}" class="page-link" style="${TAG == 1? "pointer-events: none;" : ""}">Previous</a></li>
                                <c:forEach begin="1" end="${END}" var="i">
                                    <li class="page-item ${TAG == i? "active":""}"><a href="DispatchServlet?action=Home&index=${i}" class="page-link">${i}</a></li>
                                </c:forEach>
                                <li class="page-item"><a href="DispatchServlet?action=Home&index=${TAG+1}" class="page-link" style="${TAG == END || END == null ? "pointer-events: none;" : ""}">Next</a></li>
                            </ul>
                        </div>
                    </div>
                <%} else{%>
                    <div class="container">
                        <div class="clearfix">
                            <div class="hint-text">Showing <b>${TAG}</b> out of <b>${END}</b> entries</div>
                            <ul class="pagination">
                                <li class="page-item"><a href="DispatchServlet?action=Search&txtSearch=${TEXT_SEARCH}&index=${TAG-1}" class="page-link" style="${TAG == 1? "pointer-events: none;" : ""}">Previous</a></li>
                                <c:forEach begin="1" end="${END}" var="i">
                                    <li class="page-item ${TAG == i? "active":""}"><a href="DispatchServlet?action=Search&txtSearch=${TEXT_SEARCH}&index=${i}" class="page-link">${i}</a></li>
                                </c:forEach>
                                <li class="page-item"><a href="DispatchServlet?action=Search&txtSearch=${TEXT_SEARCH}&index=${TAG+1}" class="page-link" style="${TAG == END? "pointer-events: none;" : ""}">Next</a></li>
                            </ul>
                        </div>
                    </div>
                <%}%>
            </c:if>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>

