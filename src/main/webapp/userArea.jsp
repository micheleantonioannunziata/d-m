<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.ProdottoDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Area</title>
</head>
<body>
    <%
        List<Ordine> ordiniUtente = (List<Ordine>) request.getSession().getAttribute("ordiniUtente");
        ProdottoDAO prodottoDAO = new ProdottoDAO();
    %>

    ${utente.username}, ${utente.email}

    Order History: <br>

    <% for (Ordine ordine: ordiniUtente) {
        Prodotto p = prodottoDAO.doRetrieveById(ordine.getIdProdotto());%>

        <li> <%= p.getNome() %>, <%= ordine.getQuantita() %></li>

    <% } %>
</body>
</html>
