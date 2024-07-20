<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Page</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/insertPage.css">
</head>
<body>
    <%
        Map<String,String> colonneTipi = (Map<String, String>) request.getAttribute("colonneTipi");
        String nameTable = (String) request.getAttribute("tabella"); %>

        <h2>Inserimento nella tabella <%= nameTable%></h2>

        <!-- enctype serve per inserire anche le immagini -->
        <form action="insert-data" method="post" enctype="multipart/form-data">
            <input type="hidden" name="tabella" value="<%= nameTable%>">

            <% for (Map.Entry<String, String> entry : colonneTipi.entrySet()) {
                if (entry.getKey().contains("auto") || entry.getKey().contains("default"))
                    continue;

                String dataType = entry.getValue().toLowerCase();

                String columnName = entry.getKey();

                if (columnName.contains("Hash"))
                    columnName = "password";

                //prende il tipo di dato
                if (dataType.contains("("))
                    dataType = dataType.substring(0, entry.getValue().indexOf('('));

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
                        <input type="<%= type %>" name="<%= columnName %>" placeholder="<%= columnName %>" required>

                <% break;
                    }
                    case "decimal" : { %>
                        <!-- aumento di 0.01 -->
                        <input type="number" step="0.01" name= "<%= columnName %>" placeholder="<%= columnName %>" required> <!-- step = precisione decim -->
                <% break;
                    }
                    case "tinyint" : { %>
                    <input id = "checkbox" type="checkbox" name="<%= columnName %>" placeholder="<%= columnName %>" />
                <% break;
                    }
                    case "int" : { %>
                        <input type="number" step="1" name= "<%= columnName %>" placeholder="<%= columnName %>" required>
                <% break;
                    }
                } %>
        <% } %>
            <input type="submit" value="Invia">
        </form>
</body>
</html>
