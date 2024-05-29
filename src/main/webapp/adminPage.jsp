<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<% List<Squadra> squadre = (List<Squadra>) application.getAttribute("squadre");
    List<Taglia> taglie = (List<Taglia>) application.getAttribute("taglie");
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
    List<Utente> utenti = (List<Utente>) request.getAttribute("utenti");
    List<ProdottoTaglie> prodottoTaglies = (List<ProdottoTaglie>) request.getAttribute("prodottitaglie");
%>

<div class="adminTable" style="display: flex; flex-wrap: wrap; justify-content: space-between;">
    <table border="1">
        <tr>
            <th colspan="3">Squadre</th>
        </tr>
        <tr>
            <th>Nome</th>
            <th>URL Immagine</th>
            <th>Elimina</th>
        </tr>

        <% for(Squadra s : squadre){ %>
        <tr>
            <td><%= s.getNome() %></td>
            <td><%= s.getUrlImmagine()%></td>
            <td> <form action="delete-servlet" method="post">
                <input type="hidden" value="squadre" name="deletePar">
                <input type="hidden" value="<%=s.getNome()%>" name="idSquadra">
                <input type="submit" value="Delete">
            </form>
            </td>
        </tr>

        <%} %>
    </table>

    <table border="1">
        <tr>
            <th colspan="3">Taglie</th>
        </tr>
        <tr>
            <th>Taglia </th>
            <th>Tipologia</th>
            <th>Elimina</th>
        </tr>

        <% for(Taglia t : taglie){ %>
        <tr>
            <td><%= t.getTaglia() %></td>
            <td><%= t.getTipologia() %></td>
            <td> <form action="delete-servlet" method="post">
                <input type="hidden" value="taglie" name="deletePar">
                <input type="hidden" value="<%=t.getTaglia()%>" name="idTaglia">
                <input type="submit" value="Delete">
            </form>
            </td>
        </tr>

        <%} %>
    </table>

    <table border="1">
        <tr>
            <th colspan="9">Prodotti</th>
        </tr>
        <tr>
            <th>Nome </th>
            <th>Tipologia</th>
            <th>Prezzo</th>
            <th>Id</th>
            <th>URL Immagine</th>
            <th>Squadra</th>
            <th>Collezione</th>
            <th>Produttore</th>
            <th>Elimina</th>
        </tr>

        <% for(Prodotto p : prodotti){ %>
        <tr>
            <td><%= p.getNome() %></td>
            <td><%= p.getTipologia() %></td>
            <td><%= p.getPrezzo() %></td>
            <td><%= p.getId() %></td>
            <td><%= p.getUrlImmagine() %></td>
            <td><%= p.getSquadra() %></td>
            <td><%= p.getCollezione() %></td>
            <td><%= p.getProduttore() %></td>
            <td>
                <form action="delete-servlet" method="post">
                    <input type="hidden" value="prodotti" name="deletePar">
                    <input type="hidden" value="<%=p.getId()%>" name="idProdotto">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>

        <%} %>
    </table>

    <table border="1">
        <tr>
            <th colspan="6">Utenti</th>
        </tr>
        <tr>
            <th>ID_Utente </th>
            <th>Username</th>
            <th>Email</th>
            <th>PasswordHash</th>
            <th>isAdmin</th>
            <th>Elimina</th>
        </tr>

        <% for(Utente u : utenti){ %>
        <tr>
            <td><%= u.getId() %></td>
            <td><%= u.getUsername() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getPasswordHash() %></td>
            <td><%= u.isAdmin() %></td>
            <td> <form action="delete-servlet" method="post">
                <input type="hidden" value="utenti" name="deletePar">
                <input type="hidden" value="<%=u.getId()%>" name="idUtente">
                <input type="submit" value="Delete">
            </form>
            </td>
        </tr>

        <%} %>
    </table>

    <table border="1">
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
            <th>Elimina</th>
        </tr>

        <% for(Ordine o : ordini){ %>
        <tr>
            <td><%= o.getIdOrdine() %></td>
            <td><%= o.getIdUtente() %></td>
            <td><%= o.getIdProdotto() %></td>
            <td><%= o.getTaglia() %></td>
            <td><%= o.getQuantita() %></td>
            <td><%= o.getPrezzo() %></td>
            <td> <form action="delete-servlet" method="post">
                <input type="hidden" value="ordini" name="deletePar">
                <input type="hidden" value="<%=o.getIdOrdine()%>" name="idOrdine">
                <input type="hidden" value="<%=o.getIdProdotto()%>" name="idProdotto">
                <input type="hidden" value="<%=o.getIdUtente()%>" name="idUtente">
                <input type="hidden" value="<%=o.getTaglia()%>" name="taglia">
                <input type="submit" value="Delete">
            </form>
            </td>
        </tr>

        <%} %>
    </table>
    <table border="1">
        <tr>
            <th colspan="4">ProdottoTaglie</th>
        </tr>
        <tr>
            <th>IdProdotto</th>
            <th>Taglia</th>
            <th>Quantita</th>
            <th>Elimina</th>
        </tr>
        <% for(ProdottoTaglie p  : prodottoTaglies){ %>
        <tr>
            <td><%= p.getIdProdotto() %></td>
            <td><%= p.getTaglia() %></td>
            <td><%= p.getQuantita() %></td>
            <td> <form action="delete-servlet" method="post">
                <input type="hidden" value="prodottitaglie" name="deletePar">
                <input type="hidden" value="<%=p.getIdProdotto()%>" name="idProdotto">
                <input type="hidden" value="<%=p.getTaglia()%>" name="taglia">
                <input type="submit" value="Delete">
            </form>
            </td>
        </tr>

        <%} %>
    </table>
</div>
</body>
</html>


