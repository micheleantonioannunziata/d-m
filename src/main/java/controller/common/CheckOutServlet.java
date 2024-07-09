package controller.common;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Ordine;
import model.OrdineDAO;
import model.Prodotto;
import model.Utente;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "checkOutServlet", value = "/checkOut-servlet")
public class CheckOutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utente u = (Utente) req.getSession().getAttribute("utente");

        String address = "";

        if (u == null) {
            // se non è loggato non può fare l'ordine
            address = "login.jsp";

            req.setAttribute("error", "check out not valid for unlogged user");
        } else {
            List<Prodotto> carrello = (List<Prodotto>) req.getSession().getAttribute("carrello");
            OrdineDAO ordineDAO = new OrdineDAO();

            // prendi ultimo id
            int idOrdine = (int) getServletContext().getAttribute("lastIdOrdine");

            ++idOrdine;

            // scorri carrello
            for (Prodotto p: carrello)
                for (Map.Entry<String, Integer> entry: p.getTaglieQuantita().entrySet()) {
                    Ordine o = new Ordine();

                    o.setIdOrdine(idOrdine);
                    o.setIdProdotto(p.getId_Prodotto());
                    o.setIdUtente(u.getId_Utente());
                    o.setTaglia(entry.getKey());
                    o.setQuantita(entry.getValue());

                    // aggiungi tupla ordine
                    // il prezzo viene generato in teoria dal trigger
                    ordineDAO.doSave(o);
                }

            // aggiorna idOrdine nella servlet context
            getServletContext().setAttribute("lastIdOrdine", idOrdine);

            // svuota carrello
            req.getSession().removeAttribute("carrello");

            address = "WEB-INF/modules/correctCheckOut.jsp";
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher(address);
        dispatcher.forward(req, resp);
    }
}
