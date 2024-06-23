document.addEventListener('DOMContentLoaded', function() {
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    const submitBtn = document.getElementById('submitBtn');
    const eyePassword = document.getElementById('eyePassword');
    const eyePasswordConfirm = document.getElementById('eyeConfirmPassword');

    function validatePasswords() {
        const password = passwordInput.value;
        const confirmPassword = confirmPasswordInput.value;

        // se non sono vuote e se sono uguali
        if (password && confirmPassword && password === confirmPassword)
            submitBtn.disabled = false; // abilita
        else    submitBtn.disabled = true;
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

    passwordInput?.addEventListener('input', validatePasswords);
    confirmPasswordInput?.addEventListener('input', validatePasswords);

    eyePassword?.addEventListener('click', function() {
        togglePasswordVisibility(passwordInput, eyePassword);
    });

    eyePasswordConfirm?.addEventListener('click', function() {
        togglePasswordVisibility(confirmPasswordInput, eyePasswordConfirm);
    });
});