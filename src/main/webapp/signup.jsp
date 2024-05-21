<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign up</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="poster" id="loginSection">
    <div class="poster__content">
        <div class="logo mid-text">
            <a href="index.jsp">D<span class="normal-text">&</span>M</a>
        </div>

        <form action="signup-servlet" method="post">
            <div class="input">
                <img src="img/users.png">
                <input type="text" name="username" required placeholder="Username">
            </div>
            <div class="input">
                <img src="img/mail.png">
                <input type="email" name="email" required placeholder="Email">
            </div>
            <div class="input">
                <img src="img/unlock.png">
                <input type="password" id="password" name="password" required  placeholder="Password">
            </div>
            <div class="input">
                <img src="img/check-square.png">
                <input type="password" id = "confirmPassword" name="confirmPassword" required  placeholder="Confirm Password">
            </div>

            <h4 class="small-text">Have you already an account?
                <a href="login.jsp">Log in</a>
            </h4>

            <% String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
            <p><%= error %></p>
            <%}%>

            <input type="submit" value="Sign up" id = "submitBtn">
        </form>
    </div>
    <div class="poster__img" style="width: 50%">
        <img src="img/zieloSignUp.png" alt="">
    </div>
</div>
<script type="text/javascript" src="js/checkConfirmPassword.js"></script>
</body>
</html>
