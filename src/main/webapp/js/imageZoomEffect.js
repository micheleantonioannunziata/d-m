document.addEventListener('DOMContentLoaded', () => {
    // cattura elementi
    const zoomImage = document.querySelector('#overviewSection.poster .poster__img img.zoom-image');
    const posterImg = document.querySelector('#overviewSection.poster .poster__img');

    // aggiungi funzione all'evento
    posterImg.addEventListener('mousemove', (e) => {
        const rect = posterImg.getBoundingClientRect(); // dimensione totale
        const x = e.clientX - rect.left; // posiziona mouse asse ascisse
        const y = e.clientY - rect.top;

        // calcola percentuale
        const xPercent = (x / rect.width) * 100;
        const yPercent = (y / rect.height) * 100;

        // tranform in base alle percentuale
        zoomImage.style.transformOrigin = `${xPercent}% ${yPercent}%`; // imppsta il punto di origine del zoom in base alle coordinate del mouse
        zoomImage.style.transform = 'scale(1.5)'; // imposta il livello di zoom desiderato
    });

    posterImg.addEventListener('mouseleave', () => {
        zoomImage.style.transform = 'scale(1)';
        zoomImage.style.transformOrigin = 'center center';
    });
});