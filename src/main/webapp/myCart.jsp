<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Cart</title>
</head>
<body>
<%
    List<Prodotto> carrello = (List<Prodotto>) request.getSession().getAttribute("carrello");
    double prezzoTotale = 0.;
%>

<<<<<<< HEAD
<ul>
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
=======
    <ul>
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
>>>>>>> 63e3fcba39bec8913bc2a848f84930f0b10e9870

</ul>

<<<<<<< HEAD
<% prezzoTotale = Math.ceil(prezzoTotale); %>
Prezzo Totale: <%= prezzoTotale %>
=======
    <% prezzoTotale = Math.ceil(prezzoTotale); %>
    Prezzo Totale: <%= prezzoTotale %>
>>>>>>> 63e3fcba39bec8913bc2a848f84930f0b10e9870
</body>
</html>
