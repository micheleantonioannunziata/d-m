package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminServlet", value = "/admin-servlet")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        List<Prodotto> prodottoList = prodottoDAO.doRetrieveAll();

        UtenteDAO utenteDAO = new UtenteDAO();
        List<Utente> utenteList  = utenteDAO.doRetrieveAll();

        OrdineDAO ordineDAO = new OrdineDAO();
        List<Ordine> ordineList = ordineDAO.doRetrieveAll();

        ProdottoTaglieDAO prodottoTaglieDAO = new ProdottoTaglieDAO();
        List<ProdottoTaglie> prodottoTaglies = prodottoTaglieDAO.doRetrieveAll();

        req.setAttribute("prodotti",prodottoList);
        req.setAttribute("utenti",utenteList);
        req.setAttribute("ordini",ordineList);
        req.setAttribute("prodottitaglie",prodottoTaglies);

        RequestDispatcher dispatcher = req.getRequestDispatcher("adminPage.jsp");
        dispatcher.forward(req,resp);
    }
}
