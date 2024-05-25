document.addEventListener('DOMContentLoaded', () => {
    const zoomImage = document.querySelector('#overviewSection.poster .poster__img img.zoom-image');
    const posterImg = document.querySelector('#overviewSection.poster .poster__img');

    posterImg.addEventListener('mousemove', (e) => {
        const rect = posterImg.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;

        const xPercent = (x / rect.width) * 100;
        const yPercent = (y / rect.height) * 100;

        zoomImage.style.transformOrigin = `${xPercent}% ${yPercent}%`;
        zoomImage.style.transform = 'scale(1.5)'; // Imposta il livello di zoom desiderato
    });

    posterImg.addEventListener('mouseleave', () => {
        zoomImage.style.transform = 'scale(1)';
        zoomImage.style.transformOrigin = 'center center';
    });
});