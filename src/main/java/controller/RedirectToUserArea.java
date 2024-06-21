package controller;

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
        Utente u = (Utente) req.getSession().getAttribute("utente");

        OrdineDAO ordineDAO = new OrdineDAO();
        ProdottoDAO prodottoDAO = new ProdottoDAO();

        List<Ordine> ordini = ordineDAO.doRetrieveByUser(u.getId_Utente());
        List<Prodotto> prodotti = new ArrayList<>();

        Map<Integer, List<Prodotto>> ordiniProdottiMap = new HashMap<>();

        for (Ordine o : ordini) {
            Prodotto p = prodottoDAO.doRetrieveByIdWithoutMap(o.getProdotto());

            // aggiorna map taglia quantità
            Map<String, Integer> tQ = p.getTaglieQuantita();
            tQ.put(o.getTaglia(), o.getQuantita());
            p.setTaglieQuantita(tQ);

            // se l'id attuale non esiste nella map esegue la lamba expression (che restituisce una lista vuota),
            // altrimenti restituisce la lista associata a quella map,
            // e successivamente aggiunge alla lista il prodotto
            ordiniProdottiMap.computeIfAbsent(o.getID_Ordine(), k -> new ArrayList<>()).add(p);
        }

        req.setAttribute("ordiniProdottiMap", ordiniProdottiMap);

        RequestDispatcher dispatcher = req.getRequestDispatcher("userArea.jsp");
        dispatcher.forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
