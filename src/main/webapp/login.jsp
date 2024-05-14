<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<section class="container">
    <form action="login-servlet" method="post">
        <input type="text" name="username" required placeholder="Username">
        <input type="password" name="password" required  placeholder="Password">
        <input type="submit" value="Log in">
        ${error}
    </form>
    <div class="gap"></div>
    <div class="image"></div>
</section>
</body>
</html>
