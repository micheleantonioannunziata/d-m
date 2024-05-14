<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign up</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<form action="signup-servlet" method="post">
    <input type="text" name="username" placeholder="username" required>
    <input type="text" name="email" placeholder="email" required>
    <input type="password" name="password" placeholder="password" required>
    <input type="submit" value="Go">
    ${error}
</form>
</body>
</html>
