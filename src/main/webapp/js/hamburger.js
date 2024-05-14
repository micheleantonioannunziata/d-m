// codice eseguito al caricamento della pagina
document.addEventListener("DOMContentLoaded", function() {

    // seleziona elemento .hamburger
    let hamburger = document.querySelector(".hamburger");

    // aggiungi listenere al click
    hamburger.addEventListener("click", function() {
        // seleziona elemento .menuBar
        let menuBar = document.querySelector(".menuBar");

        // toggleClass menu--open
        if (menuBar.classList.contains("menu--open")) {
            menuBar.classList.remove("menu--open");
            hamburger.classList.remove("active");
        }
        else {
            menuBar.classList.add("menu--open");
            hamburger.classList.add("active");
        }
    });
});