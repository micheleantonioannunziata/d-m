<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/about.css">
</head>
<body>

<%@include file="WEB-INF/modules/header.jsp"%>

<div class="poster" id = "aboutSection">
    <div class="poster__content">
        <h3 class="big-text stroke">About us</h3>
        <p class="small-text">
            A huge assortment of sport equipment from all most popular brands,
            professional service and attractive prices made that we are the first choice
            for a thousand of football fans. Our store is suited for everyone.
            <br><br>
            We try to be as close to the football players as it is possible
            – we want to be not only a store, but a good playmate for professional, semi-professionals,
            amateurs and the youngest players. At least, we know each other because of football.
        </p>
    </div>
    <div class="poster__img">
        <img src="img/zieloAbout.jpg" alt="zielo free kick">
    </div>
</div>


<div id="wallpaper">
    <img src="img/sportswear.png" alt="leao, theo, musah">

    <h1 class="big-text white">Your Journey to Victory Starts Here</h1>
</div>

<%@include file="WEB-INF/modules/footer.jsp"%>
</body>
</html>
