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

<<<<<<< HEAD
<li> <%= p.getNome() %>, <%= ordine.getQuantita() %></li>

<% }
}%>
<form action = "logOut-servlet" method="post">
    <input type="submit" value="Log out">
</form>
=======
                <li> <%= p.getNome() %>, <%= ordine.getQuantita() %></li>

        <% }
    }%>
    <form action = "logOut-servlet" method="post">
        <input type="submit" value="Log out">
    </form>
>>>>>>> 63e3fcba39bec8913bc2a848f84930f0b10e9870
</body>
</html>
