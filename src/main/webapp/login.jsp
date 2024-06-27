<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
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

            <!-- <form method="post" onsubmit="goToServlet(event)">  con ajax-->
            <form action="login-servlet" method="post">
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
                <!-- <p id="error"></p> con ajax -->
                <% String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                        <p><%= error %></p>
                <%
                        request.removeAttribute("error");
                    }
                %>

                <input type="submit" value="Log in">
            </form>
        </div>
        <div class="poster__img">
            <img src="img/zieloLogin.png" alt="">
        </div>
    </div>
    <script type="text/javascript" src="js/checkConfirmAndShowPassword.js"></script>

    <!-- con ajax
        <script type="text/javascript">
        // dobbiamo decidere se rimanerlo con ajax oppure farlo normalmente
        function goToServlet(event) {
            var xhttp = new XMLHttpRequest();

            event.preventDefault(); // evita comportamento di default del form

            xhttp.onreadystatechange = function() {
                if (this.readyState === 4 && this.status === 200) {

                    // prendi il json scritto dalla servlet
                    const data = JSON.parse(this.responseText);

                    if (data.errorMessage) {
                        let p = document.getElementById("error");
                        p.style.display = "block";
                        p.innerHTML = data.errorMessage;
                    } else {
                        // redirect alla pagina utente se non ci sono errori
                        window.location.href = "userArea.jsp";
                    }
                }
            };

            // apri connessione ed invia richiesta alla servlet
            xhttp.open("POST", `login-servlet`, true);

            let username = document.getElementById("username").value;
            let password = document.getElementById("password").value;
            let params = "username=" + encodeURIComponent(username) + "&password=" + encodeURIComponent(password);

            xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhttp.send(params);
        }
    </script> -->
    </body>
</html>
