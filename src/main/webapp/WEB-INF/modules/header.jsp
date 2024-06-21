<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
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
        <form action="searchBar-servlet" class="searchBar mr-20">
            <% String lastQuery = (String) request.getParameter("queryString"); %>
            <input type="text" name="queryString" placeholder="Search ..." autocomplete="off"
                    value="<%=lastQuery != null ? lastQuery : ""%>">
            <button type="submit"><img src="img/search.svg" alt=""></button>
        </form>

        <%
            String ref;
            if(session.getAttribute("utente") == null)
                ref = "login.jsp";
            else ref = "redirectToUserArea";
        %>

        <a href="<%= ref %>"><img src="img/user.svg" alt="" class="mr-20"></a>
        <a href="myCart.jsp" style="position: relative">
            <img src="img/shopping-cart.svg" alt="">
            <% List<Prodotto> cart = (List<Prodotto>) request.getSession().getAttribute("carrello");
                if (cart != null && !cart.isEmpty()) {
                    int count = 0;

                    // conta numero di prodotti
                    for (Prodotto p: cart)
                            count += p.getTaglieQuantita().size();
            %>
                    <span><%=count%></span>
            <% } %>
        </a>
    </div>

    <div class="hamburger">
        <span></span><span></span><span></span>
    </div>
</div>