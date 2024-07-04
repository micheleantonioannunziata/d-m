package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import model.*;

import java.util.List;

// servlet con priorità maggiore, viene inizializzata prima di tutte le altre
@WebServlet(name = "loadDataOnServletContext", value = "/loadData-servletContext", loadOnStartup = 0)
public class LoadDataOnServletContext extends HttpServlet {

    public void init() {
        // inserisci taglie nella servlet context
        TagliaDAO tagliaService = new TagliaDAO();
        List<Taglia> taglie = tagliaService.doRetrieveAll();
        getServletContext().setAttribute("taglie", taglie);

        // inserisci squadre nella servlet context
        SquadraDAO squadraDAO = new SquadraDAO();
        List<Squadra> squadre = squadraDAO.doRetrieveAll();
        getServletContext().setAttribute("squadre", squadre);

        // inserisci l'id dell'ultimo ordine
        OrdineDAO ordineDAO = new OrdineDAO();
        getServletContext().setAttribute("lastIdOrdine", ordineDAO.doRetrieveMaxID_Ordine());

        System.out.println(getServletContext().getAttribute("lastIdOrdine"));
    }
}
