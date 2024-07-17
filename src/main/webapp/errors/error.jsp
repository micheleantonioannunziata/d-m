<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <%@ include file="../WEB-INF/modules/header.jsp" %>

    <%!
        public int getErrorCode(Exception exception) {
            if (exception instanceof NullPointerException)      return 400;

            if (exception instanceof IllegalArgumentException)  return 300;

            return 500;
        }
    %>

    <div class="poster" id = "fanZoneSection">
        <div class="poster__content">
            <h3 class="big-text stroke">Error <%=getErrorCode((Exception) exception)%></h3>
            <p class="small-text">
                An error occurred while processing your request. Please see the details below:
            </p>
            <p>
                Error Type: <%= exception %><br>
                Message: <%= exception.getMessage().substring(0, exception.getMessage().indexOf("Please")) %>
            </p>

            <button onclick="location.href='fanZone.jsp'">Go back</button>
        </div>
        <div class="poster__img">
            <img src="../img/zieloError.jpeg" alt="">
        </div>
    </div>
</body>
</html>