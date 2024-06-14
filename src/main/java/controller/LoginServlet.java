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

@WebServlet(name = "loginServlet", value = "/login-servlet")
public class LoginServlet extends HttpServlet {

    /*  doGet non ajax
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        UtenteDAO service = new UtenteDAO();
        String errorMessage = "";
        JSONObject object = new JSONObject();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean exists = service.existsByUsername(username);


        if (!exists)    errorMessage = "no user";
        else {
            Utente utente = service.doRetrieveByUsernamePassword(username, password);

            if (utente == null) errorMessage = "wrong password";
            else    request.getSession().setAttribute("utente", utente);
        }


        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        object.put("errorMessage", errorMessage);

        out.println(object);
        out.flush();
    } */

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        UtenteDAO service = new UtenteDAO();
        String address = "";

        CarrelloDAO carrelloDAO = new CarrelloDAO();
        ProdottoDAO prodottoDAO = new ProdottoDAO();

        List<Prodotto> prodottiCarrello = new ArrayList<>();
        List<Carrello> carrelloList = new ArrayList<>();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean exists = service.existsByUsername(username);

        if (!exists) {
            request.setAttribute("error", "no user");
            address = "login.jsp";
        }
        else {
            Utente utente = service.doRetrieveByUsernamePassword(username, password);
            if (utente == null) {
                request.setAttribute("error", "password wrong");
                address = "login.jsp";
            }
            else {
                // aggiungi bean

                //prendo tutti i possibili prodotti che l'utente da non loggato ha inserito nel carrello
                List<Prodotto> prodottiNonLoggato = (List<Prodotto>) request.getSession().getAttribute("carrello");
                request.getSession().setAttribute("utente", utente);
                address = "userArea.jsp";

                //prendo tutto il carrello dal database dell'utente loggato
                carrelloList = carrelloDAO.doRetrieveById(utente.getId());

                //prendo tutte le info dei prodotti che ci sono nel carrello e li inserisco in una lista di prodotti
                for(int i=0; i < carrelloList.size(); i++){
                    Carrello carrello = carrelloList.get(i);
                    Map<String, Integer> tagliaQuantita = new HashMap<>();
                    tagliaQuantita.put(carrello.getTaglia(),carrello.getQuantita());
                    prodottiCarrello.add(prodottoDAO.doRetrieveByIdWithoutMap(carrello.getIdProdotto()));
                    Prodotto prodotto = prodottiCarrello.get(i);
                    prodotto.setTaglieQuantita(tagliaQuantita);
                }

                //se l'utente da non loggato ha inserito qualcosa nel carrello allora questi prodotti vanno inseriti
                if(prodottiNonLoggato != null && !prodottiNonLoggato.isEmpty()){
                    prodottiCarrello.addAll(prodottiNonLoggato);
                }

                //se il carrello di quest'utente non è vuoto allora inserisco il carrello nella sessione
                if(prodottiCarrello != null && !prodottiCarrello.isEmpty()){
                    request.getSession().setAttribute("carrello",prodottiCarrello);
                }
            }
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