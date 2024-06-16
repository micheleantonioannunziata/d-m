<%@ page import="java.util.Map" %>
<%@ page import="java.lang.reflect.Method" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.reflect.InvocationTargetException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Page</title>
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
<%!
    // restituisce solamente i getters
    Method[] getters(Method[] methods) {
        List<Method> gettersList = new ArrayList<>();
        for (Method method : methods)
            if (isGetter(method))
                gettersList.add(method);

        return gettersList.toArray(new Method[0]);
    }

    Method getterByName(Method[] methods, String name) {
        for (Method m: methods) {
            String getName = "get" + name;
            if (name.startsWith("is"))   getName = name;
            System.out.println(getName);
            if (m.getName().equalsIgnoreCase(getName))
                return m;
        }
        return null;
    }

    // verifica se un metodo è un getter - gpt made
    boolean isGetter(Method method) {
        if (method.getName().startsWith("is"))  return true;

        if (!method.getName().startsWith("get")) return false;

        if (method.getParameterCount() != 0) return false;

        return !void.class.equals(method.getReturnType());
    }%>


<%
    Map<String,String> colonneTipi = (Map<String, String>) request.getAttribute("colonneTipi");
    String nameTable = (String) request.getAttribute("tabella");
    Object bean = request.getAttribute("bean");
    Method[] getterMethods = getters(bean.getClass().getMethods());

%>

<h2>Modifica nella tabella <%= nameTable%></h2>

<form action="update-data" method="post">
    <input type="hidden" name="tabella" value="<%= nameTable%>">

    <%
        for (Map.Entry<String, String> entry : colonneTipi.entrySet()) {
    %>
    <%
        String dataType = entry.getValue().toLowerCase();

        String columnName = entry.getKey();

        if (columnName.contains("Hash"))    columnName = "password";

        if (dataType.contains("("))
            dataType = dataType.substring(0, entry.getValue().indexOf('('));

        Object defaultValue;
        String[] parts = columnName.split(" - ");
        try {
            if (parts[0].contains("default"))
                parts[0] = parts[0].substring(0, parts[0].indexOf("default") - 1);

            defaultValue = getterByName(getterMethods, parts[0]).invoke(bean);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        if (parts.length > 1) {
            if (parts[1].equalsIgnoreCase("pk") || parts[1].contains("auto")) {
    %>
            <input type="hidden" name="old<%=parts[0]%>" value="<%=defaultValue%>">
    <%
            if (entry.getKey().contains("auto"))    continue;
            }
        }

    %>
    <%
        switch(dataType) {
            case "varchar" : {
                String type = "text";

                if (columnName.equalsIgnoreCase("email"))
                    type = "email";
                else if (columnName.equalsIgnoreCase("password"))
                    type = "password";
    %>
    <input type="<%= type %>" name=" <%= columnName %>" placeholder="<%= columnName %>"
           value=""
           data-default-value="<%= defaultValue %>"
           data-has-focused="false"
           onfocus="setDefaultValue(this)"

           <% if (!entry.getKey().contains("default")) {
               System.out.println(entry.getKey());%>
               required
            <% } %>
    >

    <% break; }
        case "decimal" : { %>
    <input type="number" step="0.01" name= "<%= columnName %>" placeholder="<%= columnName %>"
           value=""
           data-default-value="<%= defaultValue %>"
           data-has-focused="false"
           onfocus="setDefaultValue(this)"
        <% if (!entry.getKey().contains("default")) { %>
           required
    <% } %>
    > <!-- step = precisione decim -->
    <% break; }
        case "tinyint" : { %>
            <input id = "checkbox" type="checkbox" name="<%= columnName %>" placeholder="<%= columnName %>"
                <% boolean value = (boolean) defaultValue;
                    if (value) {
                %>
                    checked
                    <%}%>
            />
    <% break; }
        case "int" : { %>
            <input type="number" step="1" name= "<%= columnName %>" placeholder="<%= columnName %>"
                   value=""
                   data-default-value="<%= defaultValue %>"
                   data-has-focused="false"
                   onfocus="setDefaultValue(this)" <% if (!entry.getKey().contains("default")) { %>
                   required
    <% } %>
            >
    <% break; }
    } %>
    <% } %>
    <input type="submit" value="Invia">
</form>

<script>
    function setDefaultValue(input) {
        if (input.dataset.hasFocused === "false") {
            if (input.dataset.defaultValue !== "null")
                input.value = input.dataset.defaultValue;
            input.dataset.hasFocused = "true";
        }
    }
</script>

</body>
</html>