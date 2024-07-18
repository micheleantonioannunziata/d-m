<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<script src="js/hamburger.js"></script>

<header>
    <div class="logo mid-text">
        <a href="index.jsp">D<span class="normal-text">&</span>M</a>
    </div>

    <ul class="menuBar small-text">
        <li><a href="about.jsp">About</a></li>
        <li><a href="fanZone.jsp">Fan Zone</a></li>
        <li><a href="gridItemByFilter.jsp">Products</a></li>
    </ul>

    <div class="icons">
        <%
            // ottieni la query string dalla richiesta
            String lastQuery = request.getParameter("queryString");

            // controlla uri richiesta
            boolean flag = request.getRequestURI().contains("gridItemByFilter") ||
                    request.getRequestURI().contains("searchBar-servlet");

            // se non stai nella pagina dei filtri
           if (!flag){ %>
                <form action="searchBar-servlet" class="searchBar"> <!-- form con flag redirect -->
                    <input type="hidden" name="redirect" value="true">

                    <input class="small-text" type="text" name="queryString" placeholder="Search ..." autocomplete="off"
                           value="<%=lastQuery != null ? lastQuery : ""%>" >

                    <button><img src="img/search.svg" alt="search"></button>

                </form>
        <% }
           // se stai nella pagina dei filtri
            else { %>
            <div class="searchBar">
                <!-- input con funziona ajax su evento oninput -->
                <input class="small-text" type="text" name="queryString" placeholder="Search ..." autocomplete="off"
                       value="<%=lastQuery != null ? lastQuery : ""%>"
                       oninput = "searchCards(this.value)">

                    <button><img src="img/search.svg" alt="search"></button>
            </div>
            <% } %>

        <%
            String ref;
            if (session.getAttribute("utente") == null)
                ref = "login.jsp";
            else ref = "redirectToUserArea";
        %>

        <a href="<%= ref %>">
            <img src="img/user.svg" alt="user">
        </a>
        <a href="myCart.jsp" style="position: relative">
            <img src="img/shopping-cart.svg" alt="cart">
            <% // prendi carrello dalla sessione
                List<Prodotto> cart = (List<Prodotto>) request.getSession().getAttribute("carrello");

                // se c'è qualcosa
                if (cart != null && !cart.isEmpty()) {
                    int count = 0;

                    // conta numero di prodotti
                    for (Prodotto p: cart)
                            count += p.getTaglieQuantita().size();
            %>
                    <!-- mostra dimensione carrello -->
                    <span><%=count%></span>
            <% } %>
        </a>
    </div>

    <div class="hamburger" onclick="hamburgerToggle()">
        <span></span><span></span><span></span>
    </div>
</header>