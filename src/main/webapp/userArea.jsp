<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.ProdottoDAO" %>
<%@ page import="model.Utente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Area</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
    List<Ordine> ordiniUtente = (List<Ordine>) request.getSession().getAttribute("ordiniUtente");
    ProdottoDAO prodottoDAO = new ProdottoDAO();
%>

<style>
    /* stile per popup */
    #popup {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 300px;
        padding: 40px;
        background-color: white;
        border: 1px solid #ccc;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        z-index: 10000;
        border-radius: 10px;
    }
    #popup-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        z-index: 1001;
    }

    #popup > form {
        margin: 10px 0;
    }

    .popup-button {
        padding: 10px 20px;
        background-color: #70F495;
        color: black;
        font-weight: 600;
        border: none;
        cursor: pointer;
        width: 100%;
    }
</style>

<!-- popup overlay -->
<div id="popup-overlay"></div>

<div id="popup">
    <p>Quale carrello desideri caricare?</p>

    <!-- forms per caricare il carrello scelto -->
    <form action="cartHandler-servlet" method="post">
        <input type="hidden" name="loadOld" value="true">
        <button class="popup-button" type="submit">Carrello vecchio</button>
    </form>
    <form action="cartHandler-servlet" method="post">
        <input type="hidden" name="loadOld" value="false">
        <button class="popup-button" type="submit">Carrello attuale</button>
    </form>
</div>

<%@include file="WEB-INF/modules/header.jsp" %>

<%
    Utente u = (Utente) session.getAttribute("utente");
    if (u.isAdmin()) {
%>
<form action = "admin-servlet" method="post" style="margin-top: 15vh">
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
        Prodotto p = prodottoDAO.doRetrieveById(ordine.getProdotto());%>

<li> <%= p.getNome() %>, <%= ordine.getQuantita() %></li>

<% }
}%>

<form action = "logOut-servlet" method="post">
    <input type="submit" value="Log out">
</form>


<script>
    // mostra
    function showPopup() {
        document.getElementById('popup-overlay').style.display = 'block';
        document.getElementById('popup').style.display = 'block';
    }

    // nascondi
    function hidePopup() {
        document.getElementById('popup-overlay').style.display = 'none';
        document.getElementById('popup').style.display = 'none';
    }

    // prendi attributo dalla richiesta ed eventualmente mostra
    <% String choose = (String) request.getAttribute("loadCart");
    if (choose != null && choose.equalsIgnoreCase("choose")) { %>
        showPopup();
    <% } else { %>
        hidePopup(); // superfluo ma lo faccio comunque
    <% } %>
</script>

</body>
</html>
