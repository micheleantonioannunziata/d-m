package controller.common;

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

    public static void addProductToCart(Prodotto p, List<Prodotto> carrello, String taglia, int quantita) {
        Map<String, Integer> tagliaQuantita = new HashMap<>();

        // verifica se già sta nel carrello
        Prodotto prod = isProductAlreadyInCart(carrello, p.getId_Prodotto());


        // se già sta nel carrello
        if (prod != null) {

            // modifica map
            tagliaQuantita = prod.getTaglieQuantita();
            tagliaQuantita.put(taglia, quantita); // considera la sua map
            prod.setTaglieQuantita(tagliaQuantita);
        }

        else {
            // aggiungi al carrello con map aggiornata
            tagliaQuantita.put(taglia, quantita);
            p.setTaglieQuantita(tagliaQuantita);
            carrello.add(p);
        }
    }

    // metodo che verifica che quel prodotto già c'è nel carrello
    public static Prodotto isProductAlreadyInCart(List<Prodotto> carrello, int id){
        if (carrello.isEmpty())     return null;

        for (Prodotto prodotto: carrello)
            // se c'è lo restituisci
            if (prodotto.getId_Prodotto() == id)      return prodotto;

        return null;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ottieni carrello
        List<Prodotto> carrello = (List<Prodotto>) req.getSession().getAttribute("carrello");

        if (carrello == null)
            carrello = new ArrayList<>();

        ProdottoDAO prodottoDAO = new ProdottoDAO();

        // otteini id del prodotto
        int id = Integer.parseInt(req.getParameter("idProdotto"));

        // effettua query
        Prodotto p = prodottoDAO.doRetrieveByIdWithoutMap(id);

        // ottieni taglia e quantità
        String taglia = req.getParameter("taglia");
        int quantita = Integer.parseInt(req.getParameter("quantita"));
        
        addProductToCart(p, carrello, taglia, quantita);

        // aggiorna carrello
        req.getSession().setAttribute("carrello", carrello);

        // ridirotta
        RequestDispatcher dispatcher = req.getRequestDispatcher("myCart.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
