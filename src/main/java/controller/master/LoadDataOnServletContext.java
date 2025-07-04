package controller.master;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import model.*;

import java.util.Comparator;
import java.util.List;

// servlet con priorità maggiore, viene inizializzata prima di tutte le altre
// inserisce cose nella servlet context (contesto intero dell'applicazione),
// memoria condivisa tra tutti gli utenti, richieste e servlet dell'applicazione
@WebServlet(name = "loadDataOnServletContext", value = "/loadData-servletContext", loadOnStartup = 0)
public class LoadDataOnServletContext extends HttpServlet {

    public void init() {
        // inserisci taglie nella servlet context
        TagliaDAO tagliaService = new TagliaDAO();
        List<Taglia> taglie = tagliaService.doRetrieveAll();

        taglie.sort(Comparator.comparing(Taglia::getTaglia));

        getServletContext().setAttribute("taglie", taglie);

        // inserisci squadre nella servlet context
        SquadraDAO squadraDAO = new SquadraDAO();
        List<Squadra> squadre = squadraDAO.doRetrieveAll();
        squadre.sort(Comparator.comparing(Squadra::getNome));
        getServletContext().setAttribute("squadre", squadre);
    }
}
