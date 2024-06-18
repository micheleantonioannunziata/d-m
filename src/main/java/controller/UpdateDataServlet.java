package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@WebServlet(name = "UpdateDataServlet",value = "/update-data")
public class UpdateDataServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String tabella = req.getParameter("tabella");
        List<String> paramNames = Collections.list(req.getParameterNames());

        List<String> newValues = new ArrayList<>(), oldValues = new ArrayList<>();

        for (String param: paramNames)
            if (param.startsWith("old"))    oldValues.add(param); //in old ci saranno le chiavi
            else newValues.add(param);

        switch (tabella.toLowerCase()) {
            case "prodotti" -> {
                ProdottoDAO prodottoDAO = new ProdottoDAO();
                Prodotto p = new Prodotto();

                // parto da 1 perché il primo è tabella
                p.setId(Integer.parseInt(req.getParameter(oldValues.get(0))));
                p.setNome(req.getParameter(newValues.get(1)));
                p.setPrezzo(Double.parseDouble(req.getParameter(newValues.get(2))));
                p.setTipologia(req.getParameter(newValues.get(3)));
                p.setSquadra(req.getParameter(newValues.get(4)));
                p.setProduttore(req.getParameter(newValues.get(5)));
                p.setCollezione(req.getParameter(newValues.get(6)));
                p.setCollezione(req.getParameter(newValues.get(7)));

                prodottoDAO.doUpdate(p, Integer.parseInt(req.getParameter(oldValues.get(0))));
            }
            case "squadre" -> {
                SquadraDAO squadraDAO = new SquadraDAO();
                Squadra s = new Squadra();

                // parto da 1 perché il primo è tabella
                s.setNome(req.getParameter(newValues.get(1)));

                s.setUrlImmagine(req.getParameter(newValues.get(2))); // setta url

                squadraDAO.doUpdate(s, req.getParameter(oldValues.get(0)));

                // aggiorna servletContext
                List<Squadra> squadre = (List<Squadra>) getServletContext().getAttribute("squadre");
                squadre.add(s);
                getServletContext().setAttribute("squadre", squadre);
            }
            case "taglie" -> {
                TagliaDAO tagliaDAO = new TagliaDAO();
                Taglia t = new Taglia();

                // parto da 1 perché il primo è tabella
                t.setTaglia(req.getParameter(newValues.get(1)));
                t.setTipologia(req.getParameter(newValues.get(2)));
                if (!req.getParameter(newValues.get(3)).isEmpty() && !req.getParameter(newValues.get(3)).equalsIgnoreCase("null"))
                    t.setDescrizione(req.getParameter(newValues.get(3)));

                tagliaDAO.doUpdate(t, req.getParameter(oldValues.get(0)));

                // aggiorna servletContext
                List<Taglia> taglie = (List<Taglia>) getServletContext().getAttribute("taglie");
                taglie.add(t);
                getServletContext().setAttribute("taglie", taglie);
            }

            case "utenti" -> {
                Utente u = new Utente();
                UtenteDAO utenteDAO = new UtenteDAO();

                // parto da 1 perché il primo è tabella
                u.setId(Integer.parseInt(req.getParameter(oldValues.get(0))));
                u.setUsername(req.getParameter(newValues.get(1)));
                u.setEmail(req.getParameter(newValues.get(2)));
                u.setPassword(req.getParameter(newValues.get(3)));

                if(req.getParameter("isAdmin") != null) // se admin è stato selezionato
                    u.setAdmin(req.getParameter("isAdmin").equalsIgnoreCase("on"));
                else u.setAdmin(false);

                utenteDAO.doUpdate(u, Integer.parseInt(req.getParameter(oldValues.get(0))));
            }
            case "prodottitaglie" -> {
                ProdottoTaglie prodottoTaglie = new ProdottoTaglie();
                ProdottoTaglieDAO prodottoTaglieDAO = new ProdottoTaglieDAO();

                prodottoTaglie.setIdProdotto(Integer.parseInt(req.getParameter(newValues.get(1))));
                prodottoTaglie.setTaglia(req.getParameter(newValues.get(2)));
                prodottoTaglie.setQuantita(Integer.parseInt(req.getParameter(newValues.get(3))));

                prodottoTaglieDAO.doUpdate(prodottoTaglie,
                        Integer.parseInt(req.getParameter(oldValues.get(0))),
                        req.getParameter(oldValues.get(1)));
            }
            case "ordini" -> {
                Ordine o = new Ordine();
                OrdineDAO ordineDAO = new OrdineDAO();

                // parto da 1 perché il primo è tabella
                o.setIdOrdine(Integer.parseInt(req.getParameter(newValues.get(1))));
                o.setIdUtente(Integer.parseInt(req.getParameter(newValues.get(2))));
                o.setIdProdotto(Integer.parseInt(req.getParameter(newValues.get(3))));
                o.setTaglia(req.getParameter(newValues.get(4)));
                o.setQuantita(Integer.parseInt(req.getParameter(newValues.get(5))));
                if (!req.getParameter(newValues.get(6)).isEmpty() && !req.getParameter(newValues.get(6)).equalsIgnoreCase("0.00"))
                    o.setPrezzo(Double.parseDouble(req.getParameter(newValues.get(3))));

                ordineDAO.doUpdate(o,
                        Integer.parseInt(req.getParameter(oldValues.get(0))),
                        Integer.parseInt(req.getParameter(oldValues.get(1))),
                        Integer.parseInt(req.getParameter(oldValues.get(2))),
                        req.getParameter(oldValues.get(3)));
            }

        }

        resp.sendRedirect("admin-servlet");
    }

}
