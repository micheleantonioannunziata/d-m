<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: ciril
  Date: 29/05/2024
  Time: 22:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>insertPage</title>
</head>
<body>
    <style>
        *{margin: 0;padding: 0;font-family: 'Montserrat', sans-serif;text-align: center;}

        body{
            height: 100%;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        input {
            display: block;
            margin: 0 auto; /* Centrare l'input all'interno del contenitore */
            margin-bottom: 10px;
        }
        h2{
            margin-bottom: 15px;
        }
        form{
            max-width: 600px; /* Larghezza massima per il contenitore degli input */
            width: 100%;
            padding: 0 20px; /* Padding laterale per estetica */
        }
    </style>
    <%
        Map<String,String> colonneTipi = (Map<String, String>) request.getAttribute("colonneTipi");
        String nameTable = (String) request.getAttribute("tabella"); %>

        <h2>Inserimento nella tabella <%= nameTable%></h2>

        <form action="insert-data" method="post">
            <input type="hidden" name="tabella" value="<%= nameTable%>">
            <% for (Map.Entry<String, String> entry : colonneTipi.entrySet()) {
                if (entry.getKey().contains("auto"))   continue;

                String choose = entry.getValue().toLowerCase();

                if (choose.contains("("))
                    choose = choose.substring(0, entry.getValue().indexOf('('));%>

                    <label>Inserisci <%=entry.getKey() %> </label>
                    <%
                        switch(choose) {
                            case "varchar" : { %>
                                <input type="text" name="<%= entry.getKey() %>">
                               <% break; }
                                   case "decimal" : { %>
                                <input type="number" step="0.01" name= "<%=entry.getKey()%>"> <!-- step = precisione decim -->
                            <% break; }
                                case "tinyint" : { %>
                                <input type="checkbox" name="<%= entry.getKey()%>" />
                            <% break; }
                                case "int" : { %>
                                <input type="number" step="1" name= "<%=entry.getKey()%>">
                            <% break; }
                        }
            } %>
                <input type="submit" value="invia">
        </form>
</body>
</html>
