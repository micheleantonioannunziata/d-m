<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/adminPage.css">
</head>
<body>

<%
    List<Squadra> squadre = (List<Squadra>) application.getAttribute("squadre");
    List<Taglia> taglie = (List<Taglia>) application.getAttribute("taglie");
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
    List<Utente> utenti = (List<Utente>) request.getAttribute("utenti");
    List<ProdottoTaglie> prodottiTaglie = (List<ProdottoTaglie>) request.getAttribute("prodottitaglie");
%>

<button onclick="location.href = 'redirectToUserArea'"
    style="margin: 20px auto" class="small-text">Back to user area</button>

<table class="scale-in-center">
    <tr>
        <th colspan="2">Squadre</th> <!-- 2 colonne (colspan) -->
        <th>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="squadre" name="tabella">
                <button type="submit">
                    <img src="img/plus-circle.svg" alt="add">
                </button>
            </form>
        </th>
        <th></th>
    </tr>
    <tr>
        <% Map<String, String> columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeSquadre");
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
        <th></th>
    </tr>

    <% for(Squadra s : squadre){ %>
    <tr>
        <td><%= s.getNome() %></td>
        <td><%= s.getUrlImmagine()%></td>
        <td>
            <form action="update-servlet" method="post">
                <input type="hidden" value="squadre" name="tabella">
                <input type="hidden" value="<%=s.getNome()%>" name="idSquadra">
                <button type="submit">
                    <img src="img/refresh-cw.svg" alt="update">
                </button>
            </form>
        </td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" value="squadre" name="tabella">
                <input type="hidden" value="<%=s.getNome()%>" name="idSquadra">
                <button type="submit">
                    <img src="img/trash.svg" alt="delete">
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
                    <img src="img/plus-circle.svg" alt="add">
                </button>
            </form>
        </th>
        <th></th>
    </tr>
    <tr>
        <% columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeTaglie");
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
        <th></th>
    </tr>

    <% for(Taglia t : taglie){ %>
    <tr>
        <td><%= t.getTaglia() %></td>
        <td><%= t.getTipologia() %></td>
        <td><%= t.getDescrizione() %></td>
        <td>
            <form action="update-servlet" method="post">
                <input type="hidden" value="taglie" name="tabella">
                <input type="hidden" value="<%=t.getTaglia()%>" name="idTaglia">
                <button type="submit">
                    <img src="img/refresh-cw.svg" alt="update">
                </button>
            </form>
        </td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" value="taglie" name="tabella">
                <input type="hidden" value="<%=t.getTaglia()%>" name="idTaglia">
                <button type="submit">
                    <img src="img/trash.svg" alt="delete">
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
                    <img src="img/plus-circle.svg" alt="add">
                </button>
            </form>
        </th>
        <th></th>
    </tr>
    <tr>
        <% columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeProdotti");
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
        <th></th>
    </tr>

    <% for(Prodotto p : prodotti){ %>
    <tr>
        <td><%= p.getId_Prodotto() %></td>
        <td><%= p.getNome() %></td>
        <td><%= p.getPrezzo() %></td>
        <td><%= p.getTipologia() %></td>
        <td><%= p.getSquadra() %></td>
        <td><%= p.getProduttore() %></td>
        <td><%= p.getCollezione() %></td>
        <td><%= p.getUrlImmagine() %></td>
        <td>
            <form action="update-servlet" method="post">
                <input type="hidden" value="prodotti" name="tabella">
                <input type="hidden" value="<%=p.getId_Prodotto()%>" name="idProdotto">
                <button type="submit">
                    <img src="img/refresh-cw.svg" alt="update">
                </button>
            </form>
        </td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" value="prodotti" name="tabella">
                <input type="hidden" value="<%=p.getId_Prodotto()%>" name="idProdotto">
                <button type="submit">
                    <img src="img/trash.svg" alt="delete">
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
                    <img src="img/plus-circle.svg" alt="add">
                </button>
            </form>
        </th>
        <th></th>
    </tr>
    <tr>
        <% columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeUtenti");
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
        <th></th>
    </tr>

    <% for(Utente u : utenti){ %>
    <tr>
        <td><%= u.getId_Utente() %></td>
        <td><%= u.getUsername() %></td>
        <td><%= u.getEmail() %></td>
        <td><%= u.getPasswordHash() %></td>
        <td><%= u.isAdmin() %></td>
        <td>
            <form action="update-servlet" method="post">
                <input type="hidden" value="utenti" name="tabella">
                <input type="hidden" value="<%=u.getId_Utente()%>" name="idUtente">
                <button type="submit">
                    <img src="img/refresh-cw.svg" alt="update">
                </button>
            </form>
        </td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" name="tabella" value="utenti">
                <input type="hidden" name="idUtente" value="<%=u.getId_Utente()%>">
                <button type="submit">
                    <img src="img/trash.svg" alt="delete">
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
                    <img src="img/plus-circle.svg" alt="add">
                </button>
            </form>
        </th>
        <th></th>
    </tr>
    <tr>
        <% columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeOrdini");;
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
        <th></th>
    </tr>

    <% for(Ordine o : ordini){ %>
    <tr>
        <td><%= o.getID_Ordine() %></td>
        <td><%= o.getUtente() %></td>
        <td><%= o.getProdotto() %></td>
        <td><%= o.getTaglia() %></td>
        <td><%= o.getQuantita() %></td>
        <td><%= o.getPrezzo() %></td>
        <td>
            <form action="update-servlet" method="post">
                <input type="hidden" value="ordini" name="tabella">
                <input type="hidden" name="idOrdine" value="<%=o.getID_Ordine()%>">
                <input type="hidden" name="idProdotto" value="<%=o.getProdotto()%>">
                <input type="hidden" name="idUtente" value="<%=o.getUtente()%>">
                <input type="hidden" name="taglia" value="<%=o.getTaglia()%>">
                <button type="submit">
                    <img src="img/refresh-cw.svg" alt="update">
                </button>
            </form>
        </td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" name="tabella" value="ordini">
                <input type="hidden" name="idOrdine" value="<%=o.getID_Ordine()%>">
                <input type="hidden" name="idProdotto" value="<%=o.getProdotto()%>">
                <input type="hidden" name="idUtente" value="<%=o.getUtente()%>">
                <input type="hidden" name="taglia" value="<%=o.getTaglia()%>">
                <button type="submit">
                    <img src="img/trash.svg" alt="delete">
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
                    <img src="img/plus-circle.svg" alt="add">
                </button>
            </form>
        </th>
        <th></th>
    </tr>
    <tr>
        <% columnDataType = (Map<String, String>) request.getAttribute("columnDataTypeProdottiTaglie");
            for (Map.Entry<String, String> entry : columnDataType.entrySet()) {%>
                <th><%= entry.getKey() %> (<%= entry.getValue() %>)</th>
            <% } %>
        <th></th>
        <th></th>
    </tr>
    <% for(ProdottoTaglie p  : prodottiTaglie){ %>
    <tr>
        <td><%= p.getProdotto() %></td>
        <td><%= p.getTaglia() %></td>
        <td><%= p.getQuantita() %></td>
        <td>
            <form action="update-servlet" method="post">
                <input type="hidden" value="prodottitaglie" name="tabella">
                <input type="hidden" name="idProdotto" value="<%=p.getProdotto()%>">
                <input type="hidden" name="taglia" value="<%=p.getTaglia()%>">
                <button type="submit">
                    <img src="img/refresh-cw.svg" alt="update">
                </button>
            </form>
        </td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" name="tabella" value="prodottitaglie">
                <input type="hidden" name="idProdotto" value="<%=p.getProdotto()%>">
                <input type="hidden" name="taglia" value="<%=p.getTaglia()%>">
                <button type="submit">
                    <img src="img/trash.svg" alt="delete">
                </button>
            </form>
        </td>
    </tr>
    <%} %>
</table>
</body>
</html>
