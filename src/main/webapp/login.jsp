<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
</head>
    <body>

    <div class="poster" id="loginSection">
        <div class="poster__content">
            <div class="logo mid-text">
                <a href="index.jsp">D<span class="normal-text">&</span>M</a>
            </div>

            <form action="login-servlet" method="post">

                <div class="input">
                    <img src="img/mail.png" alt="">
                    <input type="text" name="username" required placeholder="Username">
                </div>

                <div class="input">
                    <img src="img/unlock.png">
                    <input type="password" name="password" required  placeholder="Password">
                </div>

                <h4 class="small-text">Haven't you an account yet?
                    <a href="signup.jsp">
                        Sign up</a></h4>
                <% String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                    <p><%= error %></p>
                <%}%>
                <input type="submit" value="Log in">
            </form>
        </div>
        <div class="poster__img">
            <img src="img/zieloLogin.png" alt="">
        </div>
    </div>
    </body>
</html>
