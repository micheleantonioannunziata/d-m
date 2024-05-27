<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="model.Squadra" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GridByFilter</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <script type="text/javascript" src="js/manageFilters.js"></script>
    <%
        List<String> tipologie =  Arrays.asList("Maglia", "Pallone", "Scarpetta");

        // ottieni lista della squadre dalla servletContext
        List<Squadra> squadre = (List<Squadra>) application.getAttribute("squadre");

        String lastTipologia = request.getParameter("tipologia");
        String lastSquadra = request.getParameter("squadra");
    %>

    <%@ include file="WEB-INF/modules/header.jsp" %>

    <form action="filter-servlet" method="post" class="filters">

        <select id="selectTipologia" name="tipologia" onchange = "manageFilters(this.value)">
            <option value="" disabled selected>Tipologia</option>
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

        <select id="selectSquadra" name="squadra" class="hidden" onchange="updateCards()">
            <option value="" disabled selected>Squadra</option>
             <% for (Squadra squadra : squadre) { %>
                <option value="<%= squadra.getNome() %>"
                        <% if (squadra.getNome().equalsIgnoreCase(lastSquadra)) { %>
                        selected
                        <% } %>
                >
                    <%= squadra.getNome() %>
                </option>

            <% } %>
        </select>

        <select id="selectTaglia" name="taglia" class="hidden" onchange="updateCards()">
            <option value="" disabled selected>Taglia</option>
        </select>

        <select id="selectCollezione" name="collezione" class="hidden" onchange="updateCards()">
            <option value="" disabled selected>Collezione</option>
        </select>

        <select id="selectProduttore" name="produttore" class="hidden" onchange="updateCards()">
            <option value="" disabled selected>Produttore</option>
        </select>
    </form>

    <div class="grid-container"></div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const tipologia = "<%= lastTipologia != null ? lastTipologia : "" %>";
            if (tipologia) {
                manageFilters(tipologia);
            }
        });
    </script>
</body>
</html>
