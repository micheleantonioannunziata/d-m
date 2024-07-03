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
</head>
<body>

    <style>
        #overviewSection.poster{overflow: hidden; height: auto }
        #overviewSection.poster .poster__content{
            position: relative;
            padding: 0 3%;
            height: 50%;
        }

        #overviewSection.poster .poster__content .firstLine{
            display: flex;
            width: 100%;
            justify-content: space-between;
            align-items: center;
        }

        #overviewSection.poster .poster__content .firstLine h3{
            width: 60%;
        }

        #overviewSection.poster .poster__img img.zoom-image {
            width: 100%;
            transition: transform 0.3s ease;
            position: relative;
        }

        #overviewSection.poster .poster__img:hover img.zoom-image {
            transform: scale(1.1);
        }

        #overviewSection.poster .poster__content .buttons{
            margin-top: 10%;
            display: flex;
            column-gap: 2%;
        }

        #overviewSection.poster .poster__content .buttons button{
            border-radius: 5px;
            border: 1px solid black;
        }

        #overviewSection.poster .poster__content form{
            margin-top: 15%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }

        #overviewSection.poster .poster__content form button{
            padding: 17px 35px;
            background: var(--color-primary);
            border: none;
            font-weight: 700;
            border-radius: 50px;
        }

        input#quantitaInput{
            border-radius: 5px;
            text-align: center;
            width: 100px;
            padding: 10px;
            border: 1px solid black;
            margin-right: 20px;
        }

        input#quantitaInput:focus-visible{ border: 1px solid black}

        @media (max-width: 950px) {
            #overviewSection.poster{flex-direction: column; column-gap: 20px; justify-content: center}
            #overviewSection.poster .poster__content {width: 100%; margin-bottom: 20px}
            #overviewSection.poster .poster__img{width: 70%}
        }

        .active {background: #70F495;}
        button[disabled] { cursor: not-allowed; border: none}

        .poster#overviewSection{ margin-top: 15vh}
        .poster#overviewSection .poster__img img{height: 100%}
    </style>
    <%
        // ottieni prodotto
        Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
        List<Taglia> taglie = (List<Taglia>) application.getAttribute("taglie");%>

    <%@include file="WEB-INF/modules/header.jsp"%>


    <!-- crea poster per il prodotto indicato -->
    <div class="poster" id="overviewSection">
        <div class="poster__img">
            <img src="<%=prodotto.getUrlImmagine()%>" alt="" class="zoom-image">
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
                    // disabilita button se la taglia non appartiene al map del prodotto
                    if (!prodotto.getTaglieQuantita().containsKey(taglia.getTaglia())) { %>
                        disabled
                        <% }
                    // se appartiene funzione js per attivazione al click
                    else {
                        int quantitaMax = prodotto.getTaglieQuantita().get(taglia.getTaglia());

                        if (quantitaMax > 0) { %>
                            onclick="activeButton(this, <%= quantitaMax %>)" required
                        <% } else { %>
                            disabled
                        <% }
                    } %>
                ><%= taglia.getTaglia() %></button>
                <% }
                }%>
            </div>
            <form action="addToCart-servlet" method="post">
                <input type="hidden" name="idProdotto" value="<%= prodotto.getId_Prodotto() %>">
                <input id="tagliaInput" type="hidden" name="taglia" value="">
                <input id="quantitaInput" type="hidden" name="quantita">
                <button class="normal-text" type="submit" disabled>Add to cart</button>
            </form>
        </div>

    </div>

    <script type="text/javascript" src="js/imageZoomEffect.js"></script>

    <script type="text/javascript">

        // arg: button cliccato
        function activeButton(arg, quantitaMax) {

            // considera tutti i button
            let buttons = document.querySelectorAll(".poster__content .buttons > button");

            // condiera submit del form
            let submit = document.querySelector("form button[type=submit]");

            // rimuovi la classe active da tutte i bottoni
            buttons.forEach(button => button.classList.remove("active"));

            if (quantitaMax > 0) {
                // toggle per il button cliccato
                arg.classList.toggle("active");

                // prendi tagliaInput e modifica value
                const tagliaInput = document.getElementById('tagliaInput');
                tagliaInput.value = arg.innerHTML;

                // aggiorn quantitaInput
                const quantitaInput = document.getElementById('quantitaInput');
                quantitaInput.type = "number";
                quantitaInput.min = 1;
                quantitaInput.max = quantitaMax;
                quantitaInput.required = true;
                quantitaInput.value = quantitaInput.min;

                // abilita submit
                submit.disabled = false;
            }
            else { arg.disabled = true }
        }

    </script>
    <%@include file="WEB-INF/modules/footer.jsp" %>
</body>
</html>
