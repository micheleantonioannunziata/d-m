package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import model.*;

import java.util.List;

@WebServlet(name = "loadDataOnServletContext", value = "/loadData-servletContext", loadOnStartup = 0)
public class LoadDataOnServletContext extends HttpServlet {

    public void init() {
        // pusha taglie
        TagliaDAO tagliaService = new TagliaDAO();
        List<Taglia> taglie = tagliaService.doRetrieveAll();
        getServletContext().setAttribute("taglie", taglie);

        SquadraDAO squadraDAO = new SquadraDAO();
        List<Squadra> squadre = squadraDAO.doRetrieveAll();
        getServletContext().setAttribute("squadre", squadre);

    }
}
