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
            <ul>
            <% for (Taglia taglia: taglie) {
                if (taglia.getTipologia().equalsIgnoreCase(prodotto.getTipologia())) {
                    %>
                    <li>
                        <%= taglia.getTaglia() %>
                        <% if (prodotto.getTaglieQuantita().containsKey(taglia.getTaglia())) {%>
                            disponibile, quantità: <%= prodotto.getTaglieQuantita().get(taglia.getTaglia())%>
                        <% }%>
                    </li>
                <% }
            }%>
            </ul>
            <button class="small-text">Add to card</button>
        </div>
    </div>
<script type="text/javascript" src="js/imageZoomEffect.js">
</script>
</body>
</html>
