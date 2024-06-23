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

</body>
</html>