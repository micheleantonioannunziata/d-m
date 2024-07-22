<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign up</title>
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

        <form action="signup-servlet" method="post" onsubmit="return validateForm()">
            <div class="input">
                <img src="img/users.svg">
                <input type="text" id="username" name="username" required placeholder="Username"
                    pattern="[^\s]{5,20}"> <!-- qualsiasi carattere eccetto uno spazio bianco -->
            </div>
            <div class="input">
                <img src="img/mail.svg">
                <input type="email" id="email" name="email" required placeholder="Email"
                    pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2, }$">
            </div>
            <div class="input">
                <img src="img/unlock.svg">
                <!-- da 6 a 20 caratteri, almeno uno deve essere un numero oppure un carattere speciale -->
                <input type="password" id="password" name="password" required  placeholder="Password"
                    pattern="^(?=.*[0-9\W])(?!.*\s)[A-Za-z0-9\W]{6,20}$"> <!-- lookahead positivo, negativo -->
                <img src="img/eye.svg" id="eyePassword" alt="eye">
            </div>
            <div class="input">
                <img src="img/check-square.svg">
                <input type="password" id = "confirmPassword" name="confirmPassword" required  placeholder="Confirm Password"
                       pattern="^(?=.*[0-9\W])(?!.*\s)[A-Za-z0-9\W]{6,20}$">
                <img id="eyeConfirmPassword" src="img/eye.svg" alt="eye">
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

            <input type="submit" value="Create an account" id = "submitBtn">
        </form>
    </div>
    <div class="poster__img" style="width: 50%">
        <img src="img/zieloSignUp.png" alt="zielo-Fish-Man">
    </div>
</div>
<script type="text/javascript" src="js/checkConfirmAndShowPassword.js"></script>
<script type="text/javascript" src="js/validateForm.js">
</script>
</body>
</html>
