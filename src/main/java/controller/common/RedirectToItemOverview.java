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
@WebServlet(name = "overviewServlet", value = "/overview-servlet")
public class RedirectToItemOverview extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // ottieni id
        int id = Integer.parseInt(req.getParameter("idProdotto"));

        ProdottoDAO prodottoDAO = new ProdottoDAO();

        // effettua query
        Prodotto prodotto = prodottoDAO.doRetrieveById(id);

        // setta nella request
        req.setAttribute("prodotto", prodotto);

        // ridirotta - competenza esclusiva della servlet chiamata
        // (il controllo passa completamente al chiamato che avrà
        // l'onore e l'onere di produrre la risposta)
        RequestDispatcher dispatcher = req.getRequestDispatcher("overview.jsp");
        dispatcher.forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
