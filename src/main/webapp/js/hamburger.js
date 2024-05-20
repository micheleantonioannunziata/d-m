// codice eseguito al caricamento della pagina
document.addEventListener("DOMContentLoaded", function() {

    // seleziona elemento .hamburger
    let hamburger = document.querySelector(".hamburger");

    hamburger.addEventListener("click", function () {
        let menuBar = document.querySelector(".menuBar");
        menuBar.classList.toggle("menu--open");
        hamburger.classList.toggle("active");
    })

    // al click di un elemento del menu, chiudi il menu
    let menuItems = document.querySelectorAll(".menuBar li a");
    menuItems.forEach(function(item) {
        item.addEventListener("click", function() {
            let menuBar = document.querySelector(".menuBar");
            menuBar.classList.remove("menu--open");
            hamburger.classList.remove("active");
        });
    });
});