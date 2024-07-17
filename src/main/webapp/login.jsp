<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
</head>
    <body>

    <div class="poster" id="loginSection">
        <div class="poster__content">
            <div class="logo mid-text">
                <a href="index.jsp">D<span class="normal-text">&</span>M</a>
            </div>

            <form action="login-servlet" method="post" onsubmit="return validateForm()">
                <div class="input">
                    <img src="img/mail.svg" alt="">
                    <input id="username" type="text" name="username" required placeholder="Username">
                </div>

                <div class="input">
                    <img src="img/unlock.svg">
                    <input id="password" type="password" name="password" required  placeholder="Password">
                    <img src="img/eye.svg" id="eyePassword" alt="">
                </div>

                <h4 class="small-text">Haven't you an account yet?
                    <a href="signup.jsp">
                        Sign up</a></h4>
                <% String error = (String) request.getAttribute("error"); %>

                <p id="error"
                        <% if (error != null) { %>
                   style="display: block"
                        <% }%>
                >
                    <%= error != null ? error : "" %>
                </p>
                <input type="submit" value="Log in">
            </form>
        </div>
        <div class="poster__img">
            <img src="img/zieloLogin.png" alt="">
        </div>
    </div>

    <script type="text/javascript" src="js/checkConfirmAndShowPassword.js"></script>
    <script type="text/javascript" src="js/validateForm.js"></script>

    </body>
</html>
