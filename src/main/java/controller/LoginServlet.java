package controller;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;
import org.json.simple.JSONObject;

@WebServlet("/login-servlet")
public class LoginServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        UtenteDAO service = new UtenteDAO();
        String address = "";

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String error = SignUpServlet.checkInputValue(username, "", password, "");

        // controlla valori dell'input
        if (!error.isEmpty()) {
            address = "login.jsp";
            request.setAttribute("error", error);
        }

        // verifica esistenza utente dall'username
        else if (!new UtenteDAO().existsByUsername(username)) {
            request.setAttribute("error", "no user");
            address = "login.jsp";
        }
        else {

            // verifica password dell'utente
            Utente utente = service.doRetrieveByUsernamePassword(username, password);
            if (utente == null) {
                request.setAttribute("error", "password wrong");
                address = "login.jsp";
            }
            else {
                // aggiungi bean
                request.getSession().setAttribute("utente", utente);
                address = "redirectToUserArea";

                CarrelloDAO carrelloDAO = new CarrelloDAO();

                // considera carrello attuale
                List<Prodotto> carrello = (List<Prodotto>) request.getSession().getAttribute("carrello");

                // considera carrello nel db
                List<Carrello> carrelloDB = carrelloDAO.doRetrieveByUtente(utente.getId_Utente());

                if (carrello == null)   carrello = new ArrayList<>();

                // se il carrello attuale è vuoto, carica ciò che sta nel db (se esiste)
                if (carrello.isEmpty() && !carrelloDB.isEmpty()) {

                    // richiama funziona di CartHandler
                    CartHandlerServlet.loadOldCart(carrelloDB, carrello);

                    request.getSession().setAttribute("carrello", carrello);
                }

                // se entrambi sono non vuoti
                else if (!carrello.isEmpty() && !carrelloDB.isEmpty()){

                    // fai scegliere all'utente quale carrello considerare (inserisco l'attributo che sarà riempito in overview.jsp)
                    request.setAttribute("loadCart", "choose");
                }
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(address);
        dispatcher.forward(request, response);
    }

    public void destroy() {
    }
}