// codice eseguito al caricamento della pagina

function hamburgerToggle() {
    // cattura elementi
    let hamburger = document.querySelector(".hamburger");
    let menuBar = document.querySelector("header ul.menuBar");

    menuBar.classList.toggle("menu--open");
    // diventa una X
    hamburger.classList.toggle("active");
}