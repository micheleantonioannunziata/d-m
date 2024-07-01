<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/footer.css">
</head>
<body>

<style>
    .poster#aboutSection{
        height: 85vh;
        margin-top: 15vh;
        align-items: center;
    }

    .poster#aboutSection .poster__content h3{
        text-transform: uppercase;
    }

    .poster#aboutSection .poster__content p {
        margin-top: 12%;
    }

    .poster#aboutSection .poster__img img{height: 100%}

    #wallpaper{
        height: 130vh;
        width: 100%;
        position: relative;
    }
    #wallpaper img{
        object-fit: cover;
        height: 100%;
        width: 100%;
        position: absolute;
        z-index: 0;
    }

    #wallpaper h1{
        position: absolute;
        z-index: 1;
        padding: 0 3%;
        text-transform: uppercase;
        bottom: 10%;
    }

    @media only screen and (max-width: 800px) {
        .poster#aboutSection .poster__content { width: 100%; }
        .poster#aboutSection .poster__img{ display: none}
    }

</style>

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
        <img src="img/zieloAbout.jpg" alt="">
    </div>
</div>


<div id="wallpaper">
    <img src="img/sportswear.png" alt="">

    <h1 class="big-text white">Your Journey to Victory Starts Here</h1>
</div>

<%@include file="WEB-INF/modules/footer.jsp"%>
</body>
</html>
