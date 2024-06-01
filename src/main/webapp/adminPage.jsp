<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap');

    *{margin: 0;padding: 0;font-family: 'Montserrat', sans-serif;box-sizing: border-box;text-align: center;}

    body{
        display: flex;
        flex-direction: column;
    }

    table {
        width: 60%;
        border-collapse: collapse;
        margin: 50px auto;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    th {
        background-color: #ddd;
        color: #333;
        cursor: pointer;
    }

    tbody tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    table tr th:last-child, table tbody tr td:last-child {
        background: white;
        border: none;
    }

    button{border: none;background: none;}
    button img{cursor: pointer;}
    .scale-in-center{animation:scale-in-center .5s cubic-bezier(.25,.46,.45,.94) both}
    @keyframes scale-in-center{0%{transform:scale(0);opacity:1}100%{transform:scale(1);opacity:1}}
</style>

<%
    List<Squadra> squadre = (List<Squadra>) application.getAttribute("squadre");
    List<Taglia> taglie = (List<Taglia>) application.getAttribute("taglie");
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
    List<Utente> utenti = (List<Utente>) request.getAttribute("utenti");
    List<ProdottoTaglie> prodottiTaglie = (List<ProdottoTaglie>) request.getAttribute("prodottitaglie");
%>

<table class="scale-in-center">
    <tr>
        <th colspan="2">Squadre</th>
        <th>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="squadre" name="tabella">
                <button type="submit">
                    <img src="img/plus-circle.svg" alt="">
                </button>
            </form>
        </th>
    </tr>
    <tr>
        <% Map<String, String> columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeSquadre");
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
    </tr>

    <% for(Squadra s : squadre){ %>
    <tr>
        <td><%= s.getNome() %></td>
        <td><%= s.getUrlImmagine()%></td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" value="squadre" name="tabella">
                <input type="hidden" value="<%=s.getNome()%>" name="idSquadra">
                <button type="submit">
                    <img src="img/trash.svg" alt="">
                </button>
            </form>
        </td>
    </tr>
    <%} %>
</table>

<table class="scale-in-center">
    <tr>
        <th colspan="3">Taglie</th>
        <th>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="taglie" name="tabella">
                <button type="submit">
                    <img src="img/plus-circle.svg" alt="">
                </button>
            </form>
        </th>
    </tr>
    <tr>
        <% columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeTaglie");
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
    </tr>

    <% for(Taglia t : taglie){ %>
    <tr>
        <td><%= t.getTaglia() %></td>
        <td><%= t.getTipologia() %></td>
        <td><%= t.getDescrizione() %></td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" value="taglie" name="tabella">
                <input type="hidden" value="<%=t.getTaglia()%>" name="idTaglia">
                <button type="submit">
                    <img src="img/trash.svg" alt="">
                </button>
            </form>
        </td>
    </tr>
    <%} %>
</table>

<table class="scale-in-center">
    <tr>
        <th colspan="8">Prodotti</th>
        <th>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="prodotti" name="tabella">
                <button type="submit">
                    <img src="img/plus-circle.svg" alt="">
                </button>
            </form>
        </th>
    </tr>
    <tr>
        <% columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeProdotti");
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
    </tr>

    <% for(Prodotto p : prodotti){ %>
    <tr>
        <td><%= p.getId() %></td>
        <td><%= p.getNome() %></td>
        <td><%= p.getPrezzo() %></td>
        <td><%= p.getTipologia() %></td>
        <td><%= p.getSquadra() %></td>
        <td><%= p.getProduttore() %></td>
        <td><%= p.getCollezione() %></td>
        <td><%= p.getUrlImmagine() %></td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" value="prodotti" name="tabella">
                <input type="hidden" value="<%=p.getId()%>" name="idProdotto">
                <button type="submit">
                    <img src="img/trash.svg" alt="">
                </button>
            </form>
        </td>
    </tr>

    <%} %>
</table>

<table class="scale-in-center">
    <tr>
        <th colspan="5">Utenti</th>
        <th>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="utenti" name="tabella">
                <button type="submit">
                    <img src="img/plus-circle.svg" alt="">
                </button>
            </form>
        </th>
    </tr>
    <tr>
        <% columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeUtenti");
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
    </tr>

    <% for(Utente u : utenti){ %>
    <tr>
        <td><%= u.getId() %></td>
        <td><%= u.getUsername() %></td>
        <td><%= u.getEmail() %></td>
        <td><%= u.getPasswordHash() %></td>
        <td><%= u.isAdmin() %></td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" name="tabella" value="utenti">
                <input type="hidden" name="idUtente" value="<%=u.getId()%>">
                <button type="submit">
                    <img src="img/trash.svg" alt="">
                </button>
            </form>
        </td>
    </tr>

    <%} %>
</table>

<table class="scale-in-center">
    <tr>
        <th colspan="6">Ordini</th>
        <th>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="ordini" name="tabella">
                <button type="submit">
                    <img src="img/plus-circle.svg" alt="">
                </button>
            </form>
        </th>
    </tr>
    <tr>
        <% columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeOrdini");;
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
    </tr>

    <% for(Ordine o : ordini){ %>
    <tr>
        <td><%= o.getIdOrdine() %></td>
        <td><%= o.getIdUtente() %></td>
        <td><%= o.getIdProdotto() %></td>
        <td><%= o.getTaglia() %></td>
        <td><%= o.getQuantita() %></td>
        <td><%= o.getPrezzo() %></td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" name="tabella" value="ordini">
                <input type="hidden" name="idOrdine" value="<%=o.getIdOrdine()%>">
                <input type="hidden" name="idProdotto" value="<%=o.getIdProdotto()%>">
                <input type="hidden" name="idUtente" value="<%=o.getIdUtente()%>">
                <input type="hidden" name="taglia" value="<%=o.getTaglia()%>">
                <button type="submit">
                    <img src="img/trash.svg" alt="">
                </button>
            </form>
        </td>
    </tr>

    <%} %>
</table>

<table class="scale-in-center">
    <tr>
        <th colspan="3">ProdottiTaglie</th>
        <th>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="prodottitaglie" name="tabella">
                <button type="submit">
                    <img src="img/plus-circle.svg" alt="">
                </button>
            </form>
        </th>
    </tr>
    <tr>
        <% columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeProdottiTaglie");
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
    </tr>
    <% for(ProdottoTaglie p  : prodottiTaglie){ %>
    <tr>
        <td><%= p.getIdProdotto() %></td>
        <td><%= p.getTaglia() %></td>
        <td><%= p.getQuantita() %></td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" name="tabella" value="prodottitaglie">
                <input type="hidden" name="idProdotto" value="<%=p.getIdProdotto()%>">
                <input type="hidden" name="taglia" value="<%=p.getTaglia()%>">
                <button type="submit">
                    <img src="img/trash.svg" alt="">
                </button>
            </form>
        </td>
    </tr>
    <%} %>
</table>
</body>
</html>
