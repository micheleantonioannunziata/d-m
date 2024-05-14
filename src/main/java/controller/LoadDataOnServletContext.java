package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import model.Prodotto;
import model.ProdottoDAO;
import model.Taglia;
import model.TagliaDAO;
import java.util.List;

@WebServlet(name = "loadDataOnServletContext", value = "/loadData-servletContext", loadOnStartup = 0)
public class LoadDataOnServletContext extends HttpServlet {

    public void init() {
        // pusha taglie
        TagliaDAO tagliaService = new TagliaDAO();
        List<Taglia> taglie = tagliaService.doRetrieveAll();
        getServletContext().setAttribute("taglie", taglie);

        // pusha prodotti (produttori, collezioni, squadre stanno qua dentro)
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        List<Prodotto> prodotti = prodottoDAO.doRetrieveAll();
        getServletContext().setAttribute("prodotti", prodotti);

    }
}
