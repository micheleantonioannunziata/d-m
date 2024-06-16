package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Carrello;
import model.CarrelloDAO;
import model.Prodotto;
import model.Utente;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "logOutServlet", value = "/logOut-servlet")
public class LogOutServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        Utente u = (Utente) request.getSession().getAttribute("utente");

        // utente si disconnette
        request.getSession().removeAttribute("utente");

        List<Prodotto> carrello = (List<Prodotto>) request.getSession().getAttribute("carrello");
        request.getSession().removeAttribute("carrello");

        // se ha aggiunto qualcosa nel carrello
        if (carrello != null && !carrello.isEmpty()) {
            CarrelloDAO carrelloDAO = new CarrelloDAO();

            // elimina ciò che stava prima di questo utente
            carrelloDAO.doDeleteByUtente(u.getId_Utente());

            // aggiungi il nuovo carrello
            for (Prodotto p: carrello)
                for (Map.Entry<String, Integer> entry: p.getTaglieQuantita().entrySet()) {
                    Carrello c = new Carrello();

                    c.setIdUtente(u.getId_Utente());
                    c.setIdProdotto(p.getId_Prodotto());
                    c.setTaglia(entry.getKey()); // taglia - chiave
                    c.setQuantita(entry.getValue()); // quantità - valore

                    carrelloDAO.doSave(c);
                }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }
}
