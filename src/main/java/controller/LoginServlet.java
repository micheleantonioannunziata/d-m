package controller;

import java.io.*;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Ordine;
import model.OrdineDAO;
import model.Utente;
import model.UtenteDAO;

@WebServlet(name = "loginServlet", value = "/login-servlet")
public class LoginServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        UtenteDAO service = new UtenteDAO();
        String address = "";

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Utente utente = service.doRetrieveByUsernamePassword(username, password);

        if (utente == null) {
            request.setAttribute("error", "credenziali sbagliate");
            address = "login.jsp";
        }
        else {
            OrdineDAO ordineService = new OrdineDAO();
            List<Ordine> ordiniUtente = ordineService.doRetrieveByUser(utente.getId());

            // aggiungi bean
            request.getSession().setAttribute("utente", utente);
            request.getSession().setAttribute("ordiniUtente", ordiniUtente);
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