package controller.common;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "loginServlet", value = "/cartHandler-servlet")
public class CartHandlerServlet extends HttpServlet {

    public static void loadOldCart(List<Carrello> carrelloDB, List<Prodotto> carrello) {
        ProdottoDAO prodottoDAO = new ProdottoDAO();

        // per ogni istanza di carrello (riga nella tabella sql di quell'utente)
        for (Carrello c : carrelloDB) {

            // cattura info del prodotto
            Prodotto p = prodottoDAO.doRetrieveByIdWithoutMap(c.getIdProdotto());

            // gestisci aggiunta

            AddToCart.addProductToCart(p, carrello, c.getTaglia(), c.getQuantita());
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // ottieni parametro dalla richiesta
        String loadOld = (String) request.getParameter("loadOld");

        // ottieni bean dalla sessione
        Utente utente = (Utente) request.getSession().getAttribute("utente");

        // se è stato scelto il carrello vecchio
        if (utente != null && loadOld != null && loadOld.equalsIgnoreCase("true")) {

            CarrelloDAO carrelloDAO = new CarrelloDAO();

            // lista di prodotti vuota
            List<Prodotto> carrello = new ArrayList<>();

            // ottieni carrello db
            List<Carrello> carrelloDB = carrelloDAO.doRetrieveByUtente(utente.getId_Utente());

            // richiama funziona per caricare il vecchio carrello
            loadOldCart(carrelloDB, carrello);

            // aggiorna carrello in sessione
            request.getSession().setAttribute("carrello", carrello);
        }

        // ridirotta
        RequestDispatcher dispatcher = request.getRequestDispatcher("redirectToUserArea");
        dispatcher.forward(request, response);

    }
}
