<%@page import="java.util.List"%>
<%@page import="minhnk.category.CategoryDTO"%>
<%@page import="minhnk.product.ProductDTO"%>
<%@page import="minhnk.account.AccountDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detail</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link href="css/detail.css" rel="stylesheet" type="text/css"/>
        <style>
            .gallery-wrap .img-big-wrap img {
                height: 450px;
                width: auto;
                display: inline-block;
                cursor: zoom-in;
            }

            .gallery-wrap .img-small-wrap .item-gallery {
                width: 60px;
                height: 60px;
                border: 1px solid #ddd;
                margin: 7px 2px;
                display: inline-block;
                overflow: hidden;
            }

            .gallery-wrap .img-small-wrap {
                text-align: center;
            }
            .gallery-wrap .img-small-wrap img {
                max-width: 100%;
                max-height: 100%;
                object-fit: cover;
                border-radius: 4px;
                cursor: zoom-in;
            }
            .img-big-wrap img{
                width: 100% !important;
                height: auto !important;
            }
        </style>
    </head>
    <body style="background-color: #FFC107;">
        <jsp:include page="Menu.jsp"></jsp:include>
        <%
            List<CategoryDTO> cList = (List<CategoryDTO>) request.getAttribute("CATEGORY_LIST");
            ProductDTO p = (ProductDTO) request.getAttribute("PRODUCT_DETAIL");
            ProductDTO last = (ProductDTO) request.getAttribute("LAST_PRODUCT");
        %>
            <div class="container py-5">
                <div class="row" style="padding-top: 50px;">
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
                                <img class="img-fluid" src=<%= last.getImage()%> />
                                <h5 class="card-title show_txt"><a href="DispatchServlet?action=Detail&pid=<%= last.getId()%>" title="View Product"><%= last.getName()%></a></h5>
                                <p class="card-text">Available: <%= last.getQuantity()%></p>
                                <p class="bloc_left_price">$<%= last.getPrice()%></p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-sm-9">
                        <div class="container">
                            <div class="card" style="border-radius: 30px; overflow: hidden;">
                                <div class="row">
                                    <aside class="col-sm-5 border-right d-flex align-items-center">
                                        <article class="gallery-wrap"> 
                                            <div class="img-big-wrap">
                                                <div> <a href="#"><img src=<%= p.getImage()%>></a></div>
                                            </div> <!-- slider-product.// -->
                                            <div class="img-small-wrap">
                                            </div> <!-- slider-nav.// -->
                                        </article> <!-- gallery-wrap .end// -->
                                    </aside>
                                    <aside class="col-sm-7">
                                        <article class="card-body p-5">
                                            <h3 class="title mb-3"><%= p.getName()%></h3>

                                            <p class="price-detail-wrap"> 
                                                <span class="price h3 text-warning"> 
                                                    <span class="currency">US $</span><span class="num"><%= p.getPrice()%></span>
                                                </span> 
                                            </p> <!-- price-detail-wrap .// -->
                                            <dl class="item-property">
                                                <dt>Description</dt>
                                                <dd><p>
                                                    <%= p.getDescription()%>
                                                </p></dd>
                                            </dl>

                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-5">
                                                    <dl class="param param-inline">
                                                        <dt>Quantity: <%= p.getQuantity()%> </dt>
                                                    </dl>  <!-- item-property .// -->
                                                </div> <!-- col.// -->

                                            </div> <!-- row.// -->
                                            <hr>
                                            <a href="DispatchServlet?action=AddCart&pid=<%= p.getId() %>&url=Detail" class="btn btn-lg btn-outline-primary text-uppercase"> Add to cart </a>
                                        </article> <!-- card-body.// -->
                                    </aside> <!-- col.// -->
                                </div> <!-- row.// -->
                            </div> <!-- card.// -->
                        </div>
                    </div>
                </div>
            </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
