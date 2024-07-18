 function containsSpecialCharactersOrNumbers(str) {
        const pattern = /[^a-zA-Z\s]/;
        return pattern.test(str);
}

// gestione errori input lato client
 function validateForm() {
     const username = document.getElementById("username").value;
     const email = document.getElementById("email") || null;
     const password = document.getElementById("password").value;
     const confirmPassword = document.getElementById("confirmPassword") || null;

     const error = document.getElementById("error");

     let flag = true;
     let errorMsg = '';

     if (confirmPassword !== null && password !== confirmPassword.value) {
         errorMsg = "Le password non coincidono";
         flag = false;
     }

     else if (password.length < 6 || password.length > 20 || !containsSpecialCharactersOrNumbers(password)) {
         errorMsg = "Password non valida";
         flag = false;
     }

     else if (email !== null && !email.value.includes("@")) {
         errorMsg = "Email non valida";
         flag = false;
     }

     else if (username.length < 5 || username.length > 20) {
         errorMsg = "Username non valido";
         flag = false;
     }

     if (!flag) {
         error.style.display = 'block';
         error.innerHTML = errorMsg;
     }

     return flag;
 }