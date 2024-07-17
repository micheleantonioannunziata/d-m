<%@ page import="java.util.Map" %>
<%@ page import="java.lang.reflect.Method" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.reflect.InvocationTargetException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Page</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/updatePage.css">
</head>


<body>
<%!
    // restituisce solamente i getters
    Method[] getters(Method[] methods) {
        List<Method> gettersList = new ArrayList<>();
        for (Method method : methods) //scorre tutti i metodi di quella classe
            if (isGetter(method))
                gettersList.add(method);

        return gettersList.toArray(new Method[0]); //restituisce array di oggetti di tipo Method
    }

    //restituisce il metodo get corrispondente a quel name (valore)
    Method getterByName(Method[] methods, String name) {
        for (Method m: methods) {
            String getName = "get" + name;
            if (name.startsWith("is"))   getName = name;

            //System.out.println(getName);

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
    Map<String,String> colonneTipi = (Map<String, String>) request.getAttribute("colonneTipi"); //nome colonne + tipo colonna
    String nameTable = (String) request.getAttribute("tabella");
    Object bean = request.getAttribute("bean"); //tabella che si vuole aggiornare
    Method[] getterMethods = getters(bean.getClass().getMethods()); //passa tutti i metodi della classe della tabella che si vuole aggiornare
    // riceverà solamente i metodi getters
%>

<h2>Modifica nella tabella <%= nameTable%></h2>

<form action="update-data" method="post">
    <input type="hidden" name="tabella" value="<%= nameTable%>">
    <!-- i metodi getters serviranno per ricevere i valori dei vari campi che possono essere modificati -->
    <%
        for (Map.Entry<String, String> entry : colonneTipi.entrySet()) { //per ogni colonna + tipo della tupla che si vuole aggiornare
            String columnName = entry.getKey(); //il nome della colonna

            String dataType = entry.getValue().toLowerCase(); //il tipo della colonna

            if (dataType.contains("(")) //prendo la sottostringa che va da 0 fino all' (, prima delle parentesi tonde
                dataType = dataType.substring(0, entry.getValue().indexOf('(')); //prendo il tipo del dato

            Object defaultValue;
            String[] parts = columnName.split(" - "); //separo il contenuto di columnName aggiungendo tutto in un array
            try {
                if (parts[0].contains("default"))
                    parts[0] = parts[0].substring(0, parts[0].indexOf("default") - 1); //prendo ciò che ci sta prima di default


                defaultValue = getterByName(getterMethods, parts[0]).invoke(bean); // prendo il metodo Getter corrispondente a quel valore (in part[0])
            } catch (Exception e) {
                throw new RuntimeException(e);
            }

            if (parts.length > 1) {
                if (parts[1].equalsIgnoreCase("pk") || parts[1].contains("auto")) {
    %>
            <input type="hidden" name="old<%=parts[0]%>" value="<%=defaultValue%>"> <!-- stampo il valore nell'input tramite il metodo getter, stiamo considerando CHIAVE PRIMARIA (OLD) -->
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
           <% if (!entry.getKey().contains("default")) { %>
               required
            <% } %>
    > <!-- defaultValue = valore che c'era prima, onfocus = quando utente clicca su quell'input -->

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
    function setDefaultValue(input) { //quando utente clicca sull'input inserisci il valore di defualt
        if (input.dataset.hasFocused === "false") {
            if (input.dataset.defaultValue !== "null")
                input.value = input.dataset.defaultValue;
            input.dataset.hasFocused = "true";
        }
    }
</script>

</body>
</html>