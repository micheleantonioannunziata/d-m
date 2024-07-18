<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D&M</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/header.css">
</head>

<script type="text/javascript" src="js/redirectFilter.js"></script>

<body>

<!-- inserimento header -->
<%@include file="WEB-INF/modules/header.jsp" %>

<!-- hero section -->
<div id="hero">
    <div class="white z2">
        <span class="big-text upp stroke" style="max-width: 30%;">get in <br>the game</span> <br><br>
        <span class="small-text">What you need!</span>
    </div>

    <img src="img/heroBackground.png" alt="Anthony and football friends">
</div>

<div class="poster" id = "fanZoneSection">
    <div class="poster__content">
        <h3 class="big-text stroke">Fan Zone</h3>
        <p class="small-text">
            Get ready to dive into the ultimate hub for football fans!
            You'll find everything you need to fuel your passion for the beautiful game.
        <br><br>
            Whether you're cheering for your favourite team or celebrating the latest victories,
            join us as we unite fans from around the world in the thrilling world of football fandom!
        </p>
        <a href="fanZone.jsp"><button>Explore</button></a>
    </div>
    <div class="poster__img">
        <img src="img/fanZoneSection.png" alt="Cristiano Ronaldo">
    </div>
</div>

<div class="panels">

    <div class="panel">
        <img src="img/nikeMDS.png" alt="Nike MDS">

        <div class="text">
            <h2 class="mid-text white">Nike MDS</h2>
            <h4 class="small-text white">Elevate your game on the pitch!</h4>
            <button class="small-text"
                    data-value="Nike Mercurial"
                    onclick="redirectFilter(this, 'Scarpa', 'collezione')"
            >Go now</button>
        </div>
    </div>

    <div class="panel">
        <img src="img/uefaEuro2024.png" alt="Uefa Euro 2024">
        <div class="text">
            <h2 class="mid-text white">UEFA Euro 2024</h2>
            <h4 class="small-text white">Unleash your skills with engineering!</h4>

            <!-- data-value serve alla funzione chiamata al click del button -->
            <button class="small-text"
                    data-value ="Euro 2024"
                    onclick="redirectFilter(this, 'All', 'collezione')"
            >Go now</button>
        </div>
    </div>

</div>


<div class="writing">
    <h1 class="big-text">Stay Ahead of the Game</h1>
    <h2 class="mid-text">Explore the Latest Football News</h2>
</div>

<!-- inclusione footer -->
<%@include file="WEB-INF/modules/footer.jsp" %>

</body>
</html>