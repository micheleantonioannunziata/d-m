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
</head>
<body>

    <style>
        .active {background: #70F495;}
        button[disabled] { cursor: not-allowed}
    </style>
    <% Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
        List<Taglia> taglie = (List<Taglia>) application.getAttribute("taglie");%>
<%@include file="WEB-INF/modules/header.jsp"%>

<div class="poster" id="overviewSection">
    <div class="poster__img">
        <img src="<%=prodotto.getUrlImmagine()%>" alt="" class="zoom-image">
    </div>
    <div class="poster__content">
        <h3 class="normal-text"> <%= prodotto.getNome() %></h3>

        <h2 class="mid-text"> € <%= prodotto.getPrezzo()%></h2>
        <% for (Taglia taglia: taglie) {
            if (taglia.getTipologia().equalsIgnoreCase(prodotto.getTipologia())) {
        %>
        <button style="padding: 10px 15px" type="button" <% if (!prodotto.getTaglieQuantita().containsKey(taglia.getTaglia())) { %>
                disabled
                <% } else { %>
                onclick="activeButton(this, <%= prodotto.getTaglieQuantita().get(taglia.getTaglia())%>)" required
                <% } %>
        ><%= taglia.getTaglia() %></button>
        <% }
        }%>
        <form action="addToCart-servlet" method="post">
            <input type="hidden" name="idProdotto" value="<%= prodotto.getId_Prodotto() %>">
            <input id="tagliaInput" type="hidden" name="taglia" value="">
            <input id="quantitaInput" type="hidden" name="quantita">
            <button class="small-text" type="submit">Add to cart</button>
        </form>
    </div>
</div>
<script type="text/javascript" src="js/imageZoomEffect.js"></script>

<script type="text/javascript">
    function activeButton(arg, quantitaMax) {
        let buttons = document.querySelectorAll(".poster__content > button");

        buttons.forEach(button => button.classList.remove("active"));

        arg.classList.toggle("active");
        const tagliaInput = document.getElementById('tagliaInput');
        tagliaInput.value = arg.innerHTML;

        const quantitaInput = document.getElementById('quantitaInput');
        quantitaInput.type = "number";

        quantitaInput.min = 1;
        quantitaInput.max = quantitaMax
        quantitaInput.required = true
    }
</script>
</body>
</html>
