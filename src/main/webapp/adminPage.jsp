<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
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
        align-items: center;
    }

    table {
        width: 60%;
        border-collapse: collapse;
        margin: 50px 0;
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
</style>

<%
    List<Squadra> squadre = (List<Squadra>) application.getAttribute("squadre");
    List<Taglia> taglie = (List<Taglia>) application.getAttribute("taglie");
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
    List<Utente> utenti = (List<Utente>) request.getAttribute("utenti");
    List<ProdottoTaglie> prodottiTaglie = (List<ProdottoTaglie>) request.getAttribute("prodottitaglie");
%>

<table>
    <tr>
        <th colspan="3">Squadre</th>
    </tr>
    <tr>
        <th>Nome</th>
        <th>URL Immagine</th>
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
        <td>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="squadre" name="tabella">
                <input type="submit" value="inserisci">
            </form>
        </td>
    </tr>
    <%} %>
</table>

<table>
    <tr>
        <th colspan="3">Taglie</th>
    </tr>
    <tr>
        <th>Taglia </th>
        <th>Tipologia</th>
        <th></th>
    </tr>

    <% for(Taglia t : taglie){ %>
    <tr>
        <td><%= t.getTaglia() %></td>
        <td><%= t.getTipologia() %></td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" value="taglie" name="tabella">
                <input type="hidden" value="<%=t.getTaglia()%>" name="idTaglia">
                <button type="submit">
                    <img src="img/trash.svg" alt="">
                </button>
            </form>
        </td>
        <td>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="taglie" name="tabella">
                <input type="submit" value="inserisci">
            </form>
        </td>
    </tr>
    <%} %>
</table>

<table>
    <tr>
        <th colspan="9">Prodotti</th>
    </tr>
    <tr>
        <th>Id_Prodotto</th>
        <th>Nome</th>
        <th>Tipologia</th>
        <th>Prezzo</th>
        <th>URL Immagine</th>
        <th>Squadra</th>
        <th>Collezione</th>
        <th>Produttore</th>
        <th></th>
    </tr>

    <% for(Prodotto p : prodotti){ %>
    <tr>
        <td><%= p.getId() %></td>
        <td><%= p.getNome() %></td>
        <td><%= p.getTipologia() %></td>
        <td><%= p.getPrezzo() %></td>
        <td><%= p.getUrlImmagine() %></td>
        <td><%= p.getSquadra() %></td>
        <td><%= p.getCollezione() %></td>
        <td><%= p.getProduttore() %></td>
        <td>
            <form action="delete-servlet" method="post">
                <input type="hidden" value="prodotti" name="tabella">
                <input type="hidden" value="<%=p.getId()%>" name="idProdotto">
                <button type="submit">
                    <img src="img/trash.svg" alt="">
                </button>
            </form>
        </td>
        <td>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="prodotti" name="tabella">
                <input type="submit" value="inserisci">
            </form>
        </td>
    </tr>

    <%} %>
</table>

<table>
    <tr>
        <th colspan="6">Utenti</th>
    </tr>
    <tr>
        <th>ID_Utente </th>
        <th>Username</th>
        <th>Email</th>
        <th>PasswordHash</th>
        <th>isAdmin</th>
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
        <td>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="utenti" name="tabella">
                <input type="submit" value="inserisci">
            </form>
        </td>
    </tr>

    <%} %>
</table>

<table>
    <tr>
        <th colspan="7">Ordini</th>
    </tr>
    <tr>
        <th>ID_Ordine </th>
        <th>Id_Utente</th>
        <th>Id_Prodotto</th>
        <th>Taglia</th>
        <th>Quantita</th>
        <th>Prezzo</th>
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
        <td>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="ordini" name="tabella">
                <input type="submit" value="inserisci">
            </form>
        </td>
    </tr>

    <%} %>
</table>

<table>
    <tr>
        <th colspan="4">ProdottiTaglie</th>
    </tr>
    <tr>
        <th>IdProdotto</th>
        <th>Taglia</th>
        <th>Quantita</th>
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
        <td>
            <form action="insert-servlet" method="post">
                <input type="hidden" value="prodottitaglie" name="tabella">
                <input type="submit" value="inserisci">
            </form>
        </td>
    </tr>
    <%} %>
</table>
</body>
</html>
