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
    <!-- <script src="js/removeByCart.js"></script> -->
</head>
<body>
<%
    List<Prodotto> carrello = (List<Prodotto>) request.getSession().getAttribute("carrello");
    double prezzoTotale = 0.;
%>

<%@ include file="WEB-INF/modules/header.jsp" %>

    <h3 class="big-text stroke">My Cart</h3>
    <% if (carrello != null && !carrello.isEmpty()) { %>
        <div class="box">
            <div class="grid-container">
            <% for (Prodotto prodotto: carrello) { %>
                <div class="card scale-in-center">
                    <div class="img">
                        <img src="<%=prodotto.getUrlImmagine()%>" alt="">
                    </div>
                    <div class="content">
                        <h4 class="small-text"><%=prodotto.getNome()%></h4>

                        <% for (Map.Entry<String, Integer> entry: prodotto.getTaglieQuantita().entrySet()) {
                            prezzoTotale += prodotto.getPrezzo() * entry.getValue(); %>
                            <div class="sizes">
                                <p><span>Size</span>: <%=entry.getKey()%>, <span>Amount</span>: <%=entry.getValue()%></p>

                                <%--<button onclick='loadData(<%= prodotto.getId_Prodotto() %>, "<%= entry.getKey() %>")'>

                                <img src="img/trash.svg" alt="arrow">
                                    </button> --%>
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

                    <button>Check Out</button>
                </div>
            <% } %>
        </div>


</body>
</html>
