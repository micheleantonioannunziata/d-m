<script src="js/hamburger.js"></script>
<div class="header">
    <div class="logo mid-text">
        <a href="index.jsp">D<span class="normal-text">&</span>M</a>
    </div>

    <ul class="menuBar small-text">
        <li><a href="">About</a></li>
        <li><a href="fanZone.jsp">Fan Zone</a></li>
        <li><a href="">Collections</a></li>
    </ul>

    <div class="icons">
        <form action="" class="searchBar mr-20">
            <input type="text" name="searchBar" placeholder="Search ...">
            <a href=""><img src="img/search.svg" alt=""></a>
        </form>

        <%
            String ref;
            if(session.getAttribute("utente") == null)
                ref = "login.jsp";
            else ref = "userArea.jsp";
        %>

        <a href="<%= ref %>"><img src="img/user.svg" alt="" class="mr-20"></a>
        <a href="myCart.jsp"><img src="img/shopping-cart.svg" alt=""></a>
    </div>

    <div class="hamburger">
        <span></span><span></span><span></span>
    </div>
</div>