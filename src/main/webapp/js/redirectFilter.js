function redirectFilter(card) {
    const squadra = card.getAttribute("data-squadra");
    window.location.href = `gridItemByFilter.jsp?tipologia=Maglia&squadra=${encodeURIComponent(squadra)}`;
}