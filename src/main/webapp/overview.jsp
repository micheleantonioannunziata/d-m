<%@ page import="model.Prodotto" %>
<%@ page import="model.Taglia" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: ciril
  Date: 24/05/2024
  Time: 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <% Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
        List<Taglia> taglie = (List<Taglia>) application.getAttribute("taglie");%>

    <%@include file="WEB-INF/modules/header.jsp"%>
    <div class="poster">
        <div class="poster__img">
            <img src="<%=prodotto.getUrlImmagine()%>">
        </div>
        <div class="poster__content">
            <h3 class="normal-text"> <%= prodotto.getNome() %></h3>
            <h3 class="normal-text"> <%= prodotto.getPrezzo()%></h3>
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
            <button> Add to card </button>
        </div>
    </div>
</body>
</html>
