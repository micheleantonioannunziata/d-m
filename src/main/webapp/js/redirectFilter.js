function redirectFilter(button, tipologia, criteria) {

    // cattura valore dell'attributo data del button passato
    const value = button.getAttribute("data-value");

    window.location.href =
        `gridItemByFilter.jsp?tipologia=${encodeURIComponent(tipologia)}&${encodeURIComponent(criteria)}=${encodeURIComponent(value)}`;
}