<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
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
                prezzoTotale += prodotto.getPrezzo(); %>
                <li> <%= prodotto.getNome() %>, <%= prodotto.getPrezzo() %> </li>
            <% }
        } %>

    </ul>

    Prezzo Totale: <%= prezzoTotale %>
</body>
</html>
