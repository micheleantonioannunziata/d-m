<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign up</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%
    // forse non è MVC, bisogna fare un'altra servlet
    if (session.getAttribute("utente") != null)
        response.sendRedirect("redirectToUserArea");
%>

<div class="poster" id="loginSection">
    <div class="poster__content">
        <div class="logo mid-text">
            <a href="index.jsp">D<span class="normal-text">&</span>M</a>
        </div>

        <form action="signup-servlet" method="post" onsubmit="return validateForm()">
            <div class="input">
                <img src="img/users.svg">
                <input type="text" id="username" name="username" required placeholder="Username">
            </div>
            <div class="input">
                <img src="img/mail.svg">
                <input type="email" id="email" name="email" required placeholder="Email">
            </div>
            <div class="input">
                <img src="img/unlock.svg">
                <input type="password" id="password" name="password" required  placeholder="Password" oninput="">
                <img src="img/eye.svg" id="eyePassword" alt="">
            </div>
            <div class="input">
                <img src="img/check-square.svg">
                <input type="password" id = "confirmPassword" name="confirmPassword" required  placeholder="Confirm Password">
                <img id="eyeConfirmPassword" src="img/eye.svg" alt="">
            </div>

            <h4 class="small-text">Have you already an account?
                <a href="login.jsp">Log in</a>
            </h4>

            <% String error = (String) request.getAttribute("error"); %>

            <p id="error"
                <% if (error != null) { %>
                    style="display: block"
                <% }%>
            >
                <%= error != null ? error : "" %>
            </p>

            <input type="submit" value="Sign up" id = "submitBtn">
        </form>
    </div>
    <div class="poster__img" style="width: 50%">
        <img src="img/zieloSignUp.png" alt="">
    </div>
</div>
<script type="text/javascript" src="js/checkConfirmAndShowPassword.js"></script>
<script type="text/javascript" src="js/validateForm.js">
</script>
</body>
</html>
