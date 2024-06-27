function redirectFilter(arg, tipologia, criteria) {
    const value = arg.getAttribute("data-value");
    window.location.href =
        `gridItemByFilter.jsp?tipologia=${encodeURIComponent(tipologia)}&${encodeURIComponent(criteria)}=${encodeURIComponent(value)}`;
}