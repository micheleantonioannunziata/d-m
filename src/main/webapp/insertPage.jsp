<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>insertPage</title>
</head>
<body>
    <style></style>
    <%
        Map<String,String> colonneTipi = (Map<String, String>) request.getAttribute("colonneTipi");
        String nameTable = (String) request.getAttribute("tabella"); %>

        <h2>Inserimento nella tabella <%= nameTable%></h2>

        <form action="insert-data" method="post" enctype="multipart/form-data">
            <input type="hidden" name="tabella" value="<%= nameTable%>">
            <% for (Map.Entry<String, String> entry : colonneTipi.entrySet()) {
                System.out.println("\n"+entry.getKey()+","+entry.getValue());
                if (entry.getKey().contains("auto") || entry.getKey().contains("default"))
                    continue;

                String dataType = entry.getValue().toLowerCase();

                String columnName = entry.getKey();

                if (columnName.contains("Hash"))    columnName = "password";

                if (dataType.contains("("))
                    dataType = dataType.substring(0, entry.getValue().indexOf('('));%>

                    <label>Inserisci <%= columnName %> </label>
                        <%
                            switch(dataType) {
                                case "varchar" : {
                                    String type = "text";

                                    if (columnName.equalsIgnoreCase("urlImmagine"))
                                        type = "file";
                                    else if (columnName.equalsIgnoreCase("email"))
                                        type = "email";
                                    else if (columnName.equalsIgnoreCase("password"))
                                        type = "password";
                        %>
                        <input type="<%= type %>" name=" <%= columnName %>">
                        <% break; }
                               case "decimal" : { %>
                            <input type="number" step="0.01" name= "<%= columnName %>"> <!-- step = precisione decim -->
                        <% break; }
                            case "tinyint" : { %>
                            <input type="checkbox" name="<%= columnName %>" />
                        <% break; }
                            case "int" : { %>
                            <input type="number" step="1" name= "<%= columnName %>">
                        <% break; }
                    }
            } %>
                <input type="submit" value="invia">
        </form>
</body>
</html>
