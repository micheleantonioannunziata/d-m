<%@ page import="java.util.List" %>
<%@ page import="model.Squadra" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/footer.css">
    <script type="text/javascript" src = "js/redirectFilter.js"></script>
</head>
<body>
    <%@ include file="WEB-INF/modules/header.jsp"%>

    <%
        // ottieni squadre
        List<Squadra> squadre = (List<Squadra>) application.getAttribute("squadre"); %>

    <div class="grid-container" style="margin-top: 15vh" id="fanZone">
        <%
            // crea card per ogni squadra
            for (Squadra squadra: squadre) {
         %>
            <div class="card scale-in-center" data-value = "<%= squadra.getNome() %>" onclick = "redirectFilter(this, 'Maglia', 'squadra')">
                <img src="<%=squadra.getUrlImmagine()%>" alt="">
                <h2 class="small-text"> <%= squadra.getNome() %></h2>
                <span></span> <!-- rettangolino verde -->
            </div>
        <% }%>
    </div>
    <%@include file="WEB-INF/modules/footer.jsp" %>
</body>
</html>
