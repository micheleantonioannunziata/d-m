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
    boolean isProductAlreadyInCart(List<Prodotto> carrello, Prodotto p){
        if (carrello.isEmpty()) return false;
        for (Prodotto prodotto: carrello) {
            Map<String, Integer> taglieQuantitaCarrProd = prodotto.getTaglieQuantita();
            Map<String, Integer> taglieQuantitaP = p.getTaglieQuantita();
            Map.Entry<String, Integer> firstEntryCarrProd = taglieQuantitaCarrProd.entrySet().iterator().next();
            Map.Entry<String, Integer> firstEntryP = taglieQuantitaP.entrySet().iterator().next();
            if (prodotto.getId() == p.getId() && firstEntryP.equals(firstEntryCarrProd))
                return true;
        }
        return false;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Prodotto> carrello = (List<Prodotto>) req.getSession().getAttribute("carrello");

        if (carrello == null)
            carrello = new ArrayList<>();

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        int id = Integer.parseInt(req.getParameter("idProdotto"));
        Prodotto p = prodottoDAO.doRetrieveById(id);

        String taglia = req.getParameter("taglia");
        int quantita = Integer.parseInt(req.getParameter("quantita"));

        // se viene passato una taglia non valida dobbiamo capire come gestire gli errori
        Map<String, Integer> tagliaQuantita = new HashMap<>();
        tagliaQuantita.put(taglia, quantita);
        p.setTaglieQuantita(tagliaQuantita);

        if (!isProductAlreadyInCart(carrello, p)) {
            System.out.println(!isProductAlreadyInCart(carrello, p));
            carrello.add(p);
        }

        req.getSession().setAttribute("carrello", carrello);

        RequestDispatcher dispatcher = req.getRequestDispatcher("myCart.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
