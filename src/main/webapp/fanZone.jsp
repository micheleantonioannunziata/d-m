<%@ page import="java.util.List" %>
<%@ page import="model.Squadra" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="WEB-INF/modules/header.jsp"%>

    <% List<Squadra> squadre = (List<Squadra>) application.getAttribute("squadre"); %>

    <div class="grid-container" style="padding-top: 15vh">
        <% for (Squadra squadra: squadre) {
         %>
            <div class="card">
                <img src="<%=squadra.getUrlImmagine()%>" alt="">
                <h2 class="normal-text"> <%= squadra.getNome() %></h2>
            </div>
        <%
        }
        %>
    </div>
</body>
</html>
