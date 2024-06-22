<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.Map" %>
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
    Map<Integer, List<Prodotto>> ordiniProdottiMap = (Map<Integer, List<Prodotto>>) request.getAttribute("ordiniProdottiMap");
    double prezzoTotale;
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

    h3{text-transform: uppercase; padding-left: 3%; margin: 20px 0}
    h3.stroke{margin: 0; margin-top: 20vh;}
    h3.normal-text{font-style: italic}
    h3.small-text{text-transform: none;}

    .user-info{
        width: 100%;
        padding: 20px 3%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .user-info div p span{color: #8C8C8C}

    .user-info .buttons{display: flex;align-items: center;}

    .user-info .buttons form button {
        border: none;
        background: var(--color-primary);
        border-radius: 7px;
        padding: 8px 20px;
        font-weight: bold;
    }

    .user-info .buttons form button img{
        height: 15px;
    }

    .grid-container p span{font-weight: bold}

    .grid-container .sizes{
        display: flex;
        justify-content: space-between;
        margin: 8px 0;
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
%>

<h3 class="big-text stroke">My Account</h3>

<div class="user-info">
    <div>
        <p class="small-text"><span>Username:</span> <%=u.getUsername()%></p>
        <p class="small-text"><span>Email:</span> <%=u.getEmail()%></p>
    </div>
    <div class="buttons">
        <% if(u.isAdmin()) { %>
            <form action = "admin-servlet" method="post" style="padding: 0 20px">
                <button type="submit">Admin Area</button>
            </form>
        <% } %>
        <form action = "logOut-servlet" method="post">
            <button type="submit">
                <img src="img/log-out.svg">
            </button>
        </form>
    </div>
</div>

<%
    if (!ordiniProdottiMap.isEmpty()) {
%>
    <h3 class="mid-text" style="margin-top: 20px">Order History</h3>
    <% // per ogni ordine
        for (Map.Entry<Integer, List<Prodotto>> entry: ordiniProdottiMap.entrySet()) {
        prezzoTotale = 0.;

        // prendi prodotti
        List<Prodotto> prodotti = entry.getValue();%>

        <h3 class="normal-text">Order n. <%=entry.getKey()%></h3>
    <div class="grid-container">
        <% for (Prodotto p: prodotti) { %>
        <div class="card scale-in-center">
            <img src="<%=p.getUrlImmagine()%>" alt="">
            <h4 class="small-text"><%=p.getNome()%></h4>
            <% for (Map.Entry<String, Integer> tQ: p.getTaglieQuantita().entrySet()) {
                prezzoTotale += p.getPrezzo() * tQ.getValue(); %>
                <div class="sizes small-text">
                    <div>
                        <p><span>Size</span>: <%=tQ.getKey()%></p>
                    </div>
                    <div>
                        <p><span>Amount</span>: <%=tQ.getValue()%></p>
                    </div>
                </div>

            <% } %>

        </div>
        <% } %>
    </div>
    <h3 class="small-text">Total: € <%=Math.ceil(prezzoTotale)%></h3>
<% }
}%>


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
