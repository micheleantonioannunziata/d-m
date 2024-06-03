<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>insertPage</title>
</head>
<body>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap');

        *{margin: 0;padding: 0;font-family: 'Montserrat', sans-serif;box-sizing: border-box;}

        body {
            display: flex;
            flex-direction: column;
            align-items: center
        }

        h2 {
            margin: 25px;
        }

        form {
            display: flex;
            flex-direction: column;
            width: 50%;
            align-items: center;
        }

        input {
            margin: 25px 0;
            padding: 12px 14px;
            font-size: 17px;
            width: 80%;
        }

        input[type="submit"] {
            background: #70F495;
            border: none;
            border-radius: 20px;
            font-weight: 700;
        }
    </style>
    <%
        Map<String,String> colonneTipi = (Map<String, String>) request.getAttribute("colonneTipi");
        String nameTable = (String) request.getAttribute("tabella"); %>

        <h2>Inserimento nella tabella <%= nameTable%></h2>

        <form action="insert-data" method="post" enctype="multipart/form-data">
            <input type="hidden" name="tabella" value="<%= nameTable%>">

            <% for (Map.Entry<String, String> entry : colonneTipi.entrySet()) {
                if (entry.getKey().contains("auto") || entry.getKey().contains("default"))
                    continue;
            %>
            <%
                String dataType = entry.getValue().toLowerCase();

                String columnName = entry.getKey();

                if (columnName.contains("Hash"))    columnName = "password";

                if (dataType.contains("("))
                    dataType = dataType.substring(0, entry.getValue().indexOf('('));%>
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
                                    <input type="<%= type %>" name=" <%= columnName %>" placeholder="<%= columnName %>" required>
                            <% break; }
                               case "decimal" : { %>
                                    <input type="number" step="0.01" name= "<%= columnName %>" placeholder="<%= columnName %>" required> <!-- step = precisione decim -->
                            <% break; }
                            case "tinyint" : { %>
                                <input id = "checkbox" type="checkbox" name="<%= columnName %>" placeholder="<%= columnName %>" />
                            <% break; }
                            case "int" : { %>
                                    <input type="number" step="1" name= "<%= columnName %>" placeholder="<%= columnName %>" required>
                            <% break; }
                            } %>
                    <% } %>
            <input type="submit" value="Invia">
        </form>
</body>
</html>
