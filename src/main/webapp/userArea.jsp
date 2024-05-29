<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.ProdottoDAO" %>
<%@ page import="model.Utente" %>
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


    <%
        Utente u = (Utente) session.getAttribute("utente");
        if (u.isAdmin()) {
    %>
        <form action = "admin-servlet" method="post">
            <input type="submit" value="Admin Area">
        </form>
        utente amministratore
    <% } %>

    <%=u.getEmail() %>
    <%=u.getUsername()%>



    <%
        if (ordiniUtente != null) {
    %>
            Order History: <br>
    <%
            for (Ordine ordine: ordiniUtente) {
                Prodotto p = prodottoDAO.doRetrieveById(ordine.getIdProdotto());%>

                <li> <%= p.getNome() %>, <%= ordine.getQuantita() %></li>

        <% }
    }%>

</body>
</html>
