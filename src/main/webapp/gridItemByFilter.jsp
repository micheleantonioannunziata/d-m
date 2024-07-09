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
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/gridItemByFilter.css">
    <script type="text/javascript" src="js/manageFilters.js"></script>
</head>

<body>
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
                    <form action="overview-servlet" method="get">
                        <input name="idProdotto" value="<%=p.getId_Prodotto()%>" type="hidden">
                        <button>
                            <img src="img/arrow-right-circle.svg" alt="arrow">
                        </button>
                    </form>
                </div>
                    <% } %>
            </div>
        <% }
       // se non è stato cercato nulla, gestisci i filtri
        else {%>

                <%
                    List<String> tipologie =  Arrays.asList("All", "Maglia", "Pallone", "Scarpa");

                    // ottieni lista della squadre dalla servletContext
                    List<Squadra> squadre = (List<Squadra>) application.getAttribute("squadre");

                    String lastTipologia = request.getParameter("tipologia");
                    String lastSquadra = request.getParameter("squadra");
                    String lastCollezione = request.getParameter("collezione");
                    String lastProduttore = request.getParameter("produttore");
                    String lastTaglia = request.getParameter("taglia");

                    double start = 50. , stop = 200., step = 50.;
                %>

                <div class="filters">
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
                        <option value="All" <% if (lastSquadra != null && lastSquadra.equalsIgnoreCase("all")) { %>
                                selected
                                <% } %>
                        >All</option>
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

                    <select id="selectPrezzo" name="prezzo" class="hidden" onchange="updateCards()">
                        <option value="" disabled selected>Range Price</option>
                        <option value="All">All</option>
                        <% for (double prezzo = start; prezzo < stop; prezzo += step) {%>
                            <option value="<%=(int) prezzo%> - <%=(int) (prezzo + step)%>"
                                ><%=(int) prezzo%> - <%=(int) (prezzo + step)%></option>
                        <% } %>

                        <option value="<%=(int) stop%> + "><%=(int) stop%> + </option>
                    </select>
                </div>


                <div class="grid-container"></div>

                <script>
                    document.addEventListener("DOMContentLoaded", function() {
                        const tipologia = "<%= lastTipologia != null ? lastTipologia : "" %>";
                        if (tipologia)  manageFilters(tipologia, '<%= lastTaglia %>', '<%=lastCollezione%>', '<%=lastProduttore%>');
                    });
                </script>

                    <% } %>
                <%@include file="WEB-INF/modules/footer.jsp" %>
</body>
</html>
