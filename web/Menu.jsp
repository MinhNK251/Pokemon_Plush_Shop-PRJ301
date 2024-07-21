<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--begin of menu-->
<nav class="navbar navbar-expand-md navbar-dark bg-dark" style="position: fixed; width: 100%;top: 0; z-index: 40;">
    <div class="container">
        <a class="navbar-brand" href="DispatchServlet?action=Home"><img src="https://www.clipartmax.com/png/full/129-1298638_pokemon-pokeball-game-go-icon-free-pokemon-go-logo-png.png" width="40" height="40">  Pokemon</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
            <ul class="navbar-nav m-auto">
                <c:if test="${sessionScope.ACCOUNT == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="Login.jsp">Login</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.ACCOUNT != null}">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Hello ${sessionScope.ACCOUNT.user}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="DispatchServlet?action=LogOut">Log Out</a>
                    </li> 
                </c:if>
                <c:if test="${sessionScope.ACCOUNT.isAdmin}">
                    <li class="nav-item">
                        <a class="nav-link" href="DispatchServlet?action=ManageAccount">Manage Account</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.ACCOUNT.isSell}">
                    <li class="nav-item">
                        <a class="nav-link" href="DispatchServlet?action=ManageProduct">Manage Product</a>
                    </li>
                </c:if>
            </ul>

            <form action="DispatchServlet?action=Search" method="post" class="form-inline my-2 my-lg-0">
                <div class="input-group input-group-sm">
                    <input oninput="searchByName(this)" value="${TEXT_SEARCH}" name="txtSearch" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search...">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-secondary btn-number">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
                <a class="btn btn-success btn-sm ml-3" href="DispatchServlet?action=ViewCart">
                    <i class="fa fa-shopping-cart"></i> Cart
                </a>
            </form>
        </div>
    </div>
</nav>
<c:if test="${requestScope.isHomePage eq true}">
    <section class="jumbotron text-center" style="padding-top: 80px;">
    <div class="container">
        <h1 class="jumbotron-heading">Pokemon Plush Center</h1>
        <p class="lead text-muted mb-0">PokemonShop is an unofficial online store for Pokémon Center merchandise (Please don't sue me Nintendo or the Pokémon Co.), focusing on unique designs and high quality products for all ages. Pokémon launched in Japan in 1996 and today is one of the most popular children’s entertainment properties in the world.</p>
        <p class="lead text-muted mb-0">Whether you are a player, collector, parent, professor, or fan, we strive to offer items featuring a wide range of Pokémon to allow you to express yourself. We’re always open. Come say hello and take a look at the wide world of Pokémon!</p>
    </div>
</section>
</c:if>
<!--end of menu-->
