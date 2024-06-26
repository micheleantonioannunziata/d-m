<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D&M</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<%@include file="WEB-INF/modules/header.jsp" %>

<style>
    .panels{    margin-top: 15vh;
        height: 85vh;
        padding: 0 3%;
        display: flex;
        justify-content: space-between;
        column-gap: 30px;}

    .panel{width: 50%;
        height: 70%; position: relative}

    .panel img{width: 100%;
        height: 100%;
        object-fit: cover;
        position: absolute;
        z-index: 0; border-radius: 10px}

    .panel .text {position: absolute; z-index: 1; left: 10%; bottom: 10%}

    .panel .text h2{padding: 20px 0; font-weight: bolder}
    .panel .text h4{padding-bottom: 100px; width: 60% }

    .panel .text button{    padding: 6px 15px;
        font-weight: bold;
        background: white;
        border: none;
        border-radius: 50px;}

    .writing{padding: 0 3%}
    .writing h1{text-transform: uppercase}
    .writing h2{font-weight: normal}

    @media only screen and (max-width: 900px) {
        .panels { flex-direction: column; row-gap: 30px}
        .panel{ width: 100%; }
    }

</style>

<div id="hero">
    <div class="white z2">
        <span class="big-text upp stroke" style="max-width: 30%;">get in <br>the game</span> <br><br>
        <span class="small-text">What you need!</span>
    </div>

    <img src="img/heroBackground.png" alt="">
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
        <button onclick="location.href='fanZone.jsp'">Explore</button>
    </div>
    <div class="poster__img">
        <img src="img/fanZoneSection.png" alt="">
    </div>
</div>

<div class="panels">
    <div class="panel">
        <img src="img/nikeMDS.png" alt="Nike MDS">

        <div class="text">
            <h2 class="mid-text white">Nike MDS</h2>
            <h4 class="small-text white">Elevate your game on the pitch!</h4>
            <button class="small-text">Go now</button>
        </div>
    </div>

    <div class="panel">
        <img src="img/uefaEuro2024.png" alt="Uefa Euro 2024">
        <div class="text">
            <h2 class="mid-text white">UEFA Euro 2024</h2>
            <h4 class="small-text white">Unleash your skills with engineering!</h4>
            <button class="small-text">Go now</button>
        </div>
    </div>
</div>
<div class="writing">
<h1 class="big-text">Stay Ahead of the Game</h1>
<h2 class="mid-text">Explore the Latest Football News</h2>
</div>
</body>
</html>