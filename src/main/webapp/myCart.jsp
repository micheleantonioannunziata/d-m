<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/myCart.css">
</head>
<body>
<%
    // ottieni carrello dalla sessione
    List<Prodotto> carrello = (List<Prodotto>) request.getSession().getAttribute("carrello");
    double prezzoTotale = 0.;
%>

<%@ include file="WEB-INF/modules/header.jsp" %>

    <h3 class="big-text stroke">My Cart</h3>
    <%
        // se c'è qualcosa nel carrello
        if (carrello != null && !carrello.isEmpty()) { %>
        <div class="box">

            <div class="grid-container">

                <% // per ogni prodotto del carrello crea una card
                    for (Prodotto prodotto: carrello) { %>
                <div class="card scale-in-center">
                    <div class="img">
                        <img src="<%=prodotto.getUrlImmagine()%>" alt="">
                    </div>
                    <div class="content">
                        <h4 class="small-text"><%=prodotto.getNome()%></h4>

                        <%  // per ogni map del prodotto
                            for (Map.Entry<String, Integer> entry: prodotto.getTaglieQuantita().entrySet()) {

                                // ricalcola il prezzo totale del carrello
                                prezzoTotale += prodotto.getPrezzo() * entry.getValue(); %>
                            <!-- riga con info di taglia, quantità -->
                            <div class="sizes">
                                <p><span>Size</span>: <%=entry.getKey()%>, <span>Amount</span>: <%=entry.getValue()%></p>

                                <!-- form per eliminazione dal carrello -->
                                <form action="removeByCart-servlet" method="post">
                                    <input name="idProdotto" value="<%=prodotto.getId_Prodotto()%>" type="hidden">
                                    <input name="taglia" value="<%=entry.getKey()%>" type="hidden">
                                    <button type="submit">
                                        <img src="img/trash.svg" alt="arrow">
                                    </button>
                                </form>
                            </div>
                        <% } %>

                        <h2 class="normal-text">€ <%=prodotto.getPrezzo()%></h2>
                    </div>
                </div>
                <% } %>
            </div>

                <div class="checkOut">
                    <% prezzoTotale = Math.ceil(prezzoTotale); %>
                    <span class="small-text">Prezzo Totale:</span><span class="mid-text">€ <%= prezzoTotale %></span>
                    <form action="checkOut-servlet" method="post">
                        <button class="btnCheck normal-text">Check Out</button>
                    </form>
                </div>

            <% } %>
        </div>
</body>
</html>
