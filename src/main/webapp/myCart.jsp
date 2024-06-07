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

    <ul>
        <% if (carrello != null) {
            for (Prodotto prodotto: carrello) {
                Map<String, Integer> tagliaQuantita = prodotto.getTaglieQuantita();
                Map.Entry<String, Integer> firstEntry = tagliaQuantita.entrySet().iterator().next();
                int quantita = firstEntry.getValue();
                String taglia = firstEntry.getKey();

                prezzoTotale += prodotto.getPrezzo() * quantita; %>
                <li> <%= prodotto.getNome() %>, <%= prodotto.getPrezzo() %>,
                    <%= taglia %>, <%= quantita %>
                      </li>
            <% }
        } %>

    </ul>

    <% prezzoTotale = Math.ceil(prezzoTotale); %>
    Prezzo Totale: <%= prezzoTotale %>
</body>
</html>
