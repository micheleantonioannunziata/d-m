<%@ page import="model.Taglia" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>GridByFilter</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%
        List<String> tipologie =  Arrays.asList("Maglia", "Pallone", "Scarpetta");

        // ottieni lista di tutti i prodotti dalla servletContext
        List<Prodotto> prodotti = (List<Prodotto>) application.getAttribute("prodotti");

        // ottieni lista delle taglie dalla servletContext
        List<Taglia> taglie = (List<Taglia>) application.getAttribute("taglie");

        List<String> squadre = new ArrayList<>();
        List<String> collezioni = new ArrayList<>();
        List<String> produttori = new ArrayList<>();

        // ottieni squadre, produttori, collezioni
        for (Prodotto prodotto: prodotti) {
            if (prodotto.getSquadra() != null && !squadre.contains(prodotto.getSquadra()))
                squadre.add(prodotto.getSquadra());

            if (prodotto.getProduttore() != null && !produttori.contains(prodotto.getProduttore()))
                produttori.add(prodotto.getProduttore());

            if (prodotto.getCollezione() != null && !collezioni.contains(prodotto.getCollezione()))
                collezioni.add(prodotto.getCollezione());
        }

        String lastTaglia = request.getParameter("taglia");
        String lastTipologia = request.getParameter("tipologia");
        String lastSquadra = request.getParameter("squadra");
        String lastCollezione = request.getParameter("collezione");
        String lastProduttore = request.getParameter("produttore");

        List<Prodotto> prodottiFiltrati = (List<Prodotto>) request.getAttribute("prodottiFiltrati");

        if (prodottiFiltrati == null)
            prodottiFiltrati = prodotti;
    %>

    <%@ include file="WEB-INF/modules/header.jsp" %>

    <form action="filter-servlet" method="post" class="filters">

        <select name="tipologia">
            <% for (String tipologia : tipologie) { %>
            <option value="<%= tipologia %>"
                    <% if (tipologia.equalsIgnoreCase(lastTipologia)) { %>
                    selected
                    <% } %>
            >
                <%= tipologia %>
            </option>
            <% } %>
        </select>

        <select name="squadra">
            <% for (String squadra : squadre) { %>
            <option value="<%= squadra %>"
                    <% if (squadra.equalsIgnoreCase(lastSquadra)) { %>
                    selected
                    <% } %>
            >
                <%= squadra %>
            </option>
            <% } %>
        </select>

        <select name="taglia">
            <% for (Taglia taglia : taglie) { %>
            <option value="<%= taglia.getTaglia() %>"
                    <% if (taglia.getTaglia().equalsIgnoreCase(lastTaglia)) { %>
                        selected
                    <% } %>
            >
                <%= taglia.getTaglia() %>
            </option>
            <% } %>
        </select>

        <select name="collezione">
            <% for (String collezione : collezioni) { %>
            <option value="<%= collezione %>"
                    <% if (collezione.equalsIgnoreCase(lastCollezione)) { %>
                    selected
                    <% } %>
            >
                <%= collezione %>
            </option>
            <% } %>
        </select>

        <select name="produttore">
            <% for (String produttore : produttori) { %>
            <option value="<%= produttore %>"
                    <% if (produttore.equalsIgnoreCase(lastProduttore)) { %>
                    selected
                    <% } %>
            >
                <%= produttore %>
            </option>
            <% } %>
        </select>


        <input type="submit" value="Go">
    </form>

    <div class="grid-container">
        <% if (prodottiFiltrati.isEmpty()) { %>
            vuoto
        <% } else { %>
            <% for (Prodotto prodotto: prodottiFiltrati) { %>
            <div class="card">
                <img src="img/prod/<%= prodotto.getId() %>.png" alt="">
                <h4 class="small-text"><%= prodotto.getNome() %></h4>
                <h2 class="normal-text">€ <%= prodotto.getPrezzo() %></h2>
                <button><img src="img/arrow-right-circle.svg"></button>
            </div>
            <% } %>
        <% } %>
    </div>
</body>
</html>
