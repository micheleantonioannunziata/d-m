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
</head>
<body>
<%
    List<Prodotto> carrello = (List<Prodotto>) request.getSession().getAttribute("carrello");
    double prezzoTotale = 0.;
%>

<%@ include file="WEB-INF/modules/header.jsp" %>

<ul style="margin-top: 15vh">
    <% if (carrello != null) {
        for (Prodotto prodotto: carrello) { %>
    <li>
        <%= prodotto.getNome() %>, <%= prodotto.getPrezzo() %>
        <% for (Map.Entry<String, Integer> entry : prodotto.getTaglieQuantita().entrySet()) {
            prezzoTotale += prodotto.getPrezzo() * entry.getValue(); %>
        - <%= entry.getKey() %>, <%= entry.getValue() %>
        <% } %>
    </li>
    <% }
    } %>

<% prezzoTotale = Math.ceil(prezzoTotale); %>
Prezzo Totale: <%= prezzoTotale %>
</body>
</html>
