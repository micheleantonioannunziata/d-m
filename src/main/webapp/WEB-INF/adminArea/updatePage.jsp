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
            if (name.startsWith("is"))
                getName = name;

            //ricerca del metodo get cercato
            if (m.getName().equalsIgnoreCase(getName))
                return m;
        }
        return null;
    }

    // verifica se un metodo è un getter - gpt made
    boolean isGetter(Method method) {
        if (method.getName().startsWith("is"))  return true;

        if (!method.getName().startsWith("get")) return false;

        //se ha parametri NON è un getters
        if (method.getParameterCount() != 0) return false;

        return true;
        //return !void.class.equals(method.getReturnType());
    }%>


<%
    //nome colonne + tipo colonna
    Map<String,String> colonneTipi = (Map<String, String>) request.getAttribute("colonneTipi");

    String nameTable = (String) request.getAttribute("tabella");

    //tabella che si vuole aggiornare
    Object bean = request.getAttribute("bean");

    //passa tutti i metodi della classe della tabella che si vuole aggiornare alla funzione getters
    Method[] getterMethods = getters(bean.getClass().getMethods());
    // riceverà solamente i metodi getters
%>

<h2>Modifica nella tabella <%= nameTable%></h2>

<form action="update-data" method="post">
    <input type="hidden" name="tabella" value="<%= nameTable%>">
    <!-- i metodi getters serviranno per ricevere i valori dei vari campi che possono essere modificati (valori precedenti)-->
    <%
        //per ogni colonna + tipo della tupla che si vuole aggiornare
        for (Map.Entry<String, String> entry : colonneTipi.entrySet()) {
            String columnName = entry.getKey(); //il nome della colonna

            String dataType = entry.getValue().toLowerCase(); //il tipo della colonna

            //prendo la sottostringa che va da 0 fino all' (, prima delle parentesi tonde
            if (dataType.contains("("))
                dataType = dataType.substring(0, entry.getValue().indexOf('(')); //prendo il tipo del dato

            Object defaultValue;
            //separo il contenuto di columnName aggiungendo tutto in un array
            //esempio : id_utente - pk
            String[] parts = columnName.split(" - ");
            try {
                if (parts[0].contains("default"))
                    //prendo ciò che ci sta prima di default
                    parts[0] = parts[0].substring(0, parts[0].indexOf("default") - 1);

                // prendo il metodo Getter corrispondente a quel valore (in part[0]) ed eseguo il metodo getter (prendo il valore)
                defaultValue = getterByName(getterMethods, parts[0]).invoke(bean);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }

            if (parts.length > 1) {
                if (parts[1].equalsIgnoreCase("pk") || parts[1].contains("auto")) {
    %>
            <!--  creo un input nascosto con name in funzione dell'attributo che sto considerando
                    (solo le chiavi per passarle ad updateDataServlet che modificherà i valori
                     scrivo Old in modo da poter distinguere il valore precedente all'aggiornamento dal nuovo) -->
            <input type="hidden" name="old<%=parts[0]%>" value="<%=defaultValue%>">
    <%
                if (entry.getKey().contains("auto"))
                    continue;
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
    <!-- data-default-value conserva il valore precedente alla modifica
          onfocus (quando clicco sull'input) -->
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
    //quando utente clicca sull'input inserisci il valore di defualt
    function setDefaultValue(input) {
        //se viene cliccato per la prima volta
        if (input.getAttribute("data-has-focused") === "false") {
            if (input.getAttribute("data-default-value") !== "null")
                input.value = input.getAttribute("data-default-value");
            input.setAttribute("data-has-focused","true");
        }
    }
</script>

</body>
</html>