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

@WebServlet(name = "redirectToUserArea", value = "/redirectToUserArea")
public class RedirectToUserArea extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // cattura bean utente
        Utente u = (Utente) req.getSession().getAttribute("utente");

        OrdineDAO ordineDAO = new OrdineDAO();
        ProdottoDAO prodottoDAO = new ProdottoDAO();

        // prendi gli ordini dell'utente
        List<Ordine> ordini = ordineDAO.doRetrieveByUser(u.getId_Utente());

        // crea map con chiave: id_ordine e valore: lista con tutti i prodotti di quell'ordine
        Map<Integer, List<Prodotto>> ordiniProdottiMap = new HashMap<>();

        // crea map con chiave: id_ordine e valore: prezzo ordine
        Map<Integer, Double> ordiniPrezziMap = new HashMap<>();

        for (Ordine o : ordini) {
            // ottieni prodotto dell'ordine senza taglia e quantità
            Prodotto p = prodottoDAO.doRetrieveByIdWithoutMap(o.getProdotto());

            // aggiorna map taglia quantità in base alle informazioni dell'ordine
            Map<String, Integer> tQ = p.getTaglieQuantita();
            tQ.put(o.getTaglia(), o.getQuantita());
            p.setTaglieQuantita(tQ);

            // se l'id dell'ordine attuale non esiste nella map esegue la lamba expression (che restituisce una lista vuota),
            // altrimenti restituisce la lista associata a quell'id nella map,
            // e successivamente aggiunge alla lista il prodotto
            ordiniProdottiMap.computeIfAbsent(o.getID_Ordine(), k -> new ArrayList<>())
                    .add(p);

            // aggiungi prezzo se non c'è nel map
            if (!ordiniPrezziMap.containsKey(o.getID_Ordine()))
                ordiniPrezziMap.put(o.getID_Ordine(), o.getPrezzo());
            // altrimenti aggiornalo
            else
                ordiniPrezziMap.put(o.getID_Ordine(), ordiniPrezziMap.get(o.getID_Ordine()) + o.getPrezzo());
        }

        // metti nella request
        req.setAttribute("ordiniProdottiMap", ordiniProdottiMap);
        req.setAttribute("ordiniPrezziMap", ordiniPrezziMap);

        // ridirotta
        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/userArea.jsp");
        dispatcher.forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
