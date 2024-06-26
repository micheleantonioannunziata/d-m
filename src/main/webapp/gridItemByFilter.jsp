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
<style>
    .filters{
        padding: 20px;
        width: 80%;
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        row-gap: 20px;
        margin: 20vh auto 50px;
        background: #f6f6f6;
        border-radius: 10px;
    }
    select {
        appearance: none;
        min-width: 150px;
        padding: 12px 15px;
        border: 1px solid #d6d6d6;
        border-radius: 10px;
    }

    @media only screen and (max-width: 1030px) {
       .filters{ justify-content: space-around; }
    }
</style>
<body>
    <script type="text/javascript" src="js/manageFilters.js"></script>

    <%@ include file="WEB-INF/modules/header.jsp" %>

    <%
        // ottieni prodottiCercati
        List <Prodotto> prodottiCercati = (List<Prodotto>) request.getAttribute("prodottiCercati");

        // se è stato cercato un prodotto fai un container
        if (prodottiCercati != null && !prodottiCercati.isEmpty()) { %>
           <div class="grid-container" style="margin-top: 20vh">

            <%
            // e per ogni prodotto crea una card
            for (Prodotto p: prodottiCercati) { %>
                <div class="card scale-in-center">
                    <img src="<%=p.getUrlImmagine()%>" alt="">
                    <h4 class="small-text"><%=p.getNome()%></h4>
                    <h2 class="normal-text">€ <%=p.getPrezzo()%></h2>
                    <form action="overview-servlet" method="post">
                        <input name="idProdotto" value="<%=p.getId_Prodotto()%>" type="hidden">
                        <button>
                            <img src="img/arrow-right-circle.svg" alt="arrow">
                        </button>
                    </form>
                </div>
                    <% }
    }
       // se non è stato cercato nulla, gestisci i filtri
        else {%>

                <%
                    List<String> tipologie =  Arrays.asList("Maglia", "Pallone", "Scarpetta");

                    // ottieni lista della squadre dalla servletContext
                    List<Squadra> squadre = (List<Squadra>) application.getAttribute("squadre");

                    String lastTipologia = request.getParameter("tipologia");
                    String lastSquadra = request.getParameter("squadra");
                %>

                <div class="filters">
                    <select id="selectTipologia" name="tipologia" onchange = "manageFilters(this.value)">
                        <option value="" disabled selected>Tipologia</option>
                        <option value="All">All</option>
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
                        <option value="All">All</option>
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
                </div>


                <div class="grid-container"></div>

                <script>
                    document.addEventListener("DOMContentLoaded", function() {
                        const tipologia = "<%= lastTipologia != null ? lastTipologia : "" %>";
                        if (tipologia)  manageFilters(tipologia);
                    });
                </script>

                    <% } %>
</body>
</html>
