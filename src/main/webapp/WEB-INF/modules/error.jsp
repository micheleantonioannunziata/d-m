<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error page</title>

    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
</head>
<body>
<%@ include file="header.jsp" %>

<%!
    public int getErrorCode(Exception exception) {
        if (exception instanceof NullPointerException)      return 400;

        if (exception instanceof IllegalArgumentException)  return 300;

        return 500;
    }
%>

<div class="poster" id="fanZoneSection" style="height: 85vh; margin-top: 15vh">
    <div class="poster__content">

        <% if (exception != null) { %>
            <h3 class="big-text stroke">Error <%= getErrorCode((Exception) exception) %></h3>
            <p class="small-text">
                An error occurred while processing your request. Please see the details below:
            </p>
            <p>
                Error Type: <%= exception.getClass().getName() %><br>
                Message: <%= exception.getMessage() %>
            </p>
        <% }else {
            Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
            if (statusCode != null) {
        %>
            <h3 class="big-text stroke" style="text-transform: uppercase">Error <%= statusCode %></h3>
            <p class="small-text">
                An error occurred while processing your request. Please see the details below:
            </p>
            <p>
                Status Code: <%= statusCode %><br>
                Message: <%= request.getAttribute("jakarta.servlet.error.message") %>
            </p>
        <% }
            }%>

    </div>
    <div class="poster__img" style="width: 45%">
        <img src="img/baggio.jpg" alt="zieloError">
    </div>
</div>
</body>
</html>

