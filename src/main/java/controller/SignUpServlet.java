package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.OrdineDAO;
import model.Utente;
import model.UtenteDAO;

import java.io.IOException;

@WebServlet(name = "signUpServlet", value = "/signup-servlet")
public class SignUpServlet extends HttpServlet {

    public static boolean containsSpecialCharactersOrNumbers(String str) {
        for (char c : str.toCharArray())
            if (!Character.isLetter(c) && !Character.isWhitespace(c))
                return true; // trovato un carattere non lettera e non spazio bianco

        return false; // nessun carattere speciale o numero trovato
    }

    public static String checkInputValue(String username, String email, String password, String confirmPassword) {

        // effettua controlli
        if (confirmPassword != null && !confirmPassword.isEmpty() && !password.equals(confirmPassword))
            return "le password non coincidono";

        else if (password.length() < 6 || password.length() > 20 ||
                !containsSpecialCharactersOrNumbers(password))
            return  "password non valida";

        else if (email != null && !email.isEmpty() && !email.contains("@"))
            return "email non valida";

        else if (username.length() < 5 || username.length() > 20)
            return "username non valido";

        return "";
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Utente utente = new Utente();
        UtenteDAO service = new UtenteDAO();
        String address;

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        String error = checkInputValue(username, email, password, confirmPassword);

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            address = "signup.jsp";
        }

        // verifica esistenza utente
        else if (new UtenteDAO().existsByUsername(username)) {
            request.setAttribute("error", "utente già esistente");
            address = "signup.jsp";
        }

        // se tutto va bene
        else {
            utente.setUsername(username);
            utente.setEmail(email);
            utente.setPassword(password);
            service.doSave(utente);

            request.getSession().setAttribute("utente", utente);
            address = "WEB-INF/userArea.jsp";
        }

        // ridirotta
        RequestDispatcher dispatcher = request.getRequestDispatcher(address);
        dispatcher.forward(request, response);
    }

    public void destroy() {
    }
}
