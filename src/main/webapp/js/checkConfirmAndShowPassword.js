document.addEventListener('DOMContentLoaded', function() {
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirmPassword') || null;
    const submitBtn = document.getElementById('submitBtn');
    const eyePassword = document.getElementById('eyePassword');
    const eyePasswordConfirm = document.getElementById('eyeConfirmPassword');

    function validatePasswords() {
        const password = passwordInput.value;
        const confirmPassword = confirmPasswordInput.value;

        // se non sono vuote e se sono uguali
        if (confirmPassword !== null && password && confirmPassword && password === confirmPassword) {
            submitBtn.disabled = false; // abilita
            submitBtn.style.cursor = "pointer"; //cambia cursore
        }
        else {
            submitBtn.disabled = true;
            submitBtn.style.cursor = "not-allowed"
        }
    }

    function togglePasswordVisibility(input, icon) {
        if (input.type === "password") {
            input.type = "text";
            icon.src = "img/eyeSlash.svg";
        } else {
            input.type = "password";
            icon.src = "img/eye.svg";
        }
    }

    /*aggiungo eventListener per verificare l'uguaglianza tra password e la sua conferma per capire se disabilitare
      il bottone oppure no (evento catturato ogni volta che modifico qualcosa nel campo input) */

    if (confirmPasswordInput !== null) {
        passwordInput?.addEventListener('input', validatePasswords); //se è null non viene aggiunto
        confirmPasswordInput?.addEventListener('input', validatePasswords);
    }

    //aggiungo eventListener per mostrare e nascondere il testo dell'input e cambiare l'immagine degli occhi
    eyePassword?.addEventListener('click', function() {
        togglePasswordVisibility(passwordInput, eyePassword);
    });

    eyePasswordConfirm?.addEventListener('click', function() {
        togglePasswordVisibility(confirmPasswordInput, eyePasswordConfirm);
    });
});