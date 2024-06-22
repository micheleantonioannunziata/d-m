<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<script src="js/hamburger.js"></script>
<script src="js/manageFilters.js"></script>
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
        <%
            // Ottieni la query string dalla richiesta
            String lastQuery = (String) request.getParameter("queryString");

            // Controlla l'URI della richiesta per determinare il flag
            boolean flag = request.getRequestURI().contains("gridItemByFilter") || request.getRequestURI().contains("searchBar-servlet");

           if(!flag){ %>
                <form action="searchBar-servlet" class="searchBar">
                    <input type="hidden" name="redirect" value="true">

                    <input type="text" name="queryString" placeholder="Search ..." autocomplete="off"
                           value="<%=lastQuery != null ? lastQuery : ""%>" >

                    <button><img src="img/search.svg" alt=""></button>

                </form>
        <% }
            else { %>
            <div class="searchBar">
                <input type="text" name="queryString" placeholder="Search ..." autocomplete="off"
                       value="<%=lastQuery != null ? lastQuery : ""%>"
                       onkeyup = "searchCards(this.value)">

                    <button><img src="img/search.svg" alt=""></button>
            </div>
            <% } %>
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