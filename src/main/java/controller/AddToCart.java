package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AddToCart", value = "/addToCart-servlet")
public class AddToCart extends HttpServlet {

    // bisogna rivedere sta cosa che non funzione, adesso però è tardi non ce la faccio più
    Prodotto isProductAlreadyInCart(List<Prodotto> carrello, int id){
        if (carrello.isEmpty())     return null;

        for (Prodotto prodotto: carrello)
            if (prodotto.getId_Prodotto() == id)      return prodotto;

        return null;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Prodotto> carrello = (List<Prodotto>) req.getSession().getAttribute("carrello");

        if (carrello == null)
            carrello = new ArrayList<>();

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        int id = Integer.parseInt(req.getParameter("idProdotto"));
        Prodotto p = prodottoDAO.doRetrieveByIdWithoutMap(id);

        String taglia = req.getParameter("taglia");
        int quantita = Integer.parseInt(req.getParameter("quantita"));

        // se viene passato una taglia non valida dobbiamo capire come gestire gli errori

        Map<String, Integer> tagliaQuantita = new HashMap<>();
        Prodotto prod = isProductAlreadyInCart(carrello, id);

        // se già sta nel carrello, considera la sua map
        if (prod != null) {
            carrello.remove(prod);
            tagliaQuantita = prod.getTaglieQuantita();
        }

        // aggiungi entry - se già esiste quella taglia la modifica da solo
        tagliaQuantita.put(taglia, quantita);

        // aggiungi al carrello
        p.setTaglieQuantita(tagliaQuantita);
        carrello.add(p);

        req.getSession().setAttribute("carrello", carrello);

        RequestDispatcher dispatcher = req.getRequestDispatcher("myCart.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
