<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="minhnk.cart.CartDTO"%>
<%@page import="minhnk.category.CategoryDTO"%>
<%@page import="minhnk.product.ProductDTO"%>
<%@page import="minhnk.account.AccountDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart JSP</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <style>
            .container {
                width: 100%;
                margin: 0 auto;
                text-align: center;
            }
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
        <%
            List<ProductDTO> pList = (List<ProductDTO>) request.getAttribute("PRODUCT_LIST");
        %>
        <jsp:include page="Menu.jsp"></jsp:include>
            <div class="shopping-cart" style="padding-top: 60px;">
                <div class="px-4 px-lg-0">

                    <div class="pb-5">
                        <div class="container">
                            <div class="row py-5">
                                <div class="col-lg-12 p-5 bg-white rounded shadow-sm mb-5">

                                    <!-- Shopping cart table -->
                                        <div class="table-responsive">
                                            <%
                                                double totalAmount=0;
                                                int numberOfPokemon=0;
                                                List<CartDTO> itemsInCart = (List<CartDTO>) request.getAttribute("CART");
                                                if(itemsInCart==null || itemsInCart.size()==0){
                                            %>
                                            <h3>Cart is Empty!!! Let's go catch some Pokemon</h3>
                                            <%} else {%>
                                            <table class="table table-striped table-hover" border="1">
                                                <thead>
                                                    <tr>
                                                        <th scope="col" class="border-0 bg-light" colspan="2">
                                                            <div class="p-2 px-3 text-uppercase">Product</div>
                                                        </th>
                                                        <th scope="col" class="border-0 bg-light">
                                                            <div class="py-2 text-uppercase">Price</div>
                                                        </th>
                                                        <th scope="col" class="border-0 bg-light">
                                                            <div class="py-2 text-uppercase">Amount</div>
                                                        </th>
                                                        <th scope="col" class="border-0 bg-light">
                                                            <div class="py-2 text-uppercase">SubTotal</div>
                                                        </th>
                                                        <th scope="col" class="border-0 bg-light">
                                                            <div class="py-2 text-uppercase">Action</div>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for(CartDTO item : itemsInCart){
                                                            for (ProductDTO product: pList){
                                                                String id = String.valueOf(product.getId());
                                                                if(item.getItemId().equals(id)){
                                                                    totalAmount+=item.getSubTotal();
                                                                    numberOfPokemon+=item.getQuantity();
                                                    %>
                                                    <form action="DispatchServlet" method="post">
                                                        <tr>
                                                            <th scope="row" style="width:15%">
                                                                <div>
                                                                    <input type="hidden" value=<%= item.getItemId() %> name="ITEM_ID" />
                                                                    <img src=<%= product.getImage()%> class="img-fluid rounded shadow-sm">
                                                                </div>
                                                            </th>
                                                            <td><a href="DispatchServlet?action=Detail&pid=<%= product.getId()%>" title="View Product" class="text-dark d-inline-block"><%= product.getName()%></a></td>
                                                            <td class="align-middle"><strong>$<%= product.getPrice()%></strong></td>
                                                            <td class="align-middle">
                                                                <input name="QUANTITY" type="number" min="1" max=<%= product.getQuantity()%> style="width: 70px; margin-left: auto; margin-right: auto;" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" value=<%= item.getQuantity() %> />
                                                            </td>
                                                            <td>$<%= String.format("%.2f", item.getSubTotal()) %></td>
                                                            <td class="align-middle">
                                                                <div style="display: flex;">
                                                                    <button type="submit" class="btn btn-success edit" value="Update" name="action" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Update">&#xE161;</i></button>
                                                                    <button type="submit" class="btn btn-danger edit" value="Remove" name="action" data-toggle="modal" style="margin-left: 3px;"><i class="material-icons" data-toggle="tooltip" title="Remove">&#xe928;</i></button>
                                                                </div>
                                                            </td>
                                                        </tr> 
                                                    </form>
                                                    <%}}}%>
                                                </tbody>
                                            </table>
                                            <h3>Number of Pokemon in cart: <%= numberOfPokemon %></h3>
                                            <%}%>
                                        </div>
                                <!-- End -->
                                </div>
                            </div>

                            <div class="row py-5 p-4 bg-white rounded shadow-sm">
                                <div class="col-lg-6">
                                    <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Coupon</div>
                                    <div class="p-4">
                                        <div class="input-group mb-4 border rounded-pill p-2">
                                            <ul class="list-unstyled mb-4">
                                                <li style="margin-bottom: 10px;">Enter your coupon code if you have one.</li>
                                                <li style="margin-bottom: 10px;"><input type="text" placeholder="Coupon Code" aria-describedby="button-addon3" class="form-control border-0"></li>
                                                <li style="margin-bottom: 10px;">  
                                                    <div class="input-group-append border-0">
                                                        <button id="button-addon3" type="button" class="btn btn-dark px-4 rounded-pill"><i class="fa fa-gift mr-2"></i>Apply Coupon</button>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">CART TOTALS</div>
                                    <div class="p-4">
                                        <ul class="list-unstyled mb-4">
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Subtotal</strong><strong>$<%= String.format("%.2f", totalAmount) %></strong></li>
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Shipping</strong><strong>Free ship</strong></li>
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Coupon</strong><strong>$0</strong></li>
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Total Money</strong>
                                                <h5 class="font-weight-bold">$<%= String.format("%.2f", totalAmount) %></h5>
                                            </li>
                                        </ul>
                                        <form action="DispatchServlet" method="post">
                                            <%
                                                for(CartDTO item : itemsInCart){
                                            %>
                                                <input type="hidden" name="ITEM[]" value=<%= item.getItemId() %> />
                                                <input type="hidden" name="AMOUNT[]" value=<%= item.getQuantity()%> />
                                            <%}%>
                                            <button type="submit" class="btn btn-dark rounded-pill py-2 btn-block edit" value="Checkout" name="action" data-toggle="modal">Proceed To Checkout</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
