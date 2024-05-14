package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Utente;
import model.UtenteDAO;

import java.io.IOException;

@WebServlet(name = "signUpServlet", value = "/signup-servlet")
public class SignUpServlet extends HttpServlet {

    public boolean containsSpecialCharactersOrNumbers(String str) {
        for (char c : str.toCharArray()) {
            if (!Character.isLetter(c) && !Character.isWhitespace(c)) {
                return true; // Trovato un carattere non lettera e non spazio bianco
            }
        }
        return false; // Nessun carattere speciale o numero trovato
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Utente utente = new Utente();
        UtenteDAO service = new UtenteDAO();
        String address = "";

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // effettua controlli
        if (password.length() < 6 || password.length() > 20 ||
                !containsSpecialCharactersOrNumbers(password) || !email.contains("@")
                || username.length() < 5 || username.length() > 20) {
            request.setAttribute("error", "password o username sbagliato");
            address = "signup.jsp";
        }
        else {
            utente.setUsername(username);
            utente.setEmail(email);
            utente.setPassword(password);
            service.doSave(utente);

            request.getSession().setAttribute("utente", utente);
            address = "userArea.jsp";
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(address);
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }

    public void destroy() {
    }
}
