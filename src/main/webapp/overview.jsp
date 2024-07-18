<%@ page import="model.Prodotto" %>
<%@ page import="model.Taglia" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item Overview</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/overview.css">
</head>
<body>
 <%
        // ottieni prodotto
        Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
        List<Taglia> taglie = (List<Taglia>) application.getAttribute("taglie");
 %>

    <%@include file="WEB-INF/modules/header.jsp"%>


    <!-- crea poster per il prodotto indicato -->
    <div class="poster" id="overviewSection">
        <div class="poster__img">
            <img src="<%=prodotto.getUrlImmagine()%>" alt="<%= prodotto.getNome() %>" class="zoom-image">
        </div>

        <div class="poster__content">
            <div class="firstLine">
                <h3 class="normal-text"> <%= prodotto.getNome() %></h3>
                <h2 class="mid-text"> € <%= prodotto.getPrezzo()%></h2>
            </div>

            <div class="buttons">
                <% // per ogni taglia
                    for (Taglia taglia: taglie) {
                        // verifica compatibilità tra tipologia della taglia e del prodotto
                    if (taglia.getTipologia().equalsIgnoreCase(prodotto.getTipologia())) {
                %>

                <button style="padding: 10px 15px" type="button" <%
                    // disabilita button se la taglia non appartiene al map del prodotto (no disponibilità)
                    if (!prodotto.getTaglieQuantita().containsKey(taglia.getTaglia())) { %>
                        disabled
                        <% }
                    // se appartiene funzione js per attivazione al click
                    else {
                        int quantitaMax = prodotto.getTaglieQuantita().get(taglia.getTaglia());

                        if (quantitaMax > 0) {  // se quantità non viene azzerata %>
                            onclick="activeButton(this, <%= quantitaMax %>)" required
                        <% } else { %>
                            disabled
                        <% }
                    } %>
                ><%= taglia.getTaglia() %></button> <!-- taglia nel button -->
                <% }
                }%>
            </div>
            <form action="addToCart-servlet" method="post">
                <input type="hidden" name="idProdotto" value="<%= prodotto.getId_Prodotto() %>">
                <input id="tagliaInput" type="hidden" name="taglia" value=""> <!-- clicco sulla taglia e cambia il valore -->
                <input id="quantitaInput" type="hidden" name="quantita">
                <button class="btnCheck normal-text" type="submit" disabled>Add to cart</button> <!-- abilitato da js -->
            </form>
        </div>

    </div>

    <script type="text/javascript" src="js/imageZoomEffect.js"></script>

    <script type="text/javascript">

        // button : button cliccato
        function activeButton(button, quantitaMax) {

            // considera tutti i button delle taglie
            let buttons = document.querySelectorAll(".poster__content .buttons > button");

            // condiera submit del form
            let submit = document.querySelector("form button[type=submit]");

            // rimuovi la classe active da tutte i bottoni (1 bottone deve essere attivo)
            buttons.forEach(btn => btn.classList.remove("active"));

            if (quantitaMax > 0) {
                // toggle per il button cliccato
                button.classList.toggle("active");

                // prendi tagliaInput e modifica value
                const tagliaInput = document.getElementById('tagliaInput');
                tagliaInput.value = button.innerHTML; //scrivi la taglia in tagliaInput

                // aggiorn quantitaInput
                const quantitaInput = document.getElementById('quantitaInput');
                quantitaInput.type = "number";
                quantitaInput.min = 1;
                quantitaInput.max = quantitaMax;
                quantitaInput.required = true;
                quantitaInput.value = quantitaInput.min; //inizialmente mette quantità pari a 1

                // abilita submit
                submit.disabled = false;
            }
            else { button.disabled = true }
        }

    </script>
    <%@include file="WEB-INF/modules/footer.jsp" %>
</body>
</html>
