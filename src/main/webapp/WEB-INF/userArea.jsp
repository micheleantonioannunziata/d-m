<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Area</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/userArea.css">
    <link rel="stylesheet" href="css/header.css">
</head>
<body>

<%@include file="modules/header.jsp" %>

<%
    Map<Integer, List<Prodotto>> ordiniProdottiMap = (Map<Integer, List<Prodotto>>) request.getAttribute("ordiniProdottiMap");
    double prezzoTotale;
%>

<% String choose = (String) request.getAttribute("loadCart");
    if (choose != null && choose.equalsIgnoreCase("choose")) { %>
    <!-- popup overlay -->
    <div id="popup-overlay"></div>

    <!-- popup -->
    <div id="popup">
        <p>Quale carrello desideri caricare?</p>

        <!-- forms per caricare il carrello scelto -->
        <form action="cartHandler-servlet" method="post">
            <input type="hidden" name="loadOld" value="true">
            <button class="popup-button" type="submit">Carrello vecchio</button>
        </form>
        <form action="cartHandler-servlet" method="post">
            <input type="hidden" name="loadOld" value="false">
            <button class="popup-button" type="submit">Carrello attuale</button>
        </form>
    </div>

<% } %>

<%
    Utente u = (Utente) session.getAttribute("utente");

    if (u == null)  response.sendRedirect("login.jsp");
%>

<h3 class="big-text stroke">My Account</h3>

<!-- visualizza info dell'utente -->
<div class="user-info">
    <div>
        <p class="small-text"><span>Username:</span> ${utente.username}</p>
        <p class="small-text"><span>Email:</span> ${utente.email}</p>
    </div>
    <div class="buttons">

        <% if(u != null && u.isAdmin()) { %>
            <form action = "admin-servlet" method="post" style="padding: 0 20px">
                <button type="submit">Admin Area</button>
            </form>
        <% } %>

        <form action = "logOut-servlet" method="post">
            <button type="submit">
                <img src="img/log-out.svg">
            </button>
        </form>

    </div>
</div>

<%
    // carica gli ordini se ci sono
    if (ordiniProdottiMap != null && !ordiniProdottiMap.isEmpty()) {
%>
    <h3 class="mid-text" style="margin-top: 20px">Order History</h3>
    <% // per ogni ordine
        for (Map.Entry<Integer, List<Prodotto>> entry: ordiniProdottiMap.entrySet()) {

            // ristabilisci prezzo
            prezzoTotale = 0.;

            // prendi prodotti
            List<Prodotto> prodotti = entry.getValue();%>

        <h3 class="normal-text">Order n. <%=entry.getKey()%></h3>
    <div class="grid-container">
        <%
            // per ogni prodotto nell'ordine
            for (Prodotto p: prodotti) {
        %>

        <!-- crea card -->
        <div class="card scale-in-center">
            <img src="<%=p.getUrlImmagine()%>" alt="">
            <h4 class="small-text"><%=p.getNome()%></h4>
            <%
                // aggiungi info taglia quantità
                for (Map.Entry<String, Integer> tQ: p.getTaglieQuantita().entrySet()) {
                    prezzoTotale += p.getPrezzo() * tQ.getValue(); // ricalcola prezzo %>
                <div class="sizes small-text">
                    <div>
                        <p><span>Size</span>: <%=tQ.getKey()%></p>
                    </div>
                    <div>
                        <p><span>Amount</span>: <%=tQ.getValue()%></p>
                    </div>
                </div>

            <% } %>

        </div>
        <% } %>
    </div>
    <h3 class="small-text">Total: € <%=Math.ceil(prezzoTotale)%></h3>
<% }
}%>


</body>
</html>
